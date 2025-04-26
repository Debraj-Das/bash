import http.server
import socketserver
import json
import re
import os
import random

# from urllib.parse import urlparse, parse_qs


class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        """
        Handles POST requests to the server.  This function specifically
        processes the problem data sent in the request body.  It reads the
        data, parses it as JSON, and then performs the required file
        operations (creating test files and a main source file).
        """
        if self.path == "/":
            content_length = int(self.headers["Content-Length"])
            post_data = self.rfile.read(content_length).decode("utf-8")

            try:
                problem = json.loads(post_data)
                self.process_problem(problem)  # Extract and process problem data
                self.send_response(200)
                self.send_header("Content-type", "application/json")
                self.end_headers()
                response_data = json.dumps({"message": "Problem received successfully"})
                self.wfile.write(response_data.encode("utf-8"))

            except json.JSONDecodeError:
                self.send_error(400, "Invalid JSON")
                return
            except Exception as e:
                self.send_error(500, f"Internal server error: {e}")
                return
        else:
            self.send_error(404, "Not Found")

    def process_problem(self, problem):
        """
        Processes the problem data, creating files for tests and the main code.

        Args:
            problem (dict): A dictionary containing the problem data,
                            including name, group, url, memoryLimit,
                            timeLimit, and tests.
        """
        name = problem["name"]
        contest = problem["group"]
        url = problem["url"]
        memoryLimit = problem["memoryLimit"]
        timeLimit = problem["timeLimit"]
        tests = problem["tests"]

        print("Problem received successfully")

        # Read the template file.  Use a hardcoded path, or best, a relative path.
        # template_file_path = "Main_Boiler_Template.cpp" # Changed to relative path
        # try:
        #     with open(template_file_path, "r") as f:
        #         template = f.read()
        # except FileNotFoundError:
        #     print(f"Error: Template file not found at {template_file_path}")
        #     raise  # Re-raise to be caught in do_POST

        # Extract filename from URL or generate a random name.
        match = re.search(r"/([^/]+)$", url)
        if match:
            file_name = match.group(1)
        else:
            file_name = str(random.randint(1000, 100000000))

        # Ensure the file is created in the current directory.
        file_name = os.path.join(os.getcwd(), file_name)

        # Write the number of test cases to a file.
        with open(file_name + ".num", "w") as f:
            f.write(str(len(tests)))

        # Write each test case to a separate file.
        for i, test in enumerate(tests):
            with open(file_name + f"{i+1}.in", "w") as f:
                f.write(test["input"])
            with open(file_name + f"{i+1}.out", "w") as f:
                f.write(test["output"])

        # Write the main C++ file with problem details and template code.
        with open(file_name + ".cpp", "w") as f:
            f.write("/*\n")
            f.write(f"\tProblem Name: {name}\n")
            f.write(f"\tContest: {contest}\n")
            f.write(f"\tURL: {url}\n")
            f.write(f"\tMemory Limit: {memoryLimit} MB\n")
            f.write(f"\tTime Limit: {timeLimit} ms\n")
            f.write("*/\n\n")
            # f.write(template)
        print("Problem processed successfully")


def run_server(
    server_class=socketserver.TCPServer, handler_class=MyHandler, port=10045
):
    """
    Starts the HTTP server.  This function sets up the server to listen on the
    specified port and handle incoming requests using the provided handler class.
    """
    server_address = ("", port)  # Listen on all interfaces
    httpd = server_class(server_address, handler_class)
    print(f"Starting server on port {port}...")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
    finally:
        httpd.server_close()


if __name__ == "__main__":
    run_server()

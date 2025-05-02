# These scripts are designed to automate the testing of your solutions for competitive programming problems. They help ensure the correctness and robustness of your code by systematically generating test cases and verifying the output.

1. test.sh: Testing Solution Against Brute Force

   - Purpose:

     The test.sh script is used to compare the output of your main solution (solution.cpp) against a brute-force solution (expected.cpp) for a set of generated inputs. This is useful for verifying the correctness of an optimized solution by comparing it against a slower but more reliable approach.

   - Usage:
     `test.sh <solution_cpp> <expected_cpp> <generator_cpp> [<num_test_cases=10>]`

   - Arguments:

     - <solution_cpp>: Path to the C++ source file of your main solution.

     - <expected_cpp>: Path to the C++ source file of the brute-force solution.

     - <generator_cpp>: Path to the C++ source file of the test case generator.

     - [<num_test_cases=10>]: (Optional) The number of test cases to generate. Defaults to 10 if not provided.

   - Workflow:

     - Compilation: The script compiles solution.cpp, generator.cpp, and expected.cpp into executable files.

     - Test Case Generation: The script runs generator.cpp to create a test case (input).

     - Solution Execution: The script runs the compiled solution.out on the generated input, capturing the output.

     - Brute Force Execution: The script runs the compiled expected.out on the same generated input, capturing the expected output.

     - Output Comparison: The script compares the output of solution.out with the output of expected.out using diff.

     - Result Reporting: The script reports whether the test case passed or failed. If a test case fails, it prints the input, the expected output, and the actual output.

     - Logging: Detailed information about failed test cases is logged to the failed.log file.

     - Cleanup: The script removes all generated executables and temporary files.

     - Testing Strategies (for test.sh):

     - To effectively use test.sh, employ these testing strategies within your generator.cpp:

     - Small Input Range with High Repetition:

     - Generate many test cases with inputs within a small range.

     - This tests the consistency of your solution and its ability to handle repeated inputs efficiently.

     - Example: If the problem involves an array of numbers, generate many arrays with small numbers, potentially with many duplicates.

     - Edge Cases and Specific Input Ranges:

     - Generate test cases that include edge cases and specific input ranges that might cause issues.

   - Examples:

     - Large input values (maximum allowed values, boundary conditions).

     - Specific input patterns (sorted input, reverse-sorted input, input with many duplicate values).

     - Empty inputs.

     - Inputs with specific constraints.

     - Boundary Input for Time and Space:

     - Generate test cases that test the limits of the problem's constraints.

     - Examples:

     - Maximum allowed array size.

     - Maximum allowed value ranges.

     - Inputs that will cause the solution to use a lot of memory.

     - Combine this with a large number of test cases to stress-test the solution's time and space complexity.

   - Example Usage:
     - with out test case taking defalut 10
       `./test.sh solution.cpp generator.cpp expected.cpp`
     - taking test case as fourth input value
       `./test.sh solution.cpp generator.cpp expected.cpp 100`
       This will compile solution.cpp, generator.cpp, and expected.cpp, and then run 100 test cases, comparing the output of solution.out against expected.out for each generated input.

2. check.sh: Checking Solution Output with a Checker

   - Purpose:

     - The check.sh script is used to verify the output of your solution (solution.cpp) using a separate checker program (checker.cpp). This is useful when there isn't a simple brute-force solution, and you need a more complex program to determine the correctness of the output.

   - Usage:

     - ./check.sh <solution_cpp> <generator_cpp> <checker_cpp> [<num_test_cases=10>]

   - Arguments:

     - <solution_cpp>: Path to the C++ source file of your main solution.

     - <generator_cpp>: Path to the C++ source file of the test case generator.

     - <checker_cpp>: Path to the C++ source file of the checker program.

     - [<num_test_cases=10>]: (Optional) The number of test cases to generate. Defaults to 10 if not provided.

   - Workflow:

     - Compilation: The script compiles solution.cpp, generator.cpp, and checker.cpp into executable files.

     - Test Case Generation: The script runs generator.cpp to create a test case (input).

     - Solution Execution: The script runs the compiled solution.out on the generated input, capturing the output.

     - Checker Execution: The script runs the compiled checker.out, providing it with both the input and the output from your solution. The checker program determines the correctness of the output.

     - Result Reporting: The script checks the exit code of checker.out. A zero exit code indicates that the solution's output is correct; a non-zero exit code indicates an error. The script reports whether the test case passed or failed, along with the checker's output.

     - Logging: Detailed information about failed test cases is logged to the failed.log file.

     - Cleanup: The script removes all generated executables and temporary files.

     - Testing Strategies (for check.sh):

     - The testing strategies for check.sh are similar to those for test.sh:

     - Small Input Range with High Repetition: Generate many test cases with inputs in a small range to test consistency.

     - Edge Cases and Specific Input Ranges: Generate inputs that target potential weaknesses in your solution.

     - Boundary Input for Time and Space: Generate inputs that stress the limits of the problem's constraints.

     - Important Considerations for checker.cpp:

     - The checker.cpp program should read the input and the solution's output and determine if the output is correct according to the problem's rules.

     - The checker should exit with a code of 0 if the output is correct and a non-zero code if the output is incorrect.

     - The checker can print an error message to standard error (cerr) to provide more information about why the output is incorrect. This message will be captured in err.txt.

   - Example Usage:
     - without test case
       `./check.sh solution.cpp generator.cpp checker.cpp`
     - with test case (defalut value 10)
       `./check.sh solution.cpp generator.cpp checker.cpp 50`
       This will compile solution.cpp, generator.cpp, and checker.cpp, and then run 50 test cases, using checker.out to verify the output of solution.out for each generated input.

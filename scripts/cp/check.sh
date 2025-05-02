#!/usr/bin/env bash

# Script to test a solution using a checker program.
#
# Usage: ./test.sh <solution_cpp> <generator_cpp> <checker_cpp> [<num_test_cases=10>]
#
# Arguments:
#   <solution_cpp>:  Path to the C++ file for the main solution.
#   <generator_cpp>: Path to the C++ file for the test case generator.
#   <checker_cpp>:   Path to the C++ file for the checker program.
#   <num_test_cases>: Number of test cases to generate (optional, default 10).

# Define default number of test cases.
DEFAULT_TEST_CASES=10

# Define file names for input and outputs.
INPUT_FILE="in.txt"
OUTPUT_FILE="out.txt"
INPUT_OUTPUT_FILE="inout.txt"
ERROR_FILE="err.txt"
FAILURE_LOG="failed.log" # Log failed test case details to a file.

# Function to compile a C++ file.
# Arguments:
#   $1: Path to the C++ source file.
#   $2: Path to the output executable.
compile_cpp() {
  local source_file="$1"
  local output_exe="$2"
  echo "Compiling: $source_file -> $output_exe"
  if ! g++ -Wall -std=c++17 "$source_file" -o "$output_exe"; then
    echo "ERROR: Compilation of $source_file failed."
    exit 1
  fi
}

# Function to run a test case and compare outputs.
# Arguments:
#   $1: Test case number.
run_test_case() {
  local test_case_number="$1"
  echo -n "Test Case $test_case_number:"

  # Generate input.
  ./"$GENERATOR_EXE" > "$INPUT_FILE" || {
    echo "ERROR: Generator failed on test case $test_case_number. Exiting."
    exit 1
  }

  # Run the solution.
  ./"$SOLUTION_EXE" < "$INPUT_FILE" > "$OUTPUT_FILE" || {
    echo "ERROR: Solution failed on test case $test_case_number. Exiting."
    exit 1
  }

  # Create input + output for checker
  printf "$(cat "$INPUT_FILE")\n$(cat "$OUTPUT_FILE")" > "$INPUT_OUTPUT_FILE"

  # Run the checker.
  ./"$CHECKER_EXE" < "$INPUT_OUTPUT_FILE" > "$ERROR_FILE"
  checker_return_code=$?

  if [ "$checker_return_code" -ne 0 ]; then
    echo " ❌"

    # Log the failure details
    echo "Input:" > "$FAILURE_LOG"
    cat "$INPUT_FILE" >> "$FAILURE_LOG"
    printf "\nOutput:" >> "$FAILURE_LOG"
    cat "$OUTPUT_FILE" >> "$FAILURE_LOG"
    printf "\nChecker Exit Code: $checker_return_code" >> "$FAILURE_LOG"
    printf "\nChecker Output (err.txt):" >> "$FAILURE_LOG"
    cat "$ERROR_FILE" >> "$FAILURE_LOG"

	echo "Cleaning up..."
	rm -f "$SOLUTION_EXE" "$GENERATOR_EXE" "$CHECKER_EXE" "$INPUT_FILE" "$OUTPUT_FILE" "$INPUT_OUTPUT_FILE" "$ERROR_FILE"
    exit 1
  else
    echo " ✅"
  fi
}

# --- Main Script ---

# Check the number of arguments.
if [[ "$#" -lt 3 || "$#" -gt 4 ]]; then
  echo "Usage: $0 <solution_cpp> <generator_cpp> <checker_cpp> [<num_test_cases=$DEFAULT_TEST_CASES>]"
  exit 1
fi

# Assign arguments to variables.
SOLUTION_CPP="$1"
GENERATOR_CPP="$2"
CHECKER_CPP="$3"
NUM_TEST_CASES=${4:-$DEFAULT_TEST_CASES} # Use default if not provided.

# Validate the number of test cases.
if ! [[ "$NUM_TEST_CASES" =~ ^[0-9]+$ ]]; then
  echo "ERROR: Number of test cases must be a non-negative integer."
  exit 1
fi

# Define executable names.
SOLUTION_EXE="sol"
GENERATOR_EXE="gen"
CHECKER_EXE="check"

# Compile the C++ files.
compile_cpp "$SOLUTION_CPP" "$SOLUTION_EXE"
compile_cpp "$GENERATOR_CPP" "$GENERATOR_EXE"
compile_cpp "$CHECKER_CPP" "$CHECKER_EXE"

# Run the tests.
echo "Running tests..."
for ((i = 1; i <= NUM_TEST_CASES; ++i)); do
  run_test_case "$i"
done

# Clean up executables and temporary files.
echo "Cleaning up..."
rm -f "$SOLUTION_EXE" "$GENERATOR_EXE" "$CHECKER_EXE" "$INPUT_FILE" "$OUTPUT_FILE" "$INPUT_OUTPUT_FILE" "$ERROR_FILE"

echo "Testing complete."
exit 0

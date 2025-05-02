#!/usr/bin/env bash

# Script to test a solution against a brute force solution using generated test cases.
#
# Usage: ./test.sh <solution_cpp> <brute_cpp> <generator_cpp> [<num_test_cases=10>]
#
# Arguments:
#   <solution_cpp>:  Path to the C++ file for the main solution.
#   <brute_cpp>:     Path to the C++ file for the brute force solution.
#   <generator_cpp>: Path to the C++ file for the test case generator.
#   <num_test_cases>: Number of test cases to generate (optional, default 10).

# Define default number of test cases.
DEFAULT_TEST_CASES=10

# Define file names for input and outputs.  Using constants improves readability and
# makes it easier to change file names consistently.
INPUT_FILE="in.txt"
OUTPUT_FILE="out.txt"
EXPECTED_OUTPUT_FILE="exp.txt"
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

  # Generate input.
  ./"$GENERATOR_EXE" > "$INPUT_FILE" || {
    echo "ERROR: Generator failed on test case $test_case_number.  Exiting."
    exit 1 # Exit, because the rest of the test case cannot proceed.
  }

  # Run the solution.
  ./"$SOLUTION_EXE" < "$INPUT_FILE" > "$OUTPUT_FILE" || {
    echo "ERROR: Solution failed on test case $test_case_number. Exiting."
    exit 1
  }

  # Run the brute force solution.
  ./"$BRUTE_EXE" < "$INPUT_FILE" > "$EXPECTED_OUTPUT_FILE" || {
    echo "ERROR: Brute force solution failed on test case $test_case_number. Exiting."
    exit 1
  }

  echo -n "Test Case $test_case_number:"
  # Compare outputs using diff.
  if ! diff -Bw "$EXPECTED_OUTPUT_FILE" "$OUTPUT_FILE" > /dev/null; then
    echo " ❌"

    # Log the failure details to a file.  Append, in case multiple tests are run.
    printf "Input:\n" > "$FAILURE_LOG"
    cat "$INPUT_FILE" >> "$FAILURE_LOG"
    printf "\nExpected Output:\n" >> "$FAILURE_LOG"
    cat "$EXPECTED_OUTPUT_FILE" >> "$FAILURE_LOG"
    printf "\nActual Output:\n" >> "$FAILURE_LOG"
    cat "$OUTPUT_FILE" >> "$FAILURE_LOG"
    printf "\nDifference (Expected - Actual):\n" >> "$FAILURE_LOG" # Add this
    diff -Bw "$EXPECTED_OUTPUT_FILE" "$OUTPUT_FILE" >> "$FAILURE_LOG" # Add this

	rm -f "$SOLUTION_EXE" "$BRUTE_EXE" "$GENERATOR_EXE" "$INPUT_FILE" "$OUTPUT_FILE" "$EXPECTED_OUTPUT_FILE"
    exit 1 # Exit on first failure.  Important for automation.
  else
    echo " ✅"
  fi
}

# --- Main Script ---

# Check the number of arguments.
if [[ "$#" -lt 3 || "$#" -gt 4 ]]; then
  echo "Usage: $0 <solution_cpp> <brute_cpp> <generator_cpp> [<num_test_cases=$DEFAULT_TEST_CASES>]"
  exit 1
fi

# Assign arguments to variables.
SOLUTION_CPP="$1"
BRUTE_CPP="$2"
GENERATOR_CPP="$3"
NUM_TEST_CASES=${4:-$DEFAULT_TEST_CASES} # Use default if not provided.

# Validate the number of test cases.
if ! [[ "$NUM_TEST_CASES" =~ ^[0-9]+$ ]]; then
  echo "ERROR: Number of test cases must be a non-negative integer."
  exit 1
fi

# Define executable names.  Use constants.
SOLUTION_EXE="sol"
BRUTE_EXE="brute"
GENERATOR_EXE="gen"

# Compile the C++ files.
compile_cpp "$SOLUTION_CPP" "$SOLUTION_EXE"
compile_cpp "$BRUTE_CPP" "$BRUTE_EXE"
compile_cpp "$GENERATOR_CPP" "$GENERATOR_EXE"

# Run the tests.
echo "Running tests..."
for ((i = 1; i <= NUM_TEST_CASES; ++i)); do
  run_test_case "$i"
done

# Clean up executables and temporary files.
echo "Cleaning up..."
rm -f "$SOLUTION_EXE" "$BRUTE_EXE" "$GENERATOR_EXE" "$INPUT_FILE" "$OUTPUT_FILE" "$EXPECTED_OUTPUT_FILE"

echo "Testing complete."
exit 0

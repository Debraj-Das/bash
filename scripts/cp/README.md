# This is the scripts for using the competitive programming

there are utill files and working principal presents

1. test.sh

   - test scripts to compare the solution of the solution against brute solutions for generated input
   - for it there are third files need they are solution.cpp, generator.cpp, expected.cpp
     - solution.cpp for solution files
     - generator.cpp for input generator
     - expected.cpp for brute solution generator
   - test time first try to test for small input range with very possible input means very large repetations
   - second time use edge case like large input and specific range of input case with very possible input
   - third for test time and space using boundary number of input

2. check.sh

   - check scripts to checking the output of the solution using checker.cpp and generator.cpp
   - for it there are third files need solution.cpp, generator.cpp, checker.cpp
     - solution.cpp for solution file
     - generator.cpp for input generator
     - checker.cpp for checking the out of the solution for generate input
   - use similare testing method as test.sh

3. int

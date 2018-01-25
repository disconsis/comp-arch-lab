# Solutions to CSE-312: Computer Architecture Lab

## Installing spim
NOTE: Instructions for linux only
1. To install qtspim: Run [assignment\_1/install.sh](assignment_1/install.sh) (this downloads the linux-x64 debian package from sourceforge and installs it)
2. To install spim/xspim, run `$ sudo apt install spim`
3. xspim should successfully run with `$ xspim`.

If all this does is print a font name and quit, as below,
```bash
$ xspim
*-courier-medium-r-normal--12-*-75-*
```
run it with `$ xspim -font 6x10`

## Assignment 1

### Task
1. Write a program to add the integers 1 and 2
2. Write a program to load and add two 32-bit values: 0x10000001 and 0x20000002.
3.
    1. Step through the instructions  
    2. Set an appropriate breakpoint in the program

### Solution
1. open qtspim ($ qtspim) -> File -> Reinitialize and load file -> [assignment\_1/add1.asm](assignment_1/add1.asm) -> Run ->  see the highlighted registers on the left -> celebrate.
2. File -> reinitialize and load file -> [assignment\_1/add2.asm](assignment_1/add2.asm) -> Run -> same
3. File -> reinitialize and load file ->  [assignment\_1/add2.asm](assignment_1/add2.asm)
    1. find the thing that says "single step" when you hover over it. click it. as many times as you want (<=10 (empirical result))
    2. reinitialize again with assignment\_1/add2.asm -> right click on the line that says "lui $t1, 0x1000 # temporary..." -> set breakpoint -> Run -> see breakpoint dialog -> rejoice -> single step/continue

## Assignment 2

### Task
1. Write a program to compute GCD of two 32-bit integers using Euclid's algorithm
2. Implement the given sample program ([assignment\_2/sample.asm](assignment_2/sample.asm)). Study the instructions and the working of the program.
3. Statically declare some prompt strings for user input, and redo the addition program in **assignment 1** to prompt the user for two numbers and print the result.
4. Define an array of 8 integers as static data. Use the `.align` assembler directive. Read 8 values as input with prompts to the user and store it in the array. Examine what happens without the assembler directive.

### Solution
1. [assignment\_2/gcd.asm](assignment_2/gcd.asm)

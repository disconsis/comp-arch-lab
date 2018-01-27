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

## References
[Assembler directives](http://students.cs.tamu.edu/tanzir/csce350/reference/assembler_dir.html)  
[System calls](http://students.cs.tamu.edu/tanzir/csce350/reference/syscalls.html)  
[Calling convention](https://www.cs.umb.edu/cs641/MIPscallconvention.html)

## Assignment 1

### Task
1. Write a program to add the integers 1 and 2
2. Write a program to load and add two 32-bit values: 0x10000001 and 0x20000002.
3.
    1. Step through the instructions  
    2. Set an appropriate breakpoint in the program

### Solution
1. open qtspim ($ qtspim) → File → Reinitialize and load file → [assignment\_1/add1.asm](assignment_1/add1.asm) → Run →  see the highlighted registers on the left → celebrate.
2. File → reinitialize and load file → [assignment\_1/add2.asm](assignment_1/add2.asm) → Run → same
3. File → reinitialize and load file →  [assignment\_1/add2.asm](assignment_1/add2.asm)
    1. find the thing that says "single step" when you hover over it. click it. as many times as you want
    2. reinitialize again with assignment\_1/add2.asm → right click on the line that says "lui $t1, 0x1000 # temporary..." → set breakpoint → Run → see breakpoint dialog → rejoice → single step/continue

## Assignment 2

### Task
1. Write a program to compute GCD of two 32-bit integers using Euclid's algorithm
2. Implement the given sample program ([assignment\_2/sample.asm](assignment_2/sample.asm)). Study the instructions and the working of the program.
3. Statically declare some prompt strings for user input, and redo the addition program in **assignment 1** to prompt the user for two numbers and print the result.
4. Define an array of 8 integers as static data. Use the `.align` assembler directive. Read 8 values as input with prompts to the user and store it in the array. Examine what happens without the assembler directive.

### Solution
1. [assignment\_2/gcd.asm](assignment_2/gcd.asm)
2. The [sample program](assignment_2/sample.asm) takes a number and counts down from it.
3. [assignment\_2/add.asm](assignment_2/add.asm)
4. [assignment\_2/array.asm](assignment_2/array.asm)
    1. Even without the `.align` directive, data is still properly aligned on word boundary; thus the program works correctly.
    2. However, explicitly turning off alignment with `.align 0` causes address errors due to unaligned addresses.


## Assignment 3

### Task
1. Write a function to merge two sorted arrays into another, assuming the final array has enough space. Take array1, length1, array2, length2, final\_array as inputs. Call this function from main with the two halves of a length 8 array input by the user.
2. Write a program for recursively calculating the factorial of an integer.
3. Write a recursive mergesort procedure using the merge function taking the starting address and the length of the sub-array as arguments. It should also check that the sub-array is sorted before returning. Call this function from main with a length 8 array input by the user.
4. Insert a breakpoint at a place in your code where the stack depth (wrt call activations) will be at its maximum size. Point out the various call activation records and explain the contents of the stack.

### Solution
1. [assignment\_3/merge.asm](assignment_3/merge.asm)
2. [assignment\_3/factorial.asm](assignment_3/factorial.asm)
3. [assignment\_3/mergesort.asm](assignment_3/mergesort.asm)

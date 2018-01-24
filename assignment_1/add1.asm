# Q1

.text # == .code, i.e., code segment
main: # entry point for code

li     $t1, 1     # temporary register t1 = 1
li     $t2, 2

# v1 - register for return value
add    $v1, $t2, $t1   # v1 = t2 + t1 == 3

# return to outer function
jr     $ra

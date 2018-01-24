# Q1

.text # == .code, i.e., code segment
main: # entry point for code

li     $t1, 1     # temporary register t1 = 1
li     $t2, 2

# v0 - register for return value
add     $v0, $t2, $t1   # v0 = t2 + t1 == 3
.data
.align  2 # align on 2^2 byte (= word) boundary
# .align 0 # for address errors
start:  .asciiz "\n\nInput array:\n"
end:    .asciiz "End"
endl:   .asciiz "\n"
prompt: .asciiz "Enter number: "
arr:
.word   1
.word   2
.word   3
.word   4
.word   5
.word   6
.word   7
.word   8

.text
main:
    # initialize loop counters
    la  $t0, arr # array addr
    li  $t1, 0 # loop counter
    li  $t8, 8 # loop max

readloop:
    # print prompt
    li  $v0, 4
    la  $a0, prompt
    syscall
    # read arr[t1]
    li  $v0, 5
    syscall
    sw  $v0, 0($t0)
    # index++
    add $t0, 4
    add $t1, 1
    # if t1 > 8: break
    sub $t2, $t8, $t1
    bgtz $t2, readloop


    # print start
    li  $v0, 4
    la  $a0, start
    syscall
    # initialize loop counters
    la  $t0, arr # array addr
    li  $t1, 0 # loop counter
    li  $t8, 8 # loop max

printloop:
    # print arr[t1]
    li  $v0, 1
    lw  $a0, 0($t0)
    syscall
    # print newline
    li  $v0, 4
    la  $a0, endl
    syscall
    # index++
    add $t0, 4
    add $t1, 1
    # if t1 > 8: break
    sub $t2, $t8, $t1
    bgtz $t2, printloop
    # print end
    li  $v0, 4
    la  $a0, end
    syscall

    # return
    jr  $ra

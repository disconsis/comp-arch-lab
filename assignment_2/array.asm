.data
.align  2 # align on 2^2 byte (= word) boundary
# .align 0 # for address errors
start:  .asciiz "\n\nInput array:\n"
end:    .asciiz "End"
endl:   .asciiz "\n"
prompt: .asciiz "Enter number: "
arr:
.word   1, 2, 3, 4, 5, 6, 7, 8

.text
main:
    # initialize loop counters
    la  $t0, arr # array addr
    li  $t1, 8 # loop counter

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
    # if t1 > 8: break
    sub $t1, 1
    bgtz $t1, readloop

    # print start
    li  $v0, 4
    la  $a0, start
    syscall
    # initialize loop counters
    la  $t0, arr # array addr
    li  $t1, 8 # loop counter

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
    # if t1 > 8: break
    sub $t1, 1
    bgtz $t1, printloop
    # print end
    li  $v0, 4
    la  $a0, end
    syscall

    # return
    jr  $ra

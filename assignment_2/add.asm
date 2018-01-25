.data
prompt1:    .asciiz "Enter the first number: "
prompt2:    .asciiz "Enter the second number: "
answer:     .asciiz "The sum is: "

.text
main:
    # prompt for first input
    li      $v0, 4
    la      $a0, prompt1
    syscall

    # read first number into t0
    li      $v0, 5
    syscall
    move    $t0, $v0

    # prompt and read second number into t1
    li      $v0, 4
    la      $a0, prompt1
    syscall
    li      $v0, 5
    syscall
    move    $t1, $v0

    # print answer
    add     $v1, $t0, $t1
    li      $v0, 4
    la      $a0, answer
    syscall
    li      $v0, 1
    move    $a0, $v1
    syscall

    # return
    jr $ra

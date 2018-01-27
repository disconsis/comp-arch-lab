# calculate the gcd of 2 numbers using euclid's gcd algo
.data
prompt1:    .asciiz "Enter the first number: "
prompt2:    .asciiz "Enter the second number: "
answer:     .asciiz "The gcd is: "

.text
main:
    # for syscall, v0 = syscall number; a0-a3: syscall args

     # print prompt 1
     li      $v0, 4 # syscall 4 → print string
     # la == load address of symbol
     la      $a0, prompt1
     syscall

     # read first number (into t0)
     li      $v0, 5 # syscall 5 → read integer into v0
     syscall
     move    $t0, $v0

     # print prompt2 and read the 2nd number (into t1)
     li      $v0, 4
     la      $a0, prompt2
     syscall
     li      $v0, 5
     syscall
     move    $t1, $v0

    # while ( t0 != 0 && t1 != 0 ) {
start:
    beqz $t0, end
    beqz $t1, end

        # if ( t0 > t1 ) {
    sub     $t2, $t0, $t1
    bltz    $t2, second_greater

            # t0 = t0 % t1
    move $t3, $t1
    div $t0, $t1
    mfhi $t0
    j       start
        # }

        # else {
second_greater:
            # t1 = t1 % t0
    move $t3, $t0
    div $t1, $t0
    mfhi $t1
    j       start
        # }
    # }

end:
    # set return value
    move    $v1, $t3

    # print answer
    li      $v0, 4
    la      $a0, answer
    syscall
    li      $v0, 1
    move    $a0, $v1
    syscall

    # return to outer function
    jr      $ra

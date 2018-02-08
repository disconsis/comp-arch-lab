.data
prompt: .asciiz "Enter a number: "
answer: .asciiz "The factorial is: "

.text

.ent factorial
factorial:
    # stack management
    # make space
    sub $sp, 8
    # store ra
    sw $ra, 4($sp)
    # store s0 (since we're using it later)
    sw $s0, 0($sp)

    # if a0 == 0: return 1
    bnez $a0, non_zero
    li $v0, 1
    add $sp, 8
    jr $ra
    # else
    non_zero:

    move $s0, $a0
    sub $a0, 1
    jal factorial
    mul $v0, $v0, $s0

    lw $s0, 0($sp)
    lw $ra, 4($sp)
    add $sp, 8
    jr $ra
.end factorial

.ent main
main:
    # make space (can only +/- $sp in multiples of 8)
    sub $sp, 8
    # store return addr
    sw $ra, 4($sp)

    # print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    # read number
    li $v0, 5
    syscall

    # set argument for factorial()
    move $a0, $v0
    # call factorial
    jal factorial
    # store return
    move $t0, $v0

    # print factorial value
    li $v0, 4
    la $a0, answer
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    # return
    lw $ra, 4($sp)
    add $sp, 8
    jr $ra
.end main

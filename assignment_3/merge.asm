.data
# array: .word 23, 12, 97, 1, 5, 9, 55, 10
arr1: .word 11, 23, 97, 124
arr2: .word 85, 86, 87, 99
final: .word 0, 0, 0, 0, 0, 0, 0, 0
comma: .asciiz ", "
prompt1: .asciiz "Enter the first sorted array\n"
prompt2: .asciiz "\nEnter the second sorted array\n"
numprompt: .asciiz "Enter a number: "
answer: .asciiz "\nMerged array is:\n"


.text

.ent merge
.globl merge
merge:
# arguments:
#   a0 → arr1
#   a1 → l1
#   a2 → arr2
#   a3 → l2
#   16($sp) → farr
# assumption:
#   len(farr) >= l1 + l2
# mappings:
#   t0 → arr1[i1]
#   t1 → i1 (index for arr1)
#   t2 → arr2[i2]
#   t3 → i2 (index for arr2)
#   t4 → farr
#   t8 → compare register

# DEBUG
#    lw $t4, 16($sp) # t4 = farr
    li $t1, 0 # i1 = 0
    li $t3, 0 # i2 = 0

# compare_loop
# ------------
# while (i1 < l1 && i2 < l2) {
#     if (*arr1 < *arr2) {
#         *farr = *arr1;
#         farr++;
#         arr1++;
#         i1++;
#     }
#     else {
#         *farr = *arr2;
#         farr++;
#         arr2++;
#         i2++;
#     }
# }
compare_loop_start:
    # if i1 >= l1: break
    slt $t8, $t1, $a1
    beqz $t8, compare_loop_end
    # if i2 >= l2: break
    slt $t8, $t3, $a3
    beqz $t8, compare_loop_end

    lw $t0, 0($a0) # t0 = *arr1
    lw $t2, 0($a2) # t2 = *arr2

    # if *arr1 < *arr2
    slt $t8, $t0, $t2
    beqz $t8, arr2_smaller

    sw $t0, 0($t4) # *farr = *arr1
    addi $t4, 4 # farr++
    addi $a0, 4 # arr1++
    addi $t1, 1 # i1++
    j compare_loop_start
arr2_smaller:
    sw $t2, 0($t4) # *farr = *arr2
    addi $t4, 4 # farr++
    addi $a2, 4 # arr2++
    addi $t3, 1 # i2++
    j compare_loop_start
compare_loop_end:


# end_loop_1
# ----------
# while (i1 < l1) {
#     *farr = *arr1;
#     farr++;
#     arr1++;
#     i1++;
# }
end_loop_1_start:
    # if i1 >= l1: break
    slt $t8, $t1, $a1
    beqz $t8, end_loop_1_end

    sw $t0, 0($t4) # *farr = *arr1
    addi $t4, 4 # farr++
    addi $a0, 4 # arr1++
    addi $t1, 1 # i1++

    j end_loop_1_start
end_loop_1_end:


# end_loop_2
# ----------
# while (i2 < l2) {
#     *farr = *arr2;
#     farr++;
#     arr2++;
#     i2++;
# }
end_loop_2_start:
    # if i2 >= l2: break
    slt $t8, $t3, $a3
    beqz $t8, end_loop_2_end

    sw $t2, 0($t4) # *farr = *arr2
    addi $t4, 4 # farr++
    addi $a2, 4 # arr2++
    addi $t3, 1 # i2++

    j end_loop_2_start
end_loop_2_end:

    # return to caller
    jr $ra

.end merge


.ent main
main:
    # push return addr onto stack
    sub $sp, 4
    sw $ra, 0($sp)


    # print arr1 prompt
    li $v0, 4
    la $a0, prompt1
    syscall
    # initialize loop
    li $t5, 0
    la $t6, arr1
readloop_1:
    # print numprompt
    li $v0, 4
    la $a0, numprompt
    syscall
    # read number into arr1
    li $v0, 5
    syscall
    sw $v0, 0($t6)
    # advance array
    addi $t5, 1
    addi $t6, 4
    # check for end
    slti $t8, $t5, 4
    bnez $t8, readloop_1

    # print arr2 prompt
    li $v0, 4
    la $a0, prompt2
    syscall
    # initialize loop
    li $t5, 0
    la $t6, arr2
readloop_2:
    # print numprompt
    li $v0, 4
    la $a0, numprompt
    syscall
    # read number into arr2
    li $v0, 5
    syscall
    sw $v0, 0($t6)
    # advance array
    addi $t5, 1
    addi $t6, 4
    # check for end
    slti $t8, $t5, 4
    bnez $t8, readloop_2


    # load arguments
    la $a0, arr1
    li $a1, 4
    # addi $a2, $a0, 16
    la $a2, arr2
    li $a3, 4
# DEBUG
    la $t4, final

    # call merge
    jal merge

    # print answer string
    li $v0, 4
    la $a0, answer
    syscall
    # initialize loop
    li $t5, 0
    la $t6, final
printloop:
    # print array
    li $v0, 1
    lw $a0, 0($t6)
    syscall
    # print comma
    li $v0, 4
    la $a0, comma
    syscall
    # advance array
    addi $t5, 1
    addi $t6, 4
    slti $t8, $t5, 8
    bnez $t8, printloop

    # get return addr from stack
    lw $ra, 0($sp)
    jr $ra

.end main

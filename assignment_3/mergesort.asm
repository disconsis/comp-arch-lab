# vim: ft=mips
.data
prompt: .asciiz "Enter an array:\n"
numprompt: .asciiz "Enter a number: "
answer: .asciiz "The sorted array is: "
error: .asciiz "[!] Error while sorting\n"
comma: .asciiz ", "

.align 2
inp_arr: .space 32
tmp_arr: .space 32


.text

# merge from merge.asm (with less comments)
.ent merge
merge:
    # arguments: arr1[], l1, arr2[], l2, farr[]

    lw $t4, 16($sp) # t4 = farr
    li $t1, 0 # i1 = 0
    li $t3, 0 # i2 = 0
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

    end_loop_1_start:
    # if i1 >= l1: break
    slt $t8, $t1, $a1
    beqz $t8, end_loop_1_end
    lw $t0, 0($a0) # t0 = *arr1
    sw $t0, 0($t4) # *farr = t0
    addi $t4, 4 # farr++
    addi $a0, 4 # arr1++
    addi $t1, 1 # i1++
    j end_loop_1_start
    end_loop_1_end:

    end_loop_2_start:
    # if i2 >= l2: break
    slt $t8, $t3, $a3
    beqz $t8, end_loop_2_end
    lw $t2, 0($a2) # t2 = *arr2
    sw $t2, 0($t4) # *farr = t2
    addi $t4, 4 # farr++
    addi $a2, 4 # arr2++
    addi $t3, 1 # i2++
    j end_loop_2_start
    end_loop_2_end:

    # return to caller
    jr $ra

.end merge

.ent mergesort
mergesort:
    # arguments: arr[], l
    # return value: 0 - success; 1 - failure

    # save stuff
    sub $sp, 40
    sw $ra, 36($sp)
    sw $s0, 32($sp)
    sw $s1, 28($sp)
    sw $s2, 24($sp)

    # if l == 1
    li $t0, 1
    bne $a1, $t0, non_unity
    # return 0
    li $v0, 0
    lw $ra, 36($sp)
    add $sp, 40
    jr $ra

    # else
    non_unity:
    # save arguments
    sw $a0, 40($sp)
    sw $a1, 44($sp)

    # mergesort(arr, l/2)
    li $t0, 2
    divu $a1, $t0
    mflo $a1
    move $s1, $a1 # s1 = l/2
    jal mergesort

    # mergesort(arr + l/2, l - l/2)
    # calculate arr + l/2
    li $t0, 4
    multu $s1, $t0
    mflo $t1 # t1 = 4 * l/2
    lw $t0, 40($sp) # t0 = arr
    add $a0, $t0, $t1 # a0 = arr + l/2
    move $s0, $a0 # s0 = arr + l/2
    # calculate l - l/2
    lw $t1, 44($sp) # t1 = l
    sub $a1, $t1, $s1 # a1 = l - l/2
    move $s2, $a1 # s2 = l - l/2
    jal mergesort

    # merge(arr, l/2, arr + l/2, l - l/2, tmp_arr)
    lw $a0, 40($sp) # a0 = arr
    move $a1, $s1   # a1 = l/2
    move $a2, $s0   # a2 = arr + l/2
    move $a3, $s2   # a3 = l - l/2
    la $t0, tmp_arr
    sw $t0, 16($sp) # push tmp_arr on stack (as a4)
    jal merge

    # check if sorted
    la $t0, tmp_arr  # t0 = tmp_arr
    addi $t4, $t0, 4 # t4 = tmp_arr + 1
    lw $t1, 44($sp)  # t1 = l - 1 ; index
    sub $t1, 1
    li $t3, 0        # t3 = 0 ; check_status (0:correct; 1:error)
    check_loop:
    lw $t8, 0($t0) # t8 = *(tmp_arr)
    lw $t9, 0($t4) # t9 = *(tmp_arr + 1)
    slt $t3, $t9, $t8 # t3 = (t9 < t8)? 1:0
    bnez $t3, return # if (t9 < t8): break
    move $t0, $t4 # tmp_arr ++
    addi $t4, 4   # (tmp_arr + 1) ++
    sub $t1, 1   # index++
    bgtz $t1, check_loop

    # copy from tmp_arr to arr
    la $t0, tmp_arr # t0 = tmp_arr
    lw $t1, 40($sp) # t1 = arr
    lw $t2, 44($sp) # loop counter
    copy_loop:
    # *arr = *tmp_arr
    lw $t4, 0($t0)
    sw $t4, 0($t1)
    # index++
    addi $t0, 4
    addi $t1, 4
    sub $t2, 1
    bgtz $t2, copy_loop

    # return
    return:
    move $v0, $t3 # set return value to check_status
    lw $ra, 36($sp)
    lw $s0, 32($sp)
    lw $s1, 28($sp)
    lw $s2, 24($sp)
    add $sp, 40
    jr $ra

.end mergesort


.ent main
main:
    # save ra
    sub $sp, 24
    sw $ra, 20($sp)

    # print main prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # intialize loop
    la $t0, inp_arr
    li $t1, 8
    la $a0, numprompt

    # read into array
    readloop:
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    sw $v0, 0($t0)
    addi $t0, 4
    sub $t1, 1
    bgtz $t1, readloop

    # call mergesort
    la $a0, inp_arr
    li $a1, 8
    jal mergesort

    # if return != 0
    beqz $v0, merge_ok
    # print error
    li $v0, 4
    la $a0, error
    syscall
    # return
    lw  $ra, 20($sp)
    add $sp, 24
    jr $ra

    # else
    merge_ok:

    # print end
    li $v0, 4
    la $a0, answer
    syscall

    # intialize loop
    la $t0, inp_arr
    li $t1, 8

    # print array
    printloop:
    li $v0, 1
    lw $a0, 0($t0)
    syscall
    li $v0, 4
    la $a0, comma
    syscall
    addi $t0, 4
    sub $t1, 1
    bgtz $t1, printloop

    # return
    lw $ra, 20($sp)
    add $sp, 24
    jr $ra
.end main

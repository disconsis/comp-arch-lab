# Q2

.text # == .code, i.e., code segment
main: # entry point for code

# li      $t1, 0x10000001 - pseudo-instruction to move 32-bit number to register
# is equivalent to:
lui     $t1, 0x1000     # temporary register t1 = 0x1000 << 16 == 0x10000000
ori     $t1, 0x0001     # t1 = 0x10000000 | 0x0001 == 0x10000001

# li      $t0, 0x20000002
lui     $t2, 0x2000
ori     $t2, 0x0002

# v0 - register for return value
add     $v0, $t2, $t1   # v0 = t2 + t1 == 0x30000003
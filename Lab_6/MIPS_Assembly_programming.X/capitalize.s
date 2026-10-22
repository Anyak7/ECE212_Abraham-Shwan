.set noreorder
.global main

.text
    
main:
    la $s0, msg1
    addi $s5, $zero, 0x0    #initializing count to 0
    addi $t2, $zero, 97	    #storing 97 in register t2
    addi $t3, $zero, 122    #storing 122 in register $t3
    addi $t4, $zero, -32
    addi $s7, $zero, 1
    
loop:
    add $t0, $s5, $s0
    lbu $t1, 0x0($t0)
    slt $s1, $t1, $t2 # t1 < 97
    slt $s2, $t3, $t1 # 122 < t1
    or $s1, $s1, $s2
    beq $t1, $0, end
    add $0, $0, $0
    beq $s1, $s7, stop
    add $0, $0, $0
    add $t1, $t1, $t4
    sb $t1, 0x0($t0)
stop:
    addi $s5, $s5, 0x1
    j loop
    add $0, $0, $0
end:
    j end
    add $0, $0, $0
    
    
    .data
msg1:
    .asciz "I wAS working in the LAB late ONE Night"

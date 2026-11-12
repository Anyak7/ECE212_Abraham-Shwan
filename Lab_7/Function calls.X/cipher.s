    .set noreorder
    .global main
 ####Begin the .text segment of the assembly file
    .text
main:
    la $s7, msg1
    addi $a0, $s7, 0
    jal capitalize
    add $0, $0, $0
    addi $t0, $zero, 0
loop:
    add $t1, $s7, $t0
    lbu $t2, 0($t1)
    beq $t2, $zero, end
    add $0, $0, $0
    
    li $t7, 'A'
    slt $t3, $t2, $t7
    bne $t3, $zero, next
    add $0, $0, $0
    
    slti $t3, $t2, 91
    addi $s1, $zero, 1
    bne $t3, $s1, next
    add $0, $0, $0
    
    add $a0, $t2, $zero
    addi $a1, $zero, 4
    jal enc_char
    add $0, $0, $0
    sb $v0, 0($t1)

next:
    addi $t0, $t0, 1
    j loop
    add $0, $0, $0
    
end:
    j end
    add $0, $0, $0
    
enc_char:
    li $t4, 'A'
    sub $t5, $a0, $t4
    add $t5, $t5, $a1
    li $t6, 26
    div $t5, $t6
    mfhi $t5
    add $v0, $t5, $t4
    jr $ra
    add $0, $0, $0


capitalize:
    addi $0, $zero, 0x0
    
    
loop2:
    add $s1, $a0, $s0
    lbu $s2, 0($s1)
    beq $s2, $zero, end2
    add $0, $0, $0
    
    slti $s3, $s2, 97
    bne $s3, $zero, stop
    add $0, $0, $0
    
    slti $s3, $s2, 123
    addi $t9, $zero, 1
    bne $s3, $t9, stop
    add $0, $0, $0
    
    addi $s2, $s2, -32
    sb $s2, 0($s1)
    
stop:
    addi $s0, $s0, 0x1
    j loop2
    add $0, $0, $0
end2:
    jr $ra
    add $0, $0, $0
    
    .data
msg1:
    .asciz "Trick Or Treat"
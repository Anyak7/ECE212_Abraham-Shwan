    .set noreorder
    .global main
    
#begin
    .text
main:
    la $s0, msg1
    addi $s5, $zero, 0x0
    
loop:
    add $t0, $s5, $s0
    lbu $t1, 0x0($t0)
    beq $t1, $0, end
    add $0, $0, $0
    addi $s5, $s5, 0x1
    j loop
    add $0, $0, $0
end:
    j end
    add $0, $0, $0
    
    
    .data
msg1:
    .asciz "hello"




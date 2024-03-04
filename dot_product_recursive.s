.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "\n"
space: .string " "
msg: .string "The dot product is: "

.text
main:
    addi s0, zero, 0    # s0 = result
    li a0, 5            # a0 = size of 5
    la a1, a            # a1 = &a
    la a2, b            # a2 = &b
    
    jal dot_product_recursive
    mv s0, a0           # move result from a0 to s0
    
    # print int, the result
    addi a0, zero, 4    # print string
    la, a1, msg         # print message
    ecall
    
    addi a0, x0, 1      # print int
    mv a1, s0           # print result
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall

dot_product_recursive:
    
    lw t0, 0(a1)        # t0 = a[0]
    lw t1, 0(a2)        # t1 = b[0]
    
    # base case
    addi t3, x0, 1      # t3 = 1
    beq a0, t3, exit_base_case      # if (size == 1) exit base case
    
    # mul a[0]*b[0]
    mul t2, t0, t1      # t2 = a[0]*b[0] 
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp)        # storing the ra value on the stack
    
    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, -1     # size - 1
    addi a1, a1, 4      # a + 1, next address of array a
    addi a2, a2, 4      # b + 1, next address of array b
    
    # save t2 which is the mul result to stack
    addi sp, sp, -4
    sw  t2, 0(sp)
    
    jal dot_product_recursive      # call to dot_product_recursive  
    
    # restore the original value before the call to dot_product_recursive
    lw t2, 0(sp)
    addi sp, sp, 4
    add a0, a0, t2
    
    lw ra, 0(sp)        # 
    addi sp, sp, 4
    jr ra
    
exit_base_case:
    mul a0, t0, t1      # a[0]*b[0]
    jr ra
    

 

.data
newline: .string "\n"
space: .string " "

.text
main:
    addi a0, x0, 110
    addi a1, x0, 50
    jal mult
    
    # print int
    mv a1, a0           # by convention the return value is always in a0
    addi a0, x0, 1
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall

mult:
    # base case
    # compare a1 with 1, if the two are equal exit the mul function
    
    addi t0, x0, 1
    beq a1, t0, exit_base_case
    
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp)        # storing the ra value on the stack
    
    # mult(a, b-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1     # b-1
    jal mult            # call to mult
    
    # a + mult(a, b-1) 
    mv t1, a0
    
    # restore the original value before the call of mult
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
    
exit_base_case:
    jr ra
    

 

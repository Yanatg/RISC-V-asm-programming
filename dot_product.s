.data
a: .word 1, 2, 3, 4, 5   # define an array a, initial values
b: .word 6, 7, 8, 9, 10  # define an array b, initial values
newline: .string "The dot product is: "

.text
main:
# register not to be used x0 to x17; reason to be explain after that
# register that we can use x5 to x9 and x18 to x31; reason to be explain after that

    addi x5, x0, 5        # x5 = size and set it to 5
    addi x6, x0, 0        # x6 = sop and set it to 0

    addi x8, x0, 0        # x8 = i and set it to 0
    la x9, a              # load address of a to x9
    la x7, b              # load address of b to x7

loop1:
    bge x8, x5, exit1       # jump to exit1 if i >= 5
    slli x18, x8, 2         # set x18 to i*4
    
    add x19, x18, x9        # add i*4 to the base address of a
    lw x20, 0(x19)          # x20 = a[i]
    
    add x19, x18, x7        # add i*4 to the base address of b
    lw x21, 0(x19)          # x21 = b[i]
    
    mul x22, x21, x20       # x22 = a[i] * b[i]
    add x6, x6, x22         # sop += a[i] * b[i]
    
    addi x8, x8, 1          # i++
    j loop1
    

exit1:
    addi a0, x0, 4        # print string
    la a1, newline
    ecall
    
    addi a0, x0, 1        # print sop
    add a1, x0, x6
    ecall
    
    
    addi a1, zero, 0      # exit with code 0
    addi a0, zero, 17
    ecall

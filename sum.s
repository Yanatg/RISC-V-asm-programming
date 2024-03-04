.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # define an array, initial value with 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

.text
main:
# register not to be used x0 to x17; reason to be explain after that
# register that we can use x5 to x9 and x18 to x31; reason to be explain after that

# int size=10, i, sum1 = 0, sum2 = 0;
    addi x5, x0, 10       # x5 = size and set it to 10
    addi x6, x0, 0        # x6 = sum1 and set it to 0
    addi x7, x0, 0        # x7 = sum2 and set it to 0

#    for(i = 0; i < size; i++)
#        arr1[i] = i + 1;
    addi x8, x0, 0        # x8 = i and set it to 0
    la x9, arr1           # load address of arr1 to x9

loop1:
    bge x8, x5, exit1
    # we need to calculate arr1[i]
    # we need the base address of arr1
    # then, we add an offset i*4 to the base address
    slli x18, x8, 2     # set x18 to i*4
    add x19, x18, x9    # add i*4 to the base address of arr1
    addi x20, x8, 1     # set x20 to i+1
    sw x20, 0(x19)      # arr[i] = i+1
    addi x8, x8, 1      # i++
    j loop1
    
exit1:
    addi x8, x0, 0      # set i to zero
    la x21, arr2        # load address of arr2 to x21

loop2:
    bge x8, x5, exit2
    # we need to calculate arr2[i]
    # we need the base address of arr2
    # then, we add an offset i*4 to the base address
    slli x18, x8, 2     # set x18 to i*4
    add x19, x18, x21   # add i*4 to the base address of arr2
    add x20, x8, x8     # set x20 to i+(2*i)
    sw x20, 0(x19)      # arr[i] = i+(2*i)
    addi x8, x8, 1      # i++
    j loop2
   
exit2:
    addi x8, x0, 0      # set i to 0
    
    
loop3:
    bge x8, x5, exit3
    # sum1 = sum1 + arr1[i];
    # sum2 = sum2 + arr2[i];
    slli x18, x8, 2     # set x18 to i*4
    add x19, x18, x9    # add i*4 to the base address of arr1
    lw x20, 0(x19)      # x20 has arr1[i]
    add x6, x6, x20     # sum1 = sum1 + arr1[i]
    add x19, x18, x21   # add i*4 to the base address off arr2 and put it to x19
    lw x20, 0(x19)      # x20 has arr2[i]
    add x7, x7, x20     # sum2 = sum2 + arr2[i]
    
    addi x8, x8, 1      # i++
    j loop3
    

exit3:
    addi a0, x0, 1        # print sum1
    add a1, x0, x6
    ecall
    
    addi a0, x0, 4        # print new line
    la a1, newline
    ecall
    
    addi a0, x0, 1        # print sum2
    add a1, x0, x7
    ecall
    
    addi a0, x0, 4        # print new line
    la a1, newline
    ecall
    
    addi a1, zero, 0        # exit with code 0
    addi a0, zero, 17
    ecall

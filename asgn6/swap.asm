.globl main, printArray

main:
    la a0, arr
    li a1, 4
    jal printArray
    
    la a0, arr
    li a1,2
    li a2,0
    jal swap
# what is in the arr now?
	
	la a0, arr
	li a1, 4		
    jal printArray
    li a7, 10
    ecall
    
    
swap:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp) # this will be used for 1
	sw s2, 12(sp) # this will be used for 2
	
	mv s0, a0
	mv s1, a1 # i
	mv s2, a2 # j
	
	slli t0, s1, 2
	add t0, s0, t0 # calculate address for i
	
	slli t1, s2, 2 # calculate address for j
	add t1, s0, t1
	
	lw t2, 0(t0) #swap elements 
	lw t3, 0(t1)
	sw t2, 0(t1) 
	sw t3, 0(t0)
	
	lw      ra, 0(sp)
        lw      s0, 4(sp)
        lw      s1, 8(sp)
        lw      s2, 12(sp)
        addi    sp, sp, 16
        ret
	
	
	
printArray:
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        sw      s1, 4(sp)
        sw      s2, 0(sp)
        mv      s0, a0
        mv      s1, a1
        
#    int i; #allocate to t0 register

#    for (i = 0; i < n; i++) {
for:
        mv  s2, x0

# i < n;
forloop:
        bge     s2, s1 endfor

#   printf("%d ", arr[i]);

        slli    t0, s2, 2  # multiply index by 4
        add     t1, s0, t0 # add full index to base address.
        lw      a0, 0(t1)  # load arr[i]
       
        li      a7, 1
        ecall              #print the number

        li      a0, 0x20
        li      a7, 11
        ecall              # print a space
        
#i++
        addi    s2, s2, 1  # increment i
        b       forloop
#    }
endfor:

#return from void function
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        lw      s1, 4(sp)
        lw      s2, 0(sp)
        addi    sp, sp, 16
        ret
#}	
.data
arr: .word 1 2 3 4

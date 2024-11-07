.globl swap
.globl selectionSort
.globl printArray

#struct def'n for reference
#struct studentNode {
#   char name[6];
#   int studentid;.....................
#   int coursenum;
#};

 
#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
# callee setup goes here
	addi sp, sp, -24
        sw ra, 20(sp)
        sw s0, 16(sp)
        sw s1, 12(sp)
        sw s2, 8(sp) # this will be i
        sw s3, 4(sp) # this will be min
        sw s4, 0(sp) # this will be j
        mv s0, a0 # array
        mv s1, a2 # size (n) = s1
        mv s2, a1 # s2 is now i
	
#    int j;
#    int min = i;
	add s3, zero, s2 # min = i... s2 is i

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi s4, s2, 1  #j = i + 1
	
forloop:
# j < n
	bge s4, s1, endfor
	
#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	slli    t0, s4, 4  # multiply index by 4s
        add     t1, s0, t0 # add full index to base address.
        lw      t2, 8(t1)  # load arr[i].studentid 
	
	slli    t0, s3, 4  # multiply index by 4s
        add     t1, s0, t0 # add full index to base address.
        lw      t4, 8(t1)  # load arr[i].studentid 
	
	bge t2, t4, endif1 # if arr[j] < arr[min]
		add s3, zero, s4 # min = j

#            min = j;    /* update the index of minimum element */
#        }
endif1:
	addi s4, s4, 1
	b forloop
#    }
endfor:
	mv a0, s0
	mv a1, s3
	mv a2, s1
	jal swap
	
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:
	addi t0, s2, 1
	bge t0, s1, endif2
	mv a0, s0 # moves array into a0
	addi a1, s2, 1 # a1 = i + 1
	mv a2, s1
	jal selectionSort


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.

#caller teardown for selectionSort goes here (if needed).

#    }
endif2:
	lw ra, 0(sp)
	addi sp, sp, 24
	ret

	
# callee teardown goes here


#}

 

#callee teardown goes here (if needed)


#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here
#    int i;
#    for (i = 0; i < n; i++) {
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        sw      s1, 4(sp)
        sw      s2, 0(sp)
        mv      s0, a0
        mv      s1, a1
for2:
	 mv  s2, x0
forloop2:

#use ecalls to implement printf
	bge     s2, s1 endfor2
#        printf("%d ", arr[i].studentid);
	
	slli    t0, s2, 4  # multiply index by 4s
        add     t1, s0, t0 # add full index to base address.
        lw      a0, 8(t1)  # load arr[i].studentid 
       
        li      a7, 1
        ecall              # print the number

        li      a0, 0x20
        li      a7, 11
        ecall              # print a space
        
        
	

	
	addi    s2, s2, 1  # increment i
        b       forloop2
endfor2:

#caller teardown goes here
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        lw      s1, 4(sp)
        lw      s2, 0(sp)
        addi    sp, sp, 24
        ret
#}
 
	
#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {

swap:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp) # this will be used for 1
	sw s2, 12(sp) # this will be used for 2
	
	mv s0, a0
	mv s1, a1 # i is in s1
	mv s2, a2 # j is in s2
	
	slli t0, s1, 4
	add t0, s0, t0 # calculate address for i
	
	slli t1, s2, 4 # calculate address for j
	add t1, s0, t1
	
	lw t2, 8(t0) #swap elements 
	lw t3, 8(t1)
	sw t2, 8(t1) 
	sw t3, 8(t0)
	
	lw      ra, 0(sp)
        lw      s0, 4(sp)
        lw      s1, 8(sp)
        lw      s2, 12(sp)
        addi    sp, sp, 16 # restores the values
        ret
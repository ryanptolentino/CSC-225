.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
	addi sp, sp -24
	sw ra, 0(sp) # saves the array
	sw s0, 4(sp) # this will be used for j
	sw s1, 8(sp) # this will be used for min
	sw s2, 12(sp) # this will be used to store i
	sw s3, 16(sp) # this will be used to store n
	sw s4, 20(sp) # saves the array base
	
	mv s2, a1 # moves i to s2
	mv s3, a2 # moves n to s3
	mv s4, a0 # s4 is the array base
	
#    int j;
#    int min = i;
	add s1, zero, s2 # min = i... s2 is i

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi s0, s2, 1  #j = i + 1
	
forloop:
# j < n
	bge s0, s3, endfor
	
#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	slli t1, s0, 2 # s0 is j 
	add t1, s4, t1
	lw t2, 0(t1) # t2 now holds the arr[j] data
	
	slli t3, s1, 2 # s1 is min
	add t3, s4, t3 
	lw t4, 0(t3) # t4 now holds the arr[min] val
	
	bge t2, t4, endif1 # if arr[j] < arr[min]
		add s1, zero, s0 # min = j

#            min = j;    /* update the index of minimum element */
#        }
endif1:
	addi s0, s0, 1
	b forloop
#    }
endfor:
	mv a0, s4
	mv a1, s1
	mv a2, s2
	jal swap
	
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:
	addi t0, s2, 1
	bge t0, s3, endif2
	mv a0, s4 # moves array into a0
	addi a1, s2, 1 # a1 = i + 1
	mv a2, s3
	jal selectionSort


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.

#caller teardown for selectionSort goes here (if needed).


#    }
endif2:
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	lw s4, 20(sp)
	addi sp, sp, 24
	ret

	
# callee teardown goes here


#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
 
swap:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp) # this will be used for 1
	sw s2, 12(sp) # this will be used for 2
	
	mv s0, a0
	mv s1, a1 # i is in s1
	mv s2, a2 # j is in s2
	
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
        addi    sp, sp, 16 # restores the values
        ret

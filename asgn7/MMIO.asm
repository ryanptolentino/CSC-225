.text
.globl printInt, printString, readString, printChar, readChar, readInt, exitProgram

printInt:
    lw  t0, DSR			# get DSR addr 
    lw  t0, (t0)		# load DSR val 
    slti t1, a0, 10		# checking to see if value is less than 10 
    beq t1, zero, endInt 	# if zero, branch to endInt 
    li t2, -1 			# set t2 to -1 
    sgt t1, a0, t2		#checking to see if value is greater than or equal to 0 
    
    beq t1, zero, endInt	# if t1 equal to 0 then branch to endInt 
    beq zero, t0, printInt	# if DSR is 0, jump back to start of fun. not ready to print 
    
    lw  t0, DDR			# get DDR value 
    sb  a0, (t0)		#storing DDR value into a0 to run ecall 
    li a7, 1			#call for print int 
    ecall
    ret
    jr ra 
    
    endInt:
       ret 
       jr ra 
    
printString:
    lw  t0, DSR         # get DSR value 
    lw  t0, (t0)        # load DSR value into t0 
    beq zero, t0, printString  # if t0 is equal to 0, loop back to printString. not ready to print

    lw  t0, DDR         # load DDR address into t0 
    loop1:
    	lbu t1, (a0)        # load a byte of the string into t1
    	beq zero, t1, end1   # if t1 is equal to 0, we've reached the end of the string
    	sb  t1, (t0)        # store the byte from t1 to the DDR address 
    	addi a0, a0, 1      # increment the string pointer 
    	j   loop1           # loop back to load the next byte

	end1:
    		li a7, 4
    		ecall
    		ret
    		jr ra

    

readString: 
    mv t3, a0				# move buff to t3 
	loop:
	    lw  t0, KBSR		#load whatevr in keyboard to t0
            lw  a0, (t0)		# load val into a0 
    	    beq zero, a0, loop 		# if 0, go to start of loop 
	
    	    lw  t0, KBDR		# load keyboard register into t0 
            lw  a0, (t0)		#loading into a0 
    		
    	    li a1, 0x0A			# 0x0A is the print line hex thing 
    	    beq a0, a1, endloop 	# if the input is enter, then go to the end of the loop 
    	    sb a0, (t3)			# store it into a0 and increase buff by 1
            addi t3, t3, 1
    	    j loop 			# jump to start of loop 
    	    jr ra 
    	    
    	    endloop:
    	        sb zero, (t3)		# store null char into buff to exit str 
    		li  a7, 11		# regular ecall stuff 
    		ecall
    		ret 
    		jr ra

readChar:

    lw  t0, KBSR			# load the char from keyboard into t0 
    lw  a0, (t0)			# load val into a0 
    beq zero, a0, readChar		# if 0, go to start of func 

    lw  t0, KBDR			# load keyboard register into t0 
    lw  a0, (t0)

    li  a7, 11				# regular ecall 
    ecall
    ret
    jr ra 

printChar:
    lw  t0, DSR				# get DSR address 	
    lw  t0, (t0)			# load DSR val 
    beq zero, t0, printChar		# if 0, jump to start of func 

    lw  t0, DDR				# getting  DDR value and storing it into a0 so we can ecall it 
    sb  a0, (t0)

    li  a7, 11
    ecall
    ret
    jr ra 

readInt:
    lw	t0, KBSR			# load int from keyboard into t0. moving it into a0
    lw	a0, (t0)
    
    beq zero, a0, readInt 		# if it's zero, go back to start of fun 
    
    lw	t0, KBDR			# load keyboard into t0, moving it into a0 again 
    lw	a0, (t0)

    		
    li  t1, 48     			# set t1 to the ASCII code for '0'
    sub a0, a0, t1 			# sub '0' from the digit to get its int val, then ecall 
    li	a7, 1
    ecall	
    ret
    jr ra 



exitProgram: 				# regular exit program stuffs 
    li  a7, 10
    ecall
    
    
.data
KBSR:   .word   0xffff0000
KBDR:   .word   0xffff0004
DSR:    .word   0xffff0008
DDR:    .word   0xffff000c

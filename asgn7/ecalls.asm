.text
.global printInt, printString, readString, printChar, readChar, readInt, exitProgram

printInt:
	slti t1, a0, 10		#checking to see if value is less than 10 
	beq t1, zero, endInt
	li t2, -1 
	sgt t1, a0, t2		#checking to see if value is greater than or equal to 0 
	beq t1, zero, endInt 
	li a7, 1
	ecall
	ret
	jr ra 
	endInt:
		ret 
		jr ra 
	
printString: 
    li a7, 4
    ecall
    ret
    jr ra
    

readString: 
    mv t3, a0
	loop:
    		li a7, 12  
    		ecall   
    		     
    		li a1, 0x0A
    		beq a0, a1, endloop 
    		sb a0, (t3)
    		addi t3, t3, 1
    		j loop 
	endloop:
    		sb zero, (t3)
    		ret 
    		jr ra

readChar: 
li a7, 12
ecall
ret 	
jr ra

printChar:
li a7, 11
ecall	
ret
jr ra 

readInt:
li a7, 5		
ecall
ret
jr ra 

exitProgram: 
li a7, 10
ecall
jr ra
	
	
	
	
	
	
	


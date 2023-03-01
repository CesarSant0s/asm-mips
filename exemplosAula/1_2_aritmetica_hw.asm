.data
	meu_num1: .half 45000

.text
	lh $a0, meu_num1	
	addi $v0, $0, 1
	syscall
	
	lhu $a0, meu_num1
	addi $v0, $0, 1
	syscall
	
	
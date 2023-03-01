.data
	meu_num1: .word 55
	meu_num2: .word 45
.text
	lw $s1, meu_num1
	lw $s2, meu_num2
	
	add $t0, $s1, $s2
	
	## imprimir na tela
	addi $v0, $zero, 1
	add $a0, $zero, $t0
	syscall

.data
	# aqui vão daods
	meu_num0: .word 11
	meu_num1: .word 21
.text
	# aqui vão instruções
	lw $s0, meu_num0
	lw $s1, meu_num1
	
	# somando $s0 e $s1
	add $t0, $s0, $s1
	
	addi $v0 , $zero, 1
	add $a0 , $zero, $t0
	syscall

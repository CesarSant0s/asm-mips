.data
	num0: .word 111
	num1: .word 40
	num3: .word 0x1000
	num4: .word 0x99facada
	
.text
	lw $s0, num0
	lw $s1, num1
	
	# Multiplicação
	
	mul $t0, $s0, $s1
	
	## imprimir na tela
	addi $v0, $0, 1
	add $a0, $0, $t0
	syscall
	
	## multiplicando num3 e num4
	lw $s3, num3
	lw $s4, num4
	## multiplicação signed, (preemche HI com o sinal)
	mul $t3, $s3, $s4  
	## multiplicação unsigned (preenche HI com zero)
	mulu $t3, $s3, $s4

	#divisão
	div $t0, $s0, $s1
	
	
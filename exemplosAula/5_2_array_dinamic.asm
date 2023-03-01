.data
	num_bytes: .word 12
	
.text 

	lw $a0, num_bytes
	addi $v0, $0, 9
	syscall
	#boa pratica: mover retorno para reg seguro
	add $s0, $v0, $0
		
	addi $t0, $0, 10
	sw $t0, 0($s0)
	
	addi $t0, $0, 11
	sw $t0, 4($s0)
	
	addi $t0, $0, 12
	sw $t0, 8($s0)
	
	#esta posicao esta fora do espaco alocado.
	#vai salvar, mas eventualmente em uma nova alocacao, 
	#poderá ser sobrescrito
	addi $t0, $0, 13
	sw $t0, 12($s0)
	
	#alocar uma nova regiao de memoria
	lw $a0, num_bytes
	addi $v0, $0, 9
	syscall
	add $s0, $v0, $0
	
	addi $t0, $0, 10
	sw $t0, 0($s0)
	
	addi $t0, $0, 11
	sw $t0, 4($s0)
	
	addi $t0, $0, 12
	sw $t0, 8($s0)
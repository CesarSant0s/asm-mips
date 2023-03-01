.data
	espaco_array: .space 20
	meu_array: .word 10, 20, 30, 40, 50

.text
# forma mais "correta"
	la $t0, meu_array
	
	lw $s0, 0($t0)
	lw $s1, 4($t0)
	lw $s2, 8($t0)
	lw $s3, 12($t0)
	lw $s4, 16($t0)
	
	#outra maneira
	add $t0, $0, $0 #indice atual inic. em zero
	lw $s0, meu_array($t0) #pseudo-instrucao
	
	addi $t0, $t0, 4 #incrementa o indice de 1 word
	lw $s1, meu_array($t0)
	
	addi $t0, $t0, 4
	lw $s2, meu_array($t0)
	
	addi $t0, $t0, 4
	lw $s3, meu_array($t0)
	
	addi $t0, $t0, 4
	lw $s4, meu_array($t0)
	
#salvando dados no espaco alocado
	la $s7, espaco_array
	
	sw $s4, 0($s7)
	sw $s3, 4($s7)
	sw $s2, 8($s7)
	sw $s1, 12($s7)
	sw $s0, 16($s7)
	
## outra forma
	addi $t0, $0, 16 #indice atual inic. em 16 (ultimo indice)
	sw $s0, espaco_array($t0) #pseudo-instrucao
	
	addi $t0, $t0, -4 #decrementa o indice de 1 word
	sw $s1, espaco_array($t0) #pseudo-instrucao
	
	addi $t0, $t0, -4 #decrementa o indice de 1 word
	sw $s2, espaco_array($t0) #pseudo-instrucao
	
	addi $t0, $t0, -4 #decrementa o indice de 1 word
	sw $s3, espaco_array($t0) #pseudo-instrucao
	
	addi $t0, $t0, -4 #decrementa o indice de 1 word
	sw $s4, espaco_array($t0) #pseudo-instrucao
# beq registrador1, registrador2, L1 
#   � se o valor do registrador1 for igual ao do registrador2 o programa ser� desviado para o label L1 
#   (beq = branch if equal).
# bne registrador1, registrador2, L1 
#   � se o valor do registrador1 n�o for igual ao do registrador2 o programa ser� desviado para o label L1 
#   ( ben = branch if not equal).

.data
	true_msg: .asciiz "Verdadeiro\n"
	false_msg: .asciiz "Falso\n"
	num1: .float 10.5
	num2: .float 10.8
.text
	lwc1 $f0, num1 #carrega no coprocessador 1
	lwc1 $f2, num2

	c.eq.s $f0, $f2 #comando de comparação. Resultado seta a flag 0
	
	bc1f false ##comandos que desviam baseados na flag 0
	bc1t true
	
	false:
		la $a0, false_msg
		addi $v0, $0, 4
		syscall
		j exit
	true:
		la $a0, true_msg
		addi $v0, $0, 4
		syscall
	exit:
		addi $v0, $0, 10
		syscall



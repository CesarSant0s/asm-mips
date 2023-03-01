.data
	num0: .word 10
	num1: .word 11
	num2: .word 12
	num3: .word 13
	
.text
 main:
	
	#colocar parametros da funcao nos $a's
	lw $a0, num0
	lw $a1, num1
	lw $a2, num2
	lw $a3, num3	
	
	#chamo a funcao com jal
	jal somar
	#boa pratica: mover o retorno para um reg seguro
	add $s0, $v0, $0
	
	#imprimo retorno da funcao
	addi $v0, $0, 1
	add $a0, $s0, $0
	syscall
	
	#encerro o codigo
 	addi $v0, $0, 10
 	syscall
 	
 somar:
 	add $v0, $a0, $a1
 	add $v0, $v0, $a2
 	add $v0, $v0, $a3
 	jr $ra
 	

 

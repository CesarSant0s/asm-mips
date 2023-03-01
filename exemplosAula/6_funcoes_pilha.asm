.data
	num0: .word 10
	num1: .word 20
	num2: .word 30
	num3: .word 40

.text
  main:
  	lw $a0, num0 ## carrego valores em regs de arg.
  	lw $a1, num1
  	lw $a2, num2
  	lw $a3, num3
  	jal media ## devio para a funcao media
  	add $s0, $v0, $0 ##coloco retorno da media em reg seguros
  	
  	## imprime inteiro
  	add $a0, $s0, $0
  	addi $v0, $0, 1
  	syscall  	
  	
  	addi $v0, $0, 10
  	syscall
  media:
  	addi $sp, $sp, -4 ## aloco uma entrada na pilha
  	sw $ra, 0($sp) # salvo meu $ra atual  	
  	jal soma
  	srl $v0, $v0, 2 #divide por quatro
  	lw $ra, 0($sp) #restaura o RA original
  	addi $sp, $sp, 4 # lavar os pratos: colocar a pilha do mesmo jeito que tava
  	jr $ra
  	  	
  soma:
  	#assume que valores em $a0-a3 devem ser somados
  	#retorno vai em $v0
  	add $v0, $a0, $a1
  	add $v0, $v0, $a2
  	add $v0, $v0, $a3
  	jr $ra
  	






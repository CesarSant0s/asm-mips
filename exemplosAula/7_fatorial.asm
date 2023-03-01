.data
	n: .word 3
	
.text
  main:
  	lw $a0, n
  	jal fatorial
  	add $s0, $v0, $0
  	
  	##imprime inteiro
  	addi $v0, $0, 1
  	add $a0, $s0, $0
  	syscall
  	
  	#término do programa
  	addi $v0, $0, 10
  	syscall
  fatorial:
  	slti $t0, $a0, 2
  	beq $t0, $0, recursao
  	#se chegar aqui, é caso base
  	addi $v0, $0, 1
  	jr $ra
  	
  	# se chegar aqui, rercursao
  	recursao:
  	addi $sp, $sp, -8 #aloca 2 espacos na pilha
  	sw $ra, 0($sp) # salvo ra
  	sw $a0, 4($sp) #salvo n (vou usar depois)
  	
  	addi $a0, $a0, -1 #decremno meu n para fat(n-1)
  	jal fatorial
  	lw $a0, 4($sp)    # recupero meu n original
  	mul $v0, $v0, $a0 # multiplico n*(n-1)!
  	lw $ra, 0($sp)    # recupero meu ra
  	addi $sp, $sp, 8   #lavos pratos: pilha restaurada
  	jr $ra             # retorno
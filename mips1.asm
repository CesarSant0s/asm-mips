.data
	msg: .asciiz "forenca um numero: "
	par: .asciiz "o numero � par."
	impar: .asciiz "o numero � impar."
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5 #leitura de inteiros
	syscall
	move $t0, $v0 # valor fornecido est� em t0

	li $t1,2
	div $t0, $t1
	
	mfhi $t3
	
	beqz $t3, imprimePar
	
	li $v0, 4
	la $a0, impar
	syscall
	
	li $v0, 10
	syscall
	
	imprimePar:
		li $v0, 4
		la $a0, par
		syscall
		
		li $v0, 10
		syscall
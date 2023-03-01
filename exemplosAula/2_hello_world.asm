.data
	numero_qualquer: .word 13000
	minha_str: .asciiz "Hello World"

.text
	# pseudo instrucao que carrega endereco de variavel
	la $s0, minha_str
	
	#invoca servico de impressao de strg	
	addi $v0, $0, 4
	addi $a0, $s0, $0
	syscall
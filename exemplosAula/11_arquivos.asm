.data
	arquivo: .asciiz "arquivo_bcc_2022_1.txt"
	flag: .word 1
	texto_escrito: .asciiz "Hello World no arquivo"
	num_chars: .word 22
	
.text
	
	## abre arquivo
	la $a0, arquivo
	lw $a1, flag
	addi $v0, $0, 13
	syscall
	add $s0, $v0, $0
	
	# escreve no arquivo
	add $a0, $s0, $0
	la $a1, texto_escrito
	lw $a2, num_chars
	addi $v0, $0, 15
	syscall
	
	#fecha arquivo
	add $a0, $s0, $0
	addi $v0, $0, 16
	syscall
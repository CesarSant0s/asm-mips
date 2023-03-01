$zero
$vo e $v1 - resultado de função
$a0 $a1 $a2 $a3 - argumento de funções
$ra - endereço de retorno de uma função (volta para depois da função ser chamada)
$t1 a $t9 - temporário, que pode ser modificado por fuções
$s1 a $s8 - similar ao de cima mas salvam os valores

instruções

li -  soma imediata
#atribuindo o valor 1 de forma imediata  
li $v0, 1


syscall - chamar comando do sistema
	$v0 - indicador de comando do sistema
	$a0 - endero para mensagens de retorno
	comandos
	1 - imprimir inteiros
	4 - imprimir char ou string
	10 - encerrar o programa
	
la - load address

lw - load word

li - load imediata

add - soma
	add $t0, $t1, $t2 #t0 = t1 + t2
	addi $t0, $t1, 15 #t0 = t1 + 15
	
sub - subtração
	sub $t0, $t1, $t2 #t0 = t1 - t2
	subi $t0, $t1, 15 #t0 = t1 - 15
	
mul - $s0, $t0, $t1 # s0 = t0 * t1

move - usando para mover dados de um registrador para outro
	move - $a0, $s0 # de a0 = s0

sll - shift left (ainda n entendi direito quando precisar lembrar)
	sei que é mais rápido que o mult para potencias de 2 ou algo do tipo
	sll - $s1, $t1, $10
	
div - divisao
	div $t0, $t1 # divisao de t0/t1
	# parte inteira vai para lo
	# resto vai para h1
	
	mflo $s0 # move o conteudo de lo para s0
	mfhi $s1 # move o conteudo de h1 para s1
	
	

exemplos{
	numero é par {
		.data
			msg: .asciiz "forenca um numero: "
			par: .asciiz "o numero é par."
			impar: .asciiz "o numero é impar."
		.text
			li $v0, 4
			la $a0, msg
			syscall
			
			li $v0, 5 #leitura de inteiros
			syscall
			move $t0, $v0 # valor fornecido está em t0

			li $t1,2
			div $t0, $t1
			
			mfhi $t3
			
			beq $t1, $zero, imprimePar
			
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
			
	}
	Leitura de string {
		.data
			pergunta: .asciiz "qual e o seuo nome ?"
			saudacao: .asciiz "ola, "
			nome: .space 25
		.text
			#impressao da pergunta
			li $v0, 4
			la $a0, pergunta
			syscall
			
			#leitura de string 
			li $v0, 8
			la $a0, nome
			la $a1, 25
			syscall
			
			#mostra saudacao
			li $v0, 4
			la $a0, saudacao
			syscall
			
			#imprimir o nome
			li $v0, 4
			la $a0, nome
			syscall
			
			
	}
	leitura de inteiros {
		.data 
			saudacao: .asciiz "Olá. por favor forneça sua idade: "
			saida: .asciiz "Sua idade é "
			
		.text
			
			li $v0, 4 # imprimir uma string
			la $a0, saudacao
			syscall
			
			li $v0, 5 #leitura de inteiros
			syscall
			
			move $t0, $v0 # valor fornecido está em t0
			li $v0, 4 
			la $a0, saida 
			syscall
			
			li $v0, 1
			move $a0, $t0
			syscall
	}
	divisao de numeros{
		.text
			li $t0, 32
			li $t1, 5
			
			div $t0, $t1
			
			# parte inteira para s0
			mflo $s0
			
			# resto para s1
			mfhi $s1
	}
	multiplicar numeros{
		.text
			li $t0, 12
			li $t1, 10
			
			mul $s0, $t0, $t1
			li $v0, 1
			move Sa0, $s0
			syscall
	}
	imprimir string {
		.data
			
		.text 
	}
	imprimir inteiro{
		.data 
			idade .word 56
		.text
			li $v0, 1
			lw $a0, idade 
			syscall
	}
	somar numeros{
		.text
			li $t0, 75 # ou addi t0, $zero, 75
			li $t1, 25
			add $s0, $t0, $t1
			addi $s1, $s0, 35
	}
	subtrair numeros{
		.text 
			li $t0, 75 # ou addi t0, $zero, 75
			li $t1, 25
			sub $s0, $t0, $t1
			subi $s1, $s0, 35
	}
}

.data
	# aqui v�o daods
	meu_num0: .word 11
	meu_num1: .word 21
.text
	# aqui v�o instru��es
	lw $s0, meu_num0
	lw $s1, meu_num1
	
	# somando $s0 e $s1
	add $t0, $s0, $s1
	
	addi $v0 , $zero, 1
	add $a0 , $zero, $t0
	syscall


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
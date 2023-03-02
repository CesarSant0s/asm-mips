.data
prompt: .asciiz "Digite um n�mero: "
result: .asciiz "O n�mero de Fibonacci �: "

.text
.globl main

# Fun��o principal
main:
    # Exibe a mensagem de prompt e l� a entrada do usu�rio
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, prompt	# carregar a string
    syscall
    
    li 		$v0, 5		# adiciona o codigo do syscall
    syscall
    move 	$a0, $v0  	# Salva o input em $a0
    add		$a0, $a0, -1	# reduzindo o valor de n (j� que o metodo soma todos os valores at� n)
    
    jal 	fibonacci	# Chama a fun��o que come�a a s�rie de Fibonacci
    move 	$t0, $v0	# move o retorno do metodo para o reg $t0 ($v0 sera sobrescrito para chamar o syscall)
    
    li 		$v0, 4		# adiciona o codigo do syscall para exibe o resultado na tela
    la 		$a0, result	# carregar a string
    syscall
    
    move 	$a0, $t0   	# Move o resultado para o registrador de argumento
    li 		$v0, 1		# adiciona o codigo do syscall
    syscall
    
    li 		$v0, 10		# adiciona o codigo do syscall para terminar o programa
    syscall

fibonacci:
    bgt 	$a0, 1, fib_recursivo	# confere se o valor em $a0 � maior que 1
    move	$v0, $a0		# move $a0 para $v0 para retornar o resultado.
    jr		$ra			# retorno a chamada do metodo

# Fun��o recursiva de Fibonacci
fib_recursivo:
    sub		$sp, $sp, 12		# alocando 4 espacos na pilha
    sw		$ra, 0($sp)		# salvando o $ra anterior
    sw		$a0, 4($sp)		# salvando o n
    
    add		$a0, $a0, -1		# encontrando n-1
    jal		fibonacci		# encontrando fib(n-1)
    lw		$a0, 4($sp)		# recuperando o n
    sw		$v0, 8($sp)		# salvando fib(n-1) na 3 posi��o da pilha
    
    add		$a0, $a0, -2		# encontrando n-2 atrav�s do n recuperado acima
    jal		fibonacci		# encontrando fib(n-2)
    
    lw		$t0, 8($sp)		# recuperando fib(n-1)
    add		$v0, $t0, $v0		# somando os valores de fib(n-1) [$t0] e fib(n-2) [retornado em $v0]
    
    lw		$ra, 0($sp)		# restaurando o valor do $ra
    add 	$sp, $sp, 12		# restaurando a pilha
    jr		$ra			# retorno a chamada do metodo
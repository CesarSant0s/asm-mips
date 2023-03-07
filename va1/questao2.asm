# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questão 2.
# Algoritmo que conta quantos caracteres a string fornecida possui e imprime o valor total de caracteres.

.data
    string: .space 255
    newline: .asciiz "\n"
.text
.main

# leitura de string
    li 		$v0, 8
    la 		$a0, string
    la 		$a1, 255
    syscall 

    la 		$a0, string 		# carrega string do usuario no registrador a0
    jal 	tamanhoString 		# jump to target and save position to $ra
    move 	$a0, $v0 		# movendo o tamanho da string de $v0 para a0 (argumento do syscall)

    li 		$v0, 1 			# Sistema de saida (print integer)
    syscall 				# Chamar o sistema para imprimir o comprimento
    
    li 		$v0, 10 		# Sistema de saida (exit)
    syscall 				# Encerrar o programa


tamanhoString:
    li 		$t0, 0 			# Contador de caracteres
    move 	$t1,  $a0 		# Endereco da string

loop:
    lb 		$t2, 0($t1) 		# Carregar um byte da string
    beq 	$t2, $0, end 		# Se for o caractere nulo, sair do loop
    addi 	$t0, $t0, 1 		# Incrementar o contador
    addi 	$t1, $t1, 1 		# Avancar para o proximo caractere
    j 		loop

end:
    subi 	$t0, $t0, 1 		# O ultimo indice em $t0 eh o caractere nulo, logo o removemos para o número apresentado ser o verdadeiro.
    move 	$v0, $t0 		# movendo o tamanho da string de $t0 para $v0
    jr 		$ra 			# jump para $ra

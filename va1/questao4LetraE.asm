# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra B.
# Algoritmo que implementa a função strcmp, porém como um limente de caracteres que devem ser comparados.

.data
    string: .asciiz "string1"
    string_to_concat: .asciiz "string2"
.text
.main

    la $a0, string              # adicionando o enderco da string de destino
    la $a1, string_to_concat    # adicionando o enderco da string que sera adicionada
    jal	concat_strings          # executando a função concat_strings
    
    move $s0, $v0               # salvando o resultado da função em v0
    addi $v0, $0, 4             # Adiciona o codigo 4 para a impressao da string
    move $a0, $s0               # passa o endereço que deve ser exibido
    syscall         	        # execute

    addi	$v0, $0, 10	        # Adiciona o codigo 10 para finalizar o programa
    syscall         	        # execute


concat_strings:
    addi $sp, $sp, -4           # reserva espaço na pilha para salvar o endereço de retorno
    sw $ra, ($sp)               # salva o endereço de retorno na pilha
    
    # percorre destination até encontrar o caractere nulo
    move $t0, $a0               # t0 = endereço de destination

    loop1:
        lb $t1, ($t0)           # t1 = byte atual de destination
        beqz $t1, foundNull     # se o byte for nulo, sair do loop
        addi $t0, $t0, 1        # avança para o próximo byte
        j loop1                 # continuar no loop

    foundNull:
        # copia a string de source para destination
        move $t2, $a1           # t2 = endereço de source
    loop2:
        lb $t3, ($t2)           # t3 = byte atual de source
        sb $t3, ($t0)           # copia o byte para destination
        addi $t0, $t0, 1        # avança o endereço de destination
        addi $t2, $t2, 1        # avança o endereço de source
        bnez $t3, loop2         # se o byte copiado não for nulo, continuar a cópia

        # adiciona um caractere nulo no final da string concatenada
        li $t3, 0               # t3 = valor ASCII do caractere nulo
        sb $t3, ($t0)           # adiciona o caractere nulo em destination

        # restaura o endereço de retorno e retorna
        lw $ra, ($sp)           # recupera o endereço de retorno da pilha
        addi $sp, $sp, 4        # libera o espaço reservado na pilha
        move $v0, $a0           # retorna o endereço de destination
        jr $ra                  # retorna ao endereço de retorno
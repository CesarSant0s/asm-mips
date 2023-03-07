# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra B.
# Algoritmo que implementa a função strcmp.

.data
    string: .space 255
    string_to_compare: .space 255
    newline: .asciiz "\n"
.text
.main

# leitura de string
    li $v0, 8           # Adiciona o codigo 8 para a leitura da string
    la $a0, string      # Adiciona o endereco da string como argumento do syscall
    la $a1, 255         # Segundo argumento do syscall, tamanho reservado de captura.
    syscall             # execute

    li $v0, 8           # Adiciona o codigo 8 para a leitura da string
    la $a0, string_to_compare # Adiciona o endereco da string como argumento do syscall
    la $a1, 255         # Segundo argumento do syscall, tamanho reservado de captura.
    syscall 

    la $a0, string      # atribui o endereco de memória para comparacao a0
    la $a1, string_to_compare # atribui o endereço de memória para comparacao a1
    jal	strcmp          # executando a função strcmp
    
    move $s0, $v0       # salvando o resultado da função em v0
    addi $v0, $0, 1	    # Adiciona o codigo 1 para impressao da inteiro
    add	$a0, $0, $s0    # passa o endereço que deve ser exibido
    syscall	            # execute

    addi $v0, $0, 10	# System call 10 - Exit
    syscall	            # execute

# Implementação da função strcpy
# $a0 - endereço de memória para comparacao a0
# $a1 - endereço de memória para comparacao a1
# $v0 - resultado da comparacao
    strcmp:
    # Inicializa os registradores temporários
        add  $t0, $a0, $zero    # Endereço de memória do destino em $s0
        add  $t1, $a1, $zero    # Endereço de memória da origem em $s1
        
    loop:
        lb $t2, ($t0)           # carrega o caractere atual de str1
        lb $t3, ($t1)           # carrega o caractere atual de str2
        beq $t2, $zero, end     # se str1 acabou, termina
        beq $t3, $zero, end     # se str2 acabou, termina
        sub $t4, $t2, $t3       # compara os caracteres
        bne $t4, $zero, end     # se os caracteres são diferentes, termina
        addi $t0, $t0, 1        # avança para o próximo caractere de str1
        addi $t1, $t1, 1        # avança para o próximo caractere de str2
        j loop

    end:
        sub $v0, $t2, $t3  # retorna o valor da comparação
        jr $ra

# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra B.
# Algoritmo que implementa a função strcmp, porém como um limente de caracteres que devem ser comparados.

.data
    string: .space 255
    string_to_compare: .space 255
    newline: .asciiz "\n"
    num: .word
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

    addi $v0, $0, 5	    # system call #5 - input int
    syscall	            # execute

    la $a0, string      # atribui o endereco de memória para comparacao a0
    la $a1, string_to_compare # atribui o endereço de memória para comparacao a1 
    move $a2, $v0       # atribui o limete informado para comparacao
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
# $a2 - limete de caractares para comparacao
    strcmp:
        li $t0, 0     # inicializa o contador
        add  $t1, $a0, $zero    # Endereço de memória do destino em $s0
        add  $t2, $a1, $zero    # Endereço de memória da origem em $s1
    loop:
        beq $t0, $a2, end       # Se i = num, retorna 0 (strings são iguais até o num-ésimo caractere)
        lb $t3, ($t1)           # carrega o caractere atual de str1
        lb $t4, ($t2)           # carrega o caractere atual de str2
        beq $t3, $zero, end     # se str1 acabou, termina
        beq $t4, $zero, end     # se str2 acabou, termina
        sub $t5, $t3, $t4       # compara os caracteres
        bne $t5, $zero, end     # se os caracteres são diferentes, termina
        addi $t0, $t0, 1        # incrementa o contador
        addi $t1, $t1, 1        # avança para o próximo caractere de str1
        addi $t2, $t2, 1        # avança para o próximo caractere de str2
        j loop

    end:
        sub $v0, $t3, $t4  # retorna o valor da comparação
        jr $ra
# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra A.
# Algoritmo que implementa a função strcpy.

.data
    string: .space 255
    newline: .asciiz "\n"
    new_string: .asciiz ""
.text
.main

# leitura de string
    li $v0, 8 # Adiciona o codigo 8 para a leitura da string
    la $a0, string # Adiciona o endereco da string como argumento do syscall
    la $a1, 255 # Segundo argumento do syscall, tamanho reservado de captur.
    syscall # execute

    la $a0, new_string # Atribuindo o Enderço de destino para executar a função
    la $a1, string # Atribuindo o Enderço de origiem para executar a função
    jal	strcpy # executando a função str copy

    move $s0, $v0 # salvando o resultado da função em v0
    addi $v0, $0, 4 # Adiciona o codigo 4 para a impressao da string
    move $a0, $s0 # passa o endereço que deve ser exibido
    syscall	# execute

    addi	$v0, $0, 10	# Adiciona o codigo 10 para finalizar o programa
    syscall	# execute

# Implementação da função strcpy
# $a0 - endereço de memória do destino
# $a1 - endereço de memória da origem
# $v0 - endereço de memória do destino atualizado
strcpy:
    # Inicializa os registradores temporários
    add $t1, $a0, $zero # Endereço de memória do destino em $t1
    add $t2, $a1, $zero # Endereço de memória da origem em $t2
    move $v0, $a0 # Copia o endereço de memória do destino para $v0
    loop:
        lbu $t0, 0($t2) # Carrega o próximo caractere da string de origem em $t0
        sb $t0, 0($t1) # Copia o caractere para o destino
        addi $t1, $t1, 1 # Avança para o próximo byte do destino
        addi $t2, $t2, 1 # Avança para o próximo byte da origem
        bnez $t0, loop  # Repete até encontrar o caractere nulo
        jr $ra # Retorna para a função chamadora

# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra B.
# Algoritmo que implementa a função memcpy.

.data
    string: .space 255
    newline: .asciiz "\n"
    new_string: .asciiz ""
.text
.main

# leitura de string
    li $v0, 8           # Adiciona o codigo 8 para a leitura da string
    la $a0, string      # Adiciona o endereco da string como argumento do syscall
    la $a1, 255         # Segundo argumento do syscall, tamanho reservado de captura.
    syscall             # execute

    la $a0, new_string  # Atribuindo o Enderço de destino para executar a função
    la $a1, string      # Atribuindo o Enderço de origiem para executar a função
    addi $a2, $t1, 3    # adicionando o número de bytes que precisam ser copiados
    jal	memcpy          # executando a função str copy

    move $s0, $v0       # salvando o resultado da função em v0
    addi $v0, $0, 4     # Adiciona o codigo 4 para a impressao da string
    move $a0, $s0       # passa o endereço que deve ser exibido
    syscall         	# execute

    addi	$v0, $0, 10	# Adiciona o codigo 10 para finalizar o programa
    syscall         	# execute

# Implementação da função memcpy
# $a0 - endereço de memória do destino
# $a1 - endereço de memória da origem
# $a2 - número de bytes a serem copiados
# $v0 - endereço de memória do destino
    memcpy:
        # Inicializa os registradores temporários
        add  $t1, $a0, $zero  # Endereço de memória do destino em $s0
        add  $t2, $a1, $zero  # Endereço de memória da origem em $s1
        add  $t3, $a2, $zero  # número de bytes a serem copiados
        move $v0, $a0         # Copia o endereço de memória do destino para $v0

        # Copia os bytes da origem para o destino
        loop:
        lbu  $t0, 0($t2)      # Carrega o próximo byte da origem em $t0
        sb   $t0, 0($t1)      # Copia o byte para o destino
        addi $t1, $t1, 1      # Avança para o próximo byte do destino
        addi $t2, $t2, 1      # Avança para o próximo byte da origem
        addi $t3, $t3, -1     # Decrementa o contador de bytes
        bnez $t3, loop        # Repete até copiar todos os bytes

        jr   $ra  # Retorna para a função chamador
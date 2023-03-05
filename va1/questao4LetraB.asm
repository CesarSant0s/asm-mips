.data
string: .space 255
newline: .asciiz "\n"
new_string: .asciiz ""
.text
.main

# leitura de string
    li $v0, 8 # Adiciona o codigo para o syscall
    la $a0, string # Adiciona o endereco da string como argumento do syscall
    la $a1, 255 # Segundo argumento do syscall, final da string.
    syscall 

    la $a0, new_string #
    la $a1, string # 
    addi $a2, $t1, 4 # $a2 = $t1 + 0
    jal	memcpy # jump to strcpy and save position to $ra
    
    move $s0, $v0
    addi $v0, $0, 4 # system call #4 - print string
    move $a0, $s0
    syscall	# execute

    addi	$v0, $0, 10	# System call 10 - Exit
    syscall	# execute

# Implementação da função memcpy
# $a0 - endereço de memória do destino
# $a1 - endereço de memória da origem
# $a2 - número de bytes a serem copiados
# $v0 - endereço de memória do destino
    memcpy:
        # Inicializa os registradores
        add  $s0, $a0, $zero  # Endereço de memória do destino em $s0
        add  $s1, $a1, $zero  # Endereço de memória da origem em $s1
        move $v0, $a0         # Copia o endereço de memória do destino para $v0

        # Copia os bytes da origem para o destino
        loop:
        lbu  $t0, 0($s1)      # Carrega o próximo byte da origem em $t0
        sb   $t0, 0($s0)      # Copia o byte para o destino
        addi $s0, $s0, 1      # Avança para o próximo byte do destino
        addi $s1, $s1, 1      # Avança para o próximo byte da origem
        addi $a2, $a2, -1     # Decrementa o contador de bytes
        bnez $a2, loop        # Repete até copiar todos os bytes

        jr   $ra  # Retorna para a função chamador
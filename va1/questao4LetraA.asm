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
    jal	strcpy # jump to strcpy and save position to $ra
    
    move $s0, $v0
    addi $v0, $0, 4 # system call #4 - print string
    move $a0, $s0
    syscall	# execute

    addi	$v0, $0, 10	# System call 10 - Exit
    syscall	# execute

# Implementação da função strcpy
# $a0 - endereço de memória do destino
# $a1 - endereço de memória da origem
# $v0 - endereço de memória do destino atualizado
strcpy:
    # Inicializa os registradores
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

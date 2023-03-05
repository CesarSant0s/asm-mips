.data
string: .asciiz "cesar"
string_to_concat: .asciiz "henrique"
newline: .asciiz "\n"
.text
.main

# leitura de string
    # li $v0, 8 # Adiciona o codigo para o syscall
    # la $a0, string # Adiciona o endereco da string como argumento do syscall
    # la $a1, 255 # Segundo argumento do syscall, final da string.
    # syscall 

    # li $v0, 8 # Adiciona o codigo para o syscall
    # la $a0, string_to_concat # Adiciona o endereco da string como argumento do syscall
    # la $a1, 255 # Segundo argumento do syscall, final da string.
    # syscall 

    la $a0, string #
    la $a1, string_to_concat # 
    jal	concatenate_strings # jump to strcpy and save position to $ra
    
    move $s0, $v0
    addi $v0, $0, 4 # system call #4 - print string
    move $a0, $s0
    syscall	# execute

    addi	$v0, $0, 10	# System call 10 - Exit
    syscall	# execute


concatenate_strings:
    addi $sp, $sp, -4     # reserva espaço na pilha para salvar o endereço de retorno
    sw $ra, ($sp)         # salva o endereço de retorno na pilha
    
    # percorre destination até encontrar o caractere nulo
    move $t0, $a0         # t0 = endereço de destination
loop1:
    lb $t1, ($t0)         # t1 = byte atual de destination
    beqz $t1, foundNull   # se o byte for nulo, sair do loop
    addi $t0, $t0, 1      # avança para o próximo byte
    j loop1

foundNull:
    # copia a string de source para destination
    move $t2, $a1         # t2 = endereço de source
loop2:
    lb $t3, ($t2)         # t3 = byte atual de source
    sb $t3, ($t0)         # copia o byte para destination
    addi $t0, $t0, 1      # avança o endereço de destination
    addi $t2, $t2, 1      # avança o endereço de source
    bnez $t3, loop2       # se o byte copiado não for nulo, continuar a cópia

    # adiciona um caractere nulo no final da string concatenada
    li $t3, 0             # t3 = valor ASCII do caractere nulo
    sb $t3, ($t0)         # adiciona o caractere nulo em destination

    # restaura o endereço de retorno e retorna
    lw $ra, ($sp)         # recupera o endereço de retorno da pilha
    addi $sp, $sp, 4      # libera o espaço reservado na pilha
    move $v0, $a0         # retorna o endereço de destination
    jr $ra                # retorna ao endereço de retorno
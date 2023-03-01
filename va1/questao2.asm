.data
    string: .space 255
    newline: .asciiz "\n"
.text
.main

# leitura de string
    li $v0, 8
    la $a0, string
    la $a1, 255
    syscall 

    la $a0, string # carrega string do usuario no registrador a0
    jal tamanhoString # jump to target and save position to $ra
    move $a1, $v0 # $t0 = $t1

    li $v0, 1 # Sistema de sa?da (print integer)
    move $a0, $a1 # Passar o comprimento para $a0
    syscall # Chamar o sistema para imprimir o comprimento
    
    li $v0, 10 # Sistema de sa?da (exit)
    syscall # Encerrar o programa


tamanhoString:
    li $t0, 0 # Contador de caracteres
    move $t1,  $a0 # Endere?o da string

loop:
    lb $t2, 0($t1) # Carregar um byte da string
    beq $t2, $0, end # Se for o caractere nulo, sair do loop
    addi $t0, $t0, 1 # Incrementar o contador
    addi $t1, $t1, 1 # Avan?ar para o pr?ximo caractere
    j loop

end:
    subi $t0, $t0, 1 # $t0 = $t1 - 0
    move $v0, $t0 # movendo o tamanho da string de $t0 para $v0
    jr $ra # jump para $ra
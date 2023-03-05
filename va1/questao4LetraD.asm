.data
string: .space 255
string_to_compare: .space 255
newline: .asciiz "\n"
num: .word
.text
.main

# leitura de string
    li $v0, 8 # Adiciona o codigo para o syscall
    la $a0, string # Adiciona o endereco da string como argumento do syscall
    la $a1, 255 # Segundo argumento do syscall, final da string.
    syscall 

    li $v0, 8 # Adiciona o codigo para o syscall
    la $a0, string_to_compare # Adiciona o endereco da string como argumento do syscall
    la $a1, 255 # Segundo argumento do syscall, final da string.
    syscall 

    addi $v0, $0, 5	# system call #5 - input int
    syscall	# execute

    la $a0, string #
    la $a1, string_to_compare # 
    move $a3, $v0 # a3 = v0
    jal	strcmp # jump to strcpy and save position to $ra
    
    move $s0, $v0
    addi $v0, $0, 1	# system call #1 - print int
    add	$a0, $0, $s0
    syscall	# execute

    addi	$v0, $0, 10	# System call 10 - Exit
    syscall	# execute

# Implementação da função strcpy
# $a0 - endereço de memória para comparacao a0
# $a1 - endereço de memória para comparacao a1
    strcmp:
        li $t0, 0     # inicializa o contador
    loop:
        beq $t0, $a3, end          # Se i = num, retorna 0 (strings são iguais até o num-ésimo caractere)
        lb $t1, ($a0) # carrega o caractere atual de str1
        lb $t2, ($a1) # carrega o caractere atual de str2
        beq $t1, $zero, end   # se str1 acabou, termina
        beq $t2, $zero, end   # se str2 acabou, termina
        sub $t3, $t1, $t2     # compara os caracteres
        bne $t3, $zero, end   # se os caracteres são diferentes, termina
        addi $t0, $t0, 1      # incrementa o contador
        addi $a0, $a0, 1      # avança para o próximo caractere de str1
        addi $a1, $a1, 1      # avança para o próximo caractere de str2
        j loop

    end:
        sub $v0, $t1, $t2  # retorna o valor da comparação
        jr $ra
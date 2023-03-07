.data
    string: .space 25
    c1: .space 2
    c2: .space 2
    newline: .asciiz "\n"
    new_string: .asciiz ""
.text

# leitura de string
    li      $v0,        8                           # Adiciona o codigo para o syscall
    la      $a0,        string                      # Adiciona o endereco da string como argumento do syscall
    la      $a1,        25                          # Segundo argumento do syscall, final da string.
    syscall 

# leitura de c1
    li      $v0,        8                           # Adiciona o codigo para o syscall
    la      $a0,        c1                          # Adiciona o endereco da string como argumento do syscall
    la      $a1,        2                           # Segundo argumento do syscall, o final da string.
    syscall 

# pular linha
    li      $v0,        4                           # adicionar o codigo para o syscall
    la      $a0,        newline                     # adicionar um 'break line' ao argumento
    syscall 

# leitura de c2
    li      $v0,        8                           # Adiciona o codigo para o syscall
    la      $a0,        c2                          # Adiciona o endereco da string como argumento do syscall
    la      $a1,        2                           # Segundo argumento do syscall, o final da string.
    syscall 

# pular linha
    li      $v0,        4                           # Adiciona o codigo para o syscall
    la      $a0,        newline                     # Adiciona um 'break line' ao argumento
    syscall 

# Inicializa contadores e ponteiros
    la      $a0,        string                      # seta o endereco da string original
    la      $t1,        c1                          # Seta o endereco do caractere a ser substituido
    lb      $a1,        0($t1)                      # Usa o endereco em $t1 para carrecar o caractere
    la      $t1,        c2                          # Seta o endereco do caractere a substituto
    lb      $a2,        0($t1)                      # Usa o endereco em $t1 para carrecar o caractere substituto

    li      $t1,        0                           # Indice da proxima posicao para escrever na nova string
    la      $t2,        0($a0)                      # ponteiro para a string original
    la      $t3,        new_string                  # ponteiro para a nova string

loop:
    lb      $t4,        0($t2)                      # carrega o proximo caractere da string original
    beqz    $t4,        end                         # se for o caractere nulo, termina o loop
    beq     $t4,        $a1,        replace_char    # se for o caractere antigo, substitui
    sb      $t4,        0($t3)                      # senao, copia o caractere para a nova string
    addi    $t1,        $t1,        1               # avanca o ponteiro para a proxima posicao na nova string
    j       next_char

replace_char:
    sb      $a2,        0($t3)                      # substitui o caractere antigo pelo novo
    addi    $t1,        $t1,        1               # avanca o ponteiro para a proxima posicao na nova string

next_char:
    addi    $t2,        $t2,        1               # avanca o ponteiro para o proximo caractere na string original
    addi    $t3,        $t3,        1               # avanca o ponteiro para o proximo caractere na nova string
    j       loop

end:
    sb      $0,         0($t3)                      # adiciona o caractere nulo ao final da nova string
    addi    $v0,        $zero,      4               # adiciona o codigo do syscall
    la      $a0,        new_string                  # Adiciona a nova string como o argumento do syscall
    syscall 

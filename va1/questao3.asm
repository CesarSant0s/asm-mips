# Define as constantes para as operações
addi $zero, $zero, 0  # zero
addi $v0, $zero, 4    # print_string
addi $v1, $zero, 5    # read_int
syscall

# Lê o valor de n
add $s0, $zero, $v0   # Armazena o valor lido em $s0

# Chama a função recursiva e armazena o resultado em $s1
addi $sp, $sp, -8     # Reserva espaço para $ra e $s1 na pilha
sw   $ra, 0($sp)      # Salva o endereço de retorno na pilha
sw   $s1, 4($sp)      # Salva o valor de retorno na pilha
jal  fibonacci        # Chama a função recursiva
lw   $s1, 4($sp)      # Carrega o valor de retorno da pilha em $s1
lw   $ra, 0($sp)      # Restaura o endereço de retorno da pilha
addi $sp, $sp, 8      # Libera o espaço reservado na pilha

# Imprime o resultado
addi $v0, $zero, 1    # print_int
add $a0, $s1, $zero   # Passa o valor de retorno como argumento
syscall

# Sai do programa
addi $v0, $zero, 10   # exit
syscall


# Implementação da função fibonacci
fibonacci:
  addi $sp, $sp, -8     # Reserva espaço para $ra e $s1 na pilha
  sw   $ra, 0($sp)      # Salva o endereço de retorno na pilha
  sw   $s1, 4($sp)      # Salva o valor de retorno na pilha
  
  # Verifica se n é 0 ou 1 e retorna o valor correspondente
  beq  $s0, $zero, zero # Se n = 0, retorna 0
  beq  $s0, $at, one   # Se n = 1, retorna 1
  
  # Chama a função recursiva para n - 1 e armazena o resultado em $t0
  addi $s0, $s0, -1     # Decrementa n
  jal  fibonacci
  add  $t0, $zero, $v0  # Armazena o resultado em $t0
  
  # Chama a função recursiva para n - 2 e armazena o resultado em $t1
  addi $s0, $s0, -1     # Decrementa n novamente
  jal  fibonacci
  add  $t1, $zero, $v0  # Armazena o resultado em $t1
  
  # Soma os resultados e armazena o resultado final em $s1
  add  $s1, $t0, $t1    # Soma os resultados
  j    end              # Pula para o final da função
  
zero:
  addi $v0, $zero, 0    # Retorna 0
  j    done

one:
  addi $v0, $zero,
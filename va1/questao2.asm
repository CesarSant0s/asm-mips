.data
string: .asciiz "Sua string aqui"

.text
.globl main
main:
  li $t0, 0 # Contador de caracteres
  la $t1, string # Endereço da string

loop:
  lb $t2, 0($t1) # Carregar um byte da string
  beq $t2, $0, end # Se for o caractere nulo, sair do loop
  addi $t0, $t0, 1 # Incrementar o contador
  addi $t1, $t1, 1 # Avançar para o próximo caractere
  j loop

end:
  # $t0 agora contém o comprimento da string
  li $v0, 1 # Sistema de saída (print integer)
  move $a0, $t0 # Passar o comprimento para $a0
  syscall # Chamar o sistema para imprimir o comprimento
  li $v0, 10 # Sistema de saída (exit)
  syscall # Encerrar o programa
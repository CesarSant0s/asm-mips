.data
prompt: .asciiz "Digite uma string: "
comando: .space 50

ad_morador: .asciiz "ad_mor"
rm_modador: .asciiz "rm_mod"
ad_auto: .asciiz "ad_aut"
rm_auto: .asciiz "rm_aut"
limpar_ap: .asciiz "limpar"
info_ap: .asciiz "info_a"
info_geral: .asciiz "info_g"
salvar: .asciiz "salvar"
recarregar: .asciiz "recarr"
formatar: .asciiz "format"

teste: .asciiz "adicionado o morador\n"
teste2: .asciiz "limpo\n"

.text
.globl main

# Função principal
main:
    # Exibe a mensagem de prompt e lê a entrada do usuário
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 8
    la $a0, comando
    li $a1, 50
    syscall
    
    # Chama a função de roteamento
    jal roteamento
    
    
    j exit

# Função de roteamento
roteamento:
    # Carrega o endereço da string e o tamanho máximo permitido
    move 	$s0, $a0
    add		$a3, $zero, 6
       
    
    la 	$a1, ad_morador
    jal strcmp
    beq $v0, $zero, AdicionarMorador
    
    la 	$a1, rm_modador
    jal strcmp
    beq $v0, $zero, RemoverMorador
    
    la 	$a1, ad_auto
    jal strcmp
    beq $v0, $zero, AdicionarAutomovel
    
    la 	$a1, rm_auto
    jal strcmp
    beq $v0, $zero, RemoverAutomovel
    
    la 	$a1, limpar_ap
    jal strcmp
    beq $v0, $zero, LimparApartamento
    
    la 	$a1, info_ap
    jal strcmp
    beq $v0, $zero, InfoApartamento
    
    la 	$a1, info_geral
    jal strcmp
    beq $v0, $zero, InfoGeral
    
    la 	$a1, salvar
    jal strcmp
    beq $v0, $zero, SalvarDados
    
    la 	$a1, recarregar
    jal strcmp
    beq $v0, $zero, RecarregarDados
    
    la 	$a1, formatar
    jal strcmp
    beq $v0, $zero, FormatarDados
    
    
    AdicionarMorador:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    RemoverMorador:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    AdicionarAutomovel:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    RemoverAutomovel:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    LimparApartamento:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste2	# carregar a string teste
    syscall
    
    jal		main
    
    InfoApartamento:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    InfoGeral:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    SalvarDados:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    RecarregarDados:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    FormatarDados:
    li 		$v0, 4		# adiciona o codigo do syscall
    la 		$a0, teste	# carregar a string teste
    syscall
    
    jal		main
    
    
    
    
 ############ metodos Auxiliares ############ 
strcmp:
        li $t0, 0     		# inicializa o contador
    loop:
        beq $t0, $a3, end       # Se i = num, retorna 0 (strings são iguais até o num-ésimo caractere)
        lb $t1, ($a0) 		# carrega o caractere atual de str1
        lb $t2, ($a1) 		# carrega o caractere atual de str2
        beq $t1, $zero, end   	# se str1 acabou, termina
        beq $t2, $zero, end   	# se str2 acabou, termina
        sub $t3, $t1, $t2    	# compara os caracteres
        bne $t3, $zero, end   	# se os caracteres são diferentes, termina
        addi $t0, $t0, 1      	# incrementa o contador
        addi $a0, $a0, 1      	# avança para o próximo caractere de str1
        addi $a1, $a1, 1      	# avança para o próximo caractere de str2
        j loop

    end:
        sub $v0, $t1, $t2  	# retorna o valor da comparação
        sub $a0, $a0, $t0	# restaura $a0 para a posição inicial da string.
        jr $ra    
            
exit:
    li 		$v0, 10		# adiciona o codigo do syscall para terminar o programa
    syscall

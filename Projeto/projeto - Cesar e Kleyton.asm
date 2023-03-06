.data
prompt: .asciiz "Digite uma string: "
comando: .space 100
apartamentos: .space 40000
apto_numero: .word 4
apto_nome: .word 100

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

# Fun��o principal
main:
    # Exibe a mensagem de prompt e l� a entrada do usu�rio
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 8
    la $a0, comando
    li $a1, 100
    syscall
        
    # Chama a fun��o de roteamento
    jal roteamento
    
    
    j exit

# Fun��o de roteamento
roteamento:
    # Carrega o endere�o da string e o tamanho m�ximo permitido
    move 	$s7, $a0
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
    
# adicionar um novo morador    
AdicionarMorador:
    #ad_morador- [11 chars]  ad_morador-000-xxxxxxxxxxxxxxxx
            
    jal 	EncontrarSubstring	# removendo o comando, v0 como retorno
    
    add		$a0, $s0, 1		# pular o char '-'
    jal 	EncontrarSubstring	# v0 possui o valor do apto
    move 	$s4, $a0		# s4 contem o primeiro numero do apto
    sub		$s3, $v0, $s4		# s3 possui o numero de bytes do numero apto
    move	$s1, $v0		# s1 contem o ultimo numero do apto
    
    lb 		$t1, ($s4)		# carrego o numero do andar
    lb 		$t2, 2($s4)		# carrega o numero do apartamento
    beqz 	$t2, UltimoAndar 	#verificar se o apartamento eh no ultimo andar
    
    jal 	BuscarIndiceArray	# busca o indice do array
    move 	$a3, $v0		# move o retorno (indice do array) da funcao para a3
    
    la		$a0, apartamentos($a3)	# carrega o endero�o do array em a1
    move	$a1, $s4
    add 	$a2, $0, $s3		# 4 bytes de espa�o para o apto
    jal		memcpy 
    
    add		$a0, $s1, 1		# # restauro o antigo valor de a0 e pular o char '-'
    jal 	EncontrarSubstring	# v0 possui o nome do morador
    move 	$s4, $a0
    sub		$s3, $v0, $s4		# s3 possui o numero de bytes do numero apto
    move	$s1, $v0		# numero do apto movido pra s1
    
    la		$a0, apartamentos($a3)	# carrega o endero�o do array em a1
    move	$a1, $s4
    add 	$a2, $0, $s3		# bytes de espa�o para o nome do morador
    addi	$a0, $a0, 5
    jal		memcpy 
    
        
    la		$a0, apartamentos($a3)	# carrega o endero�o do array em a1
    li 		$v0, 4		# adiciona o codigo do syscall
    syscall			#imprimi o numero
    
    li		$v0, 4
    la 		$a0, apartamentos($a3)
    addi	$a0, $a0, 5
    syscall	
    
    jal		main			#retorna para o main
    
    
    UltimoAndar:
    mul 	$t1, $t1, 10		# multiplicando o 1 por 10, pra chegar no 10 andar.
    lb 		$t2, ($s1)		# t2 agora busca o n�mero seguinte ao zero
    
    jr		$ra			# retorno
    
    
    
    RemoverMorador:
    li 		$v0, 4			# adiciona o codigo do syscall
    la 		$a0, teste		# carregar a string teste
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
 
# Implementa��o da fun��o strcmp
# $a0 - endere�o de mem�ria para comparacao a0
# $a1 - endere�o de mem�ria para comparacao a1
strcmp:
        li $t0, 0     		# inicializa o contador
    loop_strcmp:
        beq $t0, $a3, end       # Se i = num, retorna 0 (strings s�o iguais at� o num-�simo caractere)
        lb $t1, ($a0) 		# carrega o caractere atual de str1
        lb $t2, ($a1) 		# carrega o caractere atual de str2
        beq $t1, $zero, end   	# se str1 acabou, termina
        beq $t2, $zero, end   	# se str2 acabou, termina
        sub $t3, $t1, $t2    	# compara os caracteres
        bne $t3, $zero, end   	# se os caracteres s�o diferentes, termina
        addi $t0, $t0, 1      	# incrementa o contador
        addi $a0, $a0, 1      	# avan�a para o pr�ximo caractere de str1
        addi $a1, $a1, 1      	# avan�a para o pr�ximo caractere de str2
        j loop_strcmp

    end:
        sub $v0, $t1, $t2  	# retorna o valor da compara��o
        sub $a0, $a0, $t0	# restaura $a0 para a posi��o inicial da string.
        jr $ra    
        

# Implementa��o da fun��o memcpy
# $a0 - endere�o de mem�ria do destino
# $a1 - endere�o de mem�ria da origem
# $a2 - n�mero de bytes a serem copiados
# $v0 - endere�o de mem�ria do destino
memcpy:
        # Inicializa os registradores
        add  $s0, $a0, $zero  # Endere�o de mem�ria do destino em $s0
        add  $t1, $a1, $zero  # Endere�o de mem�ria da origem em $s1
        move $v0, $a0         # Copia o endere�o de mem�ria do destino para $v0

        # Copia os bytes da origem para o destino
        loop_memcpy:
        lbu  $t0, 0($t1)      # Carrega o pr�ximo byte da origem em $t0
        sb   $t0, 0($s0)      # Copia o byte para o destino
        addi $s0, $s0, 1      # Avan�a para o pr�ximo byte do destino
        addi $t1, $t1, 1      # Avan�a para o pr�ximo byte da origem
        addi $a2, $a2, -1     # Decrementa o contador de bytes
        bnez $a2, loop_memcpy        # Repete at� copiar todos os bytes

        jr   $ra  # Retorna para a fun��o chamador
        
# Implementa��o da funcao BuscarIndiceArray
# $a0 - Numero do andar
# $a1 - Numero do apartamento (desconsiderando o andar)
# $v0 - Retorno da funcao      
 
BuscarIndiceArray:

	subi $t2, $t2, 48		# convertendo o caractere de t2 em inteiro
	subi $t1, $t1, 48		# convertendo o caractere de t1 em inteiro
	
    	subi $t1, $t1, 1 		# t1 = (t1-1)
    	mul  $t1, $t1, 4000		# t1 = (t1 * 4000)
    	mul  $t2, $t2, 1000		# t2 = (t2 * 1000)
    	subi $t2, $t2, 1000		# t2 = (t2 - 1000)
    	add  $t1, $t1, $t2		# t0 = (t0 - t2)
    	
    	move $v0, $t1			# move o resultado para v0
    	
    	jr   $ra  			# Retorna para a fun��o chamador
    	
EncontrarSubstring:
    # Salva o endere�o da string em $s0
    move $s0, $a0
    li $t0, 0				# Inicializa o contador de posi��o em 0	
	loop_substring:
    		lbu $t1, ($s0)
    		beq $t1, $zero, fim_substring  	# Se for nulo, termina o loop
    		beq $t1, 45, fim_substring     	# Se for '-', termina o loop
    		add $t2, $s0, $t0    	# Calcula o endere�o onde o caractere ser� armazenado
    		#sb $t1, ($t2)        	# Armazena o caractere na posi��o correspondente do array
    		
    		addi $t0, $t0, 1	# Incrementa o contador de posi��o
   		
    		addi $s0, $s0, 1	# Incrementa o endere�o da string
    		j loop_substring        # Volta para o in�cio do loop
	fim_substring:
		add $v0, $a0, $t0
    		jr 	$ra		# Termina a fun��o
   
            
exit:
    li 		$v0, 10		# adiciona o codigo do syscall para terminar o programa
    syscall

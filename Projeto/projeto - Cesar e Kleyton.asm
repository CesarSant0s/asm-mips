# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Projeto


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

# Função principal
main:
    # Exibe a mensagem de prompt e lê a entrada do usuário
    li 		$v0, 4			# adiciona o codigo do syscall para escrever a string
    la 		$a0, prompt		# carregar a string no argumento do syscall
    syscall
    
    li 		$v0, 8			# Adiciona o codigo para o syscall
    la 		$a0, comando		# Adiciona o endereco da string como argumento do syscall
    li 		$a1, 100		# Segundo argumento do syscall, final da string.
    syscall
    
    jal 	roteamento		# Chama a função de roteamento
    
    j 		exit			# Chama a função de parar o programa	

# Função de roteamento
roteamento:
    # Carrega o endereço da string e o tamanho máximo permitido
    move 	$s7, $a0			# salvando em s7 o endereço da string por precaucao
    add		$a3, $zero, 6			# limitando o tamanho maximo da string para comparacao
       
    
    la 		$a1, ad_morador			# salva o endereço da string de comparacao em a1 para adicionar morador
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, AdicionarMorador	# rotea o codigo para a funcao de adicionar morador
    
    la 		$a1, rm_modador			# salva o endereço da string de comparacao em a1 para remover morador
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, RemoverMorador	# rotea o codigo para a funcao de remover morador
    
    la 		$a1, ad_auto			# salva o endereço da string de comparacao em a1 para adicionar automovel
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, AdicionarAutomovel	# rotea o codigo para a funcao de adicionar automovel
    
    la 		$a1, rm_auto			# salva o endereço da string de comparacao em a1 para remover automovel
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, RemoverAutomovel	# rotea o codigo para a funcao de remover automovel
    
    la 		$a1, limpar_ap			# salva o endereço da string de comparacao em a1 para limpar apto
    jal 	strcmp				# chama o comparador de strings
    beq		$v0, $zero, LimparApartamento	# rotea o codigo para a funcao de limpar apto
    
    la 		$a1, info_ap			# salva o endereço da string de comparacao em a1 para obter info do apto
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, InfoApartamento	# rotea o codigo para a funcao de informacao de apto
    
    la 		$a1, info_geral			# salva o endereço da string de comparacao em a1 para obter infos gerais	
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, InfoGeral		# rotea o codigo para a funcao de infos gerais
    
    la 		$a1, salvar			# salva o endereço da string de comparacao em a1 para salvar em arquivo
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, SalvarDados		# rotea o codigo para a funcao de salvar arquivo
    
    la 		$a1, recarregar			# salva o endereço da string de comparacao em a1 para carregar os arquivos
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, RecarregarDados	# rotea o codigo para a funcao de recarregar dados
    
    la 		$a1, formatar			# salva o endereço da string de comparacao em a1 para apagar os registros
    jal 	strcmp				# chama o comparador de strings
    beq 	$v0, $zero, FormatarDados	# rotea o codigo para a funcao de formatar dados
    
# adicionar um novo morador    
AdicionarMorador:
            
    jal 	EncontrarSubstring	# removendo o comando, v0 como retorno
    
    add		$a0, $s0, 1		# pular o char '-' apos o comando
    jal 	EncontrarSubstring	# v0 possui o valor do apto (ultimo char do numero do apto)
    move 	$s4, $a0		# s4 contem o primeiro numero do apto
    sub		$s3, $v0, $s4		# s3 possui o numero de bytes do numero apto
    move	$s1, $v0		# s1 contem o ultimo numero do apto
    
    lb 		$t1, ($s4)		# carrego o numero do andar
    lb 		$t2, 2($s4)		# carrega o numero do apartamento
    beqz 	$t2, UltimoAndar 	#verificar se o apartamento eh no ultimo andar
    
    jal 	BuscarIndiceArray	# busca o indice do array (apartamentos) em que o apto em questão fica posicionado
    move 	$a3, $v0		# move o retorno (indice do array) da funcao para a3
    
    la		$a0, apartamentos($a3)	# carrega o endereço do array em a1
    move	$a1, $s4		# move a string com o endereço do apto para a1
    add 	$a2, $0, $s3		# 4 bytes de espaço para o apto
    jal		memcpy 			# copia o numero do apto para o array
    
    add		$a0, $s1, 1		# a0 vai para o indice apos o char '-' (comeco do nome)
    jal 	EncontrarSubstring	# v0 possui o ultimo indice nome do morador
    move 	$s4, $a0		# move o endereco como nome para s4
    sub		$s3, $v0, $s4		# s3 possui o numero de bytes do nome do morador
    move	$s1, $v0		# move o final do endereco do nome para s1
    
    la		$a0, apartamentos($a3)	# carrega o endereco do array em a0
    move	$a1, $s4		# move o inicio do endereco com o nome do morador para a0
    add 	$a2, $0, $s3		# bytes de espaço para o nome do morador
    addi	$a0, $a0, 5		# pulo 5 espaços (espaco reservado para o numero do apartamento)
    jal		memcpy 			# copia o nome do morador para o array
    
        
    la		$a0, apartamentos($a3)	# carrega o enderoço do array em a1
    li 		$v0, 4			# adiciona o codigo do syscall
    syscall				# imprime o numero
    
    la 		$a0, apartamentos($a3)	# carrega o enderoço do array em a1
    addi	$a0, $a0, 5		# pulo 5 espaços (espaco reservado para o numero do apartamento)
    syscall				# imprime o nome do morador
    
    jal		main			#retorna para o main
    
    
    UltimoAndar:
    mul 	$t1, $t1, 10		# multiplicando o 1 por 10, pra chegar no 10 andar.
    lb 		$t2, ($s1)		# t2 agora busca o número seguinte ao zero
    
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
 
# Implementação da função strcmp
# $a0 - endereço de memória para comparacao a0
# $a1 - endereço de memória para comparacao a1
strcmp:
        li $t0, 0     		# inicializa o contador
    loop_strcmp:
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
        j loop_strcmp

    end:
        sub $v0, $t1, $t2  	# retorna o valor da comparação
        sub $a0, $a0, $t0	# restaura $a0 para a posição inicial da string.
        jr $ra    
        

# Implementação da função memcpy
# $a0 - endereço de memória do destino
# $a1 - endereço de memória da origem
# $a2 - número de bytes a serem copiados
# $v0 - endereço de memória do destino
memcpy:
        # Inicializa os registradores
        add  $s0, $a0, $zero  # Endereço de memória do destino em $s0
        add  $t1, $a1, $zero  # Endereço de memória da origem em $s1
        move $v0, $a0         # Copia o endereço de memória do destino para $v0

        # Copia os bytes da origem para o destino
        loop_memcpy:
        lbu  $t0, 0($t1)      # Carrega o próximo byte da origem em $t0
        sb   $t0, 0($s0)      # Copia o byte para o destino
        addi $s0, $s0, 1      # Avança para o próximo byte do destino
        addi $t1, $t1, 1      # Avança para o próximo byte da origem
        addi $a2, $a2, -1     # Decrementa o contador de bytes
        bnez $a2, loop_memcpy        # Repete até copiar todos os bytes

        jr   $ra  # Retorna para a função chamador
        
# Implementação da funcao BuscarIndiceArray
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
    	
    	jr   $ra  			# Retorna para a função chamador
    	
EncontrarSubstring:
    # Salva o endereço da string em $s0
    move $s0, $a0
    li $t0, 0				# Inicializa o contador de posição em 0	
	loop_substring:
    		lbu $t1, ($s0)
    		beq $t1, $zero, fim_substring  	# Se for nulo, termina o loop
    		beq $t1, 45, fim_substring     	# Se for '-', termina o loop
    		add $t2, $s0, $t0    	# Calcula o endereço onde o caractere será armazenado
    		#sb $t1, ($t2)        	# Armazena o caractere na posição correspondente do array
    		
    		addi $t0, $t0, 1	# Incrementa o contador de posição
   		
    		addi $s0, $s0, 1	# Incrementa o endereço da string
    		j loop_substring        # Volta para o início do loop
	fim_substring:
		add $v0, $a0, $t0
    		jr 	$ra		# Termina a função
   
            
exit:
    li 		$v0, 10		# adiciona o codigo do syscall para terminar o programa
    syscall

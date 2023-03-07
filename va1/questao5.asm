# Grupo: Cesar Santos e Kleyton Clementino 
# Atividade 1VA
# Disciplina: Arquitetura e Organizacao de Computadores (LC-2022.1 UFRPE)
# Questao 4 letra B.
# Algoritmo que implementa a leitura de comandos do console.

loop: 
    lui $t0, 0xffff # salvando enderco ffff0000 em t0 como base 
    lw	$t1,0($t0)	# controle de leitura de caractere
    andi $t1,$t1,0x0001 # verifica se o sinal de controle de leitura é igual a 1
    beq	$t1,$0,loop # se for igual a zero continuar esperando
    lw	$a0,4($t0)	# se nao for igual salva o caractere que foi lido do teclado

    waitloop: # loop de escrita
        lw	$t1,8($t0)	# controle de escrita de caractere 
        andi $t1,$t1,0x0001 # verifica se o sinal de controle de escrita é igual a 1
        beq	$t1,$0,waitloop # se for igual a zero continuar esperando para poder escrever na tela
        sw	$a0,12($t0)	# se nao for igual escreve/carrega o caractere que foi lido do teclado na tela
    j loop
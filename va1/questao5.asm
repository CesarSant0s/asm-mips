.data 

.text

loop:
    lui $t0, 0xffff #ffff0000
    lw	$t1,0($t0)	#control
    andi $t1,$t1,0x0001
    beq	$t1,$0,loop
    lw	$a0,4($t0)	#data

    waitloop:
        lw	$t1,8($t0)	#control
        andi $t1,$t1,0x0001
        beq	$t1,$0,waitloop
        sw	$a0,12($t0)	#data
    j loop

    # leitura do teclado
    # lw	$t0, 0xffff0000 # verifica se tem carcatere
    # beq	$t0, $zero, loop	# if $t0 == $t1 then goto target
    
    # lw $t1, 0xffff0004

    # addi $t2, $t2, 1 # $t2 = $t2 + 0
    # sw $t1, 0xffff000c
    # sw $t2, 0xffff0008

    
    # lw	$t2, 0xffff0008
    # lw	$t3, 0xffff000c
    # # escrita no display
    # move $a0, $v0
    # li $v0, 4
    # syscall
    
     # volta para o in?cio do loop e continua lendo do teclado e escrevendo no display indefinidamente

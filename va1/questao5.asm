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


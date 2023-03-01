.data
	num0: .word 10
	num1: .word 11

.macro fim_de_codigo
	addi $v0, $0, 10
 	syscall
.end_macro

.macro somar(%parcela1, %parcela2, %soma )
	add %soma, %parcela1, %parcela2
.end_macro

.macro print_int(%inteiro)
	addi $v0, $0, 1
	add $a0, $0, %inteiro
	syscall
.end_macro

.text
	lw $s0, num0
	lw $s1, num1
	
	somar($s0, $s1, $t0)	
	print_int($t0)
	fim_de_codigo
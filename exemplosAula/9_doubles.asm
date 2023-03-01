.data
	pi: .double 3.1415
	e : .double 2.7183
	bl: .asciiz "\n"
	
.macro quebra #macro para quebra de linha
	la $a0, bl
	addi $v0, $0, 4
	syscall
.end_macro	
	
.text 
	ldc1 $f0, pi
	ldc1 $f2, e
	
	add.d $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 3
	syscall
	quebra
	
	sub.d $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 3
	syscall
	quebra
	
	mul.d $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 3
	syscall
	quebra
	
	div.d $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 3
	syscall
	
	
	
	

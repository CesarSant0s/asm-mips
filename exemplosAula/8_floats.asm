.data
	pi: .float 3.1415
	e : .float 2.7183
	bl: .asciiz "\n"
	
.macro quebra #macro para quebra de linha
	la $a0, bl
	addi $v0, $0, 4
	syscall
.end_macro	
	
.text 
	lwc1 $f0, pi
	lwc1 $f2, e
	
	add.s $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 2
	syscall
	quebra
	
	sub.s $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 2
	syscall
	quebra
	
	mul.s $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 2
	syscall
	quebra
	
	div.s $f12, $f0, $f2
	#imprime float
	addi $v0, $0, 2
	syscall
	
	
	
	
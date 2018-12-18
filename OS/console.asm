print_text:
	push 	ax
	print_loop:
		mov 	al, [ds:si]
		int	10h
		inc 	si
		test 	al, al
		jz 	exit_loop
		jmp 	print_loop
	exit_loop:
	pop 	ax
	ret

read_command:
	cmd:
		call 	read_key
		mov 	al, bl
		int 	10h
		cmp 	bl, 't'
		je 	cmd_exit
		jmp 	cmd
	cmd_exit:
	ret

read_key:
	push 	ax
	mov 	ah, 0x00
	int 	0x16
	mov 	bx, ax
	pop 	ax
	ret

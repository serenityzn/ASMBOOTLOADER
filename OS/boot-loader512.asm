[org 	0x7C00]  
[bits 	16]

KERNEL_OFFSET equ 0x1000

start:
	mov 	ah, 0x0E

	mov 	si, msg1
	call 	print_text
	call 	read_disk
	call 	KERNEL_OFFSET
	jmp 	$

print_text:
	print_loop:
		mov 	al, [ds:si]
		int	10h
		inc 	si
		test 	al, al
		jz 	exit_loop
		jmp 	print_loop
	exit_loop:
	ret

read_disk:
	push 	ax
	mov 	ch, 0x00 ; cylinder number
	mov 	cl, 0x02 ; sector number
	mov 	dh, 0x00 ; head number
	mov 	dl, 0x00 ; disk A - FDD
	mov 	ax, cs
	mov 	es, ax
	mov 	bx, KERNEL_OFFSET

	mov 	ah, 0x02
	mov 	al, 0x01

	int 	13h
	pop 	ax
	ret

msg1 db 'Started Boot Loader.', 0 
msg2 db 'Reading disk for Main Loader.', 0
times 510-($-$$) db 0
dw 	0xAA55

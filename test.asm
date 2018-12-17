section .code
	org 	0x7C00  ; наша программа загружается по адресу 0x7C00

	mov 	ax, cs
	mov 	ds, ax ; выбираем сегмент данных

main:
	mov 	ah, 0x0E  ; номер функции BIOS
	mov 	si, str1
	call	print_text
	mov 	ah, 0x00
	int 	0x16
	mov 	si, str5
	call	print_text
	jmp $

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

section .data
	str1 	db 	'To continue press any key', 0
	str5 	db 	'The End', 0


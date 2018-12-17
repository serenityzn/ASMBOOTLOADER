section .code
	org 	0x7C00  ; наша программа загружается по адресу 0x7C00

start:
	mov 	ax, cs
	mov 	ds, ax ; выбираем сегмент данных

video: 
	mov 	ah, 0x0E  ; номер функции BIOS
	mov 	si, 0
print_loop:
	call 	print_symbol
	inc 	si
	test 	al, al
	jz 	exit_loop
	jmp 	print_loop ; вечный цикл

exit_loop:
	call 	get_disk_info
	mov 	al, [diskmsg+si]
	int 	10h
	mov 	al, [diskmsg+di]
	int 	10h
	call 	read_disk
	jmp 	$

print_symbol:
	mov 	al, [message+si]
	int	10h
	ret

get_disk_info: ; checking if system has a flopy disk.
	mov 	si, 0
	push 	ax
	int 	11h ; get Data about disks to AX
	push 	bx

	mov 	bx, 0xC0
	and 	bx, ax 
	cmp 	bx, 0x00
	je 	c1
	cmp 	bx, 0x40
	je 	c2
	cmp 	bx, 0x80
	je 	c3
	cmp 	bx, 0xC0
	je 	c4

	c1:
		mov di, 2
		jmp cont
	c2:
		mov di, 3
		jmp cont
	c3:
		mov di, 4
		jmp cont
	c4:
		mov di, 5
	cont:
		mov 	bx, 0x01
		and 	bx, ax
		cmp 	bx, 0x00
		je      no
		jmp 	yes
	no:
		mov si, 1
	yes:
		pop 	bx
		pop 	ax
	ret

read_disk:
	push 	ax
	push 	bx
	
	mov 	ch, 0x00
	mov 	cl, 0x01
	mov 	dh, 0x00
	mov 	dl, 0x00
	mov 	ax, cs
	mov 	es, ax
	mov 	bx, buf

	mov 	ah, 0x02
	mov 	al, 0x01

	int 	13h
	pop 	bx
	pop 	ax
	ret

message db 'BOOTING Operation System... Floppy enabled: ', 0 
diskmsg db 'YN1234'
runcommand db 
buf:
	times 510-($-$$) db 0
	dw 	0xAA55

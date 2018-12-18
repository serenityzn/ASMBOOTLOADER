DATA_OFFSET equ 0x2000

read_disk:
	push 	ax
;	mov 	dl, 0x01 ; 00 - disk A - FDD  01 - disk B FDD
	mov 	ax, cs
	mov 	es, ax
	mov 	bx, DATA_OFFSET

	mov 	ah, 0x02
	mov 	al, 0x02

	int 	13h
	pop 	ax
	ret

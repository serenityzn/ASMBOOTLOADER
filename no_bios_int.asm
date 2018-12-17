	org 	0x7C00  ; наша программа загружается по адресу 0x7C00

%macro silly 2 ; 1 - message 2 - style
;	len: 		equ 	$-message
	mov 		cx, 9
	mov 		di, message1
	push 		di
	mov 		di, %1
myloop:
	mov 		al, [ds:di]
	mov 		dx, di
	inc 		dx
	pop 		di
	push 		dx
	mov 		ah, %2
	mov 		[ds:di], al
	mov 		[ds:di+1], ah
	mov 		dx, di
	add 		dx, 2
	pop 		di
	push 		dx
	loop 	myloop
%endmacro

start:
	mov 	ax, cs
	mov 	ds, ax ; выбираем сегмент данных
 
	mov 	ah, 0x03  ; номер функции BIOS
	int 	0x10
	cld
	
	mov 	ax, 0x0B800
	mov 	es, ax
	
	silly 	message, 0x02

	mov 	di, 0
	mov 	si, message1
	mov 	cx, 18
	cld
	
	rep 	movsb
	
exit_loop:
	jmp 	$

message 	db 	'Fuck off!'
message1 	db 	'empty'
finish:
;	times 0x1FE-finish+start db 0
;	db   0x55, 0xAA ; сигнатура загрузочного сектора

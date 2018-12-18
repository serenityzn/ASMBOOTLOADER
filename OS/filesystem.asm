fs_table_load: ; in si should have pointer to fstable. Returns cl, ch, dh with info about cylinder, head and sector
	push 	ax
	mov 	si, fstable
	add 	si, di
	mov 	ax, [ds:si] ; 0003
	mov 	ch, ah ; cylinder ch=00
	cmp	al, 0x13 
	jle	head0
	sub	al, 0x20
	mov 	dh, 0x01 ; head
	mov	cl, al ; sector
	jmp 	head1
	head0:
		mov 	dh, 0x00 ; head dh=00
		mov 	cl, al ; sector cl=03
	head1:
		pop 	ax
	ret

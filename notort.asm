myss segment para stack 'stack'
	dw 20h dup(?)
myss ends

myds segment para 'data'
	notlar db 65,78,56,95,21,55,3,47,84,48
	ort db 5 dup(?)
	genelort db ?
	ssayisi db 2
	ogrsayisi db 5
	notsayisi db 10
myds ends


mycs segment para 'code'
	assume ds:myds,cs:mycs,ss:myss

main proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax

		xor cx,cx
		xor bx,bx
		mov cl, notsayisi
		xor si,si
		xor di,di

	l1: mov al, notlar[si]
		add ort[di], al
		mov ax,si
		div ssayisi
		mov al,ssayisi
		dec al
		cmp ah, al
		jnz l2
		xor ah,ah
		mov al,ort[di]
		div ssayisi
		mov ort[di],al
		cmp ah,1
		jb l3
		inc ort[di]
	l3:	add bl,ort[di]
		adc bh,0
		inc di
	l2:	inc si
		loop l1
		mov ax,bx
		div ogrsayisi
		mov genelort,al
	retf
main endp

mycs ends
	end main

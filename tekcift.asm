
mys segment para 'MYS'
    org(100h)
    assume cs:mys, ss:mys, ds:mys, es:mys

main proc near
		xor cx,cx
		mov cl,len
		lea si,dizi
		xor ax,ax ; al: tek sayisi ah: cift sayisi
		mov bx,1
	l1: inc al
		test [si],bx
		jnz l2
		dec al
		inc ah
	l2:	add si,2
		loop l1
		mov tek,al
		mov cift,ah
		ret
main endp

dizi dw 10,48,7,15,2,5,78
len db 7
tek db ?
cift db ?

mys ends
    end main

sseg segment para stack 'stack'
	dw 20h dup(?)
sseg ends
dseg segment para 'data'

sayiw label word
sayi1 db 16
sayi2 db 250
sonuc dw ?

dseg ends

extrn topla:far
cseg segment para 'code'
	assume cs:cseg,ss:sseg,ds:dseg
main proc far
		push ds
		xor ax,ax
		push ax
		mov ax,dseg
		mov ds,ax
		
		push sayiw
		call topla
		pop sonuc
		retf
main endp

cseg ends
		end main

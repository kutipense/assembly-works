extrn topla:far
mseg segment para public 'code'
	assume cs:mseg,ss:mseg,ds:mseg
	org 100h

main proc near
		push sayiw
		call topla
		pop sonuc
		ret
main endp

	sayiw label word
	sayi1 db 16
	sayi2 db 250
	sonuc dw ?

mseg ends
		end main

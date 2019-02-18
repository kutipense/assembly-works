include misc.asm
mys segment para 'mys'
	org 100h
	assume cs:mys, ss:mys, ds:mys

main proc near
		push_all
		pop_all
		ret
main endp

sayilar label word
sayi1 db 12h
sayi2 db 14h
sayi3 label byte
sayi4 dw 18h

mys ends
	end main

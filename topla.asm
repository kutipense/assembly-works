
public topla
cseg segment para 'code'
topla proc far
		push bp
		mov bp,sp

		xor ax,ax
		mov al,[bp+6]
		add al,[bp+7]
		adc ah,0
		mov [bp+6],ax
		pop bp
		ret
topla endp
cseg ends
	end

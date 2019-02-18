push_all macro
		push ax
		push bx
		push cx
		push dx
		push es
		push si
		push di
		endm

pop_all macro
		pop di
		pop si
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		endm

myss segment para stack 		 'stack'
    dw 20 dup(?)
myss ends
myds segment para			 'data'
    dizi     db "abi çok zor degil be$"
    elements dw 10
    indizi   db 11 dup(?)


myds ends

mycs segment para 			 'code'
    assume cs:mycs, ss:myss, ds:myds
main proc far
    push ds 
    xor ax,ax
    push ax

    mov ax,myds
    mov ds,ax

    mov cx,elements
    lea si,indizi
    mov ah,01h
    
l1: int 21h
    mov [si],al
    inc si
    loop l1

    xor dx,dx

    mov cx,elements
    lea si,indizi
    mov ah,2

    mov dl,10
    int 21h

l2: mov dl,[si]
    int 21h
    inc si
    loop l2

    mov dl,10
    int 21h

    mov indizi[10],'$'
    lea dx,indizi
    mov ah,9h
    int 21h

     retf
main endp
mycs ends
    end main

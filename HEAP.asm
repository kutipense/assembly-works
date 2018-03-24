MYSTACK SEGMENT PARA STACK 'STACK'
    DW 20 DUP(?)
MYSTACK ENDS                     

MYDATA SEGMENT PARA 'DATA'
HEAPARRAY DW 6, 7, 9, 12, 17, 10, 1 
HEAPSIZE DW 12
HEAPLIMIT EQU 42
MYDATA ENDS

MYCODE SEGMENT PARA 'CODE' 
	ASSUME CS:MYCODE, SS:MYSTACK, DS:MYDATA 
    
LC2SI MACRO INDEX
    MOV SI,INDEX
    SHL SI,1
    ADD SI,2
    ENDM
    
RC2SI MACRO INDEX
    LC2SI INDEX
    ADD SI,2
    ENDM
    
PARENT2SI MACRO INDEX
    MOV SI,INDEX
    SUB SI,2
    SHR SI,1
    AND SI,0FFFEH
    ENDM

UPHEAPIFY PROC NEAR
    
    ;DI -> NODE
    ;BX -> HEAP ARRAY
    
   LU1:
    CMP DI,0
    JE LUEND         ;IF THERE ISN'T A PARENT
               
    PARENT2SI DI
    MOV AX,[BX+SI]
    CMP AX,[BX+DI]
    JL LUEND         ;IF PARENT IS SMALLER
    
    XCHG AX,[BX+DI]
    MOV [BX+SI],AX
    MOV DI,SI
    JMP LU1
    
   LUEND:
    RET    
UPHEAPIFY ENDP

DOWNHEAPIFY PROC NEAR
    
    ;DI -> NODE
    ;BX -> HEAP ARRAY
    
    PUSH AX
    PUSH DX
    
    LC2SI DI
    CMP SI,HEAPLIMIT 
    JG LDEND
    MOV DX,SI
    JE LD2
   LD1:   
    MOV AX,[BX+SI]
    CMP AX,[BX+SI+2]
    JL LD2
    ADD DX,2        
   LD2:
    MOV SI,DX
    MOV AX,[BX+DI]
    CMP AX,[BX+SI]
    JL LDEND
    XCHG AX,[BX+SI]
    MOV [BX+DI],AX
    MOV DI,SI
    CALL DOWNHEAPIFY
   LDEND:
    POP DX
    POP AX

    RET
DOWNHEAPIFY ENDP

INSERT PROC NEAR
    
    ;AX -> NODE VAL
    ;BX -> HEAP ARRAY
    
    CMP HEAPSIZE,HEAPLIMIT
    JGE LIEND
               
    ADD HEAPSIZE,2
    PUSH DI
    MOV DI,HEAPSIZE
    MOV [BX+DI],AX
    CALL UPHEAPIFY
    POP DI
   LIEND:
    RET    
INSERT ENDP

DELETE PROC NEAR
    
    ;DI -> NODE
    ;BX -> HEAP ARRAY
    
    CMP DI,HEAPSIZE
    JG LDELEND         
    
    MOV AX,[BX+HEAPSIZE]           
    MOV [BX+DI],AX
    CALL DOWNHEAPIFY
    SUB HEAPSIZE,2
   LDELEND:
    RET    
DELETE ENDP

POPMIN PROC NEAR
    ;BX -> HEAP ARRAY
    ;AX <- MIN
    
    XOR AX,AX
    CMP AX,HEAPSIZE
    MOV AX,0FFFFH       ;INT MAX
    JLE LPEND      
    MOV AX,[BX]
    PUSH DI
    MOV DI,0
    CALL DOWNHEAPIFY
    POP DI
   LPEND:
    
    RET    
POPMIN ENDP

MAIN PROC FAR
    XOR AX,AX
    PUSH AX
    PUSH DS 
    
    MOV AX,MYDATA
    MOV DS,AX      ;DS => MEM

    LEA BX,HEAPARRAY  
    MOV AX,10
    CALL INSERT
    RETF
       
MAIN ENDP

MYCODE ENDS
END MAIN





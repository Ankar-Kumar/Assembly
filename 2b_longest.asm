.MODEL SMALL
.STACK 100H
.DATA
   CNT Dw 20
   N DW 20
   IND DW   ?
   MSG DB 'anmkabrs$'
   str db 50
   T Dw ?
   mx dw ?
   ct dw ?
   
   ;NEWLINE DB 0AH,0DH,'$'
.CODE

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    MOV SI,8 
    mov ct,0 
    ;SCAN:
;        MOV AH,1H  
;        INT 21H
;        CMP AL,0Dh
;        JZ END_SCAN
;        MOV MSG[SI],AL
;        INC SI
;        JMP SCAN
;    
;    END_SCAN: 
;      MOV MSG[SI],'$'
;      CALL NEWLINE
      MOV N,SI 
      MOV CX,SI
      MOV SI,0  
      INC N
      MOV MX,'0'
    OUTLOOP:   
        CMP MSG[SI],'$'
        JE store2
        MOV IND,SI
        MOV DI,SI 
        
        MOV CNT,'1' 
        INLOOP: 
           CMP MSG[DI],'$'
           JE OUTLOOP
           INC DI             
           MOV BL,MSG[SI]
           CMP BL,MSG[DI]
           JG SKIP 
           INC CNT 
           MOV SI,DI
           JMP INLOOP
           SKIP:  
             MOV Dx,MX
             CMP CNT,Dx
             JG COUNT 
             ;MOV CNT,0 
             MOV SI,IND
             INC SI
             JMP OUTLOOP
           COUNT: 
            MOV Dx,CNT
            MOV mx,Dx
            sub si,mx
            ;dec si
            mov t,si
            MOV SI,IND
            INC SI 
            JMP OUTLOOP
    ;LOOP OUTLOOP
    store2:
        mov si,0  
        mov ax,t
        mov mx,ax
        ;sub mx,'0'
    ;mov cx,mx
    mov ah,02
    print: 
    
       mov dx,mx
       int 21h 
       mov ah,4ch
       int 21h
       
  
    

END MAIN

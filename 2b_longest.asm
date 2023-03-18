.MODEL SMALL
.STACK 100H
.DATA
   CNT Dw 20
   N DW 20
   IND DW   ?
   MSG DB 'abcdabcdefxyzbcdeabijklm$'
   str db 50
   T Dw ?
   mx dw ?
   ct dw ?
   
   ;NEWLINE DB 0AH,0DH,'$'
.CODE

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    
      MOV SI,0  
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
            
           
            MOV SI,IND  
             mov t,si
            INC SI 
            JMP OUTLOOP
    ;LOOP OUTLOOP
    store2:
        mov si,t  
       ; add si,'0'
        mov cx,0
    mov ah,02
    print: 
       cmp cx,mx
       je exit   
        
       mov DX,MX
       int 21h
       inc si
       inc cx
       
       jmp PRINT
       
       
    EXIT:
       mov ah,4ch
       int 21h
       
  
    

END MAIN

.MODEL SMALL
;.STACK 100H
.DATA
   CNT Dw 20
   N DW 20
   IND DW   ?
   MSG DB 50 dup('$');'bbbbbbaaaaabbbbb$';'abcdabcdeafgkxyzbcdeabklm$'
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
      MOV AH,01H
      SCAN: 
        INT 21H
        CMP AL,0DH
        JE END_SCAN
        MOV MSG[SI],AL
        INC SI
        JMP SCAN
      
      END_SCAN: 
        CMP SI,0
        JE EXIT;
        MOV MSG[SI],'$'
        call newline 
        ;;;;print statement started
        
        
        MOV SI,0        
        MOV MX,0
    OUTLOOP:   
        CMP MSG[SI],'$'
        JE store2
        MOV IND,SI
        MOV DI,SI 
        
        MOV CNT,1 
        INLOOP: 
           CMP MSG[DI],'$'
           JE OUTLOOP
           INC DI             
           MOV BL,MSG[SI]
           CMP BL,MSG[DI]
           JG SKIP
           jmp matha
           
           matha:
           mov al,msg[di]
           sub al,bl
           cmp al,1
           jne skip  
           INC CNT 
           MOV SI,DI
           JMP INLOOP
           SKIP:  
             MOV Dx,MX
             CMP CNT,Dx ;cnt,mx
             JG COUNT 
             ;MOV CNT,0 
             MOV SI,di
             
             JMP OUTLOOP
           COUNT: 
            MOV Dx,CNT
            MOV mx,Dx ;mx=cnt
            
           
            MOV SI,IND  
            mov t,si   ;t te index ta store krchi
            MOV SI,di
            JMP OUTLOOP
    
    store2:
        mov si,t
        ;add si,'0' 
       
        mov ah,02
    print:        
       mov dl,msg[si]
       int 21h
       inc si
       DEC MX
       cmp MX,0
       je exit
       jmp PRINT
       
       
    EXIT:
       mov ah,4ch
       int 21h
MAIN ENDP
    
 NEWLINE PROC
    MOV DL, 0AH ; carriage return
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH ; newline feed   
    INT 21H
    RET
 NEWLINE ENDP 

    

END MAIN

.MODEL SMALL
.STACK 100H
.DATA
   CNT Dw 20
   N DW 20
   IND DW   ?
   MSG DB 'abcdabcdefgxyzbcdeabijklm$'
   str db 50
   T Dw ?
   mx dw ?
   ct dw ?
   
   ;NEWLINE DB 0AH,0DH,'$'
.CODE

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    
     ; MOV SI,0 
;      MOV AH,01H
;      SCAN:
;        CMP AL,0DH
;        JE END_SCAN
;        MOV MSG[SI],AL
;        INT 21H
;        INC SI
;        JMP SCAN
;      
;      END_SCAN: 
;        MOV MSG[SI],'$'
;        call newline
;        
        
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
        ;add si,'0' 
       
        mov ah,02
    print:        
       mov dl,msg[si]
       int 21h
       inc si
       DEC MX
       cmp MX,'0'
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

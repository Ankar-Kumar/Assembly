.MODEL SMALL
.STACK 100H
.DATA
   CNT DB 20
   N DW 20
   IND DW   ?
   MSG DB 50
   T DB ?
   mx db ?
   
   ;NEWLINE DB 0AH,0DH,'$'
.CODE

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    MOV SI,0 
    
    SCAN:
        MOV AH,1H  
        INT 21H
        CMP AL,0Dh
        JZ END_SCAN
        MOV MSG[SI],AL
        INC SI
        JMP SCAN
    
    END_SCAN: 
      MOV MSG[SI],'$'
      CALL NEWLINE
      MOV N,SI 
      MOV CX,SI
      MOV SI,0  
      INC N
      MOV MX,'0'
    OUTLOOP:  
        CMP MSG[SI],'$'
        JE EXIT
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
             MOV DL,MX
             CMP CNT,DL
             JG COUNT 
             ;MOV CNT,0 
             MOV SI,IND
             INC SI
             JMP OUTLOOP
           COUNT: 
            MOV DL,CNT
            MOV mx,DL
            MOV SI,IND
            INC SI 
            JMP OUTLOOP
    ;LOOP OUTLOOP  
    
    EXIT:
    CALL NEWLINE
    MOV AH,2H 
    MOV DL,MX
    INT 21H
    MOV AH,4CH
    INT 21H
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

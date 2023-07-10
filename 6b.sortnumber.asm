

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP (?)
    inmsg DB "Enter the stirng of Number: $"
    outmsg DB "After sorting: $"
    n DW ?
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;input string
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0H
    
INPUT: ; input taking
    MOV AH, 01H
    INT 21H
    
    CMP AL, 0DH
    JZ ENDINPUT
    
    CMP AL,' '
    JE INPUT
    
    MOV str[SI], AL
   
    INC SI
    
    JMP INPUT
    
ENDINPUT:
    CALL NEWLINE ; new line feed
    
    MOV n, SI 
    
     MOV CX, N
     ; IF ARRAY LENGTH 1
     CMP N,1
     JE SINGLE
     ; IF ARRAY LENGTH 0
     JCXZ EXIT 
     
     
     DEC CX ;AMI LENGTH-1 BAR BAIRER OUTLOOP CHALABO
    
    OUTLOOP:
        MOV SI,0;
        MOV DI,0; 
        INC DI
;FOR(I=1;I<N;I++){}INLOOP E ETA IMPLEMENT KORA
        INLOOP:
            MOV BL,STR[SI]  
            MOV DL,STR[DI];
            CMP BL,DL
            JL SKIP
            XCHG BL,DL
            MOV STR[SI],BL
            MOV STR[DI],DL
            SKIP:
             INC SI
             INC DI 
             CMP DI,N  ;LENGTH INDEX A GELE INLOOP BREAK HBE;
             JL INLOOP;;; I<N
      LOOP OUTLOOP 
      
      
    SINGLE:      
    LEA DX, OUTMSG
    MOV AH, 09H
    INT 21H
        
    ;JUST FOR PRINT O INDEX THEKE CX PRJNTO PRINT KRBO
    MOV DI, 0
    MOV CX, N
   
    
    SHOW: ; loop for output showing 
       ; JCXZ EXIT
        MOV DL, str[DI]
        MOV AH, 02H
        INT 21H  
        MOV DL,' '
        INT 21H;        
        INC DI
    LOOP SHOW
     EXIT:
    MOV AH, 4CH
    INT 21H
            
MAIN ENDP        

NEWLINE PROC
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    RET
NEWLINE ENDP

END MAIN
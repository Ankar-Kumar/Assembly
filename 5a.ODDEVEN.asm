; Factorial 

.MODEL SMALL
.STACK 100H

.DATA
    inmsg DB "Enter a number: (1-9) $"
    EVN DB "THE NUMBER IS EVEN$"  
    OD DB "THE NUMBER IS ODD$"
    n DB ?
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; input
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
   
    MOV AH, 01H
    INT 21H  
    
    TEST AL,1   ;PROC 1
    JE EVEN
    
    
   ; SHR AL,1   ;PROC 2
;    JC ODD
    
    
    ;MOV BL,2   ;PROC 3
;    DIV BL
;    CMP AH,0  ;REMAINDER CHECK     
;    JE EVEN 


    ODD: 
        CALL NEWLINE
        LEA DX,OD
        MOV AH, 09H
        INT 21H 
        JMP EXIT 
        
        
        
    EVEN:
       CALL NEWLINE
      LEA DX, EVN
    MOV AH, 09H
    INT 21H
    JMP EXIT 
    
    
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
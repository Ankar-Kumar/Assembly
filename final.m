.model SMALL
.STACK 100H
.DATA
  outmsg1 DB "Prime Number$"
    outmsg2 DB "Not Prime Number$"
    n DB ?
NEW DB 10,13,"$"

.CODE
MAIN PROC  
    
     MOV AX,@DATA
     MOV DS,AX
         
         ;INPUT 
        MOV AH,1
        INT 21H  
        
        SUB AL, '0' 
        MOV BL, AL 
   
        MOV n, AL
        DEC n
        
        CMP AL,1
        JLE NOT_PRIME
        
        CMP AL, 2
        JE PRIME  
        ALGO:
            MOV AH,0
            DIV N
            MOV AL,BL
            CMP AH,0
            JE NOT_PRIME
            DEC N
            CMP N,2
            JG ALGO
        
         PRIME:
        CALL NEWLINE
        
        LEA DX, outmsg1
        MOV AH, 09H
        INT 21H
        
        JMP EXIT
    
    NOT_PRIME:
        CALL NEWLINE
        
        LEA DX, outmsg2
        MOV AH, 09H
        INT 21H
        
           
     EXIT:
         MOV AH,4CH
         INT 21H;  
    
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
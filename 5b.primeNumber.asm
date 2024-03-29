; Prime Number

.MODEL SMALL
.STACK 100H

.DATA
    inmsg DB "Enter a number: (0-9) $"
    outmsg1 DB "Prime Number$"
    outmsg2 DB "Not Prime Number$"
    n DB ?
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    ; Input
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV BL, AL 
    ;dec al
    MOV n, AL
    DEC n
    
    CMP AL,1
    JLE NOT_PRIME
    
    CMP AL, 2
    JE PRIME
    
    
    
    LOOP2:      ; NUMBER KE N-1,N-2....<2 PRJNTO TO DIV KRCHI
        MOV AH, 0H         
        DIV n             
        MOV AL, BL   
        
        CMP AH, 0H      ;REMAINDER
        JE NOT_PRIME
        dec n
        CMP n, 1    ;1 HOLE BREAK TO PRIME
        JG LOOP2   ;;;DEC CL EVERY TIME 
    
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
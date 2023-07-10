; Case Reversal

.MODEL SMALL
.STACK 100H

.DATA                      
str DB 100 DUP("$")
inmsg DB "Enter the string: $"
outmsg DB "The case reversed string is: $"

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg 
    MOV AH, 09H
    INT 21H
        
    MOV SI, 0H
     
        
    INPUT: 
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH  
        JZ ENDINPUT
        
        MOV str[SI], AL 
        INC SI
        
        JMP INPUT 
        
    ENDINPUT:
        
        CALL NEWLINE 
        
        LEA DX, outmsg  
        MOV AH, 09H
        INT 21H
        MOV DI, 0 
    OUTPUT:
        CMP DI, SI  
        JE EXIT
               
        MOV AL, str[DI]
        CMP AL, 'z' 
        JG NOCHANGE
        CMP AL, 'A' 
        JL NOCHANGE
        CMP AL, 'Z' 
        JG CHECK
        
        JMP CONVERSION 
    
    CHECK:
        CMP AL, 'a' 
        JL NOCHANGE 
        
        JMP CONVERSION   
         
    NOCHANGE:
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        
        INC DI
        JMP OUTPUT    
        
    CONVERSION:   
        XOR AL, 32 
        MOV DL, AL
        MOV AH, 02
        INT 21H        
        INC DI
        JMP OUTPUT 
        
    EXIT:
        MOV AH, 4CH
        INT 21H   
    
MAIN ENDP
        
NEWLINE PROC
    MOV AH, 02H ; carriage return
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH ; newline feed
    INT 21H
    RET
NEWLINE ENDP        
        
END MAIN
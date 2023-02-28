; String Reverse

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inmsg DB "Enter the string: $"
    outmsg DB "The reversed string is: $"
    
.CODE
 
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, inmsg ; printing input message
    MOV AH, 09H
    INT 21H      
    
    MOV SI, 0H
    
    INPUT:  
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH 
        JZ ENDINPUT
        MOV BX,AX
        PUSH BX
        MOV str[SI], AL 
        INC SI
        
        JMP INPUT 
        
    ENDINPUT:  
    
        CALL NEWLINE 
        MOV DI,SI
        LEA DX, outmsg 
        MOV AH, 09H
        INT 21H
              
         
              
        OUTPUT:
            DEC SI
            MOV DL, str[SI]
            MOV AH, 02H
            INT 21H
            
           ; DEC SI 
            
            CMP SI, 0H  
            JE ENDOUTPUT
            
            JMP OUTPUT
            
    ENDOUTPUT:
        CALL NEWLINE 
        
        LEA DX, outmsg 
        MOV AH, 09H
        INT 21H
        
        OUTPUT2:
         DEC DI
         POP DX
         MOV AH,2H
         INT 21H 
         CMP DI,0
         JE EXIT
        LOOP OUTPUT2
        
        EXIT:
        MOV AH, 4CH
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
.MODEL SMALL

.STACK 100H

.DATA   

TEXT DB "GEEKSFORGEEKS$"
PATTERN DB "FORG$"
FALSE DB "NOT FOUND$"
TRUE DB "FOUND$"

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX        
       
    MOV SI, 0
    CHECK:
        MOV DI,0
        MOV BX,SI
        AVAILABLE:
          MOV AL,TEXT[SI]
          MOV DL,PATTERN[DI]          
          INC DI
          INC SI
          CMP DL,'$'  ;PATTERN LAST DIGIT CHECK
          JE FOUND_MSG
          CMP AL,DL
          JE AVAILABLE
          JNE UPDATE
          
          UPDATE:
            MOV SI,BX
            INC SI 
            CMP TEXT[SI],'$'  ;TEXT LAST DIGIT CHECK
            JE NOT_FOUND_MSG             
            JNE CHECK
              
                      
    
    FOUND_MSG:
        MOV AH, 9
        LEA DX, TRUE
        INT 21H
        JMP EXIT
        
    NOT_FOUND_MSG:  
        MOV AH, 9
        LEA DX,FALSE        
        INT 21H
        JMP EXIT
        
    EXIT: 
       MOV AH,4CH
       INT 21H
  MAIN ENDP
        
END MAIN
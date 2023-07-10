.MODEL SMALL

.STACK 100H

.DATA   

TEXT DB 50 DUP('$'); "GEEKSFORGEEKS$"
PATTERN DB 50 DUP('$'); "FORG$"
FALSE DB "NOT FOUND$"
TRUE DB "FOUND$"

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX        
    ;INPUT 2 STRING
    
     MOV SI,0 
      MOV AH,01H
      SCAN:
       INT 21H
        CMP AL,0DH
        JE END_SCAN
        MOV TEXT[SI],AL
       
        INC SI
        JMP SCAN
      
      END_SCAN:
       
      
       CALL NEWLINE
        
      MOV SI,0 
      MOV AH,01H
      SCAN2:
       INT 21H
        CMP AL,0DH
        JE END_SCAN2
        MOV PATTERN[SI],AL
        
        INC SI
        JMP SCAN2
      
      END_SCAN2:
       CMP SI,0
        JE NOT_FOUND_MSG
         
      
      CALL NEWLINE
      ;END OF INPUT TAKING
    
    
    MOV SI,0
   
    CHECK:
        MOV DI,0
        MOV BX,SI
        AVAILABLE:
          MOV AL,TEXT[SI]
          MOV DL,PATTERN[DI]          
          
          CMP DL,'$'  ;PATTERN LAST DIGIT CHECK
          JE FOUND_MSG 
          INC DI
          INC SI
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


 NEWLINE PROC
    MOV DL, 0AH ; carriage return
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH ; newline feed   
    INT 21H
    RET
 NEWLINE ENDP
        
END MAIN
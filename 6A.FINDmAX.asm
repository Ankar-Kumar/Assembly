.MODEL SMALL
.STACK 100H

.DATA 
    MX db ?
    MN DB '9'
.CODE


MAIN PROC 
     MOV AX,@DATA
     MOV DS,AX
      
     MOV AH,01
     MOV MX,'0'
     MOV DI,0
     SCAN:
       INT 21H
       CMP AL,0DH
       JE END_SCAN
       
       CMP AL,' '
       JE SCAN   ;SKIP SPACE 
       INC DI    
       CMP AL,MX
       JG MAX 
       JMP SCAN
       
       MAX:
         MOV MX,AL
         JMP SCAN ;;
         
       
    
    END_SCAN:
        CALL NEWLINE  
        
        CMP DI,0 ; IF FIRST PRESS ENTER
        JE EXIT
        
        MOV DL,MX
        MOV AH,02H
        INT 21H    
    
    EXIT:
        MOV AH,4CH
        INT 21H  
        
        
    MAIN ENDP
    NEWLINE PROC
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
        RET
    NEWLINE ENDP
    
END MAIN


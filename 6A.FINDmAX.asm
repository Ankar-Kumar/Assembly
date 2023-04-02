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
     SCAN:
       INT 21H
       CMP AL,0DH
       JE END_SCAN
       
       ;; FIND MAXIMUM;;
           
       CMP AL,MX
       JG MAX
       
       MAX:
         MOV MX,AL
         JMP SCAN ;;
         
       ;;FIND MINIMUM ;;

       ;CMP AL,MN
;       JL MIN
;       JMP SCAN 
      
;       MIN:        
;         CMP AL,' '
;         JE SCAN
;         MOV MN,AL
;         JMP SCAN ;;
    
    END_SCAN:
        CALL NEWLINE  
 
        MOV DL,MN
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


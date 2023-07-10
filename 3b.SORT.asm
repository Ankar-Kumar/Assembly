



;sorting   for int type and string

;AAAKKMNRRU 

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ("$")
    inpmsg DB "Enter the string: $"
    outmsg DB "After Sorting: $"
    
    n DW ?
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg 
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    MOV DI,0
    
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JZ ENDINPUT
     
        MOV str[SI],AL 
        INC SI
           
        JMP INPUT
     ENDINPUT:
       
        ;sorting segment increasing order (Using bubble sort)
        MOV n,SI;       
                
        MOV CX,n 
         
        CMP N,1
        JE SINGLE        
        JCXZ EXIT
        
        DEC CX
        OUTLOOP:
            MOV SI,0
            MOV DI,1           
            INLOOP:
                MOV AL,str[SI] 
                MOV BL,str[DI]  
                 
                CMP AL,BL
                JL SKIP ; JG to decreasing order sort
                
                XCHG AL,BL
                MOV str[SI],AL
                MOV str[DI],BL;
                
                SKIP:                           
                INC DI
                INC SI 
                CMP DI,N
                JL  INLOOP
                    
        LOOP OUTLOOP  
          
     SINGLE:
     ;Printing segment
     CALL NEWLINE
     LEA DX,outmsg 
     MOV AH,09H
     INT 21H   
     
     MOV CX,N;
     MOV DI,0
     
     OUTPUT:        
        MOV DL,str[DI]
        MOV AH,2
        INT 21H
        INC DI   
        
    LOOP  OUTPUT
     EXIT:     
    
    MOV AH,4CH
    INT 21H    
    
MAIN ENDP

NEWLINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
NEWLINE ENDP

END MAIN
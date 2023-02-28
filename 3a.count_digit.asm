; COUNT NUMBER OF DIGIT IN THE STRING

.MODEL SMALL

.STACK 100H

.DATA

VAR DB 'ANKAR kumar sah@20 2 5566$'
 vowelS DB 'AEIOUaeiou$'
    
    vc DB '0'
    cc DB '0'
    SPAC DB '0'
    DIG DB '0'

.CODE   

MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DI,0 ;destination index initialize to 0
    ITERATE:
        CMP VAR[DI],'$'
        JE PRINT
         
        CMP VAR[DI],'A'
        JL NOTALPHABET
        CMP VAR[DI],'z'
        JG OTHERS
        
        cmp VAR[DI],'Z'
        JG CHECK 
         
        JMP ALPHABET
        
        ALPHABET:
            MOV SI,0
            MOV CX,0AH
           TOP:          
           MOV BL,VOWELS[SI]
           CMP VAR[DI],BL
           JZ VOWEL
           INC SI
           LOOP TOP
           INC CC  
           INC DI
           JMP ITERATE
           
           
           
        VOWEL:
        INC vc 
        INC DI ; vowel count 
        JMP ITERATE
        
        
        NOTALPHABET:
          CMP VAR[DI],' '
          JZ SPACE
          CMP VAR[DI],'0'
          JL OTHERS
          CMP VAR[DI],'9'
          JG OTHERS
          INC DIG 
          INC DI
          JMP ITERATE
          
          
        SPACE:
          INC SPAC 
          INC DI
          JMP ITERATE  
                
        CHECK:
          CMP VAR[DI],'a'
          JL OTHERS 
          
        OTHERS:
        INC DI
        JMP ITERATE 
        
    
    PRINT:
      MOV DL,DIG
      MOV AH,02H
      INT 21H      
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
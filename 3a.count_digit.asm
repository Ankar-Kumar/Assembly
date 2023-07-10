; COUNT NUMBER OF DIGIT IN THE STRING

.MODEL SMALL

.STACK 100H

.DATA

VAR DB 'ANKAR kumar sarrrrrrh@20 2 5566$'
vowelS DB 'AEIOUaeiou$'
     ;both '0' and 0 accepted 
    vc DB '0'
    cc Dw '0'
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
            MOV CX,0AH  ;CX=10 vowels
           TOP:      ;CHECK ALL VOWELS CHAR WITH ONE I/P CHAR    
           MOV BL,VOWELS[SI]
           CMP VAR[DI],BL
           JZ VOWEL
           INC SI
           LOOP TOP
           INC CC  ;constant inc  
           jmp others
           
           
           
        VOWEL:
        INC vc ;vowel count
        jmp others
        
        
        NOTALPHABET:
          CMP VAR[DI],' '
          JZ SPACE
          CMP VAR[DI],'0'
          JL OTHERS
          CMP VAR[DI],'9'
          JG OTHERS
          INC DIG 
          jmp others
          
          
        SPACE:
          INC SPAC 
          jmp others 
                
        CHECK:
          CMP VAR[DI],'a'
          JL OTHERS 
          jmp alphabet
        OTHERS:
        INC DI
        JMP ITERATE 
        
    
    PRINT:
      sub cc,48 
      mov bl,10
      
      mov ax,cc
      div bl 
      add ah,48
      add al,48
      
      mov bl,ah
      MOV dl,al
      MOV AH,02H
      INT 21H 
     
      MOV dx,cc
      MOV AH,02H
      INT 21H      
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
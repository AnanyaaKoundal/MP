.model small 
.stack 100H 
.386

.data
DATA1 dd 00000000H         
DATA2 dd 00000000H
REM dd ?           
QUOT dd ?

msg db 10,13,"Enter the First Number: $"
msg1 db 10,13,"Enter the Second Number: $"
msg2 db 10,13,"The Product (in Hexadecimal) is: $"

.code
.startup

MOV AH,09         
MOV DX,OFFSET msg        
INT 21H  
MOV CX, 8 
AGAIN: 
             MOV AH, 01 
             INT 21H
             CMP AL,'A'      
             JGE L5
             SUB AL,30H      
             JMP L6
             L5: SUB AL,37H
             L6: SHL EBX,4
             ADD BL,AL
             LOOP AGAIN
MOV DATA1, EBX

MOV AH,09
MOV DX, OFFSET msg1
INT 21H

MOV EBX, 0
MOV CX, 8

AGAIN1: 
             MOV AH,01 
             INT 21H
             CMP AL,'A'
             JGE L7
             SUB AL, 30H
             JMP L8
             L7: SUB AL, 37H
             L8: SHL EBX, 4
             ADD BL,AL
             LOOP AGAIN1
MOV DATA2, EBX

MOV EBX,0
MOV EDX,0
MOV EAX,0
MOV EAX,DATA1
MOV EBX,DATA2
DIV EBX

MOV REM,EDX
MOV QUOT,EAX

MOV AH,09
MOV DX,OFFSET msg2
INT 21H

;Higher 32-bits of the product
MOV EBX, REM
MOV CX, 8
AGAIN2: 
            ROL EBX, 4
            MOV DL,BL
            AND DL, 0FH
            CMP DL, 9
            JBE L1
            ADD DL, 37H    
            
            MOV AH, 02
            INT 21H             
            JMP L2

            L1: ADD DL,30H
            MOV AH,02
            INT 21H
            L2: LOOP AGAIN2

MOV EBX, QUOT
MOV CX, 8
AGAIN3: 
             ROL EBX, 4
             MOV DL,BL
             AND DL, 0FH 
             CMP DL,9
             JBE L3
             ADD DL,37H
             MOV AH,02
             INT 21H
             JMP L4
             L3: ADD DL,30H
             MOV AH,02
             INT 21H
             L4: LOOP AGAIN3
MOV AH,4CH
INT 21H
END

.model small
.stack 100H
.386
.data
	num1 dd 00000000H
	num2 dd 00000000H
	num3 dd 00000000H
	msg db 10,13, "Enter the first number: $"
	msg1 db 10, 13, "Enter the second number: $"
	msg2 db 10, 13, "The sum is: $"
	
.code
.startup

MOV AH, 09
MOV DX, OFFSET msg
INT 21H

MOV EBX, 0
MOV CX, 8
AGAIN:
	MOV AH, 01
	INT 21H
	CMP AL, 'A'
	JGE L2
	SUB AL, 30H
	SHL EBX, 4
	ADD BL, AL
	LOOP AGAIN
MOV num1, EBX
MOV AH, 09
MOV DX, OFFSET msg1
INT 21H

MOV EBX,0
MOV CX, 8
AGAIN1:
	MOV AH, 01
	INT 21H
	CMP AL, 'A'
	JGE L2
	SUB AL, 30H
	SHL EBX, 4
	ADD BL, AL
	LOOP AGAIN1

MOV num2, EBX
MOV AX, word ptr num1
MOV dx, word ptr num2
add al, dl
daa
MOV BL, AL
MOV AL, AH
ADC AL, DH
DAA
MOV BH, AL
MOV word ptr num3, bx
MOV AX, word ptr num1+2
MOV DX, word ptr num2+2
ADC AL, DL
DAA
MOV BL, AL
MOV AL, AH
ADC AL, DH
DAA

MOV BH, AL
MOV word ptr num3+2, BX
MOV EBX, num3

MOV AH, 09H
MOV DX, OFFSET msg2
INT 21H

JNC l6
MOV AH, 02H
MOV DL, "1"
INT 21H

l6: MOV CX,8

AGAIN2:
	ROL EBX, 4
	MOV DL, BL
	AND DL, 0FH
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	LOOP AGAIN2
	
L2: MOV AH, 4CH
INT 21H

END

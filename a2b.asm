.model small
.stack 100H

.data
inpstr db 10,13, "Enter the ASCII character: $"
outstr db 10,13, "The binary number is: $"

.code
.startup

MOV AH, 09H
MOV DX, OFFSET inpstr
INT 21H

MOV AH, 01H
INT 21H

MOV BL, AL

MOV DX, OFFSET outStr   
MOV AH, 09H
INT 21H

MOV CX, 8

repeat1: 
SHL BL, 1
JC printOne
MOV DL, 30H
JMP print
printOne: 
	MOV DL, 31H
print:
	MOV AH, 02H
	INT 21H
loop repeat1

MOV AH, 4CH
INT 21H

END 

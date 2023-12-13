.model small
.stack 100H

.data
inpstr db 10,13, "Enter binary number: $"
outstr db 10,13, "ASCII Character is: $"

.code
.startup

MOV AH, 09H
MOV DX, OFFSET inpstr
INT 21H

MOV BL, 00H
MOV CL, 08H

repeat1: 
MOV AH, 01H
INT 21H
SUB AL, 30H
SHL BL, 1
ADD BL, AL
loop repeat1

MOV AH, 09H
MOV DX, OFFSET outstr
INT 21H

MOV AH, 02H
MOv DL, BL
INT 21H

MOV AH, 4CH
INT 21H

END 

Addition
.model small

.stack 100h

.386
.data

data1 dd 00H

msg1 db 10,13,"Enter the first number: $"

msg2 db 10,13,"Enter the secind number: $"

res db 10,13,"Result: $"

.code

.startup

MOV AH,09

MOV DX, OFFSET msg1

INT 21H

MOV EBX, 00000000

MOV ECX, 8



INP1:   MOV AH, 01

		INT 21H

		CMP AL, 'A'

		JGE L1

		SUB AL, 30H

		JMP L2

		L1: SUB AL, 37H

		L2: ROL EBX, 4

		ADD BL, AL	;Change

		LOOP INP1

MOV data1, EBX

	

MOV AH, 09

MOV DX, OFFSET msg2

INT 21H

MOV EBX, 00000000

MOV ECX, 8



INP2:   MOV AH, 01

		INT 21H

		CMP AL, 'A'

		JGE L3

		SUB AL, 30H

		JMP L4

		L3: SUB AL, 37H

		L4: ROL EBX, 4

		ADD BL, AL

		LOOP INP2



ADD EBX, data1



MOV AH, 09

MOV DX, OFFSET res

INT 21H



MOV DX, 00

MOV ECX, 8

OUTP:   ROL EBX, 4

		MOV DL, BL

		AND DL, 0FH

		CMP DL, 9

		JLE L5

		ADD DL, 37H

		JMP L6

		L5: ADD DL, 30H

		L6: MOV AH, 02

		INT 21H

		LOOP OUTP



MOV AH, 4CH

INT 21H

END

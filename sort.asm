.model small
.stack 100H
.386

.DATA
ARRAY dw 20 dup(?)
sz dw 00H
key dw 00H
msg1 db 10,13,"Enter the size of array: $"
msg2 db 10,13,"Enter elements: $"
res db 10,13,"Sorted Array: $"

.code
.startup

MOV AH, 09
MOV DX, OFFSET msg1
INT 21H
MOV AH, 01
INT 21H

SUB AL, 30H
MOV AH, 0
MOV CX, AX
MOV sz, AX

MOV AH, 09H
MOV DX, OFFSET msg2
INT 21H

MOV AH, 0
MOV SI, 0
MOV BX, OFFSET ARRAY

INP:    MOV DL, 0AH
		MOV AH, 02
		INT 21H
		MOV AH, 01H
		INT 21H
		SUB AL, 30H
		MOV [BX+SI], AX
		INC SI
		LOOP INP
		
MOV CX, sz
MOV BX, OFFSET ARRAY
MOV DI, sz

L2: 	MOV CX, sz
		MOV key, CX
		DEC key
		MOV CX, key
		MOV SI, 0
		L3: MOV AL, [BX+SI]
			CMP [BX+SI+1], AL
			JGE L4
			XCHG AL, [BX+SI+1]
			MOV [BX+SI], AL
			L4: INC SI
			LOOP L3
		DEC DI
		JNZ L2

MOV CX, sz
MOV BX, OFFSET ARRAY
MOV SI, 0
MOV AH, 09
MOV DX, OFFSET res
INT 21H

OUTP:   MOV DL, 0AH
		MOV AH, 02
		INT 21H
		MOV DL, [BX+SI]
		INC SI
		ADD DL, 30H
		MOV AH, 02
		INT 21H
		LOOP OUTP
		
MOV AH, 4CH
INT 21H
END

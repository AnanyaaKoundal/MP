.model small
.stack 100h
.386

.data
array dw 20 dup(?)
sz dw 00h
key dw 00h
success db 10,13,"Element found!$"
fail db 10,13,"Element not found!$"

msg db 10,13, "Size: $"
msg1 db 10,13, "Elements: $"
msg2 db 10,13, "Search: $"

.code 
.startup

MOV AH, 09
MOV DX, OFFSET msg
INT 21H
MOV AH, 01
INT 21H
SUB AL, 30H
MOV AH, 0

MOV CX, AX
MOV sz, AX

MOV AH, 09
MOV DX, OFFSET msg1
INT 21H

MOV AH, 0
MOV SI, 0
MOV BX, OFFSET array

INP:    MOV DL, 0AH
		MOV AH, 02
		INT 21H
		MOV AH, 01
		INT 21H
		SUB AL, 30H
		MOV [BX+SI], AX
		INC SI
		LOOP INP

MOV AH, 09
MOV DX, Offset msg2
int 21H
mov ah, 01
int 21h
sub al, 30h
mov ah,0
mov cx, ax
mov key, ax

mov ah,0
mov si,0
mov bx, offset array
mov bp, 0
mov di, sz
mov ax, sz

L2: mov si, di
	add si, bp
	mov ax, si
	mov dl, 2
	div dl
	mov ah, 0
	mov dx, 0
	mov si, ax
	mov dx, key
	cmp [bx+si], dl
	jz l3
	call l4
	loop l2
	
mov ah, 09
mov dx, offset fail
int 21h
mov ah, 4ch
int 21h

L3: mov ah, 09
	mov dx, offset success
	int 21h
	mov ah, 4ch
	int 21h

l4 proc near
	cmp [bx+si], dl
	jl l5
	mov di, si
	ret
	l5: mov bp, si
		ret
l4 endp
mov ah, 4ch
int 21h
end

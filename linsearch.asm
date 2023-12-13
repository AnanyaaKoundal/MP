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

mov ah, 09
mov dx, offset msg
int 21h
mov ah,01
int 21h
sub al, 30h
mov ah, 0
mov cx, ax
mov sz, ax

mov ah, 0
mov si, 0
mov bx, offset array

inp: mov dl, 0ah
	 mov ah, 02
	 int 21h
	 mov ah, 01
	 int 21h
	 sub al, 30h
	 mov [bx+si], ax
	 inc si
	 loop inp

mov ah, 09
mov dx, offset msg2
int 21h
mov ah, 01
int 21h
sub al, 30h
mov ah, 0
mov key, ax

mov si, 0
mov bx, offset array

srch: mov al, [bx+si]
	  mov dx, key
	  cmp al, dl
	  je l2
	  inc si
	  loop srch

mov ah, 09
mov dx, offset fail
int 21h
JMP l3

l2: mov ah, 09
	mov dx, offset success
	int 21h

l3:
mov ah, 4ch
int 21h
end

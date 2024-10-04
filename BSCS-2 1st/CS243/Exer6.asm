; Filename: Exer6.asm
; Displaying single-characters, numbers, and symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.data
	szTitle db "Filename: Exer6.asm", 0Ah, "Displaying single-characters, numbers, and symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code
.stack 100
start:
	mov ax, @data
	mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 06h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 73
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 84h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 03h
	int 21h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 06h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 85
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h
int 27h
end start
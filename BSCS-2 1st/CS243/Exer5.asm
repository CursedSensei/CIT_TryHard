; Filename: Exer5.asm
; Displaying single-characters, numbers, and symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.data
	szTitle db "Filename: Exer5.asm", 0Ah, "Displaying single-characters, numbers, and symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code
.stack 100
start:
	mov ax, @data
	mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 5
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 2
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 40h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 2
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 40h
	mov cx, 3
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 2
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 40h
	mov cx, 1
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 2
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 10h
	mov cx, 5
	int 10h;

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h
int 27h
end start
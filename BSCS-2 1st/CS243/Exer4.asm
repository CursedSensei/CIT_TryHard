; Filename: Exer4.asm
; Displaying single-characters, numbers, and symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.data
	szTitle db "Filename: Exer4.asm", 0Ah, "Displaying single-characters, numbers, and symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code
.stack 100
start:
	mov ax, @data
	mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 84h
	mov cx, 7
	int 10h;

	mov ah, 02h
	mov dl, 67
	int 21h

	mov ah, 02h
	mov dl, 111
	int 21h

	mov ah, 02h
	mov dl, 108
	int 21h

	mov ah, 02h
	mov dl, 108
	int 21h

	mov ah, 02h
	mov dl, 101
	int 21h

	mov ah, 02h
	mov dl, 103
	int 21h

	mov ah, 02h
	mov dl, 101
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 1Ah
	mov cx, 2
	int 10h;

	mov ah, 02h
	mov dl, 111
	int 21h

	mov ah, 02h
	mov dl, 102
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 3Ah
	mov cx, 8
	int 10h;

	mov ah, 02h
	mov dl, 67
	int 21h

	mov ah, 02h
	mov dl, 111
	int 21h

	mov ah, 02h
	mov dl, 109
	int 21h

	mov ah, 02h
	mov dl, 112
	int 21h

	mov ah, 02h
	mov dl, 117
	int 21h

	mov ah, 02h
	mov dl, 116
	int 21h

	mov ah, 02h
	mov dl, 101
	int 21h

	mov ah, 02h
	mov dl, 114
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 09h
	mov bl, 1Eh
	mov cx, 7
	int 10h;

	mov ah, 02h
	mov dl, 83
	int 21h

	mov ah, 02h
	mov dl, 116
	int 21h

	mov ah, 02h
	mov dl, 117
	int 21h

	mov ah, 02h
	mov dl, 100
	int 21h

	mov ah, 02h
	mov dl, 105
	int 21h

	mov ah, 02h
	mov dl, 101
	int 21h

	mov ah, 02h
	mov dl, 115
	int 21h
int 27h
end start
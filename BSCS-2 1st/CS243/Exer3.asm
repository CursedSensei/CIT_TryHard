; Filename: Exer3.asm
; Displaying single-characters, numbers, and symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.data
	szTitle db "Filename: Exer3.asm", 0Ah, "Displaying single-characters, numbers, and symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code
.stack 100
start:
	mov ax, @data
	mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 48
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 49
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 50
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 51
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 52
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 53
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 54
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 55
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 56
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 57
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 02h
	mov dl, 33
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 42
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 35
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 36
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 37
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 94
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 38
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 42
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 40
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 41
	int 21h

	mov ah, 02h
	mov dl, 10
	int 21h

	mov ah, 02h
	mov dl, 45
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 95
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 43
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 61
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 123
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 125
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 91
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 93
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 60
	int 21h

	mov ah, 02h
	mov dl, 32
	int 21h

	mov ah, 02h
	mov dl, 63
	int 21h
int 27h
end start
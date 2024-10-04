; Filename: Exer1.asm
; Displaying single-characters, numbers, and symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.data
	szTitle db "Filename: Exer1.asm", 0Ah, "Displaying single-characters, numbers, and symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code
.stack 100
start:
	mov ax, @data
	mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 61h
	int 21h;

	mov ah, 02h
	mov dl, 62h
	int 21h;

	mov ah, 02h
	mov dl, 63h
	int 21h;

	mov ah, 02h
	mov dl, 64h
	int 21h;

	mov ah, 02h
	mov dl, 65h
	int 21h;

	mov ah, 02h
	mov dl, 66h
	int 21h;

	mov ah, 02h
	mov dl, 67h
	int 21h;

	mov ah, 02h
	mov dl, 68h
	int 21h;

	mov ah, 02h
	mov dl, 69h
	int 21h;

	mov ah, 02h
	mov dl, 6Ah
	int 21h;

	mov ah, 02h
	mov dl, 6Bh
	int 21h;

	mov ah, 02h
	mov dl, 6Ch
	int 21h;

	mov ah, 02h
	mov dl, 6Dh
	int 21h;

	mov ah, 02h
	mov dl, 6Eh
	int 21h;

	mov ah, 02h
	mov dl, 6Fh
	int 21h;

	mov ah, 02h
	mov dl, 70h
	int 21h;

	mov ah, 02h
	mov dl, 71h
	int 21h;

	mov ah, 02h
	mov dl, 72h
	int 21h;

	mov ah, 02h
	mov dl, 73h
	int 21h;

	mov ah, 02h
	mov dl, 74h
	int 21h;

	mov ah, 02h
	mov dl, 75h
	int 21h;

	mov ah, 02h
	mov dl, 76h
	int 21h;

	mov ah, 02h
	mov dl, 77h
	int 21h;

	mov ah, 02h
	mov dl, 78h
	int 21h;

	mov ah, 02h
	mov dl, 79h
	int 21h;

	mov ah, 02h
	mov dl, 7Ah
	int 21h;

	mov ah, 02h
	mov dl, 0Ah
	int 21h;
;

	mov ah, 02h
	mov dl, 41h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 42h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 43h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 44h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 45h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 46h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 47h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 48h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 49h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Ah
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Bh
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Ch
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Dh
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Eh
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 4Fh
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 50h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 51h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 52h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 53h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 54h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 55h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 56h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 57h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 58h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 59h
	int 21h;

	mov ah, 02h
	mov dl, 20h
	int 21h;

	mov ah, 02h
	mov dl, 5Ah
	int 21h;
;
	mov ah, 02h
	mov dl, 0Ah
	int 21h;
int 27h
end start
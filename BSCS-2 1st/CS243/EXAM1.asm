; FILENAME: EXAM1.ASM
; MULTIPLICATION TABLE
; John Zillion C. Reyes
; DATE: September 6, 2024

.model small
.stack 100

.data
	szTitle db "FILENAME: EXAM1.ASM", 0Ah, "MULTIPLICATION TABLE", 0Ah, "John Zillion C. Reyes", 0Ah, "DATE: September 6, 2024", 0Ah, 0Ah, '$'
	h1 db "MULTIPLICATION TABLE", 0Ah, "Created by: JOHN ZILLION REYES", 0Ah, "Date: September 6, 2024",  0Ah, "$"
	
	nx db "| X  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10  | ", 0Ah, "$"
	n1 db "| 1  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10  | ", 0Ah, "$"
	n2 db "| 2  | 2  | 4  | 6  | 8  | 10 | 12 | 14 | 16 | 18 | 20  | ", 0Ah, "$"
	n3 db "| 3  | 3  | 6  | 9  | 12 | 15 | 18 | 21 | 24 | 27 | 30  | ", 0Ah, "$"
	n4 db "| 4  | 4  | 8  | 12 | 16 | 20 | 24 | 28 | 32 | 36 | 40  | ", 0Ah, "$"
	n5 db "| 5  | 5  | 10 | 15 | 20 | 25 | 30 | 35 | 40 | 45 | 50  | ", 0Ah, "$"
	n6 db "| 6  | 6  | 12 | 18 | 24 | 30 | 36 | 42 | 48 | 54 | 60  | ", 0Ah, "$"
	n7 db "| 7  | 7  | 14 | 21 | 28 | 35 | 42 | 49 | 56 | 63 | 70  | ", 0Ah, "$"
	n8 db "| 8  | 8  | 16 | 24 | 32 | 40 | 48 | 56 | 64 | 72 | 80  | ", 0Ah, "$"
	n9 db "| 9  | 9  | 18 | 27 | 36 | 45 | 54 | 63 | 72 | 81 | 90  | ", 0Ah, "$"
	n10 db "| 10 | 10 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 90 | 100 | ", 0Ah, "$"

	mulDivide db "=========================================================", 0Ah, "$"

.code

start:
	mov ax, @data
	mov ds, ax

	lea dx, szTitle
	mov ah, 09h
	int 21h

	lea dx, h1
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 57
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h
	
	mov ah, 09h
	mov bl, 30h
	mov cx, 57
	int 10h

	lea dx, nx
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n1
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n2
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n3
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n4
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n6
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n5
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n7
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n8
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n9
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, n10
	mov ah, 09h
	int 21h

	mov ah, 09h
	mov bl, 30h
	mov cx, 5
	int 10h

	lea dx, mulDivide
	mov ah, 09h
	int 21h
int 27h
end start
; Filename: Exer7.asm
; create your own multicolored character with blinking parts
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.stack 100h
.data
	szTitle db "Filename: Exer7.asm", 0Ah, "create your own multicolored character with blinking parts", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
.code

start:
	mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

	; line 1
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 4
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	; line 2
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 6
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 3
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 22h ; beak green
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 87h ; blink
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 30h ; eye 9
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 4
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 22h ; beak green
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 5
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 5
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 22h ; beak green
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 6
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h

	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h

	; line 7
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 8
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 55h ; line purple
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 8
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 4
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 55h ; line purple
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 55h ; line purple
	mov cx, 1
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 2
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h

	; line 9
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 5
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 55h ; line purple
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 3
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 10
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 11
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 11
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 9
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 12
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 09h
	mov bl, 11h ; color blue
	mov cx, 7
	int 10h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	mov ah, 02h
	mov dl, 20h
	int 21h
	
	; line 13
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
int 27h
end start
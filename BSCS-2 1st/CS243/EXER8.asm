; Filename: Exer8.asm
; Program Description: Display text using string variables (4 string variables)
; Programmer Name: JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.stack 100h

.data
	szTitle db "Filename: Exer8.asm", 0Ah, "Program Description: Display text using string variables (4 string variables)", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 30, 2024", 0Ah, 0Ah, '$'
	msg1 db "John Zillion C. Reyes$"
	msg2 db "Bachelor of Science in Computer Science 2nd Year$"
	msg3 db "College of Computer Studies$"
	msg4 db "Cebu Institute of Technology - University$"
	
.code
.startup
start:
	
	; data
	mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h
	
	
	mov ah, 09h
	mov dx, offset msg1
	int 21h
	
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 09h
	mov dx, offset msg2
	int 21h
	
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 09h
	mov dx, offset msg3
	int 21h
	
	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h
	
	mov ah, 09h
	mov dx, offset msg4
	int 21h

int 27h
end start
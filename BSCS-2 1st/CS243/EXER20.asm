; Filename: EXER20.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.MODEL small
.STACK 100h
.DATA
	szTitle db "Filename: EXER20.ASM", 0Ah, "Programmer Name: JOHN ZILLION C. REYES", 0Ah, "Date: September 20, 2024", 0Ah, 0Ah, '$'
    prompt db 'Enter a character: $'
    isPrompt db 'Yes, you have entered letter A.$'
    notPrompt db 'No, you have not entered letter A. You entered character $'
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    lea dx, szTitle
	mov ah, 09h
	int 21h

    mov ah, 09h
    mov dx, OFFSET prompt
    int 21h

    mov ah, 1
    int 21h

    mov bl, al
    cmp al, 'A'

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    je isA

    mov ah, 09h
    mov dx, OFFSET notPrompt
    int 21h

    mov ah, 02h
    mov dl, bl
    int 21h

    mov dl, '.'
    int 21h

    jmp endIsA
isA:
    mov ah, 09h
    mov dx, OFFSET isPrompt
    int 21h
endIsA:
    mov ah, 02h
    mov dl, 0Ah
    int 21h

    int 27h
END ProgramStart
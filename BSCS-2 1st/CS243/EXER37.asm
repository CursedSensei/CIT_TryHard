; Filename: EXER37.ASM
; Programmer Name: John Zillion C. Reyes
; Date: October 18, 2024

.model small
.stack 100h
.data
    input db "Enter a character: $"
    succ db "You entered A.", 0Ah, "$"
    deny db "You entered not A.", 0Ah, "$"
.code
start:
    mov ax, @data
    mov ds ,ax

    mov dx, offset input
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    mov bl, al

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    cmp bl, 'A'
    je succPrint
    mov dx, offset deny
    jmp exitSucc
succPrint:
    mov dx, offset succ
exitSucc:
    mov ah, 09h
    int 21h

    int 27h
end start
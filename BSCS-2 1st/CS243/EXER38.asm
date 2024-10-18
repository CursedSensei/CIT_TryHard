; Filename: EXER38.ASM
; Programmer Name: John Zillion C. Reyes
; Date: October 18, 2024

.model small
.stack 100h
.data
    input db "Enter a number: $"
    equally db "The number is equal to 5.", 0Ah, "$"
    lessy db "The number is less than 5.", 0Ah, "$"
    greedy db "The number is greater than 5.", 0Ah, "$"
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

    sub bl, '0'

    cmp bl, 5
    je succPrint
    jg greedyPrint
    mov dx, offset lessy
    jmp exitSucc
greedyPrint:
    mov dx, offset greedy
    jmp exitSucc
succPrint:
    mov dx, offset equally
exitSucc:
    mov ah, 09h
    int 21h

    int 27h
    
end start
; Filename: EXER14.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024
; Description: This assembly language program will get character input and 
; display back character input.

.MODEL small
.STACK 200h
.DATA
    inputChar db ?      ; variable to store the input character
    inputMsg db 'Enter a character: $'
    outputMsg db 'You entered: $'
.CODE
Main:
    ; initialize the data segment
    mov ax, @data
    mov ds, ax

    ; display the input prompt message
    mov dx, offset inputMsg
    mov ah, 09h
    int 21h

    ; read a character from the keyboard
    mov ah, 01h     ; function to read a character
    int 21h         ; call DOS interrupt
    mov inputChar, al   ; store the character in inputChar

    ; display the output message
    mov dx, offset outputMsg
    mov ah, 09h
    int 21h

    ; display the character back
    mov dl, inputChar   ; load the character to DL
    mov ah, 02h         ; function to display a character
    int 21h             ; call DOS interrupt

    ; exit program
    mov ax, 4C00h       ; function to exit program
    int 21h
END Main
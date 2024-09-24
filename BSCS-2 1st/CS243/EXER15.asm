; Filename: EXER15.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024
; Description: This assembly language program will continuously get 
; character input and display back input until Enter key is pressed.

.MODEL small
.STACK 200h
.DATA
.CODE
ProgramStart:
    EchoLoop:
        mov ah, 1       ; DOS keyboard input function
        int 21h         ; get the next key
        cmp al, 13      ; was the key the Enter key?
        jz EchoDone     ; yes, so we're done echoing
        mov dl, al      ; put the character into DL
        mov ah, 2       ; DOS display output function
        int 21h
        jmp EchoLoop
    EchoDone:
        mov ah, 4ch     ; DOS terminate program function
        int 21h         ; terminate the program
END ProgramStart
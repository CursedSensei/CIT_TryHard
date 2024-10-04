; Filename: EXER17.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024
; Description: This assembly language program will get string input and
; display back string.

.MODEL small
.STACK 100h
.DATA
	szTitle db "Filename: EXER17.ASM", 0Ah, "Programmer Name: JOHN ZILLION C. REYES", 0Ah, "Date: September 20, 2024", 0Ah, "Description: This assembly language program will get string input and", 0Ah, "display back string.", 0Ah, 0Ah, '$'
MAXIMUM_STRING_LENGTH EQU 1000
StringInput DB MAXIMUM_STRING_LENGTH DUP (?)
InputPrompt DB 'Enter text: $'
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax      ; set DS to point to the data segment

	lea dx, szTitle
	mov ah, 09h
	int 21h

    mov dx, OFFSET InputPrompt
    mov ah, 9
    int 21h

    mov ah, 3fh     ; DOS read handle function
    mov bx, 0       ; standard input handle
    mov cx, MAXIMUM_STRING_LENGTH       ; read up to maximum number of characters

    mov dx, OFFSET StringInput      ; store the string here
    int 21h                         ; get the string
    and ax, ax                      ; were any characters read?
    jz Done                         ; no, so you're done
    mov cx, ax                      ; put the string length in CX where
                                    ; you can use it as a counter

    push cx                         ; save the string length
    mov bx, OFFSET StringInput

    pop cx                          ; get back the string length
    mov ah, 40h                     ; DOS write form handle function
    mov bx, 1                       ; standard output handle
    mov dx, OFFSET StringInput      ; prepare to print the string
    int 21h                         ; print the string

Done:
    mov ah, 4ch
    int 21h
END ProgramStart
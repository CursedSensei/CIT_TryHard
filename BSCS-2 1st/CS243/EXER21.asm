; Filename: EXER21.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.MODEL small
.STACK 100h
.DATA
    promptStart db 'REGISTRATION FORM', 0Ah, '$'
    promptFirst db 'Enter First Name: $'
    promptSecond db 'Enter Middle Name: $'
    promptThird db 'Enter Last Name: $'

    max_len EQU 1000
    first db max_len dup(?)
    middle db max_len dup(?)
    last db max_len dup(?)

    Msg db 'Hello, $'
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    lea dx, promptStart
    call printString

    lea dx, promptFirst
    call printString

    lea dx, first
    mov cx, max_len
    call getString

    push ax

    lea dx, promptSecond
    call printString

    lea dx, middle
    mov cx, max_len
    call getString

    pop dx
    push ax
    push dx

    lea dx, promptThird
    call printString

    lea dx, last
    mov cx, max_len
    call getString

    pop dx
    pop cx
    push ax
    push cx
    push dx

    mov dx, OFFSET Msg
    call printString

    mov dx, OFFSET first
    pop cx
    call printNumString

    mov dx, OFFSET middle
    pop cx
    call printNumString

    mov dx, OFFSET last
    pop cx
    call printNumString

    call endLine

    int 27h

getString:
    push bx
    mov ah, 3fh
    mov bx, 0
    mov cx, max_len
    int 21h

    pop bx
    ret

printNumString:
    push ax
    push bx
    mov ah, 40h
    add cx, -2
    mov bx, 1
    int 21h

    mov ah, 02h
    mov dl, ' '
    int 21h

    pop bx
    pop ax
    ret

printString:
    push ax
    mov ah, 09h
    int 21h
    pop ax
    ret

endLine:
    push ax
    push bx
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    pop bx
    pop ax
    ret
END ProgramStart
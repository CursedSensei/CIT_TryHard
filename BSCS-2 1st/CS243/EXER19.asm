; Filename: EXER19.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.MODEL small
.STACK 100h
.DATA
    firstIn DB 'Enter first character: $'
    secondIn DB 'Enter second character: $'
    thirdIn DB 'Enter third character: $'

    firstOut DB 'The first character is $'
    secondOut DB 'The second character is $'
    thirdOut DB 'The third character is $'

    inputIn DB 3 dup(?)
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, OFFSET firstIn
    int 21h

    mov ah, 1
    int 21h

    mov si, OFFSET inputIn
    mov [si], al

    call endLine

    mov ah, 09h
    mov dx, OFFSET secondIn
    int 21h

    mov ah, 1
    int 21h

    mov dx, OFFSET inputIn
    mov [si + 1], al

    call endLine

    mov ah, 09h
    mov dx, OFFSET thirdIn
    int 21h

    mov ah, 1
    int 21h
    mov [si + 2], al

    call endLine

    mov ah, 09h
    mov dx, OFFSET firstOut
    int 21h

    mov ah, 02h
    mov dl, [si]
    int 21h

    call endLinePeriod

    mov ah, 09h
    mov dx, OFFSET secondOut
    int 21h

    mov ah, 02h
    mov dl, [si + 1]
    int 21h

    call endLinePeriod

    mov ah, 09h
    mov dx, OFFSET thirdOut
    int 21h

    mov ah, 02h
    mov dl, [si + 2]
    int 21h

    call endLinePeriod

    mov ah, 4ch
    int 21h

endLine:
    push bx
    mov ah, 02h
    mov dl, 10
    int 21h
    pop bx
    ret

endLinePeriod:
    push bx
    mov ah, 02h
    mov dl, '.'
    int 21h
    mov dl, 10
    int 21h
    pop bx
    ret
    
END ProgramStart
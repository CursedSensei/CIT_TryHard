
; -------------------------------------------------------- 
; Colored String 
; SI - null terminated string with color code [1, length, RGB]
printColorString:
    push ax
    push bx
    push cx
    push dx
printColorLoop:
    mov bl, 0
    cmp [si], bl
    je printColorExit
    mov bl, 1
    cmp [si], bl
    jne notColor
    mov ah, 09h
    inc si
    mov cl, [si]
    mov ch, 0
    inc si
    mov bl, [si]
    int 10h
    inc si
    jmp printColorLoop
notColor:
    mov ah, 02h
    mov dl, [si]
    int 21h
    inc si
    jmp printColorLoop
printColorExit:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; -------------------------------------------------------- 
; Colored String 
; SI - null terminated string with color code [1, length, RGB]

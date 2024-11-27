; Print String with colors
;
; @Param
; SI - null terminated string with color code [1, length, RGB]
print:
    push ax
    push bx
    push cx
    push dx
    push si
_printColorLoop:
    mov bl, 0
    cmp [si], bl
    je _printColorExit
    mov bl, 1
    cmp [si], bl
    jne _notColor
    mov ah, 09h
    inc si
    mov cl, [si]
    mov ch, 0
    inc si
    mov bl, [si]
    int 10h
    inc si
    jmp _printColorLoop
_notColor:
    mov ah, 02h
    mov dl, [si]
    int 21h
    inc si
    jmp _printColorLoop
_printColorExit:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
; --------------------------------------------------------


; Print filling the string with color code
;
; @Param
; SI - Pointer to string
; BL - Color code
printColor:
    push ax
    push cx
    call strlen

    mov cx, ax
    call setColor

    call print

    pop cx
    pop ax
    ret
; --------------------------------------------------------


; Get length of string
;
; @Param
; SI - Pointer to string
; 
; @Return
; AX - length of string
strlen:
    push si
    push bx
    xor ax, ax
    mov bl, 0
    mov bh, 1
_strlenLoop:
    cmp [si], bh
    je _strlenIgnore
    cmp [si], bl
    je _strlenExit
    inc si
    inc ax
    jmp _strlenLoop
_strlenIgnore:
    add si, 3
    jmp _strlenLoop
_strlenExit:
    pop bx
    pop si
    ret
; --------------------------------------------------------


; Print centered filling the string with color code
;
; @Param
; SI - Pointer to string
; BL - Color code
printColorCenter:
    push ax
    push dx
    call strlen
    
    mov dx, ax
    mov ax, 80
    cmp dx, ax
    jge _printColorCenterIgnore
    jmp _printColorCenterIgnoreElse
_printColorCenterIgnore:
    call print
    pop dx
    pop ax
    ret
_printColorCenterIgnoreElse:
    push cx

    sub ax, dx
    mov dl, 2
    div dl

    xor cx, cx
    mov cl, al
    call _printCenterSpace

    call printColor

    add cl, ah
    call _printCenterSpace

    pop cx
    pop dx
    pop ax
    ret
; --------------------------------------------------------


; Print string center to screen
;
; @Param
; SI - Pointer to string to print
printCenter:
    push ax
    push dx
    call strlen
    
    mov dx, ax
    mov ax, 80
    cmp dx, ax
    jge _printCenterIgnore
    jmp _printCenterIgnoreElse
_printCenterIgnore:
    call print
    pop dx
    pop ax
    ret
_printCenterIgnoreElse:
    push cx

    sub ax, dx
    mov dl, 2
    div dl

    xor cx, cx
    mov cl, al
    call _printCenterSpace
    call print
    add cl, ah
    call _printCenterSpace

    pop cx
    pop dx
    pop ax
    ret

_printCenterSpace:
    push ax
    push dx
    push cx

    mov ah, 2
    mov dl, ' '

    cmp cx, 0
    jle _printCenterSpaceExit
_printCenterSpaceLoop:
    int 21h
    loop _printCenterSpaceLoop
_printCenterSpaceExit:
    pop cx
    pop dx
    pop ax
    ret
; --------------------------------------------------------


; Set color to length cx
;
; @Param
; CX - Length of color
; BL - Color code
setColor:
    push ax
    mov ah, 09h
    int 10h
    pop ax
    ret
; --------------------------------------------------------


; Fill current line with color
;
; @Param
; BL - Color code
fillColor:
    push cx
    mov cx, 80
    call setColor
    pop cx
    ret
; --------------------------------------------------------


; Print 16-bit Integer
;
; DX - Integer to print
; can only take up to 16 bits values with AX as input/parameter
printNum:
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx, 0

_printNumdigitLoop:
    mov bx, 10
    mov dx, 0
    div bx

    mov bx, ax
    mov ax, cx
    call isOdd

    je _printNumifAppend
    mov ah, dl
    mov al, 0
    jmp _printNumendifAppend
_printNumifAppend:
    pop ax
    mov al, dl
_printNumendifAppend:
    push ax
    inc cx

    mov ax, bx

    cmp ax, 0
    jne _printNumdigitLoop

_printNumprintLoop:

    mov ax, cx
    call isOdd

    pop ax
    je _printNumifPrint
    mov dl, al
    push ax
    jmp _printNumendifPrint
_printNumifPrint:
    mov dl, ah
_printNumendifPrint:
    add dl, '0'
    mov ah, 02h
    int 21h

    loop _printNumprintLoop

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    ret
; --------------------------------------------------------


; 16-bits isOdd function with AX as input/paramter
;
; @Param
; AX - 16-bit Number to evaluate
isOdd:
    push bx
    push dx
    mov dx, 0
    mov bx, 2
    div bx

    cmp dx, 1

    pop dx
    pop bx
    ret


; Newline Macro
nwln MACRO
    push ax
    push dx
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    pop dx
    pop ax
ENDM
; --------------------------------------------------------
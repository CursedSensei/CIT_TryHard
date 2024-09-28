; Filename: EXER28.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 29, 2024

.model small
.stack 100
.data
    h1 db "Input first number: $"
    h2 db "Input second number: $"

    Op db " x $"
    Res db " = $"

    cls db "                             ", 0Dh , "                             ", 0Dh, "$"
.code
start:
    mov ax, @data
    mov ds, ax

    lea di, h1
    call inputNum

    mov bx, ax

    lea di, h2
    call inputNum

    mov cx, ax

    call endLine

    mov ax, bx
    call printNum

    lea dx, Op
    call printString

    mov ax, cx
    call printNum

    mul bx

    lea dx, Res
    call printString

    call printNum

    call endLine

    int 27h


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


inputNum:
    push bx
    push cx
    push dx
    push si
    mov cx, 0
    mov si, 10
    mov bx, 0
    mov dx, di
    call printString
inputLoop:
    mov ah, 7
    int 21h

    cmp al, 8
    je inputRem
    cmp al, '0'
    jl exitInputNum
    cmp al, '9'
    jg exitInputNum
    sub al, '0'
    mov cl, al
    mov ax, bx
    mul si

    add ax, cx
    mov bx, ax

    mov dx, offset cls
    call printString
    mov dx, di
    call printString
    mov ax, bx
    call printNum

    jmp inputLoop
inputRem:
    mov ax, bx
    mov dx, 0
    div si
    mov bx, ax

    mov dx, offset cls
    call printString
    mov dx, di
    call printString
    mov ax, bx
    call printNum  

    jmp inputLoop

exitInputNum:
    call endLine
    mov ax, bx

    pop si
    pop dx
    pop cx
    pop bx
    ret


printNum:
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0

digitLoop:
    mov bx, 10
    mov dx, 0
    div bx

    mov bx, ax
    mov ax, cx
    call isOdd

    je ifAppend
    mov ah, dl
    mov al, 0
    jmp endifAppend
ifAppend:
    pop ax
    mov al, dl
endifAppend:
    push ax
    inc cx

    mov ax, bx

    cmp ax, 0
    jne digitLoop

printLoop:

    mov ax, cx
    call isOdd

    pop ax
    je ifPrint
    mov dl, al
    push ax
    jmp endifPrint
ifPrint:
    mov dl, ah
endifPrint:
    add dl, '0'
    mov ah, 02h
    int 21h

    loop printLoop

    pop si
    pop dx
    pop cx
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
    push dx

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    pop dx
    pop ax
    ret
end start
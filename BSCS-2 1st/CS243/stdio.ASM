.model small
.stack 100
.data
    h1 db "Input Number", 0Ah, "$"
    h2 db "Number: $"
    cls db "                                                                     ", 0Dh, "$"
.code
start:
    mov ax, @data
    mov ds, ax

startLoop:
    mov ah, 09h
    mov dx, offset h1
    int 21h

    call inputNum
    mov bx, ax

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    mov ah, 09h
    mov dx, offset h2
    int 21h

    mov ax, bx
    call printNum

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    jmp startLoop

    int 27h


; 16 bits isOdd with AX as input/paramter
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


; 16 bits input as AX output
inputNum:
    push bx
    push cx
    push dx
    push si
    mov cx, 0
    mov si, 10
    mov bx, 0

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

    mov ah, 09h
    mov dx, offset cls
    int 21h

    mov ax, bx

    call printNum

    jmp inputLoop
inputRem:
    mov ax, bx
    mov dx, 0
    div si
    mov bx, ax

    mov ah, 09h
    mov dx, offset cls
    int 21h

    mov ax, bx

    call printNum    

    jmp inputLoop

exitInputNum:
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    mov ax, bx

    pop si
    pop dx
    pop cx
    pop bx
    ret


; can only take up to 16 bits values with AX as input/parameter
printNum:
    push ax
    push bx
    push cx
    push dx
    push si
    push di

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

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    ret

end start
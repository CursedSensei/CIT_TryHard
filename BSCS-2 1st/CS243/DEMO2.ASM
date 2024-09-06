.model small
.stack 100
.data

.code
start:
    mov ax, 65535
    mov bx, 100
    mov dx, 0
    div bx

    call printNum

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

    mov dl, 0Ah
    mov ah, 02h
    int 21h

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    ret

end start
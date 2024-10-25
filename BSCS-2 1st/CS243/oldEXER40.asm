; Filename: EXER40.ASM
; Programmer Name: John Zillion C. Reyes
; Date: October 18, 2024

.model small
.stack 100
.data
    h1 db "MATH OPERATIONS", 0Ah, 0Ah, "$"
    hA db "1. Addition", 0Ah, "$"
    hS db "2. Subtraction", 0Ah, "$"
    hM db "3. Multiplication", 0Ah, "$"
    hD db "4. Division", 0Ah, "Enter your choice: $"

    inA0 db "Addition", 0Ah, "$"
    inA1 db "Enter first addend: $"
    inA2 db "Enter second addend: $"
    outA3 db "Sum: $"

    inS0 db "Subtraction", 0Ah, "$"
    inS1 db "Enter minuend: $"
    inS2 db "Enter subtrahend: $"
    outS3 db "Difference: $"

    inM0 db "Multiplication", 0Ah, "$"
    inM1 db "Enter multiplicand: $"
    inM2 db "Enter multiplier: $"
    outM3 db "Product: $"

    inD0 db "Division", 0Ah, "$"
    inD1 db "Enter dividend: $"
    inD2 db "Enter divisor: $"
    outD3 db "Quotient: $"

    outE db "Exit Program", 0Ah, "$"
    outN db "INVALID CHOICE!", 0Ah, "$"

    cls db "                             ", 0Dh , "                             ", 0Dh, "$"
.code

start:
    mov ax, @data
    mov ds, ax

    mov ah, 00h
    mov al, 03h
    int 10h

    lea dx, h1
    call printString

    lea dx, hA
    call printString

    lea dx, hS
    call printString


    lea dx, hM
    call printString


    lea dx, hD
    call printString

    mov ah, 01h
    int 21h

    call endLine
    call endLine

    cmp al, '1'
    jne nAdd
    call opAdd
    jmp exit
nAdd:
    cmp al, '2'
    jne nSub
    call opSub
    jmp exit
nSub:
    cmp al, '3'
    jne nMul
    call opMul
    jmp exit
nMul:
    cmp al, '4'
    call opDiv
exit:

    int 27h

opAdd:
    push dx
    push cx
    push bx
    push ax

    lea dx, inA0
    call printString
    lea di, inA1
    call inputNum
    mov bx, ax
    lea di, inA2
    call inputNum
    mov cx, ax


    add ax, bx
    lea dx, outA3
    call printString
    call printNum
    call endline

    pop ax
    pop bx
    pop cx
    pop dx
    ret
opSub:
    push dx
    push cx
    push bx
    push ax

    lea dx, inS0
    call printString
    lea di, inS1
    call inputNum
    mov bx, ax
    lea di, inS2
    call inputNum
    mov cx, ax


    sub bx, ax
    mov ax, bx
    lea dx, outS3
    call printString
    call printNum
    call endline

    pop ax
    pop bx
    pop cx
    pop dx
    ret
opMul:
    push dx
    push cx
    push bx
    push ax

    lea dx, inM0
    call printString
    lea di, inM1
    call inputNum
    mov bx, ax
    lea di, inM2
    call inputNum
    mov cx, ax


    mul bx
    lea dx, outM3
    call printString
    call printNum
    call endline

    pop ax
    pop bx
    pop cx
    pop dx
    ret
opDiv:
    push dx
    push cx
    push bx
    push ax

    lea dx, inD0
    call printString
    lea di, inD1
    call inputNum
    mov bx, ax
    lea di, inD2
    call inputNum
    mov cx, ax


    mov ax, bx
    mov dx, 0
    div cx
    lea dx, outD3
    call printString
    call printNum
    call endline

    pop ax
    pop bx
    pop cx
    pop dx
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
end start
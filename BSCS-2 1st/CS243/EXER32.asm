; Filename: EXER32.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 29, 2024

.model small
.stack 100
.data
	szTitle db "Filename: EXER32.ASM", 0Ah, "Programmer Name: JOHN ZILLION C. REYES", 0Ah, "Date: September 29, 2024", 0Ah, 0Ah, '$'
    h1 db "THE CALCULATOR", 0Ah, "Created by: JOHN ZILLION C. REYES", 0Ah, "Date: September 28, 2024", 0Ah, 0Ah, "Main Menu", 0Ah, "$"
    hA db "a - Addition", 0Ah, "$"
    hS db "s - Subtraction", 0Ah, "$"
    hM db "m - Multiplication", 0Ah, "$"
    hD db "d - Division", 0Ah, "$"
    hE db "e - Exit", 0Ah, "Enter your choice: $"

    inA0 db "Addition", 0Ah, "$"
    inA1 db "Enter first addend: $"
    inA2 db "Enter second addend: $"
    outA1 db "First addend is: $"
    outA2 db "Second addend is: $"
    outA3 db "Sum: $"

    inS0 db "Subtraction", 0Ah, "$"
    inS1 db "Enter minuend: $"
    inS2 db "Enter subtrahend: $"
    outS1 db "Minuend is: $"
    outS2 db "Subtrahend is: $"
    outS3 db "Difference: $"

    inM0 db "Multiplication", 0Ah, "$"
    inM1 db "Enter multiplicand: $"
    inM2 db "Enter multiplier: $"
    outM1 db "Multiplicand is: $"
    outM2 db "Multiplier is: $"
    outM3 db "Product: $"

    inD0 db "Division", 0Ah, "$"
    inD1 db "Enter dividend: $"
    inD2 db "Enter divisor: $"
    outD1 db "Dividend is: $"
    outD2 db "Divisor is: $"
    outD3 db "Quotient: $"

    outE db "Exit Program", 0Ah, "$"
    outN db "INVALID CHOICE!", 0Ah, "$"

    f1 db 0Ah, "Press Enter to continue.$"

    cls db "                             ", 0Dh , "                             ", 0Dh, "$"
.code

start:
    mov ax, @data
    mov ds, ax

    lea dx, szTitle
	mov ah, 09h
	int 21h

    mov ah, 00h
    mov al, 03h
    int 10h

    lea dx, h1
    call printString

    mov bl, 60h
    mov cx, 12
    call setColor
    lea dx, hA
    call printString

    mov bl, 20h
    mov cx, 15
    call setColor
    lea dx, hS
    call printString

    mov bl, 10h
    mov cx, 18
    call setColor
    lea dx, hM
    call printString

    mov bl, 50h
    mov cx, 12
    call setColor
    lea dx, hD
    call printString

    mov bl, 70h
    mov cx, 8
    call setColor
    lea dx, hE
    call printString

    mov ah, 01h
    int 21h

    call endLine
    call endLine

    cmp al, 'a'
    jne nAdd
    call opAdd
    jmp exit
nAdd:
    cmp al, 's'
    jne nSub
    call opSub
    jmp exit
nSub:
    cmp al, 'm'
    jne nMul
    call opMul
    jmp exit
nMul:
    cmp al, 'd'
    jne nDiv
    call opDiv
    jmp exit
nDiv:
    cmp al, 'e'
    jne nEx
    mov bl, 70h
    mov cx, 12
    call setColor
    lea dx, outE
    call printString
    int 27h
nEx:
    mov cx, 15
    mov bl, 0CEh
    call setColor
    lea dx, outN
    call printString
    
exit:
    lea dx, f1
    call printString

    mov ah, 01h
    int 21h
    jmp start

opAdd:
    push dx
    push cx
    push bx
    push ax

    mov cx, 8
    mov bl, 60h
    call setColor
    lea dx, inA0
    call printString
    lea di, inA1
    call inputNum
    mov bx, ax
    lea di, inA2
    call inputNum
    mov cx, ax

    lea dx, outA1
    call printString
    mov ax, bx
    call printNum
    call endLine
    lea dx, outA2
    call printString
    mov ax, cx
    call printNum
    call endLine

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

    mov cx, 11
    mov bl, 20h
    call setColor
    lea dx, inS0
    call printString
    lea di, inS1
    call inputNum
    mov bx, ax
    lea di, inS2
    call inputNum
    mov cx, ax

    lea dx, outS1
    call printString
    mov ax, bx
    call printNum
    call endLine
    lea dx, outS2
    call printString
    mov ax, cx
    call printNum
    call endLine

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

    mov cx, 14
    mov bl, 10h
    call setColor
    lea dx, inM0
    call printString
    lea di, inM1
    call inputNum
    mov bx, ax
    lea di, inM2
    call inputNum
    mov cx, ax

    lea dx, outM1
    call printString
    mov ax, bx
    call printNum
    call endLine
    lea dx, outM2
    call printString
    mov ax, cx
    call printNum
    call endLine

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

    mov cx, 8
    mov bl, 50h
    call setColor
    lea dx, inD0
    call printString
    lea di, inD1
    call inputNum
    mov bx, ax
    lea di, inD2
    call inputNum
    mov cx, ax

    lea dx, outD1
    call printString
    mov ax, bx
    call printNum
    call endLine
    lea dx, outD2
    call printString
    mov ax, cx
    call printNum
    call endLine

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

setColor:
    push ax
    
    mov ah, 09h

    int 10h

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
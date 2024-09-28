; Filename: EXAM2.ASM
; CS243 Lab Hands-on Exam No. 2 
; First Semester SY 2024-2025
; Student Name: JOHN ZILLION C. REYES
; Date Finished: September 28, 2024

.model small
.stack 100
.data
    h1 db "THE CALCULATOR", 0Ah, "Created by: JOHN ZILLION C. REYES", 0Ah, "Date: September 28, 2024", 0Ah, 0Ah, "Main Menu", 0Ah, "$"
    hA db "a - Addition", 0Ah, "$"
    hS db "s - Subtraction", 0Ah, "$"
    hM db "m - Multiplication", 0Ah, "$"
    hD db "d - Division", 0Ah, "$"
    hE db "e - Exit", 0Ah, "Enter your choice: $"

    inA1 db "Addition", 0Ah, "Enter first addend: $"
    inA2 db "Enter second addend: $"
    outA1 db "First addend is: $"
    outA2 db "Second addend is: $"

    inS1 db "Subtraction", 0Ah, "Enter minuend: $"
    inS2 db "Enter subtrahend: $"
    outS1 db "Minuend is: $"
    outS2 db "Subtrahend is: $"

    inM1 db "Multiplication", 0Ah, "Enter multiplicand: $"
    inM2 db "Enter multiplier: $"
    outM1 db "Multiplicand is: $"
    outM2 db "Multiplier is: $"

    inD1 db "Division", 0Ah, "Enter dividend: $"
    inD2 db "Enter divisor: $"
    outD1 db "Dividend is: $"
    outD2 db "Divisor is: $"

    outE db "Exit Program", 0Ah, "$"
    outN db "INVALID CHOICE!", 0Ah, "$"

    maxLen EQU 100
    num1 db maxLen dup(?)
    num2 db maxLen dup(?)

    f1 db 0Ah, "Thank you.$"
.code

start:
    mov ax, @data
    mov ds, ax

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
    mov cx, 8
    mov bl, 60h
    lea di, outA2
    lea dx, outA1
    lea si, inA2
    lea ax, inA1
    call printOperation
    jmp exit
nAdd:
    cmp al, 's'
    jne nSub
    mov cx, 11
    mov bl, 20h
    lea di, outS2
    lea dx, outS1
    lea si, inS2
    lea ax, inS1
    call printOperation
    jmp exit
nSub:
    cmp al, 'm'
    jne nMul
    mov cx, 14
    mov bl, 10h
    lea di, outM2
    lea dx, outM1
    lea si, inM2
    lea ax, inM1
    call printOperation
    jmp exit
nMul:
    cmp al, 'd'
    jne nDiv
    mov cx, 8
    mov bl, 50h
    lea di, outD2
    lea dx, outD1
    lea si, inD2
    lea ax, inD1
    call printOperation
    jmp exit
nDiv:
    cmp al, 'e'
    jne nEx
    mov bl, 70h
    mov cx, 12
    call setColor
    lea dx, outE
    call printString
    jmp exit
nEx:
    mov cx, 15
    mov bl, 0CEh
    call setColor
    lea dx, outN
    call printString
    
exit:
    lea dx, f1
    call printString

    int 27h


printOperation:
    push di
    push dx
    push si
    push ax

    call setColor
    pop bx
    lea dx, num1
    call inputNum
    pop bx
    lea dx, num2
    call inputNum
    pop bx
    lea dx, num1
    call outputNum
    pop bx
    lea dx, num2
    call outputNum

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

inputNum:
    push cx
    push dx
    mov dx, bx
    call printString

    pop dx
    mov ah, 3Fh
    mov bx, 0
    mov cx, maxLen
    int 21h

    mov si, dx
    add si, ax

    mov bl, '$'
    mov [si - 2], bl

    pop cx
    ret

outputNum:
    push dx
    mov dx, bx
    call printString
    pop dx
    call printString
    call endLine
    ret

end start
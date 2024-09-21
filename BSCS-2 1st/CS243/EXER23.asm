; Filename: EXER23.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.MODEL small
.STACK 100h
.DATA
    header1 db 'Cebu Institute of Technology - University', 0Ah, 'Automated Teller Machine', 0Ah, 0Ah, 'MAIN MENU', 0Ah, '$'
    header2 db '1 Balance Inquiry', 0Ah, '2 Withdrawal', 0Ah, '3 Deposit', 0Ah, '4 Transfer', 0Ah, '5 Bills Payment', 0Ah, '6 Change Pin', 0Ah, '7 Exit', 0Ah, 'Enter number of your choice: $'

    opStart db 0Ah, 0Ah, 'You have chosen ' , '$'
    op1 db '1 Balance Inquiry.$'
    op2 db '2 Withdrawal.$'
    op3 db '3 Deposit.$'
    op4 db '4 Transfer.$'
    op5 db '5 Bills Payment.$'
    op6 db '6 Change Pin.$'
    op7 db '7 Exit.$'

    footer db 0Ah, 0Ah, 'Thank you for banking with us!', 0Ah, 'Copyright 2024', 0Ah, 'Programmer: JOHN ZILLION REYES$'
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    lea dx, header1
    call printString
    lea dx, header2
    call printString

    mov ah, 01h
    int 21h

    lea dx, opStart
    call printString

    cmp al, '1'
    je oneOp
    cmp al, '2'
    je twoOp
    cmp al, '3'
    je threeOp
    cmp al, '4'
    je fourOp
    cmp al, '5'
    je fiveOp
    cmp al, '6'
    je sixOp
    cmp al, '7'
    je sevenOp
    jmp exitOp
oneOp:
    lea dx, op1
    call printString
    jmp exitOp
twoOp:
    lea dx, op2
    call printString
    jmp exitOp
threeOp:
    lea dx, op3
    call printString
    jmp exitOp
fourOp:
    lea dx, op4
    call printString
    jmp exitOp
fiveOp:
    lea dx, op5
    call printString
    jmp exitOp
sixOp:
    lea dx, op6
    call printString
    jmp exitOp
sevenOp:
    lea dx, op7
    call printString
    jmp exitOp
exitOp:
    lea dx, footer
    call printString
    int 27h

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
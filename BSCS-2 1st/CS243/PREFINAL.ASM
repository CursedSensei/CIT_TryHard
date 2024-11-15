; Filename: PREFINAL.ASM
; CS243 Lab Hands-on Pre-Final Exam 
; First Semester SY 2024-2025
; Student Name: John Zillion Reyes
; Date Finished: November 15, 2024
 
.MODEL SMALL
.STACK 100H
.DATA
    start_msg       DB 1, 80, 1Fh, 'Cebu Institute of Technology - University', 39 dup(' ')
                    DB 1, 80, 1Fh, 'Automatic Teller Machine', 56 dup(' ')
                    DB 1, 80, 1Fh, 'Programmer: John Zillion Reyes', 50 dup(' ')
                    DB 1, 80, 1Fh, 'Copyright 2024', 66 dup(' '), 0Ah, 0

    menu_msg        DB 1, 80, 4Fh, 'Main Menu', 71 dup(' ')
                    DB 1, 80, 4Fh, '1. Balance Inquiry', 62 dup(' ')
                    DB 1, 80, 4Fh, '2. Deposit', 70 dup(' ')
                    DB 1, 80, 4Fh, '3. Withdrawal', 67 dup(' ')
                    DB 1, 80, 4Fh, '4. Exit', 73 dup(' ')
                    DB 'Enter choice: ', 0
    balance_msg     DB 0Ah, 'Balance Inquiry', 0Ah, 'Your current balance: P$'
    deposit_msg     DB 0Ah, 'Deposit', 0Ah, 'Enter deposit amount: P', '$'
    deposit_msg2    DB 0Ah, 'You deposited P', 0
    deposit_msg3    DB '.', 0Ah, 0Ah, 0
    withdraw_msg    DB 0Ah, 'Withdrawal', 0Ah, 'Enter withdrawal amount: P', '$'
    withdraw_msg2   DB 0Ah, 'You withdrew P', 0
    withdraw_error  DB 0Ah, 1, 80, 0CEh, 'ERROR! Insufficient balance!', 52 dup(' '), 0Ah, 0
    exit_msg        DB 0Ah, 'Exit. Thank you!$', 0Ah
    error_msg       DB 0Ah, 1, 80, 0CEh, 'ERROR! Invalid choice!', 58 dup(' '), 0Ah, 0

    amount          DW 2 dup(0)
    input           DW 2 dup(0)
 
.CODE
INCLUDE io.mac
MAIN PROC
    MOV AX, @DATA         
    MOV DS, AX            
 
    lea SI, start_msg
    call printColorString
loop1:

    lea SI, menu_msg
    call printColorString
 
    MOV AH, 01H              
    INT 21H
    MOV CH, AL              
 
    CMP CH, '1'
    JE balance_option
    CMP CH, '2'
    JE deposit_option
    CMP CH, '3'
    JE withdrawal_option
    CMP CH, '4'
    JNE loop2
    jmp exit_program
loop2:
    lea SI, error_msg
    call printColorString
 
    JMP loop1           
 
balance_option:
    MOV DX, OFFSET balance_msg
    MOV AH, 09H
    INT 21H

    PutInt amount
    nwln
    nwln

    JMP loop1
 
deposit_option:
    MOV DX, OFFSET deposit_msg
    MOV AH, 09H
    INT 21H

    GetInt input
    PutStr deposit_msg2
    PutInt input
    PutStr deposit_msg3

    lea si, amount
    lea di, input
    mov dx, [di]
    add [si], dx

    JMP loop1
 
withdrawal_option:
    MOV DX, OFFSET withdraw_msg
    MOV AH, 09H
    INT 21H

    GetInt input

    lea si, amount
    lea di, input
    mov dx, [di]

    cmp dx, [si]
    jg withdrawError

    mov ax, [si]
    sub ax, dx
    mov [si], ax

    PutStr withdraw_msg2
    PutInt input
    PutStr deposit_msg3

    jmp loop1
withdrawError:
    lea si, withdraw_error
    call printColorString

    JMP loop1
 
exit_program:

    MOV DX, OFFSET exit_msg
    MOV AH, 09H
    INT 21H
    INT 27h
 
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

MAIN ENDP
END MAIN
 
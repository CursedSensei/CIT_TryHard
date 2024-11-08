;Filename: Week13e.ASM
;Programmer Name: John Zilion C. Reyes
;Program Description: Repeatedly display an ATM main menu until the user presses “e” for Exit.
;Date Created: November 8, 2024
 
.MODEL SMALL
.STACK 100H
.DATA
menu_msg        DB 'CIT-U ATM', 0Dh, 0Ah
                DB 'a. Balance Inquiry', 0Dh, 0Ah
                DB 'b. Deposit', 0Dh, 0Ah
                DB 'c. Withdrawal', 0Dh, 0Ah
                DB 'd. Bills Payment', 0Dh, 0Ah
                DB 'e. Exit', 0Dh, 0Ah, 0Dh, 0Ah, 'Enter choice: $'
balance_msg     DB 0Dh, 0Ah, 'Balance Inquiry', 0Dh, 0Ah, '$'
deposit_msg     DB 0Dh, 0Ah, 'Deposit', 0Dh, 0Ah, '$'
withdraw_msg    DB 0Dh, 0Ah, 'Withdrawal', 0Dh, 0Ah, '$'
bills_msg       DB 0Dh, 0Ah, 'Bills Payment', 0Dh, 0Ah, '$'
exit_msg        DB 0Dh, 0Ah, 'Exit. Thank you!$', 0Dh, 0Ah
 
.CODE
MAIN PROC
    MOV AX, @DATA         
    MOV DS, AX            
 
loop1:

    MOV DX, OFFSET menu_msg
    MOV AH, 09H         
    INT 21H
 
    MOV AH, 01H              
    INT 21H
    MOV CH, AL              
 
    CMP CH, 'a'
    JE balance_option
    CMP CH, 'b'
    JE deposit_option
    CMP CH, 'c'
    JE withdrawal_option
    CMP CH, 'd'
    JE bills_payment_option
    CMP CH, 'e'
    JE exit_program
 
    JMP loop1           
 
balance_option:
    MOV DX, OFFSET balance_msg
    MOV AH, 09H
    INT 21H
    JMP loop1
 
deposit_option:
    MOV DX, OFFSET deposit_msg
    MOV AH, 09H
    INT 21H
    JMP loop1
 
withdrawal_option:
    MOV DX, OFFSET withdraw_msg
    MOV AH, 09H
    INT 21H
    JMP loop1
 
bills_payment_option:
    MOV DX, OFFSET bills_msg
    MOV AH, 09H
    INT 21H
    JMP loop1
 
exit_program:

    MOV DX, OFFSET exit_msg
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH     
    INT 21H
 
MAIN ENDP
END MAIN
 
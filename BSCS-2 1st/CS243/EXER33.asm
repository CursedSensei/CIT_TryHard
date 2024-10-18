; Filename: EXER33.ASM
; Programmer Name: John Zillion C. Reyes
; Date: October 18, 2024
; Description: This assembly language program will input 
; two single-digit numbers, add the two numbers,
; and display the sum of the two numbers.
.MODEL SMALL
.STACK 100H
.DATA
    num1 DB ?
    num2 DB ?
    sum DB ?
    msg1 DB 'Enter first number (0-9): $'
    msg2 DB 0DH, 0AH, 'Enter second number (0-9): $'
    msg3 DB 0DH, 0AH, 'The sum is: $'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    ; Input first number
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    ; Read character input
    MOV AH, 01H
    INT 21H
    SUB AL, '0' ; Convert ASCII to number
    MOV num1, AL

    ; Input second number
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '0' ; Convert ASCII to number
    MOV num2, AL

    ; Calculate sum
    MOV AL, num1

    ADD AL, num2
    MOV sum, AL

    ; Display result
    LEA DX, msg3
    MOV AH, 09H
    INT 21H

    ; Convert sum to ASCII
    ADD sum, '0'
    MOV DL, sum
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN

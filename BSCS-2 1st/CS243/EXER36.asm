; Filename: EXER36.ASM
; Programmer Name: John Zillion C. Reyes
; Date: October 18, 2024
; Description: This assembly language program will input two single-digit numbers, divide the two numbers,
; and display the quotient of the two numbers.

.model small
.stack 100h
.data
    msg1 db 'Enter first number (0-9): $'
    msg2 db 'Enter second number (1-9): $' ; Second number cannot be zero
    resultMsg db 'The result is: $'
    num1 db ?
    num2 db ?
    result db ?
.code
start:
    ; Set up the data segment
    mov ax, @data
    mov ds, ax

    ; Prompt for the first number
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read first number
    call read_number
    mov num1, al

    ; Prompt for the second number
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Read second number
    call read_number
    mov num2, al

    ; Check for division by zero
    cmp num2, 0
    je div_by_zero

    ; Divide the two numbers
    mov al, num1
    xor ah, ah ; Clear AH for the division
    mov bl, num2
    div bl ; AL = AL / BL, quotient in AL, remainder in AH
    mov result, al ; Store the quotient

    ; Display the result
    mov ah, 09h
    lea dx, resultMsg
    int 21h

    ; Convert result to ASCII and print
    call print_result

    ; Exit program
    mov ax, 4C00h
    int 21h
div_by_zero:
    ; Handle division by zero (optional: you can display a message)
    mov ah, 09h
    lea dx, msg2 ; Reuse msg2 for simplicity
    int 21h
    ; Exit program
    mov ax, 4C00h
    int 21h

; Read a number from keyboard (assumes single digit input)
    read_number proc
    mov ah, 01h ; Function to read a character
    int 21h
    sub al, '0' ; Convert ASCII to integer
    ret
read_number endp

; Print the result (single digit)
print_result proc
    add result, '0' ; Convert result to ASCII
    mov ah, 0Eh ; BIOS teletype output function
    mov al, result
    int 10h
    ret
print_result endp
end start
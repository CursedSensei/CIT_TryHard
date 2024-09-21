; Filename: EXER22.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.MODEL small
.STACK 100h
.DATA
    promptStart db 'Cebu Institute of Technology - University', 0Ah, 'STUDENT ENROLLMENT FORM', 0Ah, 0Ah, 'Please enter the following information:', 0Ah, '$'
    promptID db 'Student ID Number: ', '$'
    promptFirst db 'First Name: ', '$'
    promptMiddle db 'Middle Name: ', '$'
    promptLast db 'Last Name: ', '$'
    promptAddress db 'Address: ', '$'
    promptCourse db 'Course: ', '$'
    promptYear db 'Year: ', '$'
    promptBMon db 'Birthday Month: ', '$'
    promptBDay db 'Birthday Day: ', '$'
    promptBYear db 'Birthday Year: ', '$'
    promptEmail db 'Email Address: ', '$'

    headerOutput db 0Ah, 'SUMMARY', 0Ah, 'Please check if all information are correct.', 0Ah, 0Ah, '$'

    outID db 'ID Number: ', '$'
    outName db 'Full Name: ', '$'
    outAddress db 'Address: ', '$'
    outCourseYear db 'Course & Year: ', '$'
    outBirthday db 'Birthday: ', '$'
    outEmail db 'Email Address: ', '$'

    footer db 0Ah, 'Thank you for enrolling at CIT-U.', 0Ah, 'Copyright 2024', 0Ah, 'Programmer: JOHN ZILLION REYES', 0Ah, '$'

    max_len EQU 1002

    inId db max_len dup(?)
    inFirst db max_len dup(?)
    inMiddle db max_len dup(?)
    inLast db max_len dup(?)
    inAddress db max_len dup(?)
    inCourse db max_len dup(?)
    inYear db max_len dup(?)
    inBMon db max_len dup(?)
    inBDay db max_len dup(?)
    inBYear db max_len dup(?)
    inEmail db max_len dup(?)
.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax


    lea dx, promptStart
    call printString


    lea bx, promptID
    lea dx, inId
    call inputField

    lea bx, promptFirst
    lea dx, inFirst
    call inputField

    lea bx, promptMiddle
    lea dx, inMiddle
    call inputField

    lea bx, promptLast
    lea dx, inLast
    call inputField

    lea bx, promptAddress
    lea dx, inAddress
    call inputField

    lea bx, promptCourse
    lea dx, inCourse
    call inputField

    lea bx, promptYear
    lea dx, inYear
    call inputField

    lea bx, promptBMon
    lea dx, inBMon
    call inputField

    lea bx, promptBDay
    lea dx, inBDay
    call inputField

    lea bx, promptBYear
    lea dx, inBYear
    call inputField

    lea bx, promptEmail
    lea dx, inEmail
    call inputField


    lea dx, headerOutput
    call printString


    lea bx, outID
    lea dx, inId
    call outputField

    lea dx, outName
    call printString
    lea dx, inLast
    call printNumString
    call addComma
    call addSpace
    lea dx, inFirst
    call printNumString
    call addSpace
    lea dx, inMiddle
    call printNumString
    call endLine

    lea bx, outAddress
    lea dx, inAddress
    call outputField

    lea dx, outCourseYear
    call printString
    lea dx, inCourse
    call printNumString
    call addSpace
    lea dx, inYear
    call printNumString
    call endLine

    lea dx, outBirthday
    call printString
    lea dx, inBMon
    call printNumString
    call addSpace
    lea dx, inBDay
    call printNumString
    call addComma
    call addSpace
    lea dx, inBYear
    call printNumString
    call endLine

    lea bx, outEmail
    lea dx, inEmail
    call outputField


    lea dx, footer
    call printString

    int 27h

outputField:
    push dx
    mov dx, bx
    call printString
    pop dx
    call printNumString
    call endLine
    ret

inputField:
    push dx
    mov dx, bx
    call printString
    pop dx
    call getString
    ret

getString:
    push ax
    push bx
    push cx

    add dx, 2

    mov ah, 3fh
    mov bx, 0
    mov cx, max_len - 2
    int 21h

    sub dx, 2
    mov si, dx
    mov [si], ah
    mov [si + 1], al

    pop cx
    pop bx
    pop ax
    ret

printNumString:
    push ax
    push bx
    push cx
    mov si, dx

    mov ah, 40h
    mov ch, [si]
    mov cl, [si + 1]
    add dx, 2
    sub cx, 2
    mov bx, 1
    int 21h

    pop cx
    pop bx
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
    push bx
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    pop bx
    pop ax
    ret

addSpace:
    push ax
    push bx
    mov ah, 02h
    mov dl, ' '
    int 21h
    pop bx
    pop ax
    ret

addComma:
    push ax
    push bx
    mov ah, 02h
    mov dl, ','
    int 21h
    pop bx
    pop ax
    ret

END ProgramStart
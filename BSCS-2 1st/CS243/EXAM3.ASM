; Filename: EXAM3.ASM
; CS243 Lab Hands-on Exam No. 3
; First Semester SY 2024-2025
; Student Name: JOHN ZILLION C. REYES
; Date Finished: October 4, 2024

.model small
.stack 100
.data
    head db 1, 25, 60h, "VOTER'S REGISTRATION FORM", 0Ah, 1, 33, 20h, "Created by: JOHN ZILLION C. REYES", 0Ah, 1, 21, 50h, "Date: October 4, 2024", 0Ah, 0Ah, "Please enter the following:", 0Ah, 0Ah, 0

    i1 db "First Name: ", 0
    i2 db "Middle Name: ", 0
    i3 db "Family Name: ", 0
    i4 db "Gender: ", 0
    i5 db "Birthday", 0Ah, '  Month: ', 0
    i6 db "  Day: ", 0
    i7 db "  Year: ", 0
    i8 db "Address", 0Ah, '  House Number: ', 0
    i9 db "  Street: ", 0
    i10 db "  Barangay: ", 0
    i11 db "  City: ", 0
    i12 db "  Province: ", 0
    i13 db "Educational Background", 0Ah, "  Elementary", 0Ah, "    Name of School: ", 0
    i14 db "    Year Graduated: ", 0
    i15 db "  Junior High School", 0Ah, "    Name of School: ", 0
    i16 db "    Year Graduated: ", 0
    i17 db "  Senior High School", 0Ah, "    Name of School: ", 0
    i18 db "    Year Graduated: ", 0
    i19 db "  College", 0Ah, "    Name of School: ", 0
    i20 db "    Year Graduated: ", 0

    d1 db 200 dup(0)
    d2 db 200 dup(0)
    d3 db 200 dup(0)
    d4 db 200 dup(0)
    d5 db 200 dup(0)
    d6 db 200 dup(0)
    d7 db 200 dup(0)
    d8 db 200 dup(0)
    d9 db 200 dup(0)
    d10 db 200 dup(0)
    d11 db 200 dup(0)
    d12 db 200 dup(0)
    d13 db 200 dup(0)
    d14 db 200 dup(0)
    d15 db 200 dup(0)
    d16 db 200 dup(0)
    d17 db 200 dup(0)
    d18 db 200 dup(0)
    d19 db 200 dup(0)
    d20 db 200 dup(0)

    head2 db 0Ah, "SUMMARY OF INFORMATION", 0Ah, "Please verify if all entries are correct." , 0Ah, 0Ah, 0

    f1 db 0Ah, 1, 12, 0CEh, "Vote wisely!", 0Ah, "Thank you for registering.", 0Ah, 0
.code

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

inputData:
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, dx
    call printColorString

    mov ah, 3FH
    mov bx, 0
    mov cx, 200
    mov dx, di
    int 21h

    mov bl, 0
    add di, ax
    mov [di - 2], bl

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

outputData:
    push si
    push dx
    push ax

    mov si, dx
    call printColorString
    mov si, di
    call printColorString

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    pop ax
    pop dx
    pop si
    ret

ProgramStart:
    mov ax, @data
    mov ds, ax

    lea dx, szTitle
	mov ah, 09h
	int 21h

    lea si, head
    call printColorString

    mov dx, offset i1
    mov di, offset d1
    call inputData

    mov dx, offset i2
    mov di, offset d2
    call inputData

    mov dx, offset i3
    mov di, offset d3
    call inputData

    mov dx, offset i4
    mov di, offset d4
    call inputData

    mov dx, offset i5
    mov di, offset d5
    call inputData

    mov dx, offset i6
    mov di, offset d6
    call inputData

    mov dx, offset i7
    mov di, offset d7
    call inputData

    mov dx, offset i8
    mov di, offset d8
    call inputData

    mov dx, offset i9
    mov di, offset d9
    call inputData

    mov dx, offset i10
    mov di, offset d10
    call inputData

    mov dx, offset i11
    mov di, offset d11
    call inputData

    mov dx, offset i12
    mov di, offset d12
    call inputData

    mov dx, offset i13
    mov di, offset d13
    call inputData

    mov dx, offset i14
    mov di, offset d14
    call inputData

    mov dx, offset i15
    mov di, offset d15
    call inputData

    mov dx, offset i16
    mov di, offset d16
    call inputData

    mov dx, offset i17
    mov di, offset d17
    call inputData

    mov dx, offset i18
    mov di, offset d18
    call inputData

    mov dx, offset i19
    mov di, offset d19
    call inputData

    mov dx, offset i20
    mov di, offset d20
    call inputData

    lea si, head2
    call printColorString

    mov dx, offset i1
    mov di, offset d1
    call outputData

    mov dx, offset i2
    mov di, offset d2
    call outputData

    mov dx, offset i3
    mov di, offset d3
    call outputData

    mov dx, offset i4
    mov di, offset d4
    call outputData

    mov dx, offset i5
    mov di, offset d5
    call outputData

    mov dx, offset i6
    mov di, offset d6
    call outputData

    mov dx, offset i7
    mov di, offset d7
    call outputData

    mov dx, offset i8
    mov di, offset d8
    call outputData

    mov dx, offset i9
    mov di, offset d9
    call outputData

    mov dx, offset i10
    mov di, offset d10
    call outputData

    mov dx, offset i11
    mov di, offset d11
    call outputData

    mov dx, offset i12
    mov di, offset d12
    call outputData

    mov dx, offset i13
    mov di, offset d13
    call outputData

    mov dx, offset i14
    mov di, offset d14
    call outputData

    mov dx, offset i15
    mov di, offset d15
    call outputData

    mov dx, offset i16
    mov di, offset d16
    call outputData

    mov dx, offset i17
    mov di, offset d17
    call outputData

    mov dx, offset i18
    mov di, offset d18
    call outputData

    mov dx, offset i19
    mov di, offset d19
    call outputData

    mov dx, offset i20
    mov di, offset d20
    call outputData

    lea si, f1
    call printColorString

    int 27h
end ProgramStart
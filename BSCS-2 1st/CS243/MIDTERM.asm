; Filename: MIDTERM.ASM
; CS243 Lab Hands-on Midterm Exam
; First Semester SY 2024-2025
; Student Name: JOHN ZILLION C. REYES
; Date Finished: October 4, 2024

.model small
.stack 100
.data
	szTitle db 'Online Grocery Order Form', 0Ah
            db 'Programmer: John Zillion Reyes', 0Ah
            db 'Date: October 11, 2024', 0Ah, 0Ah, 'Please enter your 5 grocery items:', 0Ah, '$'

    i1 db "Item No. 1: ", 0
    i2 db "Item No. 2: ", 0
    i3 db "Item No. 3: ", 0
    i4 db "Item No. 4: ", 0
    i5 db "Item No. 5: ", 0

    d1 db 200 dup(0)
    d2 db 200 dup(0)
    d3 db 200 dup(0)
    d4 db 200 dup(0)
    d5 db 200 dup(0)

    dColor db 1

    head db 0Ah, ' ____________________________________________________________', 0Ah, " ", 1, 60, 4Eh, "                        ORDER SUMMARY                        " , 0Ah, 0

    f1 db 0Ah, 'Thank you for shopping!', 0Ah, 1, 17, 0CEh, 'Order again soon.', 0
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

spaceLoop:
    mov dl, ' '
    mov ah, 02h
    int 21h
    jmp spaceExit

printSpace:
    push cx
    push ax
    push dx

spaceExit:
    loop spaceLoop

    pop dx
    pop ax
    pop cx
    ret

outputData:
    push si
    push dx
    push ax
    push cx

    mov cx, 2
    call printSpace

    mov si, offset dColor
    mov bl, 1
    cmp [si], bl
    je outWhite
    mov bl, 1
    mov [si], bl
    mov bl, 1Fh
    jmp outExit
outWhite:
    mov bl, 0
    mov [si], bl
    mov bl, 70h
outExit:
    mov cx, 60
    mov ah, 09h
    int 10h

    mov si, dx
    call printColorString

    mov cx, 4
    call printSpace

    mov dl, '|'
    mov ah, 02h
    int 21h

    mov cx, 2 
    call printSpace

    mov si, di
    call printColorString

    mov cx, 50
    call printSpace

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    pop cx
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

    lea si, head
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

    lea si, f1
    call printColorString

    int 27h
end ProgramStart
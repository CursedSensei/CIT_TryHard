; Filename: PRELIM.ASM
; CS243 Lab Prelim Exam First Semester SY 2024-2025
; Student Name: JOHN ZILLION REYES
; Date: September 13, 2024

.model small
.stack 100
.data
    h1 db "Cebu Institute of Technology - University$"
    h2 db "VEHICLE STICKER APPLICATION FORM$"
    h3 db "Please fill out form below$"

    d1 db "Personnel Type:$"
    d2 db "Name of Applicant/Driver:$"
    d3 db "Mobile Number:$"
    d4 db "Vehicle Make(s)/Brand:$"
    d5 db "Vehicle Color:$"
    d6 db "Vehicle Sticker Type:$"
    d7 db "ID Number:$"
    d8 db "Address:$"
    d9 db "Plate Number:$"
    d10 db "Vehicle Type:$"

    b1 db "SUBMIT$"

    f1 db "Copyright 2024 JOHN ZILLION C. REYES$"
    f2 db "Thank you!$"
.code

start:
    mov ax, @data
    mov ds, ax

    call endLine


    call printMargin

    mov cx, 73
    mov bl, 4Fh
    call printColor

    mov cx, 16
    call printSpace

    lea dx, h1
    call printString

    mov cx,16
    call printSpace

    call printMargin
    call endLine

    
    call printMargin

    mov cx, 73
    mov bl, 4Fh
    call printColor

    mov cx, 20
    call printSpace

    lea dx, h2
    call printString

    mov cx, 21
    call printSpace

    call printMargin
    call endLine


    call printMargin

    mov cx, 73
    mov bl, 0CEh
    call printColor

    mov cx, 23
    call printSpace

    lea dx, h3
    call printString

    mov cx, 24
    call printSpace

    call printMargin
    call endLine


    call addSpacing


    call printMargin

    mov bl, 70h
    mov cx, 25
    call printColor

    lea dx, d1
    call printString

    mov cx, 10
    call printSpace

    mov al, 1
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d6
    call printString
    
    mov cx, 5
    call printSpace

    call printBlank

    call printMargin
    call endLine


    call addSpacing


    call printMargin

    mov bl, 70h
    mov cx, 25
    call printColor

    lea dx, d2
    call printString

    mov al, 0
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d7
    call printString
    
    mov cx, 16
    call printSpace

    call printBlank

    call printMargin
    call endLine

    call addSpacing


    call printMargin

    mov bl, 70h
    mov cx, 25
    call printColor

    lea dx, d3
    call printString

    mov cx, 11
    call printSpace

    mov al, 0
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d8
    call printString
    
    mov cx, 18
    call printSpace

    call printBlank

    call printMargin
    call endLine
    call addSpacing

    
    call printMargin

    mov bl, 70h
    mov cx, 25
    call printColor

    lea dx, d4
    call printString

    mov cx, 3
    call printSpace

    mov al, 0
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d9
    call printString
    
    mov cx, 13
    call printSpace

    call printBlank

    call printMargin
    call endLine
    call addSpacing


    call printMargin

    mov bl, 70h
    mov cx, 25
    call printColor

    lea dx, d5
    call printString

    mov cx, 11
    call printSpace

    mov al, 1
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d10
    call printString
    
    mov cx, 13
    call printSpace

    call printBlank

    call printMargin
    call endLine

    call addSpacing
    call addSpacing


    call printMargin

    mov bl, 70h
    mov cx, 31
    call printColor
    call printSpace

    mov bl, 4Eh
    mov cx, 10
    call printColor

    mov cx, 2
    call printSpace

    lea dx, b1
    call printString

    call printSpace

    mov bl, 70h
    mov cx, 32
    call printColor
    call printSpace

    call printMargin
    call endLine
    
    call addSpacing

    mov bl, 70h
    mov cx, 75
    call printColor
    mov cx, 2
    call printSpace

    mov cx, 18
    call printSpace

    lea dx, f1
    call printString

    mov cx, 19
    call printSpace

    call printMargin
    call endLine

    call addSpacing
    call endLine

    mov bl, 8Eh
    mov cx, 80
    call printColor

    mov cx, 33
    call printSpace

    lea dx, f2
    call printString

    call endLine

    int 27h


endLine:
    push ax
    push dx
    push cx

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    mov cx, 1
    call printSpace

    pop cx
    pop dx
    pop ax
    ret

printBlank:
    push bx
    push cx
    push ax
    push dx

    mov bl, 08h
    mov cx, 7
    call printColor
    call printPixel

    cmp al, 1
    mov cx, 3

    je withBlank
    call printColor
    call printPixel
    jmp endBlank
withBlank:
    mov bl, 4Fh
    call printColor

    mov cx, 1
    call printSpace

    mov ah, 02h
    mov dl, 'V'
    int 21h

    call printSpace
endBlank:
    pop dx
    pop ax
    pop cx
    pop bx
    ret

printMargin:
    push bx
    push cx

    mov bl, 70h
    mov cx, 2
    call printColor
    call printSpace

    pop cx
    pop bx
    ret

printString:
    push ax

    mov ah, 09h
    int 21h

    pop ax
    ret


printColor:
    push ax
    
    mov ah, 09h
    mov al, 0

    int 10h

    pop ax
    ret


printPixel:
    push ax
    push dx
    push cx
printPixelLoop:
    mov ah, 02h
    mov dl, 219
    int 21h

    loop printPixelLoop

    pop cx
    pop dx
    pop ax
    ret


printSpace:
    push ax
    push dx
    push cx
printSpaceLoop:
    mov ah, 02h
    mov dl, ' '
    int 21h

    loop printSpaceLoop

    pop cx
    pop dx
    pop ax
    ret

addSpacing:
    push bx
    push cx

    call printMargin

    mov bl, 70h
    mov cx, 73
    call printColor
    call printSpace

    call printMargin
    call endLine

    pop cx
    pop bx
    ret

end start
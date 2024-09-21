; Filename: EXER24.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024

.model small
.stack 100
.data
    header db 'Cebu Institute of Technology - University', 0Ah, 'VEHICLE STICKER APPLICATION FORM', 0Ah, 'Please enter the needed information:', 0Ah, 0Ah, '$'

    max_len EQU 1000

    in1 db max_len dup(' ')
    in2 db max_len dup(' ')
    in3 db max_len dup(' ')
    in4 db max_len dup(' ')
    in5 db max_len dup(' ')
    in6 db max_len dup(' ')
    in7 db max_len dup(' ')
    in8 db max_len dup(' ')
    in9 db max_len dup(' ')
    in10 db max_len dup(' ')


    h0 db 0Ah, 'SUMMARY', 0Ah, '$'
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

    lea dx, header
    call printString


    lea bx, d1
    lea dx, in1
    call inputData

    lea bx, d2
    lea dx, in2
    call inputData

    lea bx, d3
    lea dx, in3
    call inputData

    lea bx, d4
    lea dx, in4
    call inputData

    lea bx, d5
    lea dx, in5
    call inputData

    lea bx, d6
    lea dx, in6
    call inputData

    lea bx, d7
    lea dx, in7
    call inputData

    lea bx, d8
    lea dx, in8
    call inputData

    lea bx, d9
    lea dx, in9
    call inputData

    lea bx, d10
    lea dx, in10
    call inputData


    lea dx, h0
    call printString

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
    lea dx, in1
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d6
    call printString
    
    mov cx, 5
    call printSpace
    lea dx, in6
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
    lea dx, in2
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d7
    call printString
    
    mov cx, 16
    call printSpace
    lea dx, in7
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
    lea dx, in3
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d8
    call printString
    
    mov cx, 18
    call printSpace
    lea dx, in8
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
    lea dx, in4
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d9
    call printString
    
    mov cx, 13
    call printSpace
    lea dx, in9
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
    lea dx, in5
    mov al, 1
    call printBlank

    call printMargin

    mov cx, 26
    call printColor
    
    lea dx, d10
    call printString
    
    mov cx, 13
    call printSpace
    lea dx, in10
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

    mov bl, 0Fh

    cmp al, 1
    je withBlank

    mov cx, 10
    call printColor
    call outputData
    jmp endBlank
withBlank:
    mov cx, 7
    call printColor
    call outputData

    mov cx, 3
    mov bl, 4Fh
    call printColor

    mov cx, 1
    call printSpace

    mov ah, 02h
    mov dl, 'V'
    int 21h

    call printSpace
endBlank:
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


inputData:
    push cx
    push dx
    mov dx, bx
    call printString
    mov cx, 1
    call printSpace

    pop dx
    mov ah, 3Fh
    mov bx, 0
    mov cx, max_len
    int 21h

    mov si, dx
    add si, ax
    mov [si - 2], ' '
    mov [si - 1], ' '

    pop cx
    ret

outputData:
    push ax
    push bx

    mov ah, 40h
    mov bx, 1
    int 21h

    pop bx
    pop ax
    ret

end start
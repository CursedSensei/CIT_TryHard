.model small
.stack 100
.data
    upperSlot db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0Ah, 0
    lowerSlot db 192, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 217, 0Ah, 0
    slot db 179, 1, 2, 0, "  ", 179, 0
    fileFormat db ".dat", 0
    title_sz db "Car Parking Management System", 0

    buf db 255 dup(0)
    buf2 db 255 dup(0)

    slots db 3 dup(0)
    customerLen db 0
.code
INCLUDE customio.asm

header:
    push bx
    push si
    push cx

    mov bl, 1Eh
    call fillColor
    call fillSpace
    call fillColor

    lea si, title_sz
    mov cx, 80
    call printCenter
    call fillColor
    call fillSpace

    pop cx
    pop si
    pop bx
    ret

start:
    mov ax, @data
    mov ds, ax

    call header

    call getKey
    
    int 27h
end start
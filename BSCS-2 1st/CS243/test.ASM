.model small
.stack 100
.data
.code
start:
    mov ah, 09h
    mov al, 219
    mov cx, 1
    mov bl, 08h
    int 10h

    mov ah, 02h
    mov dl, 'g'
    int 21h

    int 27h
end start
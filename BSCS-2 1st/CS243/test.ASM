.model small
.stack 100
.data
    file db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0
    data db "TEST.TXT", 0
    dir db "6.DAT", 0
    tes equ
.code
INCLUDE customio.asm
start:
    mov ax, @data
    mov ds, ax

    mov ah, 0
loopme:
    call getKey
    call printNum
    nwln
    jmp loopme

    int 27h
end start
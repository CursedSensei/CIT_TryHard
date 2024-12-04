.model small
.stack 100
.data
    file db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0
    data db "test data hi", 0
    dir db "D:\finaldata", 0
    tes equ
.code
INCLUDE customio.asm
start:
    mov ax, @data
    mov ds, ax
    mov ax, 0
loopme:
    call getKey
    call printNum
    nwln
    jmp loopme

    int 27h
end start
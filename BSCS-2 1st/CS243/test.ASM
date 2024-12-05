.model small
.stack 100
.data
    file db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0
    data db "test data hi", 0, 20 dup(0)
    dir db "D:\finaldata", 0
    tes equ
.code
INCLUDE customio.asm
start:
    mov ax, @data
    mov ds, ax

    mov ax, 1623
    lea si, data
    call formatNum
    lea di, dir
    call strcat
    call print

    int 27h
end start
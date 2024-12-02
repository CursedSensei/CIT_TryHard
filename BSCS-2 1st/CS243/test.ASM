.model small
.stack 100
.data
    file db "test.txt", 0
    data db "test data hi", 0
    dir db "D:\finaldata", 0
.code
INCLUDE customio.asm
start:
    mov ax, @data
    mov ds, ax

    lea si, file
    lea di, file
    call strcmp
    jc equalme
    int 27h
equalme:
    lea si, dir
    call print

    int 27h
end start
.model small
.stack 100
.data
    text db "test.txt", 0
.code
INCLUDE customio.asm
start:
    mov ax, @data
    mov ds, ax

    
    int 27h
end start
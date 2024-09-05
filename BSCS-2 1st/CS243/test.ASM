.model small
.stack 100
.data
    dasd db "John Zillion Reyes ", "$"
.code
start:
    mov ax, @data   ; move starting address to ax (ds is a segment register and does not allow "constant values" to be moved) - parentheses is a theory
    mov ds, ax      ; move value of ax to ds (ax is a general register thus enabling us to move value to segment register) - idk wtafak im saying

    call printInt

    mov ax, @model
    call printInt

    mov ax, @code
    call printInt

    int 27h


printInt: 
    mov si, ax
    mov cl, 0

    mov ax, si

digitLoop:
    mov bl, 10
    div bl
    mov bh, al
    mov ch, ah

    mov al, cl
    mov ah, 0
    mov bl, 2
    div bl

    cmp ah, 1
    je isOdd
    mov ah, ch
    mov al, 0
    jmp endIsOdd
isOdd:
    pop ax
    mov al, ch
endIsOdd:
    push ax

    inc cl
    mov al, bh
    cmp al, 0
    mov ah, 0
    jne digitLoop

printLoop:
    mov al, cl
    mov ah, 0
    mov bl, 2
    div bl

    cmp ah, 1
    je isOddE
    pop ax
    mov dl, al
    mov al, 0
    push ax
    jmp endIsOddE
isOddE:
    pop ax
    mov dl, ah
endIsOddE:
    dec cl

    add dl, '0'
    mov ah, 02h
    int 21h

    cmp cl, 0
    jne printLoop

    mov dl, 0Ah
    mov ah, 02h
    int 21h

    ret
end start
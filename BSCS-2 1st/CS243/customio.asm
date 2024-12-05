; [print] Print String with colors
;
; @Param
; SI - null terminated string with color code [1, length, RGB]
print:
    push ax
    push bx
    push cx
    push dx
    push si

    mov bh, 0
_printColorLoop:
    mov bl, 0
    cmp [si], bl
    je _printColorExit
    mov bl, 1
    cmp [si], bl
    jne _notColor
    mov ah, 09h
    inc si
    mov cl, [si]
    mov ch, 0
    inc si
    mov bl, [si]
    int 10h
    inc si
    jmp _printColorLoop
_notColor:
    mov ah, 02h
    mov dl, [si]
    int 21h
    inc si
    jmp _printColorLoop
_printColorExit:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
; --------------------------------------------------------


; [printChr] Print character
;
; @Param
; DL - Character code
printChr:
    push ax

    mov ah, 02h
    int 21h

    pop ax
    ret
; --------------------------------------------------------


; [printColor] Print filling the string with color code
;
; @Param
; SI - Pointer to string
; BL - Color code
printColor:
    push ax
    push cx
    call strlen

    mov cx, ax
    call setColor

    call print

    pop cx
    pop ax
    ret
; --------------------------------------------------------


; [strlen] Get length of string
;
; @Param
; SI - Pointer to string
; 
; @Return
; AX - length of string
;
; NOTE: All str functions except this one does not support colors in string
strlen:
    push si
    push bx
    xor ax, ax
    mov bl, 0
    mov bh, 1
_strlenLoop:
    cmp [si], bh
    je _strlenIgnore
    cmp [si], bl
    je _strlenExit
    inc si
    inc ax
    jmp _strlenLoop
_strlenIgnore:
    add si, 3
    jmp _strlenLoop
_strlenExit:
    pop bx
    pop si
    ret
; --------------------------------------------------------


; [strcmp] Check if both strings are equal
;
; @Param
; SI - Pointer to first string
; DI - Pointer to second string
;
; @Return
; CF - 1 if equal else 0
strcmp:
    push ax
    push cx
    push di
    push si
    call strlen
    mov cx, ax
    mov si, di
    call strlen

    pop si
    push si

    cmp cx, ax
    je _strcmpContinue
_strcmpNotEqual:
    clc
    jmp _strcmpExit
_strcmpContinue:
    cmp cx, 0
    je _strcmpEmpty
_strcmpLoop:
    mov al, [di]
    cmp [si], al
    jne _strcmpNotEqual
    inc si
    inc di
    loop _strcmpLoop
_strcmpEmpty:
    stc
_strcmpExit:
    pop si
    pop di
    pop cx
    pop ax
    ret
; --------------------------------------------------------


; [strcat] Concatenate two strings
;
; @Param
; SI - Pointer to string to be concatenated
; DI - Pointer to string to concatenate
;
; NOTE: C-Style - strcat(SI, DI);
strcat:
    push si
    push di
    push ax

    call strlen
    add si, ax

    mov al, 0

_strcatLoop:
    mov ah, [di]
    cmp ah, al
    je _strcatExit
    mov [si], ah
    inc si
    inc di
    jmp _strcatLoop
_strcatExit:
    mov [si], al

    pop ax
    pop di
    pop si
    ret
; --------------------------------------------------------


; [memcpy] Copy memory from another address to another
;
; @Param
; SI - Pointer to source
; DI - Pointer to destination
; CX - Length of bytes to copy
memcpy:
    push si
    push di
    push cx
    push bx

    cmp cx, 0
    jle _exitmemcpy
_loopmemcpy:
    mov bl, [si]
    mov [di], bl
    inc si
    inc di
    loop _loopmemcpy
_exitmemcpy:
    pop bx
    pop cx
    pop di
    pop si
    ret
; --------------------------------------------------------


; [memset] Set all bytes of a memory address to specified byte value
;
; @Param
; SI - Pointer to set value
; BL - Byte value
; CX - Length of bytes to set
memset:
    push si
    push cx

    cmp cx, 0
    jle _exitmemset
_loopmemset:
    mov [si], bl
    inc si
    loop _loopmemset
_exitmemset:
    pop cx
    pop si
    ret
; --------------------------------------------------------


; [printColorCenter] Print centered filling the string with color code
;
; @Param
; SI - Pointer to string
; BL - Color code
; CX - length of the space to print (80 for screen)
printColorCenter:
    push ax
    push dx
    call strlen
    
    mov dx, ax
    mov ax, cx
    cmp dx, ax
    jge _printColorCenterIgnore
    jmp _printColorCenterIgnoreElse
_printColorCenterIgnore:
    call print
    pop dx
    pop ax
    ret
_printColorCenterIgnoreElse:
    push cx

    sub ax, dx
    mov dl, 2
    div dl

    call setColor

    xor cx, cx
    mov cl, al
    call printSpace

    call print

    add cl, ah
    call printSpace

    pop cx
    pop dx
    pop ax
    ret
; --------------------------------------------------------


; [printCenter] Print string center to screen
;
; @Param
; SI - Pointer to string to print
; CX - length of the space to print (80 for screen)
printCenter:
    push ax
    push dx
    call strlen
    
    mov dx, ax
    mov ax, cx
    cmp dx, ax
    jge _printCenterIgnore
    jmp _printCenterIgnoreElse
_printCenterIgnore:
    call print
    pop dx
    pop ax
    ret
_printCenterIgnoreElse:
    push cx

    sub ax, dx
    mov dl, 2
    div dl

    xor cx, cx
    mov cl, al
    call printSpace
    call print
    add cl, ah
    call printSpace

    pop cx
    pop dx
    pop ax
    ret
; --------------------------------------------------------


; [printSpace] Print space
;
; @Param
; CX - number of spaces to print
printSpace:
    push ax
    push dx
    push cx

    mov ah, 2
    mov dl, ' '

    cmp cx, 0
    jle _printSpaceExit
_printSpaceLoop:
    int 21h
    loop _printSpaceLoop
_printSpaceExit:
    pop cx
    pop dx
    pop ax
    ret
; --------------------------------------------------------


; [fillSpecifiedChr] Print CX number of character
;
; @Param
; DL - Character code
; CX - number of characters to print
fillSpecifiedChr:
    push cx
    cmp cx, 0
    je _fillSpecifiedChrExit
_fillSpecifiedChr:
    call printChr
    loop _fillSpecifiedChr
_fillSpecifiedChrExit:
    pop cx
    ret
; --------------------------------------------------------


; [fillChr] Print line with specified character
;
; @Param
; DL - Character code
fillChr:
    push cx
    mov cx, 80
    call fillSpecifiedChr
    pop cx
    ret
; --------------------------------------------------------


; [fillSpace] Print line with spaces
fillSpace:
    push cx
    mov cx, 80
    call printSpace
    pop cx
    ret
; --------------------------------------------------------


; [setColor] Set color to length cx
;
; @Param
; CX - Length of color
; BL - Color code
setColor:
    push ax
    push bx
    mov bh, 0
    mov ah, 09h
    mov al, ' '
    int 10h
    pop bx
    pop ax
    ret
; --------------------------------------------------------


; [fillColor] Fill current line with color
;
; @Param
; BL - Color code
fillColor:
    push cx
    mov cx, 80
    call setColor
    pop cx
    ret
; --------------------------------------------------------


; [printNum] Print 16-bit Integer (can only take up to 16 bits values with AX as input/parameter)
;
; @Param
; AX - Integer to print
printNum:
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx, 0

_printNumdigitLoop:
    mov bx, 10
    mov dx, 0
    div bx

    mov bx, ax
    mov ax, cx
    call isOdd

    je _printNumifAppend
    mov ah, dl
    mov al, 0
    jmp _printNumendifAppend
_printNumifAppend:
    pop ax
    mov al, dl
_printNumendifAppend:
    push ax
    inc cx

    mov ax, bx

    cmp ax, 0
    jne _printNumdigitLoop

_printNumprintLoop:

    mov ax, cx
    call isOdd

    pop ax
    je _printNumifPrint
    mov dl, al
    push ax
    jmp _printNumendifPrint
_printNumifPrint:
    mov dl, ah
_printNumendifPrint:
    add dl, '0'
    mov ah, 02h
    int 21h

    loop _printNumprintLoop

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    ret
; --------------------------------------------------------


; [formatNum] Parse number to string
;
; @Param
; AX - Number to format
; SI - String buffer to output
formatNum:
    push ax
    push si
    push dx
    push bx
    push cx

    mov bl, 10
    mov bh, 0
    mov dx, 0
    div bx

    add dl, '0'
    mov [si], dl
    mov [si + 1], bh
    mov cx, 1

_formatNumLoop:
    cmp ax, 0
    je _formatNumExit
    mov dl, 0
    div bx
    push cx
    add si, cx
    mov [si + 1], bh
_formatNumShift:
    mov bh, [si - 1]
    mov [si], bh
    dec si
    loop _formatNumShift
    mov bh, 0
    add dl, '0'
    mov [si], dl
    pop cx
    inc cx
    jmp _formatNumLoop
_formatNumExit:
    pop cx
    pop bx
    pop dx
    pop si
    pop ax
    ret
; --------------------------------------------------------


; [isOdd] 16-bits isOdd function with AX as input/paramter
;
; @Param
; AX - 16-bit Number to evaluate
isOdd:
    push bx
    push dx
    mov dx, 0
    mov bx, 2
    div bx

    cmp dx, 1

    pop dx
    pop bx
    ret
; --------------------------------------------------------


; [getKey] Get key code pressed by the keyboard
;
; @Return
; AL - Key code of key pressed
getKey:
    push bx
    mov bl, ah
    
    mov ah, 7
    int 21h

    mov ah, bl
    pop bx
    ret
; --------------------------------------------------------


; [fopen] Open existing file (Write mode will overwrite file)
;
; @Param
; SI - File Name (null-terminated)
; BL - File access (0 - read, 1 - write)
;
; @Return
; BX - File Handle (0 if error)
fopen:
    push dx
    push cx

    mov dx, si
    cmp bl, 1
    jne _fopenRead
    mov cx, 0
    mov ah, 3Ch
    jmp _fopenIfExit
_fopenRead:
    mov al, 0
    mov ah, 3Dh
_fopenIfExit:
    int 21h

    jnc _fopenExit
    mov ax, 0
_fopenExit:
    mov bx, ax

    pop cx
    pop dx
    ret
; --------------------------------------------------------


; [fclose] Close a file handle
;
; @Param
; BX - File Handle
fclose:
    push ax
    mov ah, 3Eh
    int 21h
    pop ax
    ret
; --------------------------------------------------------


; [fwrite] Write to file
;
; @Param
; SI - Data to write
; CX - Length of data
; BX - File Handle
fwrite:
    push dx
    push ax

    mov dx, si
    mov ah, 40h
    int 21h

    pop ax
    pop dx
    ret
; --------------------------------------------------------


; [fput] Read character from file
;
; @Param
; BX - File Handle
; 
; @Return
; AL - Character
fput:
    push dx
    push cx
    push ax
    push si

    mov ah, [si]
    push ax

    mov dx, si
    mov cx, 1
    mov ah, 3fh
    int 21h

    pop ax
    mov cl, [si]
    mov [si], ah
    
    pop si
    pop ax
    mov al, cl
    pop cx
    pop dx
    ret
; --------------------------------------------------------


; [fread] Read till null byte is encountered
;
; @Param
; BX - File Handle
;
; @Return
; DI - Destination of data
fread:
    push ax
    push di
_freadLoop:
    call fput
    mov [di], al
    inc di
    cmp al, 0
    jne _freadLoop

    pop di
    pop ax
    ret
; --------------------------------------------------------

; [fremove] Delete file
;
; @Param
; SI - File Name
fremove:
    push ax
    push dx

    mov dx, si
    mov ah, 41h
    int 21h

    pop dx
    pop ax
    ret
; --------------------------------------------------------

; [nwln] Newline Macro
nwln MACRO
         push ax
         push dx
         mov  ah, 02h
         mov  dl, 13
         int  21h
         mov  dl, 0Ah
         int  21h
         pop  dx
         pop  ax
ENDM
; --------------------------------------------------------

; [cls] Clear Screen
cls:
    push ax
    mov ax, 3
    int 10h
    pop ax
    ret
; --------------------------------------------------------
.model small
.stack 100
.data
    slotsHeader db "Parking Slots", 0
    upperSlot db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0
    lowerSlot db 192, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 217, 0
    stateSlot db 0
    slot db 179, 1, 2, 10h, "  ", 179, 0

    fileFormat db ".DAT", 0
    title_sz db "Car Parking Management System", 0

    buf db 255 dup(0)
    buf2 db 255 dup(0)

    upperSlotState db 2 dup(0)
    lowerSlotState db 2 dup(0)

    customerLen db 0

    formLoginHeader db "Main Menu", 0
    formLoginOptionLogin db 0, "[    Login    ]", 0
    formLoginOptionRegister db 1, "[   Register  ]", 0

    formSelected db 0

    footerText db "(F1) Copyright @2024", 0
.code
INCLUDE customio.asm

; bl - bit mask, di - slot row buffer; Sets CF flag if true
slotIsOccupied:
    push bx
    push si
    mov bh, [di]
    and bh, bl
    cmp bh, 0
    je _slotIsOccupiedFalse
    stc
    jmp _slotIsOccupiedExit
_slotIsOccupiedFalse:
    clc
_slotIsOccupiedExit:
    pop si
    pop bx
    ret

parkingSlots:
    push di
    push bx
    push cx
    push si

    lea di, stateSlot
    mov bl, 0
    cmp [di], bl

    mov bl, 1Fh
    mov cx, 50
    call setColor

    jne _parkingSlotsFirst
    lea si, slotsHeader
    mov bl, 1Eh
    call printColorCenter
    mov bl, 1
    mov [di], bl 
    jmp _parkingSlotsExit
_parkingSlotsFirst:
    mov bl, 1
    cmp [di], bl
    jne _parkingSlotsSecond
    lea si, upperSlot
    call printCenter
    mov bl, 2
    mov [di], bl 
    jmp _parkingSlotsExit
_parkingSlotsSecond:
    mov bl, 2
    cmp [di], bl
    jne _parkingSlotsThird
    mov bl, 3
    mov [di], bl
    lea di, upperSlotState
    call _parkingSlotsSlot
    jmp _parkingSlotsExit
_parkingSlotsThird:
    mov bl, 3
    cmp [di], bl
    jne _parkingSlotsFourth
    mov bl, 4
    mov [di], bl
    lea di, lowerSlotState
    call _parkingSlotsSlot
    jmp _parkingSlotsExit
_parkingSlotsFourth:
    lea si, lowerSlot
    call printCenter
    mov bl, 0
    mov [di], bl
_parkingSlotsExit:
    pop si
    pop cx
    pop bx
    pop di
    ret

_parkingSlotsSlot:
    mov cx, 4
    call printSpace
    mov dl, 179
    call printChr

    lea si, slot
    mov cx, 10
    mov bl, 10000000b
_parkingSlotsSlotLoop:
    call slotIsOccupied
    jmp _parkingSlotsSlotArea
_parkingSlotsSlotReturn:
    shr bl, 1
    jnc _parkingSlotsSlotNone
    inc di
    mov bl, 10000000b
_parkingSlotsSlotNone:
    loop _parkingSlotsSlotLoop

    mov cx, 4
    call printChr
    call printSpace
    ret

_parkingSlotsSlotArea:
    jc _parkingSlotsSlotAreaOccup
    mov bh, 10h
    jmp _parkingSlotsSlotAreaExit
_parkingSlotsSlotAreaOccup:
    mov bh, 40h
_parkingSlotsSlotAreaExit:
    mov [si + 3], bh
    call print
    jmp _parkingSlotsSlotReturn


header:
    push bx
    push si
    push cx
    push dx

    mov dl, '-'
    mov bl, 1Fh
    call fillColor
    call fillChr
    call pageSkipDefault

    mov bl, 1Eh
    call fillColor
    lea si, title_sz
    mov cx, 80
    call printCenter
    call pageSkipDefault
    mov bl, 1Fh
    call fillColor
    call fillChr

    pop dx
    pop cx
    pop si
    pop bx
    ret


pageSkipDefault:
    push cx
    mov cx, 1
    call pageSkip
    pop cx
    ret

; CX - number to skip
pageSkip:
    push cx
    push bx
    mov bl, 10h

_pageSkiploop:
    call fillColor
    call fillSpace
    loop _pageSkiploop

    pop bx
    pop cx
    ret

; CX - number of spaces
pageSkipSpace:
    push cx
    push bx
    mov bl, 10h
    call setColor
    call printSpace
    pop bx
    pop cx
    ret

; calls dx (21 rows available)
pagePaint:
    nwln
    call header
    
    push bx
    push si
    lea si, stateSlot
    mov bl, 0
    mov [si], bl
    pop si
    pop bx

    call dx

    push cx
    push bx
    push si
    mov bl, 1Fh
    call pageSkipDefault
    call fillColor
    mov cx, 79
    lea si, footerText
    call printCenter
    pop si
    pop bx
    pop cx

    ret

; SI - option to print; @Outs BL - color code
printFormOption:
    push bx
    push di
    push cx
    mov bh, [si]
    lea di, formSelected
    cmp [di], bh
    je _formatFormOptionSelected
    mov bl, 1Fh
    jmp _formatFormOptionExit
_formatFormOptionSelected:
    mov bl, 9Eh
_formatFormOptionExit:
    inc si
    mov cx, 30
    call setColor
    call printCenter
    pop cx
    pop di
    pop bx
    ret

loginPage:
    push cx
    push si
    push bx

    mov cx, 3
    call pageSkip

    mov cx, 30
    mov bl, 1Eh
    lea si, formLoginHeader
    call printColorCenter
    call parkingSlots
    call pageSkipDefault

    mov cx, 30
    call pageSkipSpace
    call parkingSlots
    call pageSkipSpace
    call parkingSlots

    lea si, formLoginOptionLogin
    call printFormOption
    mov cx, 50
    call pageSkipSpace
    mov cx, 2
    call pageSkip

    lea si, formLoginOptionRegister
    call printFormOption
    mov cx, 50
    call pageSkipSpace
    mov cx, 30
    call pageSkipSpace
    call parkingSlots
    call pageSkipSpace
    call parkingSlots

    mov cx, 5
    call pageSkip

    pop bx
    pop si
    pop cx
    ret

start:
    mov ax, @data
    mov ds, ax

    lea dx, loginPage
    call pagePaint

    call getKey
    
    int 27h
end start
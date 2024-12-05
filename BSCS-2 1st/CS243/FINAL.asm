.model small
.stack 100
.data
    slotsHeader db "Parking Slots", 0
    upperSlot db 218, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 194, 196, 196, 194, 191, 0
    lowerSlot db 192, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 193, 196, 196, 193, 217, 0
    stateSlot db 0, 0
    slot db 179, 1, 2, 10h, "  ", 179, 0

    fileFormat db ".DAT", 0
    title_sz db "Car Parking Management System", 0

    buf db 21 dup(0)
    buf2 db 21 dup(0)
    fileBuf db 40 dup(0)

    upperSlotState db 2 dup(0)
    lowerSlotState db 2 dup(0)

    customerLen dw 0
    customerID dw 0
    customerSlot db 4 dup(0)
    customerSlotDisplay db 0

    formModalLogin db "Login Form", 0
    formModalRegister db "Register Form", 0
    formModalUsername db "Username: ", 0
    formModalPassword db "Password: ", 0
    formModalBack db "[    Back    ]", 0

    formLoginHeader db "Main Menu", 0
    formLoginOptionLogin db 0, "[    Login    ]", 0
    formLoginOptionRegister db 1, "[   Register  ]", 0
    formLoginOptionExit db 2, "[     Exit    ]", 0

    formMenuReserve db 0, "[    Reserve Slot    ]", 0
    formMenuVacate db 0, "[    Vacate Slot     ]", 0
    formMenuDelete db 1, "[   Delete Account   ]", 0
    formMenuLogout db 2, "[       Logout       ]", 0
    formSlotHeader db "Confirm Slot", 0

    formSelected db 0
    slotSelected db 0

    welcomeMessage db "Welcome, ", 0

    modalFull db 1, 47, 1Ch, "Parking Slots are all reserved. Try again Later"
    modalDelete db "Successfully Deleted User", 0
    modalLogout db "Successfully Logged Out", 0
    modalReserved db 1, 34, 1Ah, "Successfully Reserved Parking Slot", 0
    modalIncorrect db 1, 19, 1Ch, "Incorrect Password", 0
    modalNotFound db 1, 19, 1Ch, "User not found", 0
    modalSucRegister db 1, 23, 1Ah, "Successfully Registered", 0
    modalInvalid db 1, 19, 1Ch, "Invalid Credentials", 0
    modalExist db 1, 22, 1Ch, "Username already exist", 0
    modalQuery db "Are you sure?", 0
    modalExitMessage db "Exiting System . . .", 0
    modalOptionYes db "[ Yes ]", 0
    modalOptionNo db "[ No ]", 0
    modalOk db "[ Ok ]", 0

    footerText2 db "John Zillion C. Reyes", 0
    footerText db "(F1) December 6, 2024", 0
.code
INCLUDE customio.asm

; SI - buffer to receive name
getUserSlotName:
    push ax
    push di
    push bx
    push cx
    
    mov bh, 0
    mov ah, 'A'
    mov al, 0
    lea di, customerSlot
    mov cx, 2
_getUserSlotNameLoop:
    cmp [di], bh
    jne _getUserSlotNameExtract
    inc di
    add al, 8
    loop _getUserSlotNameLoop
    inc ah
    mov cx, 2
    mov al, 0
    jmp _getUserSlotNameLoop
_getUserSlotNameExtract:
    mov ch, [di]
_getUserSlotNameExtractLoop:
    shl ch, 1
    inc al
    jnc _getUserSlotNameExtractLoop
    mov [si], ah
    mov ah, 0
    inc si
    call formatNum
    dec si
_getUserSlotNameExit:
    pop cx
    pop bx
    pop di
    pop ax
    ret

; SI - buffer to receive name, AX - ID
getUserFileByID:
    push di
    call formatNum
    lea di, fileFormat
    call strcat
    pop di
    ret

; CF is set 1 if true
isSlotFull:
    push ax
    push bx
    push si

    mov ax, 0
    lea si, upperSlotState
    mov bl, [si]
    add ax, bx
    mov bl, [si + 1]
    add ax, bx
    lea si, lowerSlotState
    mov bl, [si]
    add ax, bx
    mov bl, [si + 1]
    add ax, bx

    cmp ax, 894
    je isSlotFullEqu
    clc
    jmp isSlotFullExit
isSlotFullEqu:
    stc
isSlotFullExit:
    pop si
    pop bx
    pop ax
    ret


; CF is set 1 if user reserved
hasSlot:
    push cx
    push si
    push bx

    lea si, customerSlot
    mov bl, 0
    mov cx, 4
_hasSlotLoop:
    cmp [si], bl
    jne _hasSlotExist
    inc si
    loop _hasSlotLoop
    clc
    jmp _hasSlotExit
_hasSlotExist:
    stc
_hasSlotExit:
    pop bx
    pop si
    pop cx
    ret

; AL - character code; Sets CF flag is true
isValidChr:
    push bx
    mov bh, 32
    mov bl, 126
    cmp al, bh
    jl _isValidChrFalse
    cmp al, bl
    jg _isValidChrFalse
    stc
    jmp _isValidChrExit
_isValidChrFalse:
    clc
_isValidChrExit:
    pop bx
    ret

; si - username; return ax as id. set CF = 1 if not found
getUsernameID:
    push di
    push si
    push bx
    push cx

    lea di, customerLen
    mov cx, [di]
    mov ax, 0
_getUsernameIDLoop:
    inc ax
    cmp ax, cx
    jg _getUsernameError
    push si
    lea si, fileBuf
    call getUserFileByID
    mov bl, 0
    call fopen
    mov di, si
    pop si
    call fread
    call fclose
    call strcmp
    jnc _getUsernameIDLoop
    clc
    jmp _getUsernameExit
_getUsernameError:
    mov ax, 0
    stc
_getUsernameExit:
    pop cx
    pop bx
    pop si
    pop di
    ret

; AX - Customer ID
writeData:
    push si
    push bx
    push cx
    push ax

    lea si, fileBuf
    call getUserFileByID

    mov bl, 1
    call fopen

    lea si, buf
    call strlen
    mov cx, ax
    inc cx
    call fwrite

    lea si, buf2
    call strlen
    mov cx, ax
    inc cx
    call fwrite

    lea si, customerSlot
    mov cx, 4
    call fwrite

    call fclose

    pop ax
    pop cx
    pop bx
    pop si

    ret


clearBufs:
    push si
    push bx
    push cx

    mov bl, 0
    mov cx, 20
    lea si, buf
    call memset
    lea si, buf2
    call memset

    pop cx
    pop bx
    pop si

    ret

; bl - bitmask, di - slot row buffer; Set CF flag if true
slotOccupiedByUser:
    push si
    push cx
    push ax
    clc
    pushf
    lea si, customerSlotDisplay
    mov cl, 0
    cmp cl, [si]
    je _slotOccupiedByUserExit
    mov cx, 2
    lea ax, customerSlot
    lea si, upperSlotState
_slotOccupiedByUserLoop:
    cmp si, di
    je _slotOccupiedByUserFind
    inc ax
    inc si
    loop _slotOccupiedByUserLoop
    lea si, lowerSlotState
    mov cx, 2
    jmp _slotOccupiedByUserLoop
_slotOccupiedByUserFind:
    mov si, ax
    cmp [si], bl
    jne _slotOccupiedByUserExit
    popf
    stc
    pushf
_slotOccupiedByUserExit:
    popf
    pop ax
    pop cx
    pop si
    ret

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
    push dx
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
    cmp [di + 1], bl
    je _parkingSlotsFirstStart
    mov cx, 50
    call printSpace
    mov [di + 1], bl
    jmp _parkingSlotsExit
_parkingSlotsFirstStart:
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
    inc bl
    mov [di + 1], bl
    lea di, upperSlotState
    call _parkingSlotsSlot
    jmp _parkingSlotsExit
_parkingSlotsThird:
    mov bl, 3
    cmp [di], bl
    jne _parkingSlotsFourth
    mov bl, 0
    cmp [di + 1], bl
    je _parkingSlotsThirdStart
    mov cx, 50
    call printSpace
    mov bl, [di + 1]
    dec bl
    mov [di + 1], bl
    jmp _parkingSlotsExit
_parkingSlotsThirdStart:
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
    pop dx
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
    call slotOccupiedByUser
    jc _parkingSlotsSlotAreaDisplay
    call slotIsOccupied
    jc _parkingSlotsSlotAreaOccup
    mov bh, 10h
    jmp _parkingSlotsSlotAreaExit
_parkingSlotsSlotAreaOccup:
    mov bh, 40h
    jmp _parkingSlotsSlotAreaExit
_parkingSlotsSlotAreaDisplay:
    mov bh, 20h
_parkingSlotsSlotAreaExit:
    mov [si + 3], bh
    call print
    jmp _parkingSlotsSlotReturn

; BL - limit of choices
; DX - Pointer to Page Paint
; CH - Key Code to Decrease Selected Index (Up, Left)
; CL - Key Code to Increase Selected Index (Down, Right)
getSelectedMenu:
    push di
    push ax
    lea di, formSelected
    mov ah, 0
    mov [di], ah
_getSelectedMenuLoopRepaint:
    call pagePaint
_getSelectedMenuLoop:
    call getKey
    mov ah, 13
    cmp al, ah
    jne _getSelectedMenuContinue
    pop ax
    pop di
    ret
_getSelectedMenuContinue:
    mov ah, 0
    cmp al, ah
    jne _getSelectedMenuLoop
    call getKey
    cmp ch, al
    jne _getSelectedMenuNotUp
    mov ah, 0
    cmp [di], ah
    je _getSelectedMenuLoop
    mov ah, [di]
    dec ah
    mov [di], ah
    jmp _getSelectedMenuLoopRepaint
_getSelectedMenuNotUp:
    cmp cl, al
    je _getSelectedMenuDown
    jmp _getSelectedMenuLoop
_getSelectedMenuDown:
    mov ah, [di]
    inc ah
    cmp ah, bl
    jnl _getSelectedMenuLoop
    mov [di], ah
    jmp _getSelectedMenuLoopRepaint


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

sidePageSkip:
    push cx
    mov cx, 30
    call pageSkipSpace
    pop cx
    ret

; calls dx (12 rows available)
pagePaint:
    call cls
    push cx
    push bx
    mov cx, 2000
    mov bl, 10h
    call setColor
    pop bx
    pop cx
    nwln
    call header

    push cx
    mov cx, 3
    call pageSkip
    pop cx

    call dx

    push cx
    push bx
    push si
    mov cx, 3
    call pageSkip
    mov bl, 1Fh
    mov cx, 80
    lea si, footerText2
    call printColorCenter
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
    push cx
    push di
    push bx
    mov bh, [si]
    lea di, formSelected
    cmp [di], bh
    pop bx
    je _formatFormOptionSelected
    mov bl, 1Fh
    jmp _formatFormOptionExit
_formatFormOptionSelected:
    mov bl, 9Eh
_formatFormOptionExit:
    inc si
    pop di
    pop cx
    ret


; CX - number of rows
formSkip:
    push cx
_formSkipLoop:
    call sidePageSkip
    call parkingSlots
    loop _formSkipLoop
    pop cx
    ret

; BX - pointer to options function to print
; SI - Message of modal
modalPage:
    push cx
    push bx

    mov cx, 4
    call pageSkip

    mov bl, 1Eh
    mov cx, 80
    call printColorCenter

    call pageSkipDefault

    pop bx
    call bx

    mov cx, 5
    call pageSkip
    pop cx
    ret

modalOptionConsent:
    push cx
    push di
    push bx
    push si
    push ax
    mov cx, 24
    call pageSkipSpace

    lea di, formSelected
    mov cl, 0
    cmp [di], cl
    je _modalOptionSelected
    mov bl, 1Fh
    mov ah, 9Eh
    jmp _modalOptionExit
_modalOptionSelected:
    mov bl, 9Eh
    mov ah, 1Fh
_modalOptionExit:
    mov cx, 16
    lea si, modalOptionYes
    call printColorCenter

    lea si, modalOptionNo
    mov bl, ah
    call printColorCenter

    mov cx, 24
    call pageSkipSpace

    pop ax
    pop si
    pop bx
    pop di
    pop cx
    ret

exitModal:
    push si
    push bx

    lea si, modalQuery
    lea bx, modalOptionConsent
    call modalPage

    pop bx
    pop si
    ret

; je will jump if yes
queryModal:
    push dx
    push cx
    push bx

    lea dx, exitModal
    mov bl, 2
    mov ch, 75
    mov cl, 77
    call getSelectedMenu

    push di
    lea di, formSelected
    mov bl, 0
    cmp [di], bl

    pop di
    pop bx
    pop cx
    pop dx
    ret

; SI - Modal Message
okModal:
    push bx
    push dx
    push ax

    lea bx, _okModalOption
    lea dx, modalPage

    call pagePaint

    mov ah, 13
_okModalLoop:
    call getKey
    cmp al, ah
    jne _okModalLoop

    pop ax
    pop dx
    pop bx
    ret

_okModalOption:
    push bx
    push cx
    push si
    mov bl, 9Eh
    mov cx, 80
    lea si, modalOk
    call printColorCenter
    pop si
    pop cx
    pop bx
    ret

; SI - Header of Form
formModal:
    push dx
    push ax
    push cx
    push bx
    push si
    push di

    mov dl, '*'
    lea di, formSelected

    mov cx, 2
    call pageSkip

    mov bl, 1Eh
    mov cx, 80
    call printColorCenter

    mov cx, 2
    call pageSkip

    mov bl, 0
    lea si, formModalUsername
    lea ax, buf
    call _formModalField

    call pageSkipDefault

    mov bl, 1
    lea si, formModalPassword
    lea ax, buf2
    call _formModalField

    mov cx, 2
    call pageSkip

    mov bl, 2
    cmp [di], bl
    mov cx, 80
    lea si, formModalBack
    je _formModalSelected
    mov bl, 1Fh
    jmp _formModalSelectedExit
_formModalSelected:
    mov bl, 9Eh
_formModalSelectedExit:
    call printColorCenter

    call pageSkipDefault

    pop di
    pop si
    pop bx
    pop cx
    pop ax
    pop dx
    ret

_formModalField:
    mov cx, 25
    call pageSkipSpace
    cmp [di], bl
    je _formModalFieldSelected
    mov bl, 1Fh
    mov bh, 70h
    jmp _formModalFieldExit
_formModalFieldSelected:
    mov bl, 1Eh
    mov bh, 60h
_formModalFieldExit:
    mov cx, 10
    call setColor
    call print
    mov bl, bh
    mov cx, 20
    call setColor
    mov si, ax
    call strlen
    lea cx, buf2
    cmp cx, si
    je _formModalFieldPassword
    call print
    jmp _formModalFieldPasswordExit
_formModalFieldPassword:
    mov cx, ax
    call fillSpecifiedChr
_formModalFieldPasswordExit:
    mov cx, 20
    sub cx, ax
    call printSpace
    mov cx, 25
    call pageSkipSpace
    ret

; DX - Pointer to modal page
formModalKey:
    push di
    push ax
    push si
    push bx

    call clearBufs
    mov bh, 0
    lea di, formSelected
    mov ah, 0
    mov [di], ah
_formModalKeyLoopRepaint:
    call pagePaint
_formModalKeyLoop:
    call getKey
    mov ah, 13
    cmp al, ah
    jne _formModalKeyNotEnter
    jmp _formModalKeyEnter
    jc _formModalKeyLoopRepaint
    cmp al, bh
    je _formModalKeyLoop
    jmp _formModalKeyExit
_formModalKeyNotEnter:
    cmp al, bh
    jne _formModalKeyNotSystem
    jmp _formModalKeyArrow
_formModalKeyNotSystem:
    mov ah, 8
    cmp al, ah
    jne _formModalKeyNotBackspace
    call _formModalKeyGetSelected
    call strlen
    cmp ax, 0
    je _formModalKeyLoop
    add si, ax
    mov [si - 1], bh
    jmp _formModalKeyLoopRepaint
_formModalKeyNotBackspace:
    call isValidChr
    jnc _formModalKeyLoop
    mov bl, al
    call _formModalKeyGetSelected
    call strlen
    cmp ax, 20
    je _formModalKeyLoop
    add si, ax
    mov [si], bl
    mov [si + 1], bh
    jmp _formModalKeyLoopRepaint
_formModalKeyExit:
    pop bx
    pop si
    pop ax
    pop di
    ret

_formModalKeyArrow:
    call getKey
    mov ah, 72
    cmp al, ah
    jne _formModalKeyArrowNotUp
    mov al, [di]
    cmp al, bh
    je _formModalKeyArrowNoPaint
    dec al
    mov [di], al
    jmp _formModalKeyLoopRepaint
_formModalKeyArrowNotUp:
    mov ah, 80
    cmp al, ah
    jne _formModalKeyArrowNoPaint
    mov al, [di]
    mov ah, 2
    cmp ah, al
    je _formModalKeyArrowNoPaint
    inc al
    mov [di], al
    jmp _formModalKeyLoopRepaint
_formModalKeyArrowNoPaint:
    jmp _formModalKeyLoop

_formModalKeyEnter:
    mov al, [di]
    mov ah, 2
    cmp ah, al
    je _formModalKeyEnterBack
    mov ah, 1
    cmp ah, al
    jne _formModalKeyEnterLogin
    stc
    jmp _formModalKeyEnterExit
_formModalKeyEnterLogin:
    inc al
    mov [di], al
    jmp _formModalKeyLoopRepaint
_formModalKeyEnterBack:
    clc
_formModalKeyEnterExit:
    jmp _formModalKeyExit

_formModalKeyGetSelected:
    cmp [di], bh
    je _formModalKeyGetSelectedFirst
    lea si, buf2
    ret
_formModalKeyGetSelectedFirst:
    lea si, buf
    ret

loginPage:
    push cx
    push si
    push bx

    mov cx, 30
    mov bl, 1Eh
    lea si, formLoginHeader
    call printColorCenter
    call parkingSlots

    mov cx, 3
    call formSkip

    lea si, formLoginOptionLogin
    call printFormOption
    mov cx, 30
    call setColor
    call printCenter
    call parkingSlots

    mov cx, 2
    call formSkip

    lea si, formLoginOptionRegister
    call printFormOption
    mov cx, 30
    call setColor
    call printCenter
    call parkingSlots

    mov cx, 2
    call formSkip
    
    lea si, formLoginOptionExit
    call printFormOption
    mov cx, 30
    and bl, 0F0h
    or bl, 0Ch
    call setColor
    call printCenter
    mov cx, 50
    call pageSkipSpace
    call pageSkipDefault

    pop bx
    pop si
    pop cx
    ret

menuPage:
    push cx
    push si
    push bx
    push di

    mov cx, 30
    mov bl, 1Eh
    lea si, welcomeMessage
    lea di, fileBuf
    call strcpy
    mov si, di
    lea di, buf
    call strcat
    call printColorCenter
    call parkingSlots

    call hasSlot
    pushf

    lea di, customerSlotDisplay
    mov cl, 0
    mov [di], cl
    jnc _menuPageOccupiedDisplayExit
    lea si, formSelected
    cmp [si], cl
    jne _menuPageOccupiedDisplayExit
    mov cl, 1
    mov [di], cl
_menuPageOccupiedDisplayExit:

    mov cx, 3
    call formSkip

    popf
    jc _menuPageOccupied
    lea si, formMenuReserve
    jmp _menuPageOccupiedExit
_menuPageOccupied:
    lea si, formMenuVacate
_menuPageOccupiedExit:
    call printFormOption
    mov cx, 30
    call setColor
    call printCenter
    call parkingSlots

    mov cx, 2
    call formSkip

    lea si, formMenuDelete
    call printFormOption
    mov cx, 30
    and bl, 0F0h
    or bl, 0Ch
    call setColor
    call printCenter
    call parkingSlots

    mov cx, 2
    call formSkip
    
    lea si, formMenuLogout
    call printFormOption
    mov cx, 30
    call setColor
    call printCenter
    mov cx, 50
    call pageSkipSpace
    call pageSkipDefault

    pop di
    pop bx
    pop si
    pop cx
    ret

slotPage:
    push cx
    push si
    push bx
    push dx

    call slotVerify

    mov cx, 30
    mov bl, 1Eh
    lea si, formSlotHeader
    call printColorCenter
    call parkingSlots

    mov cx, 3
    call formSkip

    mov cx, 30
    mov bl, 1Fh
    call setColor
    mov cx, 8
    call printSpace
    mov dl, '<'
    call printChr
    mov cx, 12
    lea si, fileBuf
    call getUserSlotName
    call printCenter
    mov dl, '>'
    call printChr
    mov cx, 8
    call printSpace
    call parkingSlots

    mov cx, 5
    call formSkip
    mov cx, 2
    call pageSkip

    pop dx
    pop bx
    pop si
    pop cx
    ret

slotVerify:
    push si
    push di
    push ax

    lea si, customerSlot
    lea di, slotSelected
    mov al, [di]
    lea di, formSelected
    mov ah, [di]

    call hasSlot
    jc _slotVerifyContinue
    mov al, 20
    call _slotVerifyNext
    jmp _slotVerifyExit
_slotVerifyContinue:
    cmp al, [di]
    jg _slotVerifyNotNext
    call _slotVerifyNext
    jmp _slotVerifyExit
_slotVerifyNotNext:
    call _slotVerifyBack
_slotVerifyExit:
    call _slotVerifyIndex
    mov [di], al
    mov [di + 1], al
    pop ax
    pop di
    pop si
    ret

; CF set if found
_slotVerifyExists:
    push di
    push si
    push bx
    push cx
    lea si, upperSlotState
    lea di, customerSlot
    mov cx, 1
    mov bh, 0
_slotVerifyExistsLoop:
    mov bl, [si]
    and bl, [di]
    inc di
    inc si
    cmp bl, 0
    jne _slotVerifyExistsCatch
    loop _slotVerifyExistsLoop
    cmp bh, 0
    jne _slotVerifyExistsSucc
    mov bh, 1
    mov cx, 1
    lea si, lowerSlotState
    jmp _slotVerifyExistsLoop
_slotVerifyExistsSucc:
    clc
    jmp _slotVerifyExistsExit
_slotVerifyExistsCatch:
    stc
_slotVerifyExistsExit:
    pop cx
    pop bx
    pop si
    pop di
    ret

_slotVerifyBack:
    cmp al, 1
    jne _slotVerifyBackLe
    mov al, 21
_slotVerifyBackLe:
    dec al
    call _slotVerifyBinary
    call _slotVerifyExists
    jc _slotVerifyBack
    ret

_slotVerifyNext:
    cmp al, 20
    jne _slotVerifyNextGr
    mov al, 0
_slotVerifyNextGr:
    inc al
    call _slotVerifyBinary
    call _slotVerifyExists
    jc _slotVerifyNext
    ret


_slotVerifyBinary:
    push si
    push ax
    push bx
    push cx

    lea si, customerSlot
    mov bl, 0
    mov cx, 4
    call memset
    mov bl, 10000000b
    mov ah, 0

    cmp al, 10
    jle _slotVerifyBinaryGrExit
    sub al, 10
    add si, 2
_slotVerifyBinaryGrExit:
    cmp al, 8
    jle _slotVerifyBinaryGr2Exit
    inc si
    sub al, 8
_slotVerifyBinaryGr2Exit:
    dec al
_slotVerifyBinaryLoop:
    cmp al, 0
    je _slotVerifyBinaryExit
    dec al
    shr bl, 1
    jmp _slotVerifyBinaryLoop
_slotVerifyBinaryExit:
    mov [si], bl
    pop cx
    pop bx
    pop ax
    pop si
    ret


_slotVerifyIndex:
    push dx
    push cx
    lea si, customerSlot
    mov ax, 0
    mov cx, 2
_slotVerifyIndexLoop:
    mov dh, [si]
    cmp dh, ah
    jne _slotVerifyIndexExit
    inc si
    add al, 8
    loop _slotVerifyIndexLoop
    sub al, 6
    mov cx, 2
    jmp _slotVerifyIndexLoop
_slotVerifyIndexExit:
    inc al
    shl dh, 1
    jnc _slotVerifyIndexExit
    pop cx
    pop dx
    ret


customerOccupy:
    push di
    push si
    push ax

    lea di, upperSlotState
    lea si, customerSlot

    mov ax, [di]
    or ax, [si]
    mov [di], ax

    lea di, lowerSlotState
    mov ax, [di]
    or ax, [si + 2]
    mov [di], ax

    lea si, customerID
    mov ax, [si]
    call writeData

    pop ax
    pop si
    pop di
    ret


loginModal:
    push si
    lea si, formModalLogin
    call formModal
    pop si
    ret

registerModal:
    push si
    lea si, formModalRegister
    call formModal
    pop si
    ret

getMainPage:
    push di
    push bx
    lea di, customerID
    mov bx, 0
    cmp [di], bx
    pop bx
    pop di
    mov bl, 3
    mov ch, 72
    mov cl, 80
    je _getMainPageLogin
    lea dx, menuPage
    lea ax, customerMenuHandler
    ret
_getMainPageLogin:
    lea dx, loginPage
    lea ax, startHandler
    ret

startHandler:
    mov al, 2
    cmp [di], al
    jne _notExit
    call queryModal
    je _startHandlerContinue
    ret
_startHandlerContinue:
    lea si, modalExitMessage
    call okModal
    call cls
    lea si, fileBuf
    lea di, customerLen
    mov ax, [di]
    lea di, fileFormat
    cmp ax, 0
    je _goExit
_cleanup:
    call formatNum
    call strcat
    call fremove
    dec ax
    cmp ax, 0
    jg _cleanup
_goExit:
    int 27h
_notExit:
    mov al, 0
    cmp [di], al
    jne _notLogin
    lea dx, loginModal
    call formModalKey
    jnc _startHandlerBack
    call loginUser
    ret
_notLogin:
    lea dx, registerModal
    call formModalKey
    jnc _startHandlerBack
    call registerUser
_startHandlerBack:
    ret

customerMenuHandler:
    mov al, 2
    cmp [di], al
    jne _customerMenuHandlerNotLogout
    call queryModal
    je _customerMenuHandlerToLogout
    jmp _customerMenuHandlerExit
_customerMenuHandlerToLogout:
    call logoutCustomer
    lea si, modalLogout
    call okModal
    jmp _customerMenuHandlerExit
_customerMenuHandlerNotLogout:
    mov al, 1
    cmp [di], al
    jne _customerMenuHandlerNotDelete
    call queryModal
    jne _customerMenuHandlerExit
    call _customerMenuHandlerDelete
    call logoutCustomer
    lea si, modalDelete
    call okModal
    jmp _customerMenuHandlerExit
_customerMenuHandlerNotDelete:
    jmp _customerMenuHandlerSlot
_customerMenuHandlerExit:
    ret

_customerMenuHandlerDelete:
    push di
    lea si, customerID
    mov ax, [si]
    lea si, customerLen
    mov cx, [si]
    lea si, fileBuf
    call getUserFileByID
    call fremove
_customerMenuHandlerDeleteLoop:
    cmp ax, cx
    je _customerMenuHandlerDeleteExit
    lea si, fileBuf
    call getUserFileByID
    mov di, si
    lea si, buf2
    inc ax
    call getUserFileByID
    call frename
    jmp _customerMenuHandlerDeleteLoop
_customerMenuHandlerDeleteExit:
    dec cx
    lea si, customerLen
    mov [si], cx
    lea si, customerSlot
    mov ax, [si]
    lea di, upperSlotState
    xor [di], ax
    mov ax, [si + 2]
    lea di, lowerSlotState
    xor [di], ax
    pop di
    ret

_customerMenuHandlerSlot:
    call hasSlot
    jnc _customerMenuHandlerSlotReserve
    call queryModal
    jne _customerMenuHandlerSlotNoRemove
    push di
    lea si, customerSlot
    lea di, upperSlotState
    call _customerMenuHandlerSlotRemove
    lea di, lowerSlotState
    call _customerMenuHandlerSlotRemove
    pop di
    lea si, customerSlot
    mov cx, 4
    mov bl, 0
    call memset
    lea si, customerID
    mov ax, [si]
    call writeData
_customerMenuHandlerSlotNoRemove:
    jmp _customerMenuHandlerExit
_customerMenuHandlerSlotReserve:
    call isSlotFull
    jc _customerMenuHandlerSlotReserveFull
    lea si, customerSlotDisplay
    mov bl, 1
    mov [si], bl
    mov bl, 22
    mov ch, 75
    mov cl, 77
    lea dx, slotPage
    call getSelectedMenu
    call customerOccupy
    lea si, modalReserved
    call okModal
    jmp _customerMenuHandlerExit
_customerMenuHandlerSlotReserveFull:
    lea si, modalFull
    call okModal
    jmp _customerMenuHandlerExit

_customerMenuHandlerSlotRemove:
    mov cx, 2
_customerMenuHandlerSlotRemoveLoop:
    mov dl, [si]
    mov dh, [di]
    xor dh, dl
    mov [di], dh
    inc si
    inc di
    loop _customerMenuHandlerSlotRemoveLoop
    ret

logoutCustomer:
    push si
    push ax

    lea si, customerID
    mov ax, 0
    mov [si], ax

    pop ax
    pop si
    ret

; Invalid sets CF = 1
verifyInput:
    push si
    push ax
    lea si, buf
    call strlen
    cmp ax, 0
    je _verifyInputError
    lea si, buf2
    call strlen
    cmp ax, 0
    je _verifyInputError
    clc
    jmp _verifyInputExit
_verifyInputError:
    lea si, modalInvalid
    call okModal
    stc
_verifyInputExit:
    pop si
    pop ax
    ret
    

registerUser:
    push di

    call verifyInput
    jc _registerUserExit
    
    lea si, buf
    call getUsernameID
    jnc _registerUserExist
    lea si, customerLen
    mov ax, [si]
    inc ax
    mov [si], ax
    lea si, customerSlot
    mov bl, 0
    mov cx, 4
    call memset
    call writeData
    lea si, modalSucRegister
    call okModal
    jmp _registerUserExit
_registerUserExist:
    lea si, modalExist
    call okModal
_registerUserExit:
    pop di
    ret

loginUser:
    push di
    call verifyInput
    jc _loginUserExit

    lea si, customerLen
    mov ax, [si]
_loginUserLoop:
    cmp ax, 0
    je _loginUserNotFound
    call _loginUserVerify
    jc _loginUserExit
    dec ax
    jmp _loginUserLoop
_loginUserNotFound:
    lea si, modalNotFound
    call okModal
_loginUserExit:
    pop di
    ret

_loginUserVerify:
    lea si, fileBuf
    call getUserFileByID
    mov bl, 0
    call fopen
    mov di, si
    call fread
    lea si, buf
    call strcmp
    jc _loginUserVerifyContinue
    clc
    pushf
    jmp _loginUserVerifyExit
_loginUserVerifyContinue:
    stc
    pushf
    lea si, buf2
    call fread
    call strcmp
    jc _loginUserVerifySuccess
    lea si, modalIncorrect
    call okModal
    jmp _loginUserVerifyExit
_loginUserVerifySuccess:
    lea si, customerID
    mov [si], ax
    mov cx, 4
    lea si, customerSlot
_loginUserVerifyLoop:
    call fget
    mov [si], al
    inc si
    loop _loginUserVerifyLoop
    lea si, welcomeMessage
    lea di, fileBuf
    call strcpy
    mov si, di
    lea di, buf
    call strcat
    call okModal
_loginUserVerifyExit:
    call fclose
    popf
    ret

start:
    mov ax, @data
    mov ds, ax

    lea di, formSelected

mainLoop:
    call getMainPage
    call getSelectedMenu
    call ax
    jmp mainLoop
    
end start
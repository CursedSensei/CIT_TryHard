; Filename: FINAL.ASM
; CS243 Lab Hands-on Final Exam 
; First Semester SY 2024-2025
; Student Name: JOHN ZILLION C. REYES
; Date Finished: December 13, 2024

.model small
.stack 100
.data
    hh  db 0Ah, 'Cebu Institute of Technology - University', 0Ah
        db 'College of Computer Studies', 0Ah
        db 'FAVORITE CLASSMATE VOTING SYSTEM', 0Ah
        db 'Programmer: John Zillion C. Reyes', 0Ah, 0Ah, 0
    mh  db 'MAIN MENU', 0Ah
        db '1. ', 1, 4, 3Eh, 'Vote', 0Ah
        db '2. ', 1, 4, 1Fh, 'View', 0Ah
        db '3. ', 1, 6, 2Eh, 'Update', 0Ah
        db '4. ', 1, 6, 4Fh, 'Delete', 0Ah
        db '5. Exit', 0Ah
        db 'Enter choice: ', 0

    vh  db  1, 4, 3Eh, 'Vote', 0Ah
        db 'Enter candidate name: ', 0
    vh2 db 'Enter vote rating (0-100): ', 0

    uh  db 1, 6, 2Eh, 'Update', 0Ah, 0
    uh1 db 'Enter record number to update: ', 0
    uh2 db 'Enter new candidate name: ', 0
    uh3 db 'Enter new vote rating (0-100): ', 0

    delH db 1, 6, 4Fh, 'Delete', 0Ah, 0
    delH1 db 'Enter record number to delete: ', 0
    delH2 db 'Record deleted.', 0Ah, 0

    buf1 db 80 dup(0)
    buf2 db 80 dup(0)
    buf3 db 80 dup(0)

    viewH db 1, 4, 1Fh, 'View', 0Ah, 0
    viewEmpty db 'No record found.', 0Ah, 0
    viewPre db '. ', 0
    viewIn db ' - ', 0

    return db 0Ah, 0Ah, 'Press any key to go back to Main Menu...', 0Ah, 0
    format db '.DAT', 0

    ending db 'Exiting...', 0Ah
        db 'Thank you for using Favorite Classmate Voting System.', 0Ah, 0

    len dw 0
.code
INCLUDE customio.asm

; si - pointer
getInput:
    push si
    push ax
    push bx
    push cx
    push dx


    mov ah, 3FH
    mov bx, 0
    mov cx, 80
    mov dx, si
    int 21h

    mov bl, 0
    add si, ax
    mov [si - 2], bl

    pop dx
    pop cx
    pop bx
    pop ax
    pop si

    ret

; si - buffer; out CF set if ok
verifyNum:
    push ax
    push bx
    push si
    push cx
    call strlen

    cmp ax, 0
    je verifyNumError

    mov bl, '0'
    mov bh, '9'
    mov cx, ax
    mov al, ' '
    mov ah, 0
verifyNumLoop:
    cmp [si], al
    jne verifyNumNotSpace
    mov [si], ah
    stc
    jmp verifyNumExit
verifyNumNotSpace:
    cmp [si], bl
    jl verifyNumError
    cmp [si], bh
    jg verifyNumError
    loop verifyNumLoop
    stc
    jmp verifyNumExit
verifyNumError:
    clc
verifyNumExit:
    pop cx
    pop si
    pop bx
    pop ax
    ret

viewCandis:
    inc ax
    cmp ax, cx
    jg viewCandisExit
    lea si, buf3
    call formatNum
    call print
    lea di, format
    call strcat
    mov bl, 0
    call fopen
    lea di, buf1
    call fread
    lea di, buf2
    call fread
    call fclose

    lea si, viewPre
    call print
    lea si, buf1
    call print
    lea si, viewIn
    call print
    lea si, buf2
    call print
    nwln
    
    jmp viewCandis
viewCandisExit:
    ret

viewCandi:
    call header
    lea si, viewH
    call print

    mov ax, 0
    lea di, len
    cmp [di], ax
    mov cx, [di]
    jne viewCandiLoop
    lea si, viewEmpty
    call print
    jmp viewCandiExit
viewCandiLoop:
    call viewCandis
viewCandiExit:
    ret

updateCandi:
    call header
    lea si, uh
    call print
    mov ax, 0
    call viewCandis
    lea si, uh1
    call print
    lea si, buf3
    call getInput
    xor ax, ax
    mov al, [si]
    sub al, '0'

    lea si, uh2
    call print
    lea si, buf1
    call getInput
    lea si, uh3
    call print
    lea si, buf2
    call getInput

    lea si, buf3
    call formatNum

    lea di, format
    call strcat
    mov bl, 1
    call fopen

    lea si, buf1
    call strlen
    mov cx, ax
    call fwrite
    add si, ax
    mov cx, 1
    call fwrite
    lea si, buf2
    call strlen
    mov cx, ax
    call fwrite
    add si, ax
    mov cx, 1
    call fwrite
    call fclose

    ret

deleteCandi:
    call header
    lea si, delH
    call print
    mov ax, 0
    call viewCandis

    lea si, delH1
    call print
    lea si, buf2
    call getInput
    xor ax, ax
    mov al, [si]
    sub al, '0'

    lea si, delH2
    call print

    lea di, len
    mov cx, [di]
    dec cx
    mov [di], cx

    lea si, buf1
    call formatNum
    lea di, format
    call strcat
    call fremove

deleteCandiLoop:
    cmp ax, cx
    jg deleteCandiExit
    push ax

    lea si, buf1
    call formatNum
    lea di, format
    call strcat

    inc ax
    lea si, buf2
    call formatNum
    lea di, format
    call strcat

    lea di, buf1
    call frename

    pop ax
    inc ax
    jmp deleteCandiLoop
deleteCandiExit:
    ret

addCandi:
    call header
    lea si, vh
    call print
    lea si, buf1
    call getInput
    lea si, vh2
    call print
    lea si, buf2
    call getInput

    lea di, len
    xor ax, ax
    mov ax, [di]
    inc ax
    mov [di], ax

    lea si, buf3
    call formatNum

    lea di, format
    call strcat
    mov bl, 1
    call fopen

    lea si, buf1
    call strlen
    mov cx, ax
    call fwrite
    add si, ax
    mov cx, 1
    call fwrite
    lea si, buf2
    call strlen
    mov cx, ax
    call fwrite
    add si, ax
    mov cx, 1
    call fwrite
    call fclose

    ret

header:
    call cls
    lea si, hh
    call print
    ret    

start:
    mov ax, @data
    mov ds, ax

startLoop:
    call header
    lea si, mh
    call print

    lea si, buf3
    call getInput
    mov al, [si]
    nwln

    cmp al, '1'
    jne notVote
    call addCandi
    jmp toLoop
notVote:
    cmp al, '2'
    jne notView
    call viewCandi
    jmp toLoop
notView:
    cmp al, '3'
    jne notUpdate
    call updateCandi
    jmp toLoop
notUpdate:
    cmp al, '4'
    jne notDelete
    call deleteCandi
    jmp toLoop
notDelete:
    cmp al, '5'
    jne notExit

    lea si, ending
    call print

    int 27h
toLoop:
    lea si, return
    call print
    call getKey
notExit:
    jmp startLoop
end start
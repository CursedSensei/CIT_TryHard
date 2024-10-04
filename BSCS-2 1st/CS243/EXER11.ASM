; Filename: EXER11.asm
; Program Description: Simulates a bank
; Programmer Name: JOHN ZILLION REYES
; Date Finished: September 13, 2024
 
 
.MODEL SMALL
.STACK 100
.DATA
	szTitle db "Filename: EXER11.asm", 0Ah, "Program Description: Simulates a bank", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date Finished: September 13, 2024", 0Ah, 0Ah, '$'
 
 
TEXT    db '   Log Out '
        db 13, 10, 10, '                        Dear Customers, Welcome to Bank X             ', 13, 10, 10
        db 13, 10, 10, '        <    Withdrawal                                   Payment    >', 13, 10, 10
        db 13, 10, 10, '        <    Balance Inquiry                   Recent Transaction    >', 13, 10, 10
        db 13, 10, 10, '        <    Transfer                      Credit Card Operations    >', 13, 10, 10
        db 13, 10, 10, '        <    Change PIN                                   Deposit    >', 13, 10, 10, 10, 10, '$'
 
.CODE
START:
    mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

    ; Setup for coloring the backgrounds and texts
    mov ax, 3  
    int 10h     ;
    mov ah, 06h ;
    xor al, al  ;
    xor cx, cx  ;
 
    ; Blue background
    mov ch, 1   ; Row start       x1
    mov cl, 0   ; Column start    y1
    mov dh, 22  ; Row end         x2
    mov dl, 80  ; Column end      y2
    mov bh, 17h ; Color
    int 10h;
   
    ; Header Cyan background
    mov ch, 1   ; Row start
    mov cl, 0   ; Column start
    mov dh, 3   ; Row end
    mov dl, 80  ; Column end
    mov bh, 31h ; Column end
    int 10h

    ; Log Out White background
    mov ch, 0   ; Row start
    mov cl, 0   ; Column start
    mov dh, 0   ; Row end
    mov dl, 80  ; Column end
    mov bh, 71h ; Column end
    int 10h
 
 
    ; (Withdrawal) User Input Box background
    mov ch, 6   ; Row start
    mov cl, 10  ; Column start
    mov dh, 6   ; Row end
    mov dl, 32  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 6   ; Row start
    mov cl, 7  ; Column start
    mov dh, 6   ; Row end
    mov dl, 9  ; Column end
    mov bh, 71h ; Color
    int 10h
 
    ; (Payment) User Input Box background
    mov ch, 6   ; Row start
    mov cl, 41  ; Column start
    mov dh, 6   ; Row end
    mov dl, 67  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 6   ; Row start
    mov cl, 68  ; Column start
    mov dh, 6   ; Row end
    mov dl, 70  ; Column end
    mov bh, 71h ; Color
    int 10h
 
 
    ; (Balance Inq) User Input Box background
    mov ch, 10  ; Row start
    mov cl, 10  ; Column start
    mov dh, 10  ; Row end
    mov dl, 32  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 10   ; Row start
    mov cl, 7  ; Column start
    mov dh, 10  ; Row end
    mov dl, 9  ; Column end
    mov bh, 71h ; Color
    int 10h
 
    ; (Recent Transact) User Input Box background
    mov ch, 10  ; Row start
    mov cl, 41  ; Column start
    mov dh, 10  ; Row end
    mov dl, 67  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 10   ; Row start
    mov cl, 68  ; Column start
    mov dh, 10   ; Row end
    mov dl, 70  ; Column end
    mov bh, 71h ; Color
    int 10h
 
 
    ; (Balance Inq) User Input Box background
    mov ch, 14  ; Row start
    mov cl, 10  ; Column start
    mov dh, 14  ; Row end
    mov dl, 32  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 14   ; Row start
    mov cl, 7  ; Column start
    mov dh, 14  ; Row end
    mov dl, 9  ; Column end
    mov bh, 71h ; Color
    int 10h
 
    ; (Recent Transact) User Input Box background
    mov ch, 14  ; Row start
    mov cl, 41  ; Column start
    mov dh, 14  ; Row end
    mov dl, 67  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 14   ; Row start
    mov cl, 68  ; Column start
    mov dh, 14   ; Row end
    mov dl, 70  ; Column end
    mov bh, 71h ; Color
    int 10h
 
 
    ; (Balance Inq) User Input Box background
    mov ch, 18  ; Row start
    mov cl, 10  ; Column start
    mov dh, 18  ; Row end
    mov dl, 32  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 18   ; Row start
    mov cl, 7  ; Column start
    mov dh, 18  ; Row end
    mov dl, 9  ; Column end
    mov bh, 71h ; Color
    int 10h
 
    ; (Recent Transact) User Input Box background
    mov ch, 18  ; Row start
    mov cl, 41  ; Column start
    mov dh, 18  ; Row end
    mov dl, 67  ; Column end
    mov bh, 31h ; Color
    int 10h
    ; Arrow
    mov ch, 18   ; Row start
    mov cl, 68  ; Column start
    mov dh, 18   ; Row end
    mov dl, 70  ; Column end
    mov bh, 71h ; Color
    int 10h
 
 
    ; Yellow blinking text "Thank you"
    ;mov ch, 22  ; Row start
    ;mov cl, 2   ; Column start
    ;mov dh, 22  ; Row end
    ;mov dl, 77  ; Column end
    ;mov bh, 08EH; Blinking red background yellow text
    ;int 10h

 
 
    ; Print the Texts
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    lea dx, text
    int 21h    
 
int 27h
END START
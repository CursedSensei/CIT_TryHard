; Filename: Exer10.asm
; Program Description: Displaying single chraracters, numbers, & symbols
; Programmer Name: JOHN ZILLION REYES
; Date: August 29, 2024

.model small
.stack 100h

.data
	szTitle db "Filename: Exer10.asm", 0Ah, "Program Description: Displaying single chraracters, numbers, & symbols", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Date: August 29, 2024", 0Ah, 0Ah, '$'
    ;box shapes
    boxtopL db 218, "$"
    boxtopR db 191, "$"
    boxbotL db 192, "$"
    boxbotR db 217, "$"
    boxcen db 196, "$"

    ; title
    form db "College Enrollment Form$"
    college db "Cebu Institute of Technology - University $"

    ; Field Names (length set to 20)
    FullName db  "     Full Name      $"
    Address db   "     Address        $"
    BirthDate db "     Birth Date     $"
    Gender db    "     Gender         $"
    StuNum db    "     Student Number $"
    StuMail db   "     Student Email  $"
    Comp db      "     Company        $"
    Course db    "     Courses        $"
    Comment db   "     Addt. Comments $"
    Date db      "Date: $"
    Sig db "Signature$"

    ; Field Labels

.code

;description
main PROC
    ; code setup
    mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

    mov ah, 00
    mov al, 03
    int 10h
    
    mov ah, 09
    mov bh, 00
    mov al, 20h
    mov cx, 800h ; bg
    mov bl, 70h
    int 10h

    ; code start

    call newline
    call banner

    ; FULL NAME
    mov ah, 09h
	mov dx, offset FullName
	int 21h

    mov cx, 20 
    call boxtop

    call space
    call space

    mov cx, 20
    call boxtop

    call newline
    
    mov cx, 20
    call spaceloop

    mov cx, 20
    call boxbot

    call space
    call space

    mov cx, 20
    call boxbot


    ; ADDRESS
    call newline

    mov ah, 09h
	mov dx, offset Address
	int 21h

    mov cx, 44
    call boxtop ; box addre 1 big

    call newline

    mov cx, 20
    call spaceloop

    mov cx, 44
    call boxbot
    
    call newline ; box addre 2 small
    
    mov cx, 20
    call spaceloop

    mov cx, 20 
    call boxtop

    call space
    call space

    mov cx, 20
    call boxtop

    call newline
    
    mov cx, 20
    call spaceloop

    mov cx, 20
    call boxbot

    call space
    call space

    mov cx, 20
    call boxbot

    ; Birth Date
    call newline

    mov ah, 09h
	mov dx, offset BirthDate
	int 21h

    mov cx, 12 ; topside 3 bd bop
    call boxtop
    call space
    call space
    mov cx, 12
    call boxtop
    call space
    call space
    mov cx, 12
    call boxtop

    call newline
    mov cx, 20
    call spaceloop
    mov cx, 12 ; botside 3 bd bop
    call boxbot
    call space
    call space
    mov cx, 12
    call boxbot
    call space
    call space
    mov cx, 12
    call boxbot
    call newline


    mov ax, 4c00h ; return 0
	int 21h
main ENDP

;top box side
boxtop PROC ; set cx before calling (min=1)

    ;Topside
    mov ah, 09h
	mov dx, offset boxtopL
	int 21h

    boxlength1:
    mov ah, 09h
	mov dx, offset boxcen
	int 21h
    
    loop boxlength1

    mov ah, 09h
	mov dx, offset boxtopR
	int 21h

    ret
boxtop ENDP

;bot box side
boxbot PROC ; set cx before calling (min=1)

    ;Botside
    mov ah, 09h
	mov dx, offset boxbotL
	int 21h

    boxlength2:
    mov ah, 09h
	mov dx, offset boxcen
	int 21h
    
    loop boxlength2

    mov ah, 09h
	mov dx, offset boxbotR
	int 21h
    
    ret
boxbot ENDP

; newline gen
newline PROC

	mov ah, 02h
	mov dl, 0ah  ;newline
	int 21h

	ret
newline ENDP

; space gen (1 space)
space PROC
    mov ah, 02h
    mov dl, 20h     ; space
    int 21h

    ret
space ENDP

;many space gen 
spaceloop PROC

    spacelooper:
    call space
    loop spacelooper
    
    ret
spaceloop ENDP

;description
banner PROC
    mov ah, 09h
    mov bl, 43h     ; red
    mov cx, 80
    int 10h

    call newline

    mov ah, 09h
    mov bl, 43h     ; red
    mov cx, 80
    int 10h

    mov cx, 5
    call spaceloop

    mov ah, 09h
	mov dx, offset form
	int 21h

    mov cx, 5
    call spaceloop

    mov ah, 09h
	mov dx, offset college
	int 21h

    mov cx, 5
    call spaceloop

    call newline

    mov ah, 09h
    mov bl, 43h     ; red
    mov cx, 80
    int 10h

    
    call newline

    ret

    int 27h

banner ENDP
end main
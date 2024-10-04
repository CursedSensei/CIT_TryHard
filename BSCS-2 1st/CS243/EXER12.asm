; Filename: EXER12.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Date: September 20, 2024
; Description: This assembly language program will display multiple string variables on single lines.

.MODEL small
.STACK 200h
.DATA
	szTitle db "Filename: EXER12.ASM", 0Ah, "Programmer Name: JOHN ZILLION C. REYES", 0Ah, "Date: September 20, 2024", 0Ah, "Description: This assembly language program will display multiple string variables on single lines.", 0Ah, 0Ah, '$'
String1 DB 'Line1', '$'     ; DB = Define Byte String1 variable and assign ‘Line1’ value.
String2 DB 'Line2', '$'
String3 DB 'Line3', '$'

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

    mov ah, 9               ; DOS print string function
    mov dx, OFFSET String1  ; 1st string to print
    int 21h                 ; invoke DOS to print string

    mov dx, OFFSET String2  ; 2nd string to print
    int 21h                 ; invoke DOS to print string

    mov dx, OFFSET String3  ; 3rd string to print
    int 21h                 ; invoke DOS to print string

    mov ah, 4ch             ; DOS terminate program function
    int 21h                 ; invoke DOS to end program
END ProgramStart
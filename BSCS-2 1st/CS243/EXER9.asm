; Filename: EXER9.ASM
; Programmer Name: JOHN ZILLION REYES
; Program Description: Display August Calendar
; Date: August 29, 2024

.model small
.stack 100h

.data
	szTitle db "Filename: EXER9.ASM", 0Ah, "Programmer Name: JOHN ZILLION REYES", 0Ah, "Program Description: Display August Calendar", 0Ah, "Date: August 29, 2024", 0Ah, 0Ah, '$'
    str1 db '|-----------------------------------------|', 13, 10
         db '|                 AUGUST                  |', 13, 10
         db '|-----------------------------------------|', 13, 10
         db '| MON | TUE | WED | THU | FRI | SAT | SUN |', 13, 10 
         db '|-----------------------------------------|', 13, 10
         db '|   29|   30|   31|    1|    2|    3|    4|', 13, 10
         db '|-----------------------------------------|', 13, 10
         db '|    5|    6|    7|    8|    9|   10|   11|', 13, 10
         db '|-----------------------------------------|', 13, 10
         db '|   12|   13|   14|   15|   16|   17|   18|', 13, 10
         db '|-----------------------------------------|', 13, 10
         db '|   19|   20|   21|   22|   23|   24|   25|', 13, 10
         db '|-----------------------------------------|', 13, 10
         db '|   26|   27|   28|   29|   30|   31|    1|', 13, 10
         db '|-----------------------------------------|', 13, 10, '$'
.code

start:
    mov ax, @data
    mov ds, ax
	lea dx, szTitle
	mov ah, 09h
	int 21h

    lea dx, str1
    mov ah, 09h
    int 21h

int 27h
end start





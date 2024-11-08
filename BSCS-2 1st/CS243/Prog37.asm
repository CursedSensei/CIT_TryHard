; Filename: Prog37.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Program Description: uppercase conversion of characters.
; Date Created: November 8, 2024

; TITLE uppercase conversion of characters
; COMMENT |
;    Objective: To convert lowercase letters to 
;   corresponding uppercase letters. 
;    Input: Requests a character string from keyboard. 
; | Output: Prints the input string in uppercase. 

MODEL SMALL 
.STACK 100H 
.DATA 

name_prompt DB 'Please type your name: ',0 
out_msg DB 'Your name in capitals is: ',0 
in_name DB 31 DUP (?)

.CODE
INCLUDE IO.MAC
main PROC
    .STARTUP
    PutStr  name_prompt ; request character string 
    GetStr  in_name,31  ; read input character string 
    nwln
    PutStr  out_msg
    mov     BX,OFFSET in_name ; BX := address of in_name
process_char:
    mov     AL, [BX]    ; move the char. to AL 
    cmp     AL,0        ; if it is the NULL character
    je      done        ; conversion done 
    cmp     AL,'a'      ; if (char < 'a') 
    jl      not_lower_case ; not a lowercase letter
    cmp     AL,'z'         ;if (char > 'z') 
    jg      not_lower_case ;not a lowercase letter 
lower_case:
    add     AL,'A'-'a' ; convert to uppercase
not_lower_case:
    PutCh   AL ; write the character
    inc     BX ; BX points to next char.
    jmp     process_char ; go back to process next char. 
    
done:
    nwln
    int 27h
main ENDP
     END main


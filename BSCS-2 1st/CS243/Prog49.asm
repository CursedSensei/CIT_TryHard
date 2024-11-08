; Filename: Prog49.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Program Description: Parameter passing via registers.
; Date Created: November 8, 2024

; TITLE Parameter passing via registers 
; Objective: To show parameter passing via registers 
; Input: Requests two integers from the user. 
; Output: Outputs the sum of the input integers.

.MODEL SMALL
.STACK 100H
.DATA
prompt_msgl DB 'Please input the first number: ',0 
prompt_msg2 DB 'Please input the second number: ',0 
sum_msg DB 'The sum is ',0

.CODE
INCLUDE io.mac

main PROC
    .STARTUP
    PutStr prompt_msgl ; request first number 
    GetInt CX   ; CX := first number
    nwln 
    PutStr prompt_msg2 ; request second number 
    GetInt DX       ; DX := second number 
    nwln 
    call sum        ; returns sum in AX
    PutStr sum_msg ; display sum 
    PutInt AX
    nwln
done:
    int 27h
main ENDP
; -----------------------------------------------------------
; Procedure sum receives two integers in CX and DX. 
; The sum of the two integers is returned in AX. 
;-----------------------------------------------------------
sum PROC
    mov AX,CX ; sum := first number 
    add AX,DX ; sum := sum + second number 
    ret
sum ENDP
    END main
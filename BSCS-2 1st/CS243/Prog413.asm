; Filename: Prog413.ASM
; Programmer Name: JOHN ZILLION C. REYES
; Program Description: I Bubble sort procedure
; Date Created: November 8, 2024

; COMMENT I Bubble sort procedure
; Objective: To implement the bubble sort algorithm
; Input: A set of non-zero integers to be sorted.
; Input is terminated by entering zero.
; Output: Outputs the numbers in ascending order.

CRLF EQU 0DH,0AH
MAX_SIZE EQU 20 
.MODEL SMALL 
.STACK 100H
.DATA
     array DW MAX_SIZE DUP (?) ; input array for integers 
     prompt_msg DB 'Enter non-zero integers to be sorted.',CRLF 
     DB 'Enter zero to terminate the input.',0
     output_msg DB 'Input numbers in ascending order:',0

.CODE 
.486 
INCLUDE io.mac 
main PROC 
    .STARTUP
    PutStr prompt_msg   ; request input numbers 
    nwln
    mov BX,OFFSET array ;  BX := array pointer
    mov CX,MAX_SIZE     ; CX := max array size 
    sub DX,DX           ; number count := 0
read_loop:
    GetInt AX           ; read input number 
    nwln 
    cmp AX,0            ; if the number is zero
    je stop_reading     ; no more numbers to read 
    mov [BX],AX         ; copy the number into array 
    add BX,2            ; BX points to the next element 
    inc DX              ; increment number count 
    loop read_loop      ; reads a max. of MAX_SIZE numbers 
stop_reading:
    push DX             ; push actual array size onto stack 
    push OFFSET array   ; place array pointer on stack 
    call bubble_sort
    PutStr output_msg   ; display sorted input numbers 
    nwln
    mov BX,OFFSET array
    mov CX,DX           ; CX := actual number count 
print_loop:
    PutInt [BX]
    nwln
    add BX,2
    loop print_loop
done:
        int 27h
main ENDP


;------------------------------------------------------------
; This procedure receives a pointer to an array of integers
; and the size of the array via the stack. It sorts the
; array in ascending order using the bubble sort algorithm.
;------------------------------------------------------------
SORTED      EQU 0
UNSORTED    EQU 1
bubble_sort     PROC
        pusha
        mov     BP,SP

        ; CX serves the same purpose as the end_index variable
        ; in the C procedure. CX keeps the number of comparisons
        ; to be done in each pass. Note that CX is decremented
        ; by 1 after each pass.
        mov     CX, [BP+20]     ; load array size into CX
        mov     BX, [BP+18]     ; load array address into BX

next_pass:
        dec     CX              ; if # of comparisons is zero
        jz      sort_done       ; then we are done
        mov     DI,CX           ; else start another pass

        ; DX is used to keep SORTED/UNSORTED status
        mov     DX,SORTED       ; set status to SORTED

        ; SI points to element X and SI+2 to the next element
        mov     SI,BX           ; load array address into SI
pass:
        ; This loop represents one pass of the algorithm.
        ; Each iteration compares elements at [SI] and [SI+2]
        ; and swaps them if ([SI]) > ([SI+2]).
        mov     AX, [SI]
        cmp     AX, [SI+2]
        jg      swap
increment:
        ;Increment SI by 2 to point to the next element
        add     SI,2 
        dec     DI
        jnz     pass

        cmp     DX,SORTED       ; if status remains SORTED
        je      sort_done       ; then sorting is done
        jmp     next_pass       ; else initiate another pass
swap:
        ; swap elements at [SI] and [SI+2]
        xchg    AX, [SI+2]
        mov     [SI],AX
        mov     DX, UNSORTED    ; set status to UNSORTED
        jmp     increment
sort_done:
        popa
        ret     4               ; return and clear parameters
bubble_sort     ENDP
        END     main
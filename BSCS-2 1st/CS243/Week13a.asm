; Filename: Week13a.ASM
; Programmer Name: John Zilion C. Reyes
; Program Description: Using a loop, vertically display the numbers 1 to 10.
; Date Created: November 8, 2024
 
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN:
    MOV ax, @DATA
    MOV ds, ax
    MOV bl, 1
   
    PRINT_LOOP:

        MOV al, bl     
        MOV ah, 0      
        MOV BH, 10    
        DIV BH        
       
        CMP al, 0      
        JE SINGLE_DIGIT

        PUSH ax        
        ADD al, 30H   
        MOV dl, al
        MOV ah, 2    
        INT 21H
        POP ax       
       
        MOV dl, ah   
        ADD dl, 30H   
        MOV ah, 2
        INT 21H
        JMP nwln
       
    SINGLE_DIGIT:

        MOV dl, ah    
        ADD dl, 30H   
        MOV ah, 2
        INT 21H
       
    nwln:
     
        MOV dl, 0DH   
        MOV ah, 2
        INT 21H
        MOV dl, 0AH   
        MOV ah, 2
        INT 21H
       
        INC bl
       
        CMP bl, 11
        JNE PRINT_LOOP
   
    MOV ah, 4CH
    INT 21H
END MAIN

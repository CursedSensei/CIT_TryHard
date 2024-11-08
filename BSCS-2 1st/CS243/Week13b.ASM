;Filename: Week13b.ASM
;Programmer Name: John Zilion C. Reyes
;Program Description: Using a loop, horizontally display the numbers 1 to 20, with space between each number.
;Date Created: November 8, 2024
 
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
        JMP PRINT_SPACE
       
    SINGLE_DIGIT:

        MOV dl, ah   
        ADD dl, 30H  
        MOV ah, 2
        INT 21H
       
    PRINT_SPACE:

        MOV dl, 20H    
        MOV ah, 2
        INT 21H
       
        INC bl
       
        CMP bl, 21
        JNE PRINT_LOOP
   
    MOV ah, 4CH
    INT 21H
END MAIN
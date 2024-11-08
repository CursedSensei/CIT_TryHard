;Filename: Week13c.ASM
;Programmer Name: John Zilion C. Reyes
;Program Description: Ask user to input a number from 1 to 8. Display error
;message if number entered is less than 1 or greater than 8. If
;input is correct, horizontally display the numbers, with space
;between each number, from 1 to the number entered by user.
;Date Created: November 8, 2024
 
.MODEL SMALL
.STACK 100H
.DATA
prompt_msg  DB 'Enter a number from 1 to 8: $'
error_msg   DB 'Error: Number out of range!$'
newline     DB 0Dh, 0Ah, '$'
space       DB ' $'

.CODE
MAIN:
    MOV  ax, @DATA      
    MOV ds,  ax     
 
loop1:

    MOV dx, OFFSET prompt_msg
    MOV ah, 09H        
    INT 21H
 
    MOV ah, 01H            
    INT 21H
    SUB al, '0'         
 
    CMP al, 1                
    JB show_error           
    CMP al, 8               
    JA show_error           
 
    MOV cl, al               
    MOV bl, 1           
 
displaynum:
    MOV dl, bl          
    ADD dl, '0'            
    MOV ah, 02H          
    INT 21H
 
    DEC cl                  
    JZ end_display          
    MOV dl, ' '             
    MOV ah, 02H            
    INT 21H
 
    INC bl
    JMP displaynum   
 
end_display:

    MOV dx, OFFSET newline
    MOV ah, 09H
    INT 21H
    JMP loop1          
 
show_error:

    MOV dx, OFFSET error_msg
    MOV ah, 09H
    INT 21H
    MOV dx, OFFSET newline
    MOV ah, 09H
    INT 21H
    JMP loop1   
END MAIN
 
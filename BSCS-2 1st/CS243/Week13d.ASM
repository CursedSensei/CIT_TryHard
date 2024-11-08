;Filename: Week13d.ASM
;Programmer Name: John Zilion C. Reyes
;Program Description: Repeatedly ask user to input a single digit whole number
;until the number entered is a zero. Display “Thank you.” When
;the number entered is zero.  
;Date Created: November 8, 2024
 
.MODEL SMALL
.STACK 100H
.DATA
prompt_msg  DB 'Enter a single digit number: $'
thank_you_msg DB 'Thank you.$'
newline     DB 0Dh, 0Ah, '$'
 
.CODE
MAIN:
    MOV AX, @DATA      
    MOV DS, AX           
 
loop1:

    MOV DX, OFFSET prompt_msg
    MOV AH, 09H            
    INT 21H
 
 
    MOV AH, 01H           
    INT 21H
    SUB AL, '0'             
 
    CMP AL, 0                
    JE display     
 
    MOV DL, 10         
    MOV AH, 02H
    INT 21H
    MOV DL, 13             
    MOV AH, 02H
    INT 21H
 
    JMP loop1        
 
display:
    
    MOV DL, 10              
    MOV AH, 02H
    INT 21H
    MOV DL, 13             
    MOV AH, 02H
    INT 21H
 
    MOV DX, OFFSET thank_you_msg
    MOV AH, 09H            
    INT 21H
 
    MOV AH, 4CH            
    INT 21H
END MAIN
 
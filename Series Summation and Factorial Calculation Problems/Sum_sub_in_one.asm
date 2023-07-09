.model small
.stack 100h
.data
    prompt1 db 'Enter 1st digit: $'
    prompt2 db 10, 13, 'Enter 2nd digit: $'
    resultAddMsg db 10, 13, 'Addition: $'
    resultSubMsg db 10, 13, 'Subtraction: $'
    num1 db ?
    num2 db ?
.code  
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    mov ah, 1
    int 21h 
    
    sub al, 48
    mov cl, al
    mov num1, al
    
    mov ah, 9
    lea dx, prompt2
    int 21h
    
    mov ah, 1
    int 21h 
    
    sub al, 48
    mov bl, al
    mov num2, al
    
    add bl, num1 
    add bl, 48
    
    mov ah, 9
    lea dx, resultAddMsg
    int 21h
    
    mov ah, 2
    mov dl, bl
    int 21h
    
    sub cl, num2
    add cl, 48
    
    mov ah, 9
    lea dx, resultSubMsg
    int 21h
    
    mov ah, 2
    mov dl, cl
    int 21h
     
    mov ah, 4ch
    int 21h
        
main endp
  
end main

;checking a number is prime or not.


.model small
.stack 100h

.data 
    input db "Enter a number between 0 to 9 : $"
    pri db "The numner is a prime number.$"
    notpri db "The numner is not a prime number.$"
    
    n db ?
  

.code

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx,input
    mov ah,09h
    int 21h
    
    mov ah,1
    int 21h
    
    sub al,48
    mov n,al 
    
    cmp n,0
    je not_prime 
    
     cmp n,1
    je not_prime
            
    cmp n,2
    je prime
    
    sub al,0
    mov bl,al 
    mov cl,al   
    dec cl
      
    
    loop1:  
    
        ;he code divides the value in the AL register 
        ;(BL in this case) by the value in the CL register.
      
        mov ah,0h
        div cl      ;al = quotient 
        mov al,bl
        
        ;checks if the remainder 
        ;(stored in the AH register) is equal to 0   
        
        cmp ah,0h   ;remainder
        je not_prime
        
        ;compares the value in the CL register with 2
        
        cmp cl,02h
        je prime 
        
        ;loop continues until the 
        ;value in the CL register becomes 2
        
        loop loop1
    
    prime:
        call new_line  
        
        lea dx,pri
        mov ah,09h
        int 21h 
        
        jmp exit
    
    not_prime:
        call new_line  
        
        lea dx,notpri
        mov ah,09h
        int 21h 
        
        jmp exit
    
    exit:
        mov ah,4ch
        int 21h 
        
main endp

new_line proc
    mov ah,2
    mov dl,0ah
    int 21h
    mov dl,0dh
    int 21h
    ret
new_line endp

end main

.model small
.stack 100h
.data
    input db "Enter number  : $"
    outp  db "Factorial is : $"   
    
    res db ?
    dv  db 2  
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, input
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h 
    
    sub al, 48
    
    mov bl, al
    mov al, 1
    mov res, 1
    
    cmp bl, 0
    je end
    
    fact:
        mul res
        
        cmp bl, res
       
        je end  
        
        inc res
        jmp fact
    
    end:
       mov res, al
       
    ;new line
    
     mov  ah, 2
	 mov  dl, 10
	 int  21h
	 mov  dl, 13
	 int  21h
	 
       
    lea dx, outp
    mov ah, 9
    int 21h  
    
    mov dl, res 
    add dl, 48
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h
    


end main   



;mul res multiplies the value in the accumulator (al) with the value stored in res. The mul instruction performs an unsigned multiplication of the two operands and stores the result in the combination of registers ax and dx.

;cmp bl, res compares the value in the bl register (which contains the entered number) with the value in res. It sets the appropriate flags in the processor's status register based on the comparison.

;je end checks if the previous comparison resulted in equality (je stands for "jump if equal"). If the values are equal, the program jumps to the label end, indicating that the factorial calculation is complete.

;inc res increments the value stored in the res variable.

;jmp fact jumps back to the fact label, repeating the loop and continuing the factorial calculation.
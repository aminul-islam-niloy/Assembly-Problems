; oddd even proble

.model small
.stack 100h
.data 
    input db 'Enter the input:$'
    ev db 'The number is even$'
    od db 'The number is odd$'
    
    d db 2
    
.code
main proc 
    mov ax,@data
    mov ds,ax 
    
    mov ah,9
    lea dx,input
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
     
    ;odd even chack  operation
    
    div d
    cmp ah,0    ; hold the remainder after the division operation
    
    je even
            
            call newline 
            mov ah,9
            lea dx,od
            int 21h 
            jmp exit
            
    even:
            call newline 
            mov ah,9
            lea dx,ev
            int 21h
            jmp exit
    
    
    exit:
    mov ah,4ch
    int 21h    
    
    main endp 
    
    newline proc 
        
        mov ah,2
        mov dl,13
        int 21h
        mov ah,2
        mov dl,10
        int 21h
        ret
         
    newline endp   
    

  
end main

.model small
.stack 100h

.data
    loadinput db 'enter some numbers from 0 to 9: $'
    loadoutput db 'the  largest number : $' 
   
    newline db 13,10,'$'
    
.code   

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx,loadinput   ; load the address of the string into the DX register.
    mov ah,9
    int 21h 
     
    mov bl,1
    
    input:
    
        mov ah,1
        int 21h
        
        
        cmp al,13
        je output    
        
        cmp al,bl
        jg check   ;jump greater
        
        jmp input
        
    check:    
        mov bl,al
        jmp input
        
    output:
        call new
        ;print output msg
        mov ah,9
        lea dx,loadoutput
        int 21h
    
        ;print result
        mov dl,bl 
        
        mov ah,2
        int 21h
        jmp exit
        
    exit:
        mov ah,4ch
        int 21h   
    main endp
        
     new proc
        mov ah,2
        mov dl,13
        int 21h
        mov ah,2
        mov dl,10
        int 21h
        ret 
        new endp
                   
                   
end main

        
      
   
        
;The code enters a loop labeled "input" to repeatedly read numbers from the user.
;Inside the loop, the code reads a single character from the input using the DOS
; function 01h (read character) and stores it in the AL register. 

;The code compares the entered character with the ASCII value for carriage return (13).
; If they are equal, it jumps to the "output" section. 

;The code compares the entered character with the value in the BL register (initially 1).
; If the entered character is greater, it jumps to the "check" section. Otherwise,
; it jumps back to the "input" loop to read the next character.
        
   
    

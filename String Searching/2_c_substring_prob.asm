                                      
.model small
.stack 100h

.data 
    mainmsg db "enter the main string : $"
    submsg  db "enter the sub string : $"
    found   db "substring found.$"
   notfound db "substring not found.$"
      
    mainst db 100 dup ("$")
    subst db 100 dup ("$")

.code

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx,mainmsg
    mov ah,09h
    int 21h
    
    mov si,0
    
    main_st:
        mov ah,1
        int 21h
        cmp al,0dh
        je end_main_st
        
        mov mainst[si],al
        inc si
        jmp main_st
        
    end_main_st:
    
    call new_line 
    
    lea dx,submsg
    mov ah,09h
    int 21h
    
    mov si,0
    
    sub_st:
        mov ah,1
        int 21h
        cmp al,0dh
        je end_sub_st
        
        mov subst[si],al
        inc si
        jmp sub_st
        
    end_sub_st:
    
    call new_line
    mov si,0
    
    check:
        mov di,0
        push si
        
        for_loop:
            mov ah,mainst[si]
            mov al,subst[di]
            inc si
            inc di
            cmp al,'$'
            je found_msg
            cmp ah,al
            je for_loop
            jmp update_si
            
    update_si:
        pop si
        inc si
        mov ah,mainst[si]
        cmp ah,'$'
        je not_found_msg
        jmp check
     
    found_msg:
        lea dx,found
        mov ah,09h
        int 21h
        jmp exit   
        
    not_found_msg:
        lea dx,notfound
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

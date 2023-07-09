.model small
.stack 100h

.data
    inpmsg db "enter the input string : $"  
    vowmsg db "no of vowels = $"
    conmsg db "no of consonants = $"
    digmsg db "no of digits = $"
    spamsg db "no of spaces = $"
    str db 100 dup ?
    
    vowel db 48
    consonant db 48
    digit db 48
    space db 48
    
.code

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx,inpmsg
    mov ah,09h
    int 21h
    
    mov si,0
    mov di,0
    
    input:
        mov ah,1
        int 21h
        cmp al,0dh  
        
        je end_input
        
        ;space
        cmp al,20h
        je count_space
        
        ;digit
        digit_:
            cmp al,'0'       ;is greater than or equal to
            
            jge less_nine
            
            jmp vowel_  
            
   ;This part checks if the character is a digit. 
   ;It compares the character in al with the ASCII code for '0'.
   ; If the character is greater than or equal to '0',
   ; it jumps to the label less_nine. Otherwise, it jumps to the label vowel_.
            
            less_nine:
                cmp al,'9'
                jle count_digit
                jmp vowel_ 
                
        ;vowel
        vowel_:
            cmp al,'a'
            je count_vowel
            cmp al,'e'
            je count_vowel
            cmp al,'i'
            je count_vowel
            cmp al,'o'
            je count_vowel
            cmp al,'u'
            je count_vowel
            
            jmp consonant_
        
        ;consonant 
        
        consonant_:
            cmp al,'a'
            jg less_z    
            
  ;checks if the character is a consonant by comparing 
  ;it with the ASCII codes for 'a' and 'z'. 
            
            jmp input
            
            less_z:
                cmp al,'z'
                jle count_consonant
                jmp input  
        
        count_space:
            inc space
            inc si
            jmp input
        
        count_digit:
            inc digit
            inc si
            jmp input
        
        count_vowel:
            inc vowel
            inc si
            jmp input
        
        count_consonant:
            inc consonant
            inc si
            jmp input
        
    end_input:
    
    
    output:
        ;printing no of vowels            
         call new_line
         lea dx,vowmsg
         mov ah,09h
         int 21h
          
         mov dl,vowel
         mov ah,2
         int 21h
         
         ;printing no of consonants            
         call new_line
         lea dx,conmsg
         mov ah,09h
         int 21h
          
         mov dl,consonant
         mov ah,2
         int 21h
         
         ;printing no of digits            
         call new_line
         lea dx,digmsg
         mov ah,09h
         int 21h
          
         mov dl,digit
         mov ah,2
         int 21h
         
         ;printing no of spaces            
         call new_line
         lea dx,spamsg
         mov ah,09h
         int 21h
          
         mov dl,space
         mov ah,2
         int 21h
    
    end_output:
    
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

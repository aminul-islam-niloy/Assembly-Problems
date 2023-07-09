.model small
.stack 100h

.data
    inpmsg db "Enter the input string: $"  
    vowmsg db "No. of vowels = $"
    conmsg db "No. of consonants = $"
    digmsg db "No. of digits = $"
    spamsg db "No. of spaces = $"
    othermsg db "No. of other characters = $"
    str db 100 dup ?
    
    vowel db 48
    consonant db 48
    digit db 48
    space db 48
    other db 48
    
.code

main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, inpmsg
    mov ah, 09h
    int 21h
    
    mov si, 0
    mov di, 0
    
    input:
        mov ah, 1
        int 21h
        cmp al, 0dh  
        je end_input
        
        cmp al, 20h
        je count_space
        
        cmp al, '0'
        jl count_other
        cmp al, '9'
        jle count_digit
        
        cmp al, 'a'
        jl count_other
        cmp al, 'z'
        jg count_other
        
        cmp al, 'a'
        je count_vowel
        cmp al, 'e'
        je count_vowel
        cmp al, 'i'
        je count_vowel
        cmp al, 'o'
        je count_vowel
        cmp al, 'u'
        je count_vowel
        
        jmp count_consonant
        
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
        
    count_other:
        inc other
        inc si
        jmp input
    
    end_input:
    
    output:
        ; Printing the count of vowels            
        call new_line
        lea dx, vowmsg
        mov ah, 09h
        int 21h
        
        mov dl, vowel
        mov ah, 2
        int 21h
        
        ; Printing the count of consonants            
        call new_line
        lea dx, conmsg
        mov ah, 09h
        int 21h
        
        mov dl, consonant
        mov ah, 2
        int 21h
        
        ; Printing the count of digits            
        call new_line
        lea dx, digmsg
        mov ah, 09h
        int 21h
        
        mov dl, digit
        mov ah, 2
        int 21h
        
        ; Printing the count of spaces            
        call new_line
        lea dx, spamsg
        mov ah, 09h
        int 21h
        
        mov dl, space
        mov ah, 2
        int 21h
        
        ; Printing the count of other characters
        call new_line
        lea dx, othermsg
        mov ah, 09h
        int 21h
        
        mov dl, other
        mov ah, 2
        int 21h
    
    end_output:
    
    exit:
        mov ah, 4ch
        int 21h
        
main endp

new_line proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    
    mov dl, 0dh
    int 21h
    
    ret
new_line endp

end main

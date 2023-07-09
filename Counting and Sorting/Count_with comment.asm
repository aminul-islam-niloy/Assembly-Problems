.model small
.stack 100h

.data
    inpmsg db "enter the input string : $"  
    vowmsg db "no of vowels = $"
    conmsg db "no of consonants = $"
    digmsg db "no of digits = $"
    spamsg db "no of spaces = $"
    str db 100 dup ? ; Character array to store the input string
    
    vowel db 48      ; Variable to store the count of vowels (initialized to 0)
    consonant db 48  ; Variable to store the count of consonants (initialized to 0)
    digit db 48      ; Variable to store the count of digits (initialized to 0)
    space db 48      ; Variable to store the count of spaces (initialized to 0)

.code

main proc
    mov ax, @data   ; Load the data segment into the ax register
    mov ds, ax      ; Set the data segment using the value in ax
    
    lea dx, inpmsg  ; Load the offset address of inpmsg into the dx register
    mov ah, 09h     ; Set ah to 09h (display string function)
    int 21h         ; Invoke DOS interrupt 21h to display the prompt message
    
    mov si, 0       ; Initialize si register to 0 (used as pointer for input string)
    mov di, 0       ; Initialize di register to 0 (used as pointer for input string)
    
    input:
        mov ah, 1     ; Set ah to 1 (function to read a character from standard input)
        int 21h       ; Invoke the DOS interrupt 21h to read a character from the keyboard
        cmp al, 0dh   ; Compare the ASCII value of the character with carriage return (ASCII 0dh)
        je end_input  ; If the character is a carriage return, jump to the label end_input
        
        ; Check for space
        cmp al, 20h   ; Compare the ASCII value of the character with space (ASCII 20h)
        je count_space ; If the character is a space, jump to count_space
        
        ; Check for digit
        digit_:
            cmp al, '0'  ; Compare the character with the ASCII code for '0'
            jge less_nine  ; If the character is greater than or equal to '0', jump to less_nine
            jmp vowel_  ; Otherwise, jump to vowel_
            
        ; Check if the character is a digit
        less_nine:
            cmp al, '9'  ; Compare the character with the ASCII code for '9'
            jle count_digit  ; If the character is less than or equal to '9', jump to count_digit
            jmp vowel_  ; Otherwise, jump to vowel_
            
        ; Check if the character is a vowel
        vowel_:
            cmp al, 'a'  ; Compare the character with the ASCII code for 'a'
            je count_vowel  ; If the character is 'a', jump to count_vowel
            cmp al, 'e'  ; Compare the character with the ASCII code for 'e'
            je count_vowel  ; If the character is 'e', jump to count_vowel
            cmp al, 'i'  ; Compare the character with the ASCII code for 'i'
            je count_vowel  ; If the character is 'i', jump to count_vowel
            cmp al, 'o'  ; Compare the character with the ASCII code for 'o'
            je count_vowel  ; If the character is 'o', jump to count_vowel
            cmp al, 'u'  ; Compare the character with the ASCII code for 'u'
            je count_vowel  ; If the character is 'u', jump to count_vowel
            
            jmp consonant_  ; If the character is not a vowel, jump to consonant_
        
        ; Check if the character is a consonant
        consonant_:
            cmp al, 'a'  ; Compare the character with the ASCII code for 'a'
            jg less_z     ; If the character is greater than 'a', jump to less_z
            
            jmp input  ; If the character is less than or equal to 'a', jump back to input
            
            less_z:
                cmp al, 'z'  ; Compare the character with the ASCII code for 'z'
                jle count_consonant  ; If the character is less than or equal to 'z', jump to count_consonant
                jmp input  ; If the character is greater than 'z', jump back to input
        
        count_space:
            inc space  ; Increment the count of spaces
            inc si     ; Increment the pointer for input string
            jmp input  ; Jump back to the input loop
        
        count_digit:
            inc digit  ; Increment the count of digits
            inc si     ; Increment the pointer for input string
            jmp input  ; Jump back to the input loop
        
        count_vowel:
            inc vowel  ; Increment the count of vowels
            inc si     ; Increment the pointer for input string
            jmp input  ; Jump back to the input loop
        
        count_consonant:
            inc consonant  ; Increment the count of consonants
            inc si     ; Increment the pointer for input string
            jmp input  ; Jump back to the input loop
    
    end_input:
    
    output:
        ; Printing the count of vowels            
        call new_line
        lea dx, vowmsg  ; Load the offset address of vowmsg into the dx register
        mov ah, 09h     ; Set ah to 09h (display string function)
        int 21h         ; Invoke DOS interrupt 21h to display the vowmsg string
        
        mov dl, vowel   ; Move the count of vowels into the dl register
        mov ah, 2       ; Set ah to 2 (display character function)
        int 21h         ; Invoke DOS interrupt 21h to display the count of vowels
        
        ; Printing the count of consonants            
        call new_line
        lea dx, conmsg  ; Load the offset address of conmsg into the dx register
        mov ah, 09h     ; Set ah to 09h (display string function)
        int 21h         ; Invoke DOS interrupt 21h to display the conmsg string
        
        mov dl, consonant  ; Move the count of consonants into the dl register
        mov ah, 2       ; Set ah to 2 (display character function)
        int 21h         ; Invoke DOS interrupt 21h to display the count of consonants
        
        ; Printing the count of digits            
        call new_line
        lea dx, digmsg  ; Load the offset address of digmsg into the dx register
        mov ah, 09h     ; Set ah to 09h (display string function)
        int 21h         ; Invoke DOS interrupt 21h to display the digmsg string
        
        mov dl, digit   ; Move the count of digits into the dl register
        mov ah, 2       ; Set ah to 2 (display character function)
        int 21h         ; Invoke DOS interrupt 21h to display the count of digits
        
        ; Printing the count of spaces            
        call new_line
        lea dx, spamsg  ; Load the offset address of spamsg into the dx register
        mov ah, 09h     ; Set ah to 09h (display string function)
        int 21h         ; Invoke DOS interrupt 21h to display the spamsg string
        
        mov dl, space   ; Move the count of spaces into the dl register
        mov ah, 2       ; Set ah to 2 (display character function)
        int 21h         ; Invoke DOS interrupt 21h to display the count of spaces
    
    end_output:
    
    exit:
        mov ah, 4ch     ; Set ah to 4ch (exit program function)
        int 21h         ; Invoke DOS interrupt 21h to exit the program
        
main endp

new_line proc
    mov ah, 2         ; Set ah to 2 (display character function)
    mov dl, 0ah       ; Set dl to 0ah (ASCII value for line feed)
    int 21h           ; Invoke DOS interrupt 21h to display a line feed
    
    mov dl, 0dh       ; Set dl to 0dh (ASCII value for carriage return)
    int 21h           ; Invoke DOS interrupt 21h to display a carriage return
    
    ret               ; Return from the procedure

new_line endp

end main

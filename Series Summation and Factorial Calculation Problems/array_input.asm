                         .model small
.stack 100h
.data
    array db 5 dup(?)    ; Array to store values
    arraySize equ 5     ; Number of elements in the array
    buffer db 6 dup(?)  ; Buffer to store the converted strings
    msg db 'Enter values for the array: $'
    msg2 db 0ah,0dh,'Input String: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Display message to prompt user for input
    lea dx, msg       ; Load the offset of the message into the dx register
    mov ah, 9         ; Function code 9 - Display string
    int 21h           ; Call interrupt 21h to display the message
    
    ; Take input from the user and populate the array
    mov cx, arraySize   ; Counter for the loop
    lea si, array       ; Load the offset of the array into the di register
    
    inputLoop:
        call readChar    ; Call the readChar subroutine to read a single character from the user
        mov [si], al     ; Store the input character in the current element of the array
        inc si           ; Move to the next element in the array
        loop inputLoop   ; Repeat until all elements are populated
    
    ; Display the array elements
    mov cx, arraySize   ; Counter for the loop
    lea si, array       ; Load the offset of the array into the si register
    
    mov ah,9
    lea dx,msg2
    int 21h
    
    displayLoop:
        mov al, [si]        ; Load the value at [si] into al
        mov dl, al          ; Load the offset of the buffer into the dx register
        mov ah, 2           ; Function code 9 - Display string
        int 21h             ; Call interrupt 21h to display the digit
        
        inc si              ; Move to the next element in the array
        loop displayLoop    ; Repeat until all elements are displayed
    
    mov ah, 4ch     ; Function code 4Ch - Terminate program
    int 21h         ; Call interrupt 21h to terminate the program
    
main endp

; Subroutine to read a single character from the user
readChar proc
    mov ah, 1     ; Function code 1 - Read character
    int 21h       ; Call interrupt 21h to read a character
    ret
readChar endp

end main
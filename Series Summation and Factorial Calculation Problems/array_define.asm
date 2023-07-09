.model small
.stack 100h
.data
    array db 1, 2, 3, 4, 5  ; Array with default values
    arraySize equ 5         ; Number of elements in the array
    buffer db 6 dup(?)      ; Buffer to store the converted strings
    msg db 'Input String: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Display message to prompt user for input
    lea dx, msg       ; Load the offset of the message into the dx register
    mov ah, 9         ; Function code 9 - Display string
    int 21h           ; Call interrupt 21h to display the message
    
    ; Display the array elements
    mov cx, arraySize   ; Counter for the loop
    lea si, array       ; Load the offset of the array into the si register
    
    displayLoop:
        mov al, [si]        ; Load the value at [si] into al
        mov dl, al          ; Load the offset of the buffer into the dx register
        add dl, 48          ; Convert the value to ASCII character
        mov ah, 2           ; Function code 2 - Display character
        int 21h             ; Call interrupt 21h to display the digit
        
        inc si              ; Move to the next element in the array
        loop displayLoop    ; Repeat until all elements are displayed
    
    mov ah, 4ch     ; Function code 4Ch - Terminate program
    int 21h         ; Call interrupt 21h to terminate the program
    
main endp

end main

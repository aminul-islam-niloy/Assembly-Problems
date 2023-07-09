.model small
.stack 100h

.data
    input dw 'Enter N number (0-3): $'
    output dw ,10,13, 'Factorial: $'  
    res dw 1
    

.code
main proc
    mov ax, @data       ; Move the segment address of the data segment
    mov ds, ax          ; Point the data segment register to the data segment

    ; Load input text
    mov ah, 9
    lea dx, input
    int 21h

    ; Take input
    mov ah, 1
    int 21h             ; Input contains the value in AL register
    sub al, 48         ; Convert to ASCII

    ; Calculate factorial
    mov bl, al          ; Save the input value in BL
    mov cl, al          ; Loop counter

    mov ax, 1           ; Initialize result to 1

    factorial_loop:
        mul bl          ; Multiply AX by the current value in BL
        dec bl          ; Decrement BL
        loop factorial_loop

    ; Display the result
    mov dx, ax          ; Move the result to DX
    add dx, 48         ; Convert to ASCII  
    
    mov res,dx
    
    
    mov ah, 9
    lea dx, output
    int 21h

    mov dx, res          ; Display the high byte of DX (ASCII value)
    mov ah, 2
    int 21h

    mov dl, dl          ; Display the low byte of DX (ASCII value)
    int 21h

    mov ah, 4Ch         ; Exit program
    int 21h
main endp
end main

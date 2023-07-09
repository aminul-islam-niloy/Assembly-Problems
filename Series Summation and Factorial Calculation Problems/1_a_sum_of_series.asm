; sum of series

.model small
.stack 100h

.data 

    input db 'Enter number between 1-3 : $'   
    output db ,10,13, 'Sum of number is : $'  
    
    a db ?
    b db 2
    
 .code 
 
    main proc 
        
        mov ax,@data ;moves the segment address of the data segment
        mov ds,ax    ;data segment register to point to the data segment
        
        ;load input text
        mov ah,9
        lea dx,input
        int 21h
        
        ;take input
        
        mov ah,1
        int 21h   ; input contain in al register
        sub al,48 ; convert to ascii
        
        ;sum operation
        
        mov a,al
        inc a
        mul a
        div b
        mov a,al    
        
        mov ah,9
        lea dx,output 
        int 21h
        
        mov dl,a
        add dl,48
        mov ah,2 
        int 21h
        
      main endp
    end main
        
        
        
        
        
        
        
    
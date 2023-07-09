; sum of series

.model small
.stack 100h

.data 

    input dw 'Enter N number : $'   
    output dw ,10,13, 'Sum of number is : $'  
    
    Res dw ?
    I dw 1
    
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
        mov cx,0
        mov cl,al   ;loop counter contain in cl
        
        mov bx,0
        mov dx,0
        
        sum:
            add bx,I 
            inc I
            loop sum
            
            mov Res,bx
            
            
        
        mov ah,9
        lea dx,output 
        int 21h
        
        mov dx,Res
        add dx,48
        mov ah,2 
        int 21h
        
      main endp
    end main
        
        
        
        
        
        
        
    
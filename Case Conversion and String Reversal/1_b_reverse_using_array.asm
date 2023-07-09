.model small
.stack 100h
.data
       array      db 100 dup('$')
       len        dw 0
       input_msg  db "input :$"
       output_msg db "output:$"

.code
      main proc
                mov  ax, @data
                mov  ds, ax
      
      
                lea  dx, input_msg
                mov  ah,9
                int  21h
         
       ;loop input
                mov  si, offset array
                inc  si  
                 
       ; base address of array is loaded into the si register,
       ; and then si is incremented by 1. This prepares si
       ; to point to the first element of the array.         
                
                
       repeat:  
                mov  ah, 1
                int  21h
                cmp  al, 13
                je   break
         
                mov  array[si], al
                inc  si
                inc  len
                jmp  repeat
  
       break:   
       ;new line
                call new_line
      
                lea  dx, output_msg
                mov  ah,9
                int  21h
       ;loop reverse output
                mov  si, offset array
                add  si, len 
                
       ;The si register is set to point to the last character 
       ;of the string in array by adding len (the length of the string)
       ; to the offset of array. 
       
       output: 
       
                mov  dl, [si]
                cmp  dl, '$'
                je   stop  
                
       ;the character at the current position pointed to by si
       ; is loaded into the dl register.
         
                mov  ah, 2
                int  21h
        
                dec  si
                jmp  output

       stop:    
                mov  ah, 4ch
                int  21h

main endp

new_line proc
                mov  ah, 2
                mov  dl, 10
                int  21h
                mov  dl, 13
                int  21h
                ret
new_line endp

end main

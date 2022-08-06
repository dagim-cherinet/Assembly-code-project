
.model small
.stack 100
.data
     crlf           db 0DH,0AH,'$'
     prompt1        db "Enter ten three digit integers smaller than 255: $"
	 prompt3        db "The values stored in B: $" 
	 prompt4        db 0ah, 0dh,"The maximum number: is $"
	 invalidPrompt  db 0ah, 0dh,"**you are tying to enter a number greater than 255 or u are entering alphabets $**" 
	 ascending      db 0ah, 0dh,"Asencending order:->$"
	 descending     db 0ah, 0dh,"Dsencending order:->$"
	 minimum        db 0ah, 0dh,"The minimum number: is $"
	 num            db 10 Dup(?)
	 
.code 
main proc far
     mov ax,@data
     mov ds,ax
     LEA DX,prompt1   ;display prompt1
	 mov ah,09h
	 int 21h
	 mov CX,10
	 mov di,0
EnterFirst: 	 
	 Mov bh,100
     mov dl,0
	 mov bl,0
	 mov dh, 10 
ThreeDigit: 
     mov ah,01h
	 int 21h               ;                        
	 sub al,30h 
	 cmp bh, 100            
	                         cmp bh, 100
	                         je  test1
							 cmp al, 39h ;compare with 9
							 ja exit4
							 cmp al, 30h ;compare with 0
                             jmp continue 
						   
   continue:  
            mul bh
            add dl,al 
            jc exit4
		    jmp continue2
   test1:   cmp al, 2 ;
            ja exit4
		    jbe continue
   exit4:   LEA DX,invalidPrompt  ;display you are tying to entered a num 255
	        mov ah,09h
	        int 21h 
	        mov ah, 4ch
            int 21h
   continue2: 
	        mov al,bh
	        mov ah,0
	        div dh
	        mov bh,al
	        sub bh,0       
	        JNZ ThreeDigit
	        mov num[di],dl
	        inc di
	        mov dl,20h
	        mov ah,02h
	        int 21h
	        loop EnterFirst
	        lea dx,crlf
	        mov ah,09h
	        int 21h
 
	mov ah, 09h
	lea dx, prompt4    ;display the max number is
	int 21h
	
	                            mov cx, 10
	                             mov di, 0 
	                             mov bl, 0
	                         comp:
	                             mov al, num[di]
	                             cmp al, bl
	                             jb below
	                             mov bl, al
	                         below:
	                             inc di
	                             dec cx
	                             jnz comp
	                             
	                             mov al, bl
	 
 
	 mov bh,100
	 mov bl,10
	 mov ah,0
	 mov dh,0
	 
	 display: 
     div bh	
	 mov dh,ah
     add al,30h	 
	 mov dl,al
	 mov ah,02h
	 int 21h  
	 mov ah,0
	 mov al,bh
	 div bl
	 mov bh,al
	 mov al,dh
	 sub bh,0
	 JNZ display  
	; jmp exit     
	
	
	;ascending procudeure
	
	 LEA DX,ascending   ;display ascending
	 mov ah,09h
	 int 21h
	
	         xor ax, ax      
	         mov bl, al
			  mov cl, al
			 lea si, num
			 mov bl, 10
			 
			 dec bl
	
	l3: 
	     mov cl, bl
	    lea si, num
	l2: mov al, [si]
	    cmp al, [si + 1]
		jbe l1
		xchg al, [si + 1]
		mov [si], al 
	    
	l1: inc si 
	    loop l2
		dec bl 
		jnz l3 
	 
	 mov cx, 10
	 mov si, 0             
	 
	  mov di,0
displayOUTER:	 
	 mov bh,100
	 mov bl,10
	 mov ah,0
	 mov dh,0
	 mov al,num[di]
display2: 
     div bh	
	 mov dh,ah
     add al,30h	 
	 mov dl,al
	 mov ah,02h
	 int 21h  
	 mov ah,0
	 mov al,bh
	 div bl
	 mov bh,al
	 mov al,dh
	 sub bh,0
	 JNZ display2
	 
	 mov dl,20h
	 mov ah,02h
	 int 21h
	 
	 inc di
	 dec cx
	 jnz displayOUTER

    ; jmp exit  
     
     
  ;descending order 
  mov cx, 10  
     
   mov ah, 09h
   lea dx, descending
   int 21h  
        	 
	  mov di,9
disp3:	 
	 mov bh,100
	 mov bl,10
	 mov ah,0
	 mov dh,0
	 mov al,num[di]
display3: 
     div bh	
	 mov dh,ah
     add al,30h	 
	 mov dl,al
	 mov ah,02h
	 int 21h  
	 mov ah,0
	 mov al,bh
	 div bl
	 mov bh,al
	 mov al,dh
	 sub bh,0
	 JNZ display3
	 
	 mov dl,20h
	 mov ah,02h
	 int 21h
	 
	 dec di
	 dec cx
	 jnz disp3
	 
     mov ah, 09h
     lea dx, minimum
     int 21h
   
  
     mov al, num[0] 
     mov bh,100
	 mov bl,10
	 mov ah,0
	 mov dh,0
	 
	 displaymin: 
     div bh	
	 mov dh,ah
     add al,30h	 
	 mov dl,al
	 mov ah,02h
	 int 21h  
	 mov ah,0
	 mov al,bh
	 div bl
	 mov bh,al
	 mov al,dh
	 sub bh,0
	 JNZ displaymin  
     jmp exit
exit: mov ah, 4ch
      int 21h
main endp
     end main











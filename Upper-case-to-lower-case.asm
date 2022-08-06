.model small
.stack 67
.data
menu     db 0ah, 0dh,'-> MAIN MENU$'
message  db 0ah, 0dh,'1) PRESS 1 for UPPER to lower case $'  
message1 db 0ah, 0dh,'2) PRESS 2 for lower to UPPER case $'
message2 db 0ah, 0dh,'>ENTER THE UPPER-CASE SENTENCE  $' 
message3 db 0ah, 0dh,'>ENTER the lower-case sentence  $'
invalid1 db 0ah, 0dh,"***INVALID INPUT***$"
above    db 0ah, 0dh,'**YOU ENTERED MORE THAN 50 CHARACTERS** please enter correctly$'

correct  db 0ah, 0dh,'Your sentence becomes--> $'
sentence db 50 dup('$')                                    
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax  

MOV CX, 0 


main_menu:      mov ah, 09h
                lea dx, menu
				int 21h
output_message: mov ah, 09h
                lea dx, message
                int 21h 
output_message1:mov ah, 09h
                lea dx, message1
                int 21h 
				      
taking_input: mov ah, 1h
              int 21h
			          
     cmp al, 31h       ;comparing the input with 1
     je upper_to_lower 
	 cmp al, 32h       ;comparing the input with 2
     je lower_to_upper 
	 jmp invalid
invalid: mov ah, 09h
         lea dx, invalid1
		 int 21h
         jmp exit
upper_to_lower:
 

MOV CX, 0 
lea di, sentence 

                mov ah, 09h
                lea dx, message2
                int 21h 
                     
input1: mov ah, 1h
        int 21h
        cmp al, 0dh ; whether the key entered was enter key or not 
        jne save1 
        je print1
        
save1: stosb
         
       INC CX  ;counting the number of characters(for every input cx increments)
       cmp cx, 49
	   ja above_501
	   jmp input1 
above_501: mov ah, 09h
          lea dx, above
          int 21h
          jmp exit

print1: 
        mov ah, 09h
         lea Dx, correct
         int 21h 
         mov si, 0
		
 again:  mov dl, sentence[si]
         cmp dl, 40h          ;comparing with A
		 jb symbol
		 cmp dl, 5ah          ;comparing with Z                  
		 ja symbol
		 jmp letter
letter:  add dl, 20h          ;changing into a lower-case
         jmp print	
symbol:	  
		
		 jmp print
print:         
     mov ah, 2h
	 int 21h
	 inc si
	 loop again 
     jmp exit   

               
lower_to_upper:  
 
lea di, sentence 

                 mov ah, 09h       ; lower-case to uppercase
                 lea dx, message3
                 int 21h
                      
input2:  mov ah, 1h
         int 21h
         cmp al, 0dh ; whether the key entered was enter key or not 
         jne save2 
         je print2
                          
save2: stosb
          
         INC CX
		 cmp cx , 50d
		 ja above_502
         jmp input2 
above_502: mov ah, 09h
          lea dx, above
          int 21h
		  jmp exit

         		  
             
print2:
         mov ah, 09h
         lea Dx, correct
         int 21h 
         mov si, 0
 again2:     
         mov dl, sentence[si]
         cmp dl, 60h          ;comparing with a
		 jb symbol2
		 cmp dl, 7ah          ;comparing with z                  
		 ja symbol2
		 jmp letter2
letter2:
         sub dl, 20h          ;changing into a upper-case
         jmp print3
symbol2:	  
         mov ah, 2h
		 jmp print3
												
 print3:         
    mov ah, 2h
	int 21h
	inc si
	loop again2  

exit: mov ah, 4ch
int 21h
main endp
     end main








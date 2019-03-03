INCLUDE Irvine32.inc
    
 .data
    ArrayforPrime dd 1000 dup(0);    INITIALIZES ARRAY T0 0
	prim1 byte "There are ",0
	prim11 byte " primes between 2 and n (n = ",0
	prim12 byte " )",0
	prim3 byte "Prime Numbers are :",0
	primmenu byte "Please enter a number (less than 1000) : ",0
	primerror byte "Number is either negative or too large, please enter a number between 2 and 1000 !! ",0
	primespace byte "    ",0
	countno dword 0d
	primeLmit dword 0d
	
	.code

main PROC  
	  mov edx, offset primmenu
	  invoke writestring
	  call readint
	  mov primeLmit, eax
	  ;call writedec
	  mov esi, offset primeLmit
	  mov edx, offset prim3
	  call writestring
	  call crlf
      xor ecx, ecx 
	  fillArrayLoop:        ;  fill array with numbers                      
	  mov eax, ecx                

        add eax, 2        ; prime number start from 2  
        mov [ArrayforPrime+4*ecx], eax      
        inc ecx                          
        cmp ecx, primeLmit          
        jb fillArrayLoop
        xor ecx, ecx
    ; take a number at a time from ArrayforPrime            

   FirstLoop:                               
        mov ebx, ecx                
		inc ebx                          
		cmp [ArrayforPrime+4*ecx], -1       
        jne SecondLoop
		
	restart1: 
	inc ecx                      
    cmp ecx, primeLmit          
	jb FirstLoop                    
	jmp exit1               

   SecondLoop:                               
        cmp [ArrayforPrime+4*ebx], -1       
		jne ThirdLoop
		                    
	restart2:                   
	inc ebx                          
	cmp ebx, primeLmit          
	jb SecondLoop                    
	jmp restart1                     

;CHECK IF NUMBER IS PRIME OR NOT

     ThirdLoop:                               
         xor edx, edx                
         xor eax, eax                
         mov eax, [ArrayforPrime+4*ebx]      
         div [ArrayforPrime+4*ecx]           
         cmp edx, 0                       
         je Failure                    
                                         
     restart3:                   
     jmp restart2                     
     


   Failure:
          mov [ArrayforPrime+4*ebx], -1   ;indicate non prime number by -1  
          jmp restart3    
		  

		ArrayPrimePrint:     
    push ecx      
	mov eax, [ArrayforPrime+4*ecx]
	call writedec
		mov edx, offset primespace
	call writestring
	inc countno
	cmp countno, 5
	je nextline
	jne processit
	nextline: 
	Call crlf
	mov countno, 0
	processit:
    inc ebx                          
    pop ecx     

    jmp runagain   ;resume where we left in printArrayforPrime   
       
	exit1:                   
	;REMOVING 0
	xor ecx, ecx
	;REMOVING 0                      
	xor ebx, ebx                     

	DisplayPrimes:     	
	cmp [ArrayforPrime+4*ecx], -1       
	jne ArrayPrimePrint
	runagain:           
	inc ecx                          
	cmp ecx, primeLmit          
	jb DisplayPrimes  
	
	call crlf
   mov edx, offset prim1
   call WriteString
   ;print str$(primeLmit)
    mov eax, ebx
   call writedec
   mov edx, offset prim11
   call WriteString
   mov edx, offset primeLmit
   call Writedec
   mov edx, offset prim12
   call WriteString
   ;print str$(ebx), 10, 13
   call crlf


  
   ret
main ENDP
end Main
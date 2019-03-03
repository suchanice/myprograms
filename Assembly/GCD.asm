;Sucharita Das
; HW8 - GCD
Include Irvine32.inc

.data
str1 byte "Enter first number for GCD (greater than 2): ",0
str2 byte "Enter second number for GCD  (greater than 2): ",0
str3 byte "Greatest Common Divisor is: ",0
str4 byte "Do you wish to enter another pair (Enter 1 for Yes/ 2 for No): ",0
str5 byte "Your opted not to play ! Exiting the program...... ",0
str6 byte "The GCD (Greatest Common Divisor is Prime). ",0
str7 byte "The GCD (Greatest Common Divisor is NOT Prime).",0
userinput byte 0h
number1 dword 0d
number2 dword 0d
primeno dword 0d
primecomp dword 2d


.code
main PROC

startagain:
mov edx, offset str1
call writestring
call readint
mov number1, eax
mov edx, eax
mov edx, offset str2
call writestring
call readint
mov number2, eax
mov ebx, eax
call gcd
mov edx, offset str3
call writestring
call writedec
mov primeno, eax
call crlf
jmp primecheck
call crlf

restart:
mov edx, offset str4
call writestring
pop edx
call readhex
cmp al, 1
je startagain
mov edx, offset str5
call writestring
exit


primecheck :				;-------Top of loop--------------
mov	edx, 0				;divide number we are checking
mov	eax, primeno
cmp primeno,1
je printPrimes
mov	ecx, primecomp
div	ecx

	cmp	edx, 0				;if evenly devided, check if prime
	je	checkQuo
								;else 
	inc	primecomp
	jmp	primecheck			;back to top if not evenly divisable


			checkQuo:
				cmp	eax, 1				;remainder is 0, if quotent == 1, its prime
				je	printPrimes
				jmp	notPrime			;else, its not prime


			printPrimes:					;prints prime
			mov edx, offset str6
			call writestring
			call crlf
			jmp done

			notPrime:						;moves on to check next number
			mov edx, offset str7
			call writestring
			call crlf
			jmp done

	done:
	xor ecx, ecx
	;REMOVING 0                      
	xor ebx, ebx  
	xor edx, edx
	jmp restart


gcd proc
pop edi
pop eax
pop ebx
mov eax, number1
mov ebx, number2
gcd1:
mov edx,0
div ebx
mov eax,ebx
mov ebx,edx
cmp ebx,0
jg gcd1
push edi
ret
gcd endp
main ENDP
END main
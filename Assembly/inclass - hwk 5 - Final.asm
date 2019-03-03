TITLE inclassMENU.asm
; Author:  Sucharita Das
; Date:  25 Oct 2018
; Description: This program presents a menu allowing the user to pick a menu option
;              which then performs a given task.
;			   If the user has not entered a string, options 2 through 5 can not be
;			   accomplished and the user should be prompted to enter a string.
;			   The palidrome check should not be case-sensitive or care about punctuation,
;			   to include spaces.The user will be allowed to enter a string containing any
;              symbol or number on the standard QWERTY keyboard.
;			   When option 5 is selected, print the existing string(modified by other options or not)
;			   Option 4 prints the string and informs the user if the string is a palindrome or not.
;			   With options 2 - 3, print the string received by the option, and
;              then the resulting string.
;			   The max string length must be a symbolic constant and used where necessary.
; Option Definitions
; 1.  The user enters a string of no more than 100 characters.
; 2.  The entered string is converted to lower case.
; 3.  The entered string has all non - letter elements removed except numbers.
; 4.  Is the entered string a palindrome?  
; 5.  Print the string.
; 6.  Exit
; ====================================================================================

;// Your assignment is to implement all remaining functionality and error checking as required. 
;// Remember this code allows the user to keep entering strings until


Include Irvine32.inc 

;//Macros
ClearEAX textequ <mov eax, 0>
ClearEBX textequ <mov ebx, 0>
ClearECX textequ <mov ecx, 0>
ClearEDX textequ <mov edx, 0>
ClearESI textequ <mov esi, 0>
ClearEDI textequ <mov edi, 0>
Newline  textequ <0ah, 0dh>
maxLength = 101d

.data

UserOption byte 0h
theString byte maxLength dup(0)	;		// declares the array to be used throughout the program.
theStringLen byte 0
errormessage byte 'You have entered an invalid option. Please try again.', Newline, 0h
;str byte maxLength dup(0)	
UserInput Byte 0h

str1 db 'MADAM','$'  
  strlen1 dw $-str1
  strrev db 20 dup(' ')
  str_palin db 'String is Palindrome.','$'
  str_not_palin db 'String is not Palindrome.','$'




.code
main PROC

call ClearRegisters          ;// clears registers
startHere:

mov ebx, OFFSET UserOption
call displayMenu

mov edx, offset theString
mov ecx, lengthof theString   ;//length of the string

opt1:
cmp useroption, 1
jne opt2                      ;//jump if not equal
mov ebx, offset thestringlen  ;// will hold the length of the entered string
call option1         
jmp starthere

opt2:
cmp useroption, 2
jne opt3
movzx ecx, thestringlen
call option2
jmp starthere

opt3:
cmp useroption, 3
jne opt4                           ; if not option 3 go to option 4
; mov edx, OFFSET theString            ; offset of string
movzx ecx, theStringLen            ; length of string
call option3      
jmp starthere


opt4:
cmp useroption, 4
jne opt5
movzx ecx, thestringlen
call option4
jmp starthere


opt5:
cmp useroption, 5
jne opt6
call option5
call waitmsg
jmp starthere

opt6:
cmp useroption, 6
jne oops ;// invalid entry
jmp quitit

;// error check
oops:
push edx
mov edx, offset errormessage
call writestring
call waitmsg
pop edx
jmp starthere

quitit:
exit
main ENDP

;// Procedures
;// ===============================================================
DisplayMenu Proc
;// Description:  Displays the Main Menu to the screen and gets user input
;// Receives:  Offset of UserOption variable in ebx
;// Returns:  User input will be saved to UserOption variable

.data
MainMenu byte 'MAIN MENU', 0Ah, 0Dh,
'==========', 0Ah, 0Dh,
'1. Enter a String:', 0Ah, 0Dh,
'2. Convert all elements to lower case: ',0Ah, 0Dh,
'3. Remove all non-letter elements: ',0Ah, 0Dh,
'4. Determine if the string is a palindrome: ',0Ah, 0Dh,
'5. Display the string: ',0Ah, 0Dh,
'6. Exit: ',0Ah, 0Dh, 0Ah, 0Dh,
'Please enter a number between 1 and 6 -->', 0h
.code
push edx  				 ;// preserves current value of edx
;call clrscr
mov edx, offset MainMenu ;// required by WriteString
call WriteString
call readhex			 ;// get user input
mov byte ptr [ebx], al	 ;// save user input to UserOption
pop edx    				 ;// restores current value of edx

ret
DisplayMenu ENDP



ClearRegisters Proc
;// Description:  Clears the registers EAX, EBX, ECX, EDX, ESI, EDI
;// Requires:  Nothing
;// Returns:  Nothing, but all registers will be cleared.

cleareax
clearebx
clearecx
clearedx
clearesi
clearedi

ret
ClearRegisters ENDP
;// ---------------------------------------------------------------
option1 proc uses edx ecx
;// Description: Gets string from user.
;// Receives:  Address of string
;// Returns:   String is modified and length of entered string is in saved in theStringLen


.data
option1prompt byte 'Please enter a string of characters (', maxLength, ' or less): ', newline, '--->   ', 0h

.code
push edx       ;//saving the address of the string pass in.
mov edx, offset option1prompt
call writestring
pop edx

;//add procedure to clear string (loop through and place zeros)

call readstring
mov byte ptr [ebx], al     ;//length of user entered string, now in thestringlen

ret
option1 endp



option2 proc uses edx 
;// Description:  Converts all elements to lower case
;// Receives:  address of string in edx
;// Returns:  noting, but string is now lower case.
.data
opt2prompt1 byte "Original :", newline , 0
opt2prompt2 byte "Modified :", newline,0
.code
push edx
mov edx, offset opt2prompt1
call writestring
pop edx
call option5
call crlf
push edx
L2:
mov al, byte ptr [edx+esi]
cmp al, 41h
jb keepgoing  ;// not a letter
cmp al, 5ah
ja keepgoing  ;// not a letter
;//have changed into add from or then it is working to convert into lowercase
add al, 20h     ;//could use add al,  to convert to lower case.
mov byte ptr [edx+esi], al ;// letter now lower case
keepgoing:
inc esi
loop L2
mov edx, offset opt2prompt2
call writestring
pop edx
call option5
call waitmsg
ret
option2 endp

option5 proc
;// Description:  Displays the string.
;// Receives: address of string in edx
;// Returns:  nothing


.data
option5prompt byte 'The String is: ', 0h
.code
push edx	;// save the address of the string to write prompt
mov edx, offset option5prompt
call writestring
pop edx
call writestring ;// write the string
call crlf

ret
option5 endp




option3 proc uses edx 
.data
opt3prompt1 byte "Original :", newline , 0
opt3prompt2 byte "Modified :", newline,0
.code
push edx
mov edx, offset opt3prompt1
call writestring
pop edx
call option5
call crlf
push edx
L2:
mov al, byte ptr [edx+esi]
cmp al, 41h
jb keepgoing  ;// not a letter
cmp al, 5ah
ja keepgoing  ;// not a letter
;//have changed into add from or then it is working to convert into lowercase
add al, 20h     ;//could use add al,  to convert to lower case.
mov byte ptr [edx+esi], al ;// letter now lower case
keepgoing:
inc esi
loop L2
mov edx, offset opt3prompt2
call writestring
pop edx
call option5
call waitmsg
ret
option3 endp



option4 proc uses edx 
.data
target  byte  SIZEOF theString DUP(0), 0      

.code
    pushad
    mov edx, offset theString
    call writestring
    call CrlF
    mov edx, 0

    mov  esi, offset theString 
    mov  edi, offset target      
L1:
    mov  al, [ esi ]          ; get character from theString

    cmp  al, 0
    je   final

    cmp  al, 65
    jb   not_letter    ; if char is lower than 'A' jump to not letter
    cmp al, 122
    ja  not_letter     ; if char is greater than 'z' jump to not letter

    cmp al, 90
    ja Label1           ; jump if above 'Z'
    jmp next            ; false
    Label1:
    cmp al, 97
    jl Label2           ; jmp if less than 'a'
    jmp next            ; false
    Label2:             ; if both are true than is greater than 'Z' but less than 'a'
    jmp not_letter      ; jump to not letter

    next:
    mov  [ edi ], al
    inc  di                ; position to next character.

    not_letter:
    inc  si                ; move to next character
    jmp  L1

    final:
    mov  [ edi ], al     

    mov  edx, OFFSET target
    mov  ah, 9
    call WriteString
    call CrlF


    popad
;exit
;call waitmsg
ret
option4 endp


END main


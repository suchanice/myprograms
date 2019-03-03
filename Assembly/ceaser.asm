TITLE ceaser.asm
; Author:  Sucharita Das
; Date:  3rd Nov 2018

;Assignment 6 (pa6.asm)
;NOTE: The word shift is used in the problem statement, but this does not refer to the SHIFT instructions in Assembly. Instead it refers to the shift/rotation involved with the Caesar Cipher.
;The goal of this assignment is to create an encryption/decryption system.
;A menu will be shown asking the user if they wish to encrypt or decrypt a message.
;If a phrase already exists in the system, ask the user if they wish to encrypt or decrypt that phrase or enter a new one. If a key has already been entered, then ask if they wish to enter a new key or using the existing one. This suggests that the program may be used more than once prior to exiting. This should be accounted for in your code.
;You will need to convert the entered phrase to be encrypted into all uppercase (ChangeCase PROC). You will also need to remove all non-letter elements (LettersOnly PROC). (YES you may use pre-existing code)So that you are only encrypting/decrypting letters. The Key can be any combination of Alphanumeric characters and any symbol on the keyboard.
;The encryption/decryption method is a variation of the Caesar Cipher (https://en.wikipedia.org/wiki/Caesar_cipher). The encryption/decryption key will be a word entered by the user and can be made of any symbol on the keyboard. The key will not be modified. The ASCII value of each element of the key will be used to determine how far to shift/rotate
;the corresponding letter of the phrase to be encrypted to the right. Decrypting a word/phrase will require a shift/rotate to the left. Requires two proc’s: encrypt PROC and decrypt PROC
;You MUST take the modulus base 1A16 of the ASCII hex value of each letter of the key to see how far to shift each letter of the word/phrase to be encrypted/decrypted.
;There is no modulus instruction in ASSEMBLY, but there is something you can use instead. If you don’t know what the modulus is, you can find more information at https://en.wikipedia.org/wiki/Modulo_operation.
;After Encrypt/Decrypt is executed the resulting phrase must consist of capital letters.
;The key may be shorter than the word/phrase to be encrypted/decrypted. If this is the case, the key repeats.
;The encrypted/decrypted word/phrase will be printed out in the following format. 5 letters then a space then 5 letters etc. This means you CAN NOT use WRITESTRING from the Irvine Library to print out your result. You will have to write your own procedure. (Printit PROC) See example below. You can use WRITESTRING to print prompts, etc.
;***** ***** ***** Where each * represents a letter.
;You may safely assume the user will not enter a string longer than 150 characters for either the phrase or the key. If the user does enter a string longer than 150 characters, just truncate it.
;All necessary procedures will be passed using registers. You may NOT pass variables on the stack at this time.

; ====================================================================================

;// Your assignment is to implement all remaining functionality and error checking as required. 
;// Remember this code allows the user to keep entering strings until


Include Irvine32.inc 
Include Macros.inc
BufSize = 100

;//First let us clear the register
ClearEAX textequ <mov eax, 0>
ClearEBX textequ <mov ebx, 0>
ClearECX textequ <mov ecx, 0>
ClearEDX textequ <mov edx, 0>
ClearESI textequ <mov esi, 0>
ClearEDI textequ <mov edi, 0>
Newline  textequ <0ah, 0dh>
maxLength = 101d

.data
; starting to declare variables
UserOption byte 0h
theString byte maxLength dup(0)	;		// declares the array to be used throughout the program.
theString1 byte maxLength dup(0)	;		// declares the array to be used throughout the program.
thekey byte maxLength dup(0)	;		// declares the array to be used throughout the program.
theStringLen byte 0
thekeyLen byte 0
Arrayk BYTE 6,4,1,2,7,5,2,4,3,6
errormessage byte 'You have entered an invalid option. Please try again.', Newline, 0h
;str byte maxLength dup(0)	
UserInput Byte 0h
target  byte  SIZEOF theString DUP(0), 0  
option6prompt byte 'Please enter a string of characters  --->   ', 0h
optionkeyprompt byte 'The Key is (please enter the key): ', 0h
mWriteln "Write a text to be encrypted."
buffer BYTE BufSize DUP(?),0,0
 

.code
main PROC

call ClearRegisters          ;// clears registers
startHere:

mov ebx, OFFSET UserOption
call displayMenu

mov edx, offset theString
mov ecx, lengthof theString   ;//length of the string


opt1:   ; Option 1 to read the string
cmp useroption, 1
jne opt2                      ;//jump if not equal
mov ebx, offset thestringlen  ;// will hold the length of the entered string
call option1         
jmp starthere

opt2:   ; Option 2 to convert the string to uppercase
cmp useroption, 2
jne opt3
movzx ecx, thestringlen
call ChangeCase
jmp starthere

opt3:      ;  Option 3 to remove all non letter characters
cmp useroption, 3
jne opt4                           ; if not option 3 go to option 4
; mov edx, OFFSET theString            ; offset of string
movzx ecx, theStringLen            ; length of string
call LettersOnly   
jmp starthere

opt4:    ; option 4 to read the key
cmp useroption, 4
jne opt5                           ; if not option 4 go to option 5
push edx       ;//saving the address of the string pass in.
mov edx, offset optionkeyprompt
call writestring
pop edx
call readstring
mov esi, offset thekey
call writestring
call crlf
jmp starthere

; option 5 to display the modified string (upper case and all non letter characters removed)
opt5:    
cmp useroption, 5
jne opt6
call option51
call waitmsg
jmp starthere

; option 7 and 8 for encrypt and decrypt

opt6:
cmp useroption, 6
jne opt7
   MOV EDX, OFFSET target ; getting the string and the size
   MOV ECX, SIZEOF target
   mov esi, offset Arrayk
   MOV EBX, 0
   call encDecText
   call WriteString
   call Crlf
   jmp starthere

opt7:
cmp useroption, 7
jne opt8
   MOV EDX, OFFSET target  ; getting the string and the size
   MOV ECX, SIZEOF target
   mov esi, offset Arrayk
   MOV EBX, 1
   mov esi, offset Arrayk
   call encDecText
   call WriteString
   call Crlf
   jmp starthere

opt8:
cmp useroption, 8
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
; mail menu to display

.data
MainMenu byte 'MAIN MENU : Enter Your Option # :', 0Ah, 0Dh,
'==========', 0Ah, 0Dh,
'1. Enter text:', 0Ah, 0Dh,
'2. Convert the text into upper case: : ',0Ah, 0Dh,
'3. Remove all non-letter elements: ',0Ah, 0Dh,
'4. Enter the key : ',0Ah, 0Dh,
'5. Display the string: ',0Ah, 0Dh,
'6. Encrypt the string: ',0Ah, 0Dh,
'7. Decrypt the string: ',0Ah, 0Dh,
'8. Exit: ',0Ah, 0Dh, 0Ah, 0Dh,
'Please enter a number between 1 and 8 -->', 0h
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
option1prompt byte 'Please enter a string of characters  ---> : ', 0h

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

;

encDecText PROC
   ;Receives EDX - OFFSET of the text
   ; ECX - SIZE of the text
   ; ESI - OFFSET of the key
   PUSHAD
   CMP EBX, 0
   JE equals
       MOV EBX, ESI
       ADD EBX, 9 ;the length of key
       loopNotEquals:
       MOV AL, [EDX] ; value of the text
       PUSH ECX
       MOV CL, [ESI] ; value of the key
       ROR AL, CL ; ror the text by the key
       MOV [EDX], AL
       POP ECX
       CMP ESI, EBX ; if all the keys are used, reset the offset so it uses the beginning
       JE reset1      
       INC ESI      
       JMP endReset1
       reset1:
       SUB ESI, 9
       endReset1:      
       INC EDX
       loop loopNotEquals
       mWriteln 'Input decrypted.'
   JMP endCMP
   equals:
       MOV EBX, ESI
       ADD EBX, 9 ; the length of key
       loopEquals:
       MOV AL, [EDX] ; value of the text
       PUSH ECX
       MOV CL, [ESI] ; value of the key
       ROL AL, CL ; rol the text by the key
       MOV [EDX], AL
       POP ECX
       CMP ESI, EBX ; if all the keys are used, reset the offset so it uses the beginning
       JE reset2
       INC ESI      
       JMP endReset2
       reset2:
       SUB ESI, 9
       endReset2:
       INC EDX
       loop loopEquals
       mWriteln 'Input encrypted.'
   endCMP:
   POPAD
   RET
encDecText ENDP

ChangeCase proc uses edx 
;// Description:  Converts all elements to upper case
;// Receives:  address of string in edx
;// Returns:  noting, but string is now upper case.
.data
opt2prompt1 byte "Original :", newline , 0
opt2prompt2 byte "Modified in UPPERCASE:", newline,0
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
;cmp al, 41h
;jb keepgoing  ;// not a letter
;cmp al, 5ah
;ja keepgoing  ;// not a letter
cmp al, 61h
jb keepgoing  ;// not a letter
cmp al, 7ah
ja keepgoing  ;// not a letter
;//have changed into add from or then it is working to convert into lowercase
sub al, 20h     ;//could use add al,  to convert to lower case.
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
ChangeCase endp

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
push edx
mov edx, offset theString
call writestring ;// write the string
pop edx
call crlf
ret
option5 endp


option51 proc
.data
;option5prompt byte 'The String is: ', 0h
.code
push edx	;// save the address of the string to write prompt
mov edx, offset option5prompt
call writestring
pop edx
push edx
mov edx, offset target
call writestring ;// write the string
pop edx
call crlf
ret
option51 endp

; to remove all non letter from the string to keep everything with in the ascii values

LettersOnly proc uses edx 
.data
;target  byte  SIZEOF theString DUP(0), 0      
optionLettersOnlyprompt byte 'The String after removing all non-letter element is: ', 0h
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
	mov edx, offset optionLettersOnlyprompt
	call writestring
	;pop edx

    mov  edx, OFFSET target
    mov  ah, 9
    call WriteString
    call CrlF


    popad
;exit
call waitmsg

ret
LettersOnly endp




END main


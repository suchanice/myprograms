TITLE Hangman4.asm
; Author:  Sucharita Das
; Date:  14th Nov 2018

INCLUDE Irvine32.inc


ClearEAX textequ <mov eax, 0>
ClearEBX textequ <mov ebx, 0>
ClearECX textequ <mov ecx, 0>
ClearEDX textequ <mov edx, 0>
ClearESI textequ <mov esi, 0>
ClearEDI textequ <mov edi, 0>
Newline  textequ <0ah, 0dh>

.data

;endl EQU <0dh,0ah>	; end of line sequence
message BYTE "Let's play the HANGMAN game !! " ,0
messageSize DWORD ($-message)
consoleHandle HANDLE 0     ; handle to standard output device
bytesWritten  DWORD ?      ; number of bytes written
wordis byte " Word is : ",0
youentered byte " You Entered : ",0

yousurvivedthistime  BYTE "| YOU   WIN  | ",0
msgsize DWORD ($-yousurvivedthistime)
youdiedthistime BYTE "| SORRY !!  YOU  ARE DEAD !! | ",0

; random number what we generete
ranNum DWORD ?		

Syagl byte "Sorry, you alredy guessed letter, ",0Dh, 0Ah, 0
Iryomttlwyg byte "Sorry the above letter is already being guessed!!! ",0
gla byte "Guess a letter: ",0
mainmenu byte "Do you wish to guess a letter or the whole word  - (Enter 1 for letter 2 for word) :  ",0
menu0 byte "10 letter and 3 word guess remaining.",0
menu1 byte " letter and ",0
menu2 byte " word guess remaining.",0
maxLength = 101d
incorrectinput byte "Incorrect Input, please try again !!! Either put 1 or 2 ...",0
gamewon dword 0d
gamelost dword 0d
gametotal dword 0d

gametotaltext byte "Total games played : ",0
gamewontext byte "Total game won : ",0
gamelosttext byte "Total game lost : ",0
chanceletters byte "All your options with words are exhausted.You still have # of chances left with letters : ",0
chancewords byte "All your chances with letters are exhausted.You still have # of chances left with words :",0

inputword byte maxLength dup(0)
wordsize byte 0d
wordsize1 byte 0d
UserOption byte 0d
option1prompt byte "Guess the word : ",0
youwin byte "You WIN !!!",0
youtry byte "Try once again !!!", 0
sorryfailed byte "Sorry you failed, try once again !!!", 0
countleft byte "You have total of 3 chances, chances left now : ",0
wordtrycount dword 0d
donewithtry byte "You have exhausted all your options, you lost the game !!", 0
wordplaycount byte 0d
letterplaycount byte 0d

;All words what is posible to guess. 
;Pick by random generartor and put in selectedWords
manyWords	BYTE "kiwi",	0
			BYTE "canoe", 0
			BYTE "doberman", 0
			BYTE "puppy", 0
			BYTE "banana", 0
			BYTE "orange", 0
			BYTE "frigate", 0
			BYTE "ketchup", 0
			BYTE "postal", 0
			BYTE "basket", 0
			BYTE "cabinet", 0
			BYTE "mutt", 0
			BYTE "machine", 0
			BYTE "mississippian", 0
			BYTE "destroyer", 0
			BYTE "zoomies", 0
			BYTE "body", 0
			BYTE "correct", 0
			BYTE "love", 0
			BYTE "pole", 0
			BYTE "north", 0
			BYTE 0					; End of list
len equ $ - manyWords
maxLength = 101d
; number what we make to know where are you in game
statusGameLive DWORD ?		

;Wordls what we select by rundom code
selectedWords BYTE "                    ", 0
;Use as variable in funcstion for lenght of Array
lengthArray DWORD ?

;Letter what we guess, input from keyboard
guessLetter BYTE ?
;word what we print with -------,0
guessWords BYTE 50 DUP (?)
;Array of guess Letter
wordguess BYTE 50 DUP (?)
chardelete   BYTE 'A'
;Letter what are unknows, change with - 
letterDash BYTE '-'

drowDelay = 1000	; delay 1 sec
var_loop BYTE 15	; repeat 15 times
	
.code

main PROC

jump_game_start_again:
call ClearRegisters ; clearing the registers
call crlf
mov edx, offset message
call writestring 
mov letterplaycount,0  ; starting the counts
mov wordplaycount, 0
mov edx, offset menu0  ; initial menu display for number of words and letters
call writestring

  ;Part of code for generate random number from 0 until 20
	mov  eax,20d			;get random 0 to 20
	call Randomize		;re-seed generator
	call RandomRange   
	mov  ranNum,eax		;save random number
	
	call Crlf			;new line

  ;Find a selectedWords base on generate randum Number rannum from wordlist
	mov edx, ranNum     ;Index
	call find_str       ;Returns EDI = pointer to string, we pick word

  ;Copy find word in variable selectedWords
	INVOKE Str_copy, ADDR [edi],ADDR selectedWords
  
  ;Print selectedWords on screen	
  mov edx, offset wordis
  call writestring
  
	mov edx, offset selectedWords
	;call WriteString   ; not printing it

  ;Make array of dash. It would be word what we guess
	call make_array_dash
    mov edx, offset guessWords
	call WriteString                ; write a string pointed to by EDX
	call Crlf                       ; new line


  ;Inicialization number of life what you have, 3 for words and 10 for letters
mov statusGameLive, 10
mov wordtrycount,3

starthere:

again_input_word:
push edx  
mov edx, offset mainmenu ; main menu display
call WriteString
call readhex			 ;// get user input
pop edx  
mov UserOption, al  ;// save user input to UserOption


; below is the checkflg to both word and letter options, addition for those counts will be zero when all chances will be exhausted
wordcheck:
mov eax,wordtrycount
add eax, statusGameLive
cmp eax,0   ; compare it with zero
je biglooser  ; jump to big looser


beginwm:

cmp useroption, 2  ; option 2 means word match
je wordmatch

cmp useroption, 1 ; option 1 means letter match
jne IncorrectIP
je opt1

IncorrectIP:    ; if your option input is other than 1 or 2, then the game will be restarted again
mov edx, offset incorrectinput
call writestring
call crlf
jmp jump_game_start_again   ; it will start the game and start from the beginning
;jmp beginwm

opt1:
  mov ah,0
mov wordguess, ah  ; clearing the word guess vairable

cmp statusGameLive,0   ; checking whether chances with letters are exhausted or not
je loop_game_over  ; if yes, then go to end of letter check block

   mov letterplaycount, 1   ; each 
  ;Check if you have more live. If player lost all lives, game is over
	cmp statusGameLive, 0
	je loop_game_over   	

	mov edx, offset gla
	Call Writestring

	call readChar	;User inputs char
	cmp al, 27		;Check if is press ESC
	je exit_main	;YES, end game
	cmp al, 32		;Check if is press SPACE
	je restart_game	;YES, restart game

	push eax
	sub al, 'a'		;checks if it is a letter
    cmp al, 'z'-'a'
    jbe lowercase
	jmp again_input_word
lowercase:
	pop eax
	mov guessLetter, al
	call WriteChar
	call Crlf		;new line

		dec statusGameLive
		mov eax, statusGameLive
		call writedec 
		mov edx, offset menu1
		call writestring
		mov eax, wordtrycount
		call writedec 
		mov edx, offset menu2
		call writestring
		call crlf


	;Check if letter is alredy guessed
	mov ecx, LENGTHOF wordguess
	mov edi, offset wordguess
	mov al, guessLetter                 ; Load character to find
	repne scasb                         ; Search
	je loop_guess_letter_exists			; Letter already exist
		

	call make_array_guess_letter 
	;Check if letter is in selectedWords. If not take life
	mov ecx, LENGTHOF selectedWords
	mov edi, offset selectedWords
	mov al, guessLetter                 ; Load character to find
	repne scasb                         ; Search
	jne loop_take_live					; Letter exist take life


  ; We are making new array, guess letter whange dash on right pleace
    mov esi, offset selectedWords       ; Source
    mov edi, offset guessWords          ; Destination
    mov ecx, LENGTHOF selectedWords     ; Number of bytes to check
    mov al, guessLetter                 ; Search for that character
    xor ebx, ebx                        ; Index EBX = 0

ride_hard_loop:
    cmp [esi+ebx], al                   ; Compare memory/register
    jne @F                              ; Skip next line if no match
    mov [edi+ebx], al                   ; Hang 'em lower
    @@:
    inc ebx                             ; Increment pointer
    dec ecx                             ; Decrement counter
    jne ride_hard_loop                  ; Jump if ECX != 0
	   	   
  ;Is there more letter to guess of we finish
	mov ecx, LENGTHOF guessWords		
    mov edi, offset guessWords
    mov al, letterDash                  ; Load character to find

	mov edx, offset guessWords		; added here
	call WriteString                ; write a string pointed to by EDX
	call crlf
    repne scasb							; Search
    jne loop_game_win					; No more letter
	jmp again_input_word				; Guess next word


exit_main:
		
	INVOKE ExitProcess,0

; check if the guessed letter already exists or not, if yes, then it will display
loop_guess_letter_exists:				
		MOV EDX, OFFSET Syagl;
		mov al, guessLetter
		call WriteChar
		call Crlf                       ; new line		
		MOV EDX, OFFSET Iryomttlwyg
		call writestring
		call Crlf                       ; new line		
		mov edx, offset gla
		call writestring
		mov edx, offset wordguess
		call WriteString                ; write a string pointed to by EDX
		call Crlf                       ; new line
		jmp loop_take_live			; Guess next letter	


loop_take_live:
	mov edx, offset guessWords		; added here
	call WriteString                ; write a string pointed to by EDX
	call crlf
	jmp again_input_word			; Guess next letter

restart_game:
		call ClearRegisters
		INVOKE Str_trim, ADDR wordguess, ','

		mov  edx, OFFSET wordguess
		call StrLength				
		mov  lengthArray, eax

		mov edi, offset wordguess ; Destination
		add edi, lengthArray
		dec edi
		INVOKE Str_trim, ADDR wordguess, [edi]

		cmp edi, offset wordguess		
		jne restart_game
		jmp jump_game_start_again			; Guess next letter
		
		
loop_game_win:
	mov edx, offset yousurvivedthistime
	call writestring
	call Crlf
	jmp bigwinner


	
loop_game_over:	
	cmp wordtrycount,0
	mov edx, offset chancewords
	call writestring
	mov eax, wordtrycount
	call writedec
	call crlf
	jne again_input_word
	je biglooser
	


wordmatch :
cmp wordtrycount,0
je donewithtryst
mov wordplaycount, 1
mov esi, 0
mov edx, offset option1prompt
call writestring
pop edx
mov edx, offset inputword
mov ecx, lengthof inputword
call readstring
;mov wordsize, al
mov edx, offset youentered
call writestring
mov	edx,OFFSET inputword	; display the buffer
call	WriteString
mov eax, edx
call Crlf 
mov	edx,OFFSET selectedwords	; display the buffer
;call	WriteString
call Crlf 
mov ebx,0
mov ecx, sizeof selectedWords     ; Number of bytes to check
mov ah, wordsize1
mov wordsize, ah


compareloop:
	mov ah, selectedwords [ebx]
	mov al, inputword [ebx]
	cmp al,ah
	jne looser                              ; Skip next line if no match
    inc ebx                             ; Increment pointer
    dec wordsize                             ; Decrement counter
    jne compareloop                  ; Jump if ECX != 0

winner:
jmp bigwinner


looser:
push edx       
mov edx, offset sorryfailed
call writestring
call Crlf
mov edx, offset countleft
call writestring
;pop edx
dec wordtrycount
;push edx
mov eax, wordtrycount
call writedec
pop edx
call Crlf
cmp wordtrycount, 0
je donewithtryst
jmp again_input_word


donewithtryst:
mov edx, offset chanceletters
call writestring
mov eax, statusGameLive
call writedec
call crlf
cmp statusGameLive,0
jne again_input_word
push edx       
je biglooser
;wordmatch ENDP

; after all the chances are gone, the program control will end up here
biglooser:
	mov edx, offset donewithtry
	call writestring
	call Crlf
	inc gamelost
	jmp newstart

; after winning on any chance, the program control will end up here and the next game will start	

bigwinner:
push edx
mov edx, offset youwin
call writestring
pop edx
call Crlf
inc gamewon
jmp newstart	

newstart:
mov edx, offset gamewontext
call writestring
mov eax, gamewon
call writedec
call crlf
mov edx, offset gamelosttext
call writestring
mov eax, gamelost
call writedec
call crlf
mov eax,gamewon
add eax, gamelost
mov edx, offset gametotaltext
call writestring
mov gametotal, eax
call writedec
call crlf
jmp jump_game_start_again



main ENDP

find_str PROC					; ARG: EDX = index
    lea edi, manyWords          ; Address of string list

    mov ecx, len                ; Maximal number of bytes to scan
    xor al, al                  ; Scan for 0

    @@:
    sub edx, 1					
    jc done                     ; No index left to scan = string found
    repne scasb                 ; Scan for AL
    jmp @B                      ; Next string

  done:
	ret

find_str ENDP                   ; RESULT: EDI pointer to string[edx]


; array dash proc
make_array_dash PROC     
	mov  edx,OFFSET selectedWords
    call StrLength              ; Length of a null-terminated string pointed to by EDX
    mov  lengthArray,eax
	mov wordsize, al
	mov wordsize1, al

    mov al, '-'                 ; Default charcter for guessWords
    mov ecx, lengthArray		; REP counter
    mov edi, offset guessWords  ; Destination
    rep stosb                   ; Build guessWords
    mov BYTE PTR [edi], 0       ; Store the null termination

    ret
make_array_dash ENDP  


make_array_guess_letter PROC    
	mov  edx, OFFSET wordguess
    call StrLength				; Length of a null-terminated string pointed to by EDX
    mov  lengthArray, eax

    mov edi, offset wordguess ; Destination
    add edi, lengthArray
	mov al, guessLetter
	mov BYTE PTR [edi], al      ; Store guessLetter
	inc edi
	mov BYTE PTR [edi], ','     ; Store the null termination

    ret
make_array_guess_letter ENDP  

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

END main
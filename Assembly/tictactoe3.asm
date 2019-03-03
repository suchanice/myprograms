TITLE tictactoe.asm

; Name: Sucharita Das
; Date: Dec 7th, 2018

INCLUDE Irvine32.inc     ;Includes the Irvine32 library of functions

.data 

     IfXWins DWORD 0
     IfOWins DWORD 0
     winnerArrayX DWORD 0,0,0  ; tic-tac-toe array assignment
     winnerArrayO DWORD 0,0,0
     arrtictactoe DWORD 9,9,9                      
     Rowsize = ($ - arrtictactoe)
                 DWORD 9,9,9
                 DWORD 9,9,9
     firstprompt BYTE "Let's play the Tic-Tac-Toe Game!!",0
     MenuDisplay BYTE "Enter the number of your choice...",0
     MenuDisplay1 BYTE "1. Player vs Computer (Player will go first) ",0
	 MenuDisplay2 BYTE "2. Computer vs Player (Computer will go first) ",0
     MenuDisplay3 BYTE "3. Computer X vs. Computer O",0
	 MenuDisplay4 BYTE "4. Player X vs. Player O (Player X will go first, then Player O)",0
     MenuDisplay5 BYTE "5. Display Game Statistics",0
	 MenuDisplay6 BYTE "6. Quit",0
     UserOption BYTE "Enter your options (1-6): ",0
     ErrorMessage BYTE "Invalid choice... please enter 1, 2, 3, 4, 5, or 6",0
	 pvpcount dword 0d
	 pvccount dword 0d
	 cvccount dword 0d
	 drawcount dword 0d
	 

.code
main PROC
	 

     ViewGame PROTO, boardptr: PTR DWORD   
	 xwincheck PROTO, Xticprt: PTR DWORD, win2x: PTR DWORD, doubleXArray: PTR DWORD
     owincheck PROTO, Oticprt: PTR DWORD, winnerOO: PTR DWORD, doubleOArray: PTR DWORD

     playersturn PROTO, tictacptr1: PTR DWORD
	 playersturn1 PROTO, tictacptr1: PTR DWORD   

     boardwinner PROTO , wincomboard : PTR DWORD , winallx: PTR DWORD , winallo: PTR DWORD, doubleXArrayX: PTR DWORD, doubleOArrayO: PTR DWORD

	 compOChoice PROTO, tictacptr2: PTR DWORD
     compXChoice PROTO , tictacptr3 : PTR DWORD

     call Randomize                             ;random function
     mov eax, 0									;zeroed out all the registers    
     mov ebx, 0
     mov ebp, 0   
	 mov ecx, 0
     mov edx, 0                                
     mov edi, 0

     start:                                     ;start of Menu label
    ;defining value to the variables
     mov ecx, 9                            
     mov esi, OFFSET arrtictactoe
     mov eax, 9
     mov IfXWins, 0
     mov IfOWins, 0
     loop0:
          mov [esi], eax
          add esi, TYPE DWORD
     loop loop0
     mov esi, OFFSET arrtictactoe

     ;Menu options display 
     mov eax, white + (black * 16)               ;white letters w/ black background
     call SetTextColor
     call clrscr
     call Crlf
     mov eax, 3                                  
     mov edx, OFFSET firstprompt
     call WriteString
     mov eax, white + (black * 16)               
     call SetTextColor
     call Crlf
     mov edx, OFFSET MenuDisplay                  ;menu options to user display
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay1
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay2
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay3
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay4
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay5
     call WriteString
     call Crlf
     mov edx, OFFSET MenuDisplay6
     call WriteString
     call Crlf
     mov edx, OFFSET UserOption
     call WriteString

     mov al,0
     or al,1                                  ;to clear the zero flag

     call ReadInt                             ;reads in the menu choice from user
     cmp eax,1
     jz option1                                ;if option 1 is selected, go to option1
     cmp eax,2
     jz option2                                ;if option 2 is selected, go to option2
     cmp eax,3
     jz option3                                ;if option 3 is selected, go to option3
     cmp eax,4
     jz option4                                ;if option 4 is selected, go to option4                                   
     cmp eax,5
     jz option5                                ;if option 4 is selected, go to option5
     cmp eax,6
     jz option6                                ;if option 4 is selected, go to option5
     jnz Error                                ;error message displayed when 1,2,3,4,5 or 6 is not inputted

     Error:                                   
     mov edx, OFFSET ErrorMessage
     call WriteString
     call Crlf
     call WaitMsg
     jmp start                                 ;go back to start again

     EndProgram: ;if option 5 is chosen
     call Crlf
     call WaitMsg 
     call Crlf
     INVOKE ExitProcess,0                     ;exit the program

     ;details about option 1
     option1:     
	 inc pvccount
     call Crlf
     INVOKE playersturn , ADDR arrtictactoe   ;Player will be X, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compOChoice , ADDR arrtictactoe   ;Computer will take O, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn , ADDR arrtictactoe   ;Player 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compOChoice , ADDR arrtictactoe   ;Computer 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn , ADDR arrtictactoe   ;Player's turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX  ; check if X wins, since there is a chance with 3 turns
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ; O is going for 3rd time, possibility of winning
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;Again X, check if X wins
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;Again O, check if O Wins
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;Again X , check if X wins
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
	 
     jmp endgame  


     ;Option 2 details
     option2: 
	 inc pvccount
     call Crlf
     INVOKE compXChoice , ADDR arrtictactoe   ;Computer will be X, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player will take O, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Computer 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Computer's turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX   ; check if X wins, since there is a chance with 3 turns
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;3rd O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;4th X , possibility of x winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;4th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;5th/last X , possibility of x winner
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
	 
     jmp endgame  


     ;Option 3 details
     option3:                                
     call Crlf
	 inc cvccount
     INVOKE compXChoice , ADDR arrtictactoe   ;First X choice for comp
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE compOChoice , ADDR arrtictactoe   ;First Comp O choice
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE compXChoice , ADDR arrtictactoe   ;2nd X choice
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE compOChoice , ADDR arrtictactoe   ;2nd O choice
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE compXChoice , ADDR arrtictactoe   ;3rd X, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;3rd O, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;4th X, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;4th O, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;5th X, starting to check winning possibilities
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
	 
	 jmp endgame  


     ;Option 4 details
     option4:                                
     call Crlf
	 inc pvpcount
     INVOKE playersturn , ADDR arrtictactoe   ;1st player with X
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE playersturn1 , ADDR arrtictactoe   ;2nd player with O
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE playersturn , ADDR arrtictactoe   ;1st player with 2nd chance
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE playersturn1 , ADDR arrtictactoe   ;2nd player with 2nd chance
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE playersturn , ADDR arrtictactoe   ;3rd X, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;3rd O, starting to check winning possibilities
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;4th X
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;4th O
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;5th X
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
	 
	 	 
     endgame:
          INVOKE boardwinner , ADDR arrtictactoe , IfXWins , IfOWins , ADDR winnerArrayX , ADDR winnerArrayO
     call Waitmsg
     jmp start                                 ;jump to start

     option5:
	 call gamestat
	 call Waitmsg
     jmp start                                 ;jump to start
     
     option6:
	 call gamestat
	 call Waitmsg
     jz EndProgram

INVOKE ExitProcess,0               ;Exit criteria
main ENDP


;------------------------------------------------------
;proc to display game statistics

gamestat PROC
.data

	 statsdisp BYTE "Game Statistics so far : ",0
	 pvpdisp BYTE "Total Player Vs. Player Games Played :",0
	 pvcdisp BYTE "Total Player Vs. Computer OR Computer Vs. Player Games Played :",0
	 cvcdisp BYTE "Total Computer Vs. Computer Games Played :",0
	 drawdisp BYTE "Total Games Drawn :",0


.code
	mov edx,0
	mov eax,0
	mov edx, offset statsdisp
	call writestring
	call crlf
	mov edx, offset pvpdisp
	call writestring
	;call crlf
	mov eax, pvpcount
	call writedec
	call crlf
	mov edx, offset pvcdisp
	call writestring
	;call crlf
	mov eax,  pvccount
	call writedec
	call crlf
	mov edx, offset cvcdisp
	call writestring
	;call crlf
	mov eax,  cvccount
	call writedec
	call crlf
	mov edx, offset drawdisp
	call writestring
	;call crlf
	mov eax,  drawcount
	call writedec
	call crlf
RET
gamestat ENDP



;------------------------------------------------------------------------------------------------
; proc to explain the Tic Tac Toe game
gameruleexplain PROC
.data
promptdescribe0 BYTE "Tic-Tac-Toe Game Rule :",0
promptdescribe1 BYTE "The board positions are shown with numbers as given",0
promptdescribe2 BYTE "Your symbol will be placed on the number position you have selected",0
emptyline1 BYTE " 1 | 2 | 3 ",0
emptyline2 BYTE " 4 | 5 | 6 ",0
emptyline3 BYTE " 7 | 8 | 9 ",0
promptdescribe3 BYTE "Player with three straight X's or O's along the rows or columns or diagonally will Win the game!",0

.code
mov edx, offset promptdescribe0
call writestring
call crlf
mov edx, offset promptdescribe1
call writestring
call crlf
mov edx, offset promptdescribe2
call writestring
call crlf
mov edx, offset emptyline1
call writestring
call crlf
mov edx, offset emptyline2
call writestring
call crlf
mov edx, offset emptyline3
call writestring
call crlf
mov edx, offset promptdescribe3
call writestring
call crlf
RET                                     ;returns after call of procedure
gameruleexplain ENDP

;---------------------------------------------------------------------------------

;Procedure for player with an 'O' on the board with filling the array with 1

playersturn1 PROC, tictacptr1: PTR DWORD
           

.data
promptPlayer1Start BYTE "PLAYER O START (select from 1 - 9, your option will be reflected in the board as per position) : ",0
promptOccupied1 BYTE "Sorry, that space has already been taken ! Try again...",0
promptNotValidNumber1 BYTE "Invalid Input, please choose a number between 1 to 9....",0

.code
call Crlf
call Crlf

playeroption1:
mov esi, tictacptr1
call gameruleexplain
mov edx, OFFSET promptPlayer1Start       ;prompts user that it is their turn
call WriteString
call ReadDec
mov ecx, 9     ;checking the input
cmp ecx, eax
jz userinputcheck1
mov ecx, 8
cmp ecx, eax
jz userinputcheck1
mov ecx, 7
cmp ecx, eax
jz userinputcheck1
mov ecx, 6
cmp ecx, eax
jz userinputcheck1
mov ecx, 5
cmp ecx, eax
jz userinputcheck1
mov ecx, 4
cmp ecx, eax
jz userinputcheck1
mov ecx, 3
cmp ecx, eax
jz userinputcheck1
mov ecx, 2
cmp ecx, eax
jz userinputcheck1
mov ecx, 1
cmp ecx, eax
jz userinputcheck1

;invalid input
call Crlf
mov edx, OFFSET promptNotValidNumber1
call WriteString
call Crlf
call Crlf
jmp playeroption1

userinputcheck1:
mov ecx, eax
cmp ecx, 1                              ;compare choice with 1
jz CHOICE1                              ;jump to choice1 if it is 1
dec ecx
LOOPTOCHECKVALID1:
     add esi, TYPE DWORD
     loop LOOPTOCHECKVALID1

CHOICE1:       
mov ebx, 9
cmp [esi], ebx                          ;compare input with 9
jz OKAYCHOICE1                           ;position is empty if it is 9, move to proc to fill in with value
mov edx, OFFSET promptOccupied1          ;not empty, move on
call Crlf
call WriteString
call Crlf
call Crlf
jmp playeroption1                    

OKAYCHOICE1:
mov ebx, 0                              ;moves 'x' into position
mov [esi], ebx                          ;1 means X and 0 means O , 9 is empty

RET                                     ;return
playersturn1 ENDP                                    


;---------------------------------------------------------------------

;Procedure to place an 'x' on the for player and fills the array with 1 or 'X'

playersturn PROC, tictacptr1: PTR DWORD         

.data
promptPlayerStart BYTE "PLAYER X START (select from 1 - 9, your option will be reflected in the board as per position) : ",0
promptOccupied BYTE "Sorry, that space has already been taken ! Try again...",0
promptNotValidNumber BYTE "Invalid Input, please choose a number between 1 to 9....",0

.code
call Crlf
playeroption:
mov esi, tictacptr1
call gameruleexplain
mov edx, OFFSET promptPlayerStart       ;prompts user that it is their turn
call WriteString
call ReadDec
mov ecx, 9     ;compare user input from 1 to 9
cmp ecx, eax
jz userinputcheck
mov ecx, 8
cmp ecx, eax
jz userinputcheck
mov ecx, 7
cmp ecx, eax
jz userinputcheck
mov ecx, 6
cmp ecx, eax
jz userinputcheck
mov ecx, 5
cmp ecx, eax
jz userinputcheck
mov ecx, 4
cmp ecx, eax
jz userinputcheck
mov ecx, 3
cmp ecx, eax
jz userinputcheck
mov ecx, 2
cmp ecx, eax
jz userinputcheck
mov ecx, 1
cmp ecx, eax
jz userinputcheck

;invalid input
call Crlf
mov edx, OFFSET promptNotValidNumber
call WriteString
call Crlf
call Crlf
jmp playeroption

userinputcheck:
mov ecx, eax
cmp ecx, 1                              ;compare choice with 1
jz CHOICE1                              ;jump to choice1 if it is 1
dec ecx
LOOPTOCHECKVALID:
     add esi, TYPE DWORD
     loop LOOPTOCHECKVALID

CHOICE1:       
mov ebx, 9
cmp [esi], ebx                          ;compare input with 9
jz OKAYCHOICE                           ;position is empty if it is 9, move to proc to fill in with value
mov edx, OFFSET promptOccupied          ;not empty, move on
call Crlf
call WriteString
call Crlf
call Crlf
jmp playeroption                    

OKAYCHOICE:
mov ebx, 1                              ;moves 'O' into position
mov [esi], ebx                          ;1 means X and 0 means O , 9 is empty

RET                                     ;returns after call of procedure
playersturn ENDP                                    

;---------------------------------------------------------------------------

;Procedure for computer to randomly select from 1 to 9 to fill the board with 0 ('o') value
compOChoice PROC , tictacptr2 : PTR DWORD         

.data
promptComputerStart BYTE "Computer O START (selecting in progress...)",0
checkfiveO dword 0d

.code
call Crlf
mov edx, OFFSET promptComputerStart               ;informs user Computer O is choosing
call WriteString
mov esi, tictacptr2                                  ;ESI = start of tictacptr2 array

RANDOMCOMPCHOICE:
mov esi, tictacptr2
mov eax, 9
call RandomRange                                  ;RandomRange returns back 0 - 8
add eax, 1                                        ;adding 1 to make the selection from 1-9
mov ecx, eax

cmp checkfiveO,0										; put the first shot in position 5, if available
jne jump5
; inserting position 5
mov ecx,5
mov checkfiveO, ecx
jump5:


cmp ecx, 1                                        ;was Computer O's choice = 1?
jz CHOICE2                                        ;if yes jump to CHOICE2, no need to increment through array                    
dec ecx
LOOPTOCHECKVALID:
     add esi, TYPE DWORD
     loop LOOPTOCHECKVALID
CHOICE2:
mov ebx, 9
cmp [esi], ebx                                    ;1 means X and 0 means O , 9 is empty
jz OKAYCOMPCHOICE
jmp RANDOMCOMPCHOICE

OKAYCOMPCHOICE:
mov ebx, 0
mov [esi], ebx                                    ;1 means X and 0 means O , 9 is empty


;adding some delay
push ebp
mov ebp, 30000
mov eax, 30000
delay2:
dec bp                   ;wait for 3 seconds
nop
jnz delay2
dec eax
cmp eax,0    
jnz delay2
pop ebp

RET                                                          ;return
compOChoice ENDP                                       

;---------------------------------------------------------------------------
;Procedure for computer to randomly select from 1 to 9 to fill the board with 1 ('X') value

compXChoice PROC , tictacptr3 : PTR DWORD

.data
promptOComputerStart BYTE "Computer X START (selecting in progress...)",0
checkfive dword 0d

.code
call Crlf
call Crlf
mov edx, OFFSET promptOComputerStart
call WriteString
mov esi, tictacptr3

compchoicex:
mov esi, tictacptr3

mov eax, 9
call RandomRange                                  ;RandomRange returns between 0 - 8
add eax, 1                                        ;adding 1 to make the selection from 1-9
mov ecx, eax

cmp checkfive,0										; put the first shot in position 5
jne jump5
; inserting position 5
mov ecx,5
mov checkfive, ecx
jump5:

cmp ecx, 1                                        ;compare it with 1
jz CHOICE2CX                                      ;if yes jump to CHOICE2CX 

dec ecx
validationx:
     add esi, TYPE DWORD
     loop validationx
CHOICE2CX:
mov ebx, 9
cmp [esi], ebx
jz compchoicexok
jmp compchoicex

compchoicexok:
mov ebx, 1
mov [esi], ebx        ;1 = X, and 0 = O


;adding some delay
push ebp
mov ebp, 30000
mov eax, 30000
delay2:
dec bp
nop
jnz delay2
dec eax
cmp eax,0    
jnz delay2
pop ebp

RET                                                     ;return
compXChoice ENDP                                   

;Now the board display proc starts
ViewGame PROC , boardptr : PTR DWORD
;To display the board with the x's, o's, and non filled spaces 
          

.data
emptyshell BYTE "    |   |    ",0
posx BYTE 2
posy BYTE 0
displayOutCounter DWORD 0

.code
mov posx, 2                                ;reset posx = 2 
mov posy, 0                                ;reset posy = 2 
mov displayOutCounter, 0                     ;reset displayOutCounter = 0
mov esi, boardptr
call Clrscr
mov ecx, 3
;display the board pipes
DISPLAYPIPES:
	 mov eax, white + (black * 16)      
	 call SetTextColor
     mov edx, OFFSET emptyshell
     call WriteString
     call Crlf
     loop DISPLAYPIPES

;display the numbers
mov boardptr, esi
cmp boardptr, 1
DOITAGAIN:
mov ecx, 3

LOOPDISPLAY:
     push edx          
     mov dh, posy                               ;dh = posy
     mov dl, posx                               ;dl = posx
     call Gotoxy                                  ;moves cursor to (x,y) on screen
     pop edx     

     mov ebx, 9
     cmp [esi], ebx
     jz DISPLAYDASH      ;9 means dashes to display
     mov ebx, 1
     cmp [esi], ebx
     jz DISPLAYx         ;1 is X
     mov ebx, 0
     cmp [esi], ebx
     jz DISPLAYo         ;0 is O

     DISPLAYx:
		  mov eax, yellow + (black * 16) 
		 call SetTextColor
          mov eax, 'x'   ; display the X with yellow color with black background
          call WriteChar
          jmp TOLOOPNEXTCHAR

     DISPLAYo:
		  mov eax, cyan + (black * 16) 
		 call SetTextColor
          mov eax, 'o'  ; display O with cyan color with black background
          call WriteChar

          jmp TOLOOPNEXTCHAR

     DISPLAYDASH:
		 mov eax, white + (black * 16)      
		call SetTextColor
          mov eax, '-'
          call WriteChar

     TOLOOPNEXTCHAR:
          add posx, 4
          add esi, TYPE DWORD


loop LOOPDISPLAY                   ;Loop thrice for one row   

mov posx, 2                      ;reset posx = 2
add posy, 1                      ;move to next line
add displayOutCounter, 1
mov edx, 2 
cmp displayOutCounter, edx         
jbe DOITAGAIN                      ;one more row
	 mov eax, white + (black * 16)      
	 call SetTextColor

RET                                ;return
ViewGame ENDP                                        

;---------------------------------------------------------------------------
;Proc to check winner with 3 straight Xs to fill in doubleXArray with positions and update win2x

xwincheck PROC , Xticprt : PTR DWORD, win2x: PTR DWORD, doubleXArray: PTR DWORD


.data
xthrough DWORD 0

.code
mov esi, Xticprt    ;ESI = beginning of Xticprt array
mov eax, 0
mov xthrough, 0
;go through the rows
mov ecx, 3

chkrows:
     push ecx                      ;ESP = ecx
     mov eax, 0
     mov ecx, 3
     LOOPFORROWS:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
          loop LOOPFORROWS

     pop ecx                       ;pop ECX

;find out values for doubleXArray
     mov edx, 0
     cmp edx, xthrough
     jz firstx
     mov edx, 1
     cmp edx, xthrough
     jz secondx
     mov edx, 2
     cmp edx, xthrough
     jz thirdx

     firstx:                   ;row operations
     mov edi, doubleXArray
     mov edx, 1                    ;set EDX = 1
     mov [edi], edx                ;doubleXArray[0] = EDX
     add edi, TYPE DWORD
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 3
     mov [edi], edx
     jmp endofx

     secondx:                  ;2nd row
     mov edi, doubleXArray
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     jmp endofx

     thirdx:                   ;3rd row
     mov edi, doubleXArray
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     endofx:

add xthrough, 1 

;check for wins
mov edx, 3          ;check for sum=3
cmp eax, edx
jz xwonx

mov ebx,1
cmp ecx, ebx        
jz xfin
sub ecx, 1
jmp chkrows
     
xfin:

;column operation
mov ecx, 3
mov xthrough, 0                          ;reset xthrough = 0
mov esi, Xticprt                             ;reset esi to beginning of array
chkcols:
     push ecx
     mov eax, 0
     mov ecx, 3
     LOOPFORCOLS:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           
          loop LOOPFORCOLS
     pop ecx

;find out values for doubleXArray
     mov edx, 0
     cmp edx, xthrough
     jz Xfirstx
     mov edx, 1
     cmp edx, xthrough
     jz Xsecondx
     mov edx, 2
     cmp edx, xthrough
     jz Xthirdx

     Xfirstx:                  ;1st col
     mov edi, doubleXArray
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     jmp endofxX

     Xsecondx:                 ;2nd col
     mov edi, doubleXArray
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     jmp endofxX

     Xthirdx:                  ;3rd col
     mov edi, doubleXArray
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     endofxX:
;check for wins
     mov edx, 3
     cmp eax, edx
     jz xwonx
 
     mov edx, 1
     cmp edx, xthrough         ;check first col 
     jz ad2colx              ;go to 2nd loop
     mov esi, Xticprt
     add esi, TYPE DWORD
     jmp ad2colxfin
     ad2colx:
     mov esi, Xticprt              ;check 3rd col
     add esi, TYPE DWORD
     add esi, TYPE DWORD

     ad2colxfin:
     mov ebx, 1
     cmp ecx, ebx                  ;check ecx counter
     jz xfinX                     
     sub ecx, 1     
     add xthrough, 1
     jmp chkcols

     xfinX:

;diagonal win check
     mov esi, Xticprt              ;esi = beginning of Xticprt array
     mov ebx, 0
     mov eax, [esi]                ;adding position 1 of board, no need to increment
     add ebx, eax
     mov ecx, 2
     diagx:
          add esi, TYPE DWORD           ;upper left to lower right diagonal for position 1,5,9
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           ;needs to increment 4 
          mov eax, [esi]
          add ebx, eax
     loop diagx

     mov edi, doubleXArray             ;assigning 1,5,9 position value to array
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     mov edx, 3                         ;checking for win with sum
     cmp ebx, edx
     jz xwonx

     mov eax,0
     mov ebx, 0
     mov esi, Xticprt                   ;reset variables
     add esi, TYPE DWORD
     add esi, TYPE DWORD                
     mov eax, [esi]
     add ebx, eax

     mov ecx, 2
     diag2x:
          add esi, TYPE DWORD           ;upper right to lower left diagonalfor position 3,5,7
          add esi, TYPE DWORD
          mov eax, [esi]
          add ebx, eax
     loop diag2x

     mov edi, doubleXArray             ;assigning 3,5,7 position value to array
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx

     mov edx, 3     ;checking for win with sum
     cmp ebx, edx
     jz xwonx

jmp XENDING         ;if no winner is found, must skip over xwonx

;winner
xwonx:
     mov edx, win2x
     mov eax, 1
     mov [edx], eax                ;set address to 1

XENDING:

RET                                                          ;return
xwincheck ENDP                                         

;---------------------------------------------------------------------------
;Proc to check winner with 3 straight Os to fill in doubleOArray with positions and update winerOO array

owincheck PROC , Oticprt : PTR DWORD, winnerOO: PTR DWORD, doubleOArray: PTR DWORD
 

.data
TimeThroughO DWORD 0

.code
mov esi, Oticprt    ;ESI = beginning of Oticprt array
mov eax, 0
mov TimeThroughO, 0
;go through the rows
mov ecx, 3

chkrowsO:
     push ecx                      ;ESP = ecx
     mov eax, 0
     mov ecx, 3
     LOOPFORROWSO:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
          loop LOOPFORROWSO

     pop ecx                       ;pop ECX

;set doubleOArray
     mov edx, 0
     cmp edx, TimeThroughO
     jz firsto
     mov edx, 1
     cmp edx, TimeThroughO
     jz secondo
     mov edx, 2
     cmp edx, TimeThroughO
     jz thirdo

     firsto:                   ;row operations
     mov edi, doubleOArray
     mov edx, 1                    ;set EDX = 1
     mov [edi], edx                ;doubleOArray[0] = EDX
     add edi, TYPE DWORD
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 3
     mov [edi], edx
     jmp endofo

     secondo:                  ;2nd row
     mov edi, doubleOArray
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     jmp endofo

     thirdo:                   ;3rd row
     mov edi, doubleOArray
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     endofo:

add TimeThroughO, 1 

;check for wins
mov edx, 0          ;check if sum = 0
cmp eax, edx
jz owono

mov ebx,1
cmp ecx, ebx        
jz ZeroX
sub ecx, 1
jmp chkrowsO
     
ZeroX:

;column operation
mov ecx, 3
mov TimeThroughO, 0                          ;reset TimeThroughO = 0
mov esi, Oticprt                             ;reset esi to beginning of array
chkcolsO:
     push ecx
     mov eax, 0
     mov ecx, 3
     loopcolo:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           
          loop loopcolo
     pop ecx

;set doubleOArray
     mov edx, 0
     cmp edx, TimeThroughO
     jz Ofirsto
     mov edx, 1
     cmp edx, TimeThroughO
     jz Osecondo
     mov edx, 2
     cmp edx, TimeThroughO
     jz Othirdo

     Ofirsto:                  ;1st col
     mov edi, doubleOArray
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     jmp endofoO

     Osecondo:                 ;2nd col
     mov edi, doubleOArray
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     jmp endofoO

     Othirdo:                  ;3rd col
     mov edi, doubleOArray
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     endofoO:
;check for wins
     mov edx, 0
     cmp eax, edx
     jz owono
 
     mov edx, 1
     cmp edx, TimeThroughO         ;check first col 
     jz ad2colo              ;go to 2nd loop
     mov esi, Oticprt
     add esi, TYPE DWORD
     jmp colfino
     ad2colo:
     mov esi, Oticprt              ;check 3rd col
     add esi, TYPE DWORD
     add esi, TYPE DWORD

     colfino:
     mov ebx, 1
     cmp ecx, ebx                  ;check ecx counter
     jz odono                     
     sub ecx, 1     
     add TimeThroughO, 1
     jmp chkcolsO

     odono:

;diagonal win check
     mov esi, Oticprt              ;esi = beginning of Oticprt array
     mov ebx, 0
     mov eax, [esi]                ;adding position 1 of board, no need to increment
     add ebx, eax
     mov ecx, 2
     diago:
          add esi, TYPE DWORD           ;upper left to lower right diagonalfor position 1,5,9
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           ;needs to increment 4 
          mov eax, [esi]
          add ebx, eax
     loop diago

     mov edi, doubleOArray             ;assignment of the doubleOArray values 1, 5, 9
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx

     mov edx, 0                         ;check sum value for winner
     cmp ebx, edx
     jz owono

     mov eax,0
     mov ebx, 0
     mov esi, Oticprt                   ;reset variables
     add esi, TYPE DWORD
     add esi, TYPE DWORD                
     mov eax, [esi]
     add ebx, eax

     mov ecx, 2
     diag2o:
          add esi, TYPE DWORD           ;upper right to lower left diagonalfor position 3,5,7
          add esi, TYPE DWORD
          mov eax, [esi]
          add ebx, eax
     loop diag2o

     mov edi, doubleOArray             ;assignment of the doubleOArray values. 1, 5, 9
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx

     mov edx, 0     ;check sum value for winner
     cmp ebx, edx
     jz owono

jmp oendoo         ;no winner, move on

;winner
owono:
     mov edx, winnerOO
     mov eax, 1
     mov [edx], eax                ;set dereferenced address to 1

oendoo:

RET                                                          ;return
owincheck ENDP                                         

;---------------------------------------------------------------------------
;Procedure to display wins with either O or X, shows no colors for a draw

boardwinner PROC , wincomboard : PTR DWORD , winallx : PTR DWORD , winallo : PTR DWORD, doubleXArrayX : PTR DWORD, doubleOArrayO : PTR DWORD      

.data
posxW BYTE 2
posyW BYTE 0
emptyshellW BYTE "    |   |    ",0
displayOutCounterW DWORD 0
promptxwonx BYTE "    X is the Winner!",0
promptowono BYTE "    O is the Winner!",0
promptNowono BYTE "The game ended in a draw...",0
DisplayNumberW DWORD 1
promptCongrats BYTE "Congrats !!!",0
promptCongrats2 BYTE "-------",0

.code
mov DisplayNumberW, 1              ;reset variables
mov posxW, 2
mov posyW, 0
mov displayOutCounterW, 0
mov esi, wincomboard
call Clrscr
mov ecx, 3
pipdisp:;display pipes
     mov edx, OFFSET emptyshellW
     call WriteString
     call Crlf
     loop pipdisp

mov wincomboard, esi             ;ESI = beginning of board array
startagain:
mov ecx, 3

loopdisp:
     push edx                                 
     mov dh, posyW                               ;dh = posy
     mov dl, posxW                               ;dl = posx
     call Gotoxy                                  ;moves cursor to (x,y) on screen
     pop edx     

     ;set regular color
     mov eax, white + (black * 16)      
     call SetTextColor

     mov ebx, 9
     cmp [esi], ebx
     jz dispdas          ;to display -
     mov ebx, 1
     cmp [esi], ebx
     jz dispx3             ;to display x
     mov ebx, 0
     cmp [esi], ebx
     jz dispo1             ;to display o

     dispx3:
          mov eax, 0
          cmp eax, winallx                      ;compare winallx
          push ecx
          jz dispjx                         ;if yes, x did not win. 
          mov eax, doubleXArrayX                 ;if no, x won the game
          mov ebx, DisplayNumberW                 ;EBX = DisplayNumberW
          mov ecx, 3
          LOOPCHECKxwonx:
               cmp [eax], ebx                     
               jz dispcolx
               add eax, TYPE DWORD
          loop LOOPCHECKxwonx
          jmp dispjx                        ;if none found to be same, no color added
          dispcolx:
          mov eax, black + (yellow * 16)           ;black letters w/ white background
          call SetTextColor                       
          dispjx:
          pop ecx
          mov eax, 'x'
          call WriteChar
		  mov eax, white + (black * 16)           ;regular colors
          call SetTextColor
          jmp nxtchrloop

     dispo1:
          mov eax, 0
          push ecx
          cmp eax, winallo                      ;is winallo = 0?
          jz dispjsto                         ;if yes, x did not win. 
          mov eax, doubleOArrayO                 ;if no, x won the game
          mov ebx, DisplayNumberW                 ;EBX = DisplayNumberW
          mov ecx, 3
          LOOPCHECKowono:
               cmp [eax], ebx
               jz colrdispo
               add eax, TYPE DWORD
          loop LOOPCHECKowono
          jmp dispjsto                        ;if none found to be same, no color added
          colrdispo:
          mov eax, black + (yellow * 16)           ;black letters w/ white background
          call SetTextColor                       
          dispjsto:
          pop ecx
          mov eax, 'o'
          call WriteChar
		  mov eax, white + (black * 16)           ;regular colors
          call SetTextColor
          jmp nxtchrloop

     dispdas:                                ;dashes never have color
          mov eax, '-'
          call WriteChar

     nxtchrloop:
          add posxW, 4                          ;inc x coordinate
          add esi, TYPE DWORD
          add DisplayNumberW, 1
          mov eax, white + (black * 16)           ;regular colors
          call SetTextColor

     mov ebx, 1                                   ;since loop would be too far, must dec ecx by hand
     cmp ecx, ebx
     jz DONEDISPLAYINGXXX     
     sub ecx, 1
     jmp loopdisp                             ;loops 3 times (for each row)

     DONEDISPLAYINGXXX:  

mov posxW, 2                                    ;reset x coordinate back to first column
add posyW, 1                                    ;inc to next row
add displayOutCounterW, 1
mov edx, 2
cmp displayOutCounterW, edx                       ; if displayOutCounterW hasn' reached 3, need to do agian
jbe startagain  


;to display CONGRATULATIONS
call Crlf
call Crlf
mov eax,winallo   
cmp winallx, eax                      ;no winner, equal number
jnz possiblewinner
mov edx, OFFSET promptNowono
call WriteString
inc drawcount
jmp GAMEOVER                            ;draw

possiblewinner:
mov edx, OFFSET promptCongrats          ;congratulation banner 
call WriteString
call Crlf
mov eax, white + (black * 16)           ;regular colors
call SetTextColor

mov eax, 1
cmp winallx, eax
jnz TRYowono
mov edx, OFFSET promptxwonx
call WriteString                        ;X wins
jmp secondheader

TRYowono:                             ; if none of the above, o wins!
mov edx, OFFSET promptowono
call WriteString                        ;O wins

secondheader:
call Crlf
mov edx, OFFSET promptCongrats2          ;congratulation2 banner 
call WriteString
call Crlf
mov eax, white + (black * 16)           ;regular colors
call SetTextColor

GAMEOVER:
call Crlf
call Crlf

RET                                                          ;return
boardwinner ENDP                                      

;---------------------------------------------------------------------------
end main
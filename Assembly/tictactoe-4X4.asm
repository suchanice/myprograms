TITLE tictactoe-4X4.asm

; Name: Sucharita Das
; Date: Dec 7th, 2018



INCLUDE Irvine32.inc     ;Includes the Irvine32 library of functions

.data 

     IfXWins DWORD 0
     IfOWins DWORD 0
     winnerArrayX DWORD 0,0,0,0  ; tic-tac-toe array assignment
     winnerArrayO DWORD 0,0,0,0
     arrtictactoe DWORD 16,16,16,16                      
     Rowsize = ($ - arrtictactoe)
                 DWORD 16,16,16,16
                 DWORD 16,16,16,16
				 DWORD 16,16,16,16
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
     mov ecx, 16                            
     mov esi, OFFSET arrtictactoe
     mov eax, 16
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
     mov eax, 4                                  
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
     INVOKE playersturn , ADDR arrtictactoe   ;Player's 3rd turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
	 INVOKE compOChoice , ADDR arrtictactoe   ;Computer 3rd turn for O	 
	 INVOKE ViewGame , ADDR arrtictactoe		; View game
	 INVOKE playersturn , ADDR arrtictactoe   ;Player 4th turn for X 
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX  ; check if X wins, since there is a chance with 4 turns
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ; O is going for 4th time, possibility of winning
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;Again X, check if X wins, 5th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX

          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;Again O, check if O Wins; 5th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;Again X , check if X wins; 6th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
		  mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;Again O, check if O Wins; 6th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE playersturn , ADDR arrtictactoe   ;Again X , check if X wins; 7th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
		  mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;Again O, check if O Wins; 7th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE playersturn , ADDR arrtictactoe   ;Again X , check if X wins; 8th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
		  mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;Again O, check if O Wins; 8th time
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
	  
     jmp endgame  


     ;Option 2 details
     option2: 
	 inc pvccount
     call Crlf
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp will be X, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player will take O, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;player 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp's 3rd turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player 3rd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp's 4th turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
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
     INVOKE compXChoice , ADDR arrtictactoe   ;5th X , possibility of x winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;5th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;6th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;6th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE compXChoice , ADDR arrtictactoe   ;7th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;7th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE compXChoice , ADDR arrtictactoe   ;8th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;8th O , possibility of o winner
     ;INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
 	 
     jmp endgame  


     ;Option 3 details
     option3:                                
     call Crlf
	 inc cvccount
	 
	 INVOKE compXChoice , ADDR arrtictactoe   ;Comp will be X, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compOChoice , ADDR arrtictactoe   ;Player will take O, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compOChoice , ADDR arrtictactoe   ;player 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp's 3rd turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compOChoice , ADDR arrtictactoe   ;Player 3rd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE compXChoice , ADDR arrtictactoe   ;Comp's 4th turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX   
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;4th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;5th X , possibility of x winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;5th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE compXChoice , ADDR arrtictactoe   ;6th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;6th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE compXChoice , ADDR arrtictactoe   ;7th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;7th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE compXChoice , ADDR arrtictactoe   ;8th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE compOChoice , ADDR arrtictactoe   ;8th O , possibility of o winner
     ;INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
	 
	 jmp endgame  


     ;Option 4 details
     option4:                                
     call Crlf
	 inc pvpcount
  

     INVOKE playersturn , ADDR arrtictactoe   ;Comp will be X, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player will take O, first turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn , ADDR arrtictactoe   ;Comp 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;player 2nd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn , ADDR arrtictactoe   ;Comp's 3rd turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn1 , ADDR arrtictactoe   ;Player 3rd turn
     INVOKE ViewGame , ADDR arrtictactoe		; View game
     INVOKE playersturn , ADDR arrtictactoe   ;Comp's 4th turn again for X
     INVOKE ViewGame , ADDR arrtictactoe		; View game
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
     INVOKE playersturn , ADDR arrtictactoe   ;5th X , possibility of x winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;5th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame
     INVOKE playersturn , ADDR arrtictactoe   ;6th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;6th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE playersturn , ADDR arrtictactoe   ;7th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;7th O , possibility of o winner
     INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO
          mov eax, 1
          cmp eax, IfOWins
          jz endgame

     INVOKE playersturn , ADDR arrtictactoe   ;8th X , possibility of x winner
	 INVOKE ViewGame , ADDR arrtictactoe
     INVOKE xwincheck , ADDR arrtictactoe, ADDR IfXWins, ADDR winnerArrayX
          mov eax, 1
          cmp eax, IfXWins
          jz endgame
     INVOKE playersturn1 , ADDR arrtictactoe   ;8th O , possibility of o winner
     ;INVOKE ViewGame , ADDR arrtictactoe
     INVOKE owincheck , ADDR arrtictactoe, ADDR IfOWins, ADDR winnerArrayO	 
	 	 
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
	call crlf
	mov eax, pvpcount
	call writedec
	call crlf
	mov edx, offset pvcdisp
	call writestring
	call crlf
	mov eax,  pvccount
	call writedec
	call crlf
	mov edx, offset cvcdisp
	call writestring
	call crlf
	mov eax,  cvccount
	call writedec
	call crlf
	mov edx, offset drawdisp
	call writestring
	call crlf
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
emptyline1 BYTE " 1 | 2 | 3 | 4 ",0
emptyline2 BYTE " 5 | 6 | 7 | 8 ",0
emptyline3 BYTE " 9 | 10| 11| 12",0
emptyline4 BYTE " 13| 14| 15| 16",0
promptdescribe3 BYTE "Player with four straight X's or O's along the rows or columns or diagonally will Win the game!",0

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
mov edx, offset emptyline4
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
promptPlayer1Start BYTE "PLAYER O START (select from 1 - 16, your option will be reflected in the board as per position) : ",0
promptOccupied1 BYTE "Sorry, that space has already been taken ! Try again...",0
promptNotValidNumber1 BYTE "Invalid Input, please choose a number between 1 to 16....",0

.code
call Crlf

playeroption1:
mov esi, tictacptr1
call gameruleexplain
mov edx, OFFSET promptPlayer1Start       ;prompts user that it is their turn
call WriteString
call ReadDec
mov ecx, 16  ;checking the input
cmp ecx, eax
jz userinputcheck1
mov ecx, 15
cmp ecx, eax
jz userinputcheck1
mov ecx, 14
cmp ecx, eax
jz userinputcheck1
mov ecx, 13
cmp ecx, eax
jz userinputcheck1
mov ecx, 12
cmp ecx, eax
jz userinputcheck1
mov ecx, 11
cmp ecx, eax
jz userinputcheck1
mov ecx, 10
cmp ecx, eax
jz userinputcheck1
mov ecx, 9     
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
mov ebx, 16
cmp [esi], ebx                          ;compare input with 16
jz OKAYCHOICE1                           ;position is empty if it is 16, move to proc to fill in with value
mov edx, OFFSET promptOccupied1          ;not empty, move on
call Crlf
call WriteString
call Crlf
call Crlf
jmp playeroption1                    

OKAYCHOICE1:
mov ebx, 0                              ;moves 'x' into position
mov [esi], ebx                          ;1 means X and 0 means O , 16 is empty

RET                                     ;return
playersturn1 ENDP                                    


;---------------------------------------------------------------------

;Procedure to place an 'x' on the for player and fills the array with 1 or 'X'

playersturn PROC, tictacptr1: PTR DWORD         

.data
promptPlayerStart BYTE "PLAYER X START (select from 1 - 16, your option will be reflected in the board as per position) : ",0
promptOccupied BYTE "Sorry, that space has already been taken ! Try again...",0
promptNotValidNumber BYTE "Invalid Input, please choose a number between 1 to 16....",0

.code
call Crlf
playeroption:
mov esi, tictacptr1
call gameruleexplain
mov edx, OFFSET promptPlayerStart       ;prompts user that it is their turn
call WriteString
call ReadDec

mov ecx, 16  ;checking the input
cmp ecx, eax
jz userinputcheck
mov ecx, 15
cmp ecx, eax
jz userinputcheck
mov ecx, 14
cmp ecx, eax
jz userinputcheck
mov ecx, 13
cmp ecx, eax
jz userinputcheck
mov ecx, 12
cmp ecx, eax
jz userinputcheck
mov ecx, 11
cmp ecx, eax
jz userinputcheck
mov ecx, 10
cmp ecx, eax
jz userinputcheck

mov ecx, 9     
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
mov ebx, 16
cmp [esi], ebx                          ;compare input with 16
jz OKAYCHOICE                           ;position is empty if it is 16, move to proc to fill in with value
mov edx, OFFSET promptOccupied          ;not empty, move on
call Crlf
call WriteString
call Crlf
call Crlf
jmp playeroption                    

OKAYCHOICE:
mov ebx, 1                              ;moves 'O' into position
mov [esi], ebx                          ;1 means X and 0 means O , 16 is empty

RET                                     ;returns after call of procedure
playersturn ENDP                                    

;---------------------------------------------------------------------------

;Procedure for computer to randomly select from 1 to 16 to fill the board with 0 ('o') value
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
mov eax, 16
call RandomRange                                  ;RandomRange returns back 0 - 15
add eax, 1                                        ;adding 1 to make the selection from 1-16
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
mov ebx, 16
cmp [esi], ebx                                    ;1 means X and 0 means O , 16 is empty
jz OKAYCOMPCHOICE
jmp RANDOMCOMPCHOICE

OKAYCOMPCHOICE:
mov ebx, 0
mov [esi], ebx                                    ;1 means X and 0 means O , 16 is empty


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

mov eax, 16
call RandomRange                                  ;RandomRange returns between 0 - 15
add eax, 1                                        ;adding 1 to make the selection from 1-16
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
mov ebx, 16
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

;---------------------------------------------------------
;Now the board display proc starts
ViewGame PROC , boardptr : PTR DWORD
;To display the board with the x's, o's, and non filled spaces 

.data
emptyshell BYTE "    |   |   |    ",0
posx BYTE 2
posy BYTE 0
displayOutCounter DWORD 0

.code
mov posx, 2                                ;reset posx = 2 
mov posy, 0                                ;reset posy = 2 
mov displayOutCounter, 0                     ;reset displayOutCounter = 0
mov esi, boardptr
call Clrscr
mov ecx, 4
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
mov ecx, 4

LOOPDISPLAY:
     push edx          
     mov dh, posy                               ;dh = posy
     mov dl, posx                               ;dl = posx
     call Gotoxy                                  ;moves cursor to (x,y) on screen
     pop edx     

     mov ebx, 16
     cmp [esi], ebx
     jz DISPLAYDASH      ;16 means dashes to display
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
		 ;mov eax, white + (black * 16)      
		 ;call SetTextColor
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


loop LOOPDISPLAY                   ;Loop 4 times for one row   

mov posx, 2                      ;reset posx = 2
add posy, 1                      ;move to next line
add displayOutCounter, 1
mov edx, 3 
cmp displayOutCounter, edx         
jbe DOITAGAIN                      ;one more row
mov eax, white + (black * 16)      
call SetTextColor

RET                                ;return
ViewGame ENDP                                        

;---------------------------------------------------------------------------

;Proc to check winner with 4 straight Xs to fill in doubleXArray with positions and update win2x

xwincheck PROC , Xticprt : PTR DWORD, win2x: PTR DWORD, doubleXArray: PTR DWORD

.data
xthrough DWORD 0

.code
mov esi, Xticprt    ;ESI = beginning of Xticprt array
mov eax, 0
mov xthrough, 0
;go through the rows
mov ecx, 4

chk4rows:
     push ecx                      ;ESP = ecx
     mov eax, 0
     mov ecx, 4
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
     mov edx, 3
     cmp edx, xthrough
     jz fourthx

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
     add edi, TYPE DWORD
     mov edx, 4
     mov [edi], edx
     jmp endofx

     secondx:                  ;2nd row
     mov edi, doubleXArray
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     jmp endofx

     thirdx:                   ;3rd row
     mov edi, doubleXArray
     mov edx, 9
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 10
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 12
     mov [edi], edx
     jmp endofx

	 fourthx:
     mov edi, doubleXArray
     mov edx, 13
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 14
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 15
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx

     endofx:

add xthrough, 1 

;check for wins
mov edx, 4          ;check for sum=4
cmp eax, edx
jz winnrx

mov ebx,1
cmp ecx, ebx        
jz xfin
sub ecx, 1
jmp chk4rows
     
xfin:

;column operation
mov ecx, 4
mov xthrough, 0                          ;reset xthrough = 0
mov esi, Xticprt                             ;reset esi to beginning of array
chk4cols:
     push ecx
     mov eax, 0
     mov ecx, 4
     LOOPFORCOLS:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
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
     mov edx, 3
     cmp edx, xthrough
     jz Xfourthx

     Xfirstx:                  ;1st col
     mov edi, doubleXArray
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 13
     mov [edi], edx
     jmp endofxX

     Xsecondx:                 ;2nd col
     mov edi, doubleXArray
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 10
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 14
     mov [edi], edx
     jmp endofxX

     Xthirdx:                  ;3rd col
     mov edi, doubleXArray
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 15
     mov [edi], edx
     jmp endofxX

     Xfourthx:                  ;4th col
     mov edi, doubleXArray
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 12
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx

     endofxX:

;check for wins
     mov edx, 4
     cmp eax, edx
     jz winnrx
 
     mov edx, 1
     cmp edx, xthrough         ;check first col 
     jz col2add2x              ;go to 2nd loop
     mov esi, Xticprt
     add esi, TYPE DWORD
     jmp xfincoladd
     col2add2x:
     mov esi, Xticprt              ;check 3rd col
     add esi, TYPE DWORD
     add esi, TYPE DWORD
     jmp xfincoladd
     mov esi, Xticprt              ;check 4th col
     add esi, TYPE DWORD
     add esi, TYPE DWORD
	 add esi, TYPE DWORD

     xfincoladd:
     mov ebx, 1
     cmp ecx, ebx                  ;check ecx counter
     jz xfinX                     
     sub ecx, 1     
     add xthrough, 1
     jmp chk4cols

     xfinX:

;diagonal win check
     mov esi, Xticprt              ;esi = beginning of Xticprt array
     mov ebx, 0
     mov eax, [esi]                ;adding position 1 of board, no need to increment
     add ebx, eax
     mov ecx, 2
     diagxloop:
          add esi, TYPE DWORD           ;upper left to lower right diagonal for position 1,6,11,16
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           ;needs to increment 5 
          mov eax, [esi]
          add ebx, eax
     loop diagxloop

     mov edi, doubleXArray             ;assigning 1,6,11,16 position value to array
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx


     mov edx, 4                         ;checking for win with sum
     cmp ebx, edx
     jz winnrx

     mov eax,0
     mov ebx, 0
     mov esi, Xticprt                   ;reset variables
     add esi, TYPE DWORD
     add esi, TYPE DWORD    
	 add esi, TYPE DWORD  ; added once more
     mov eax, [esi]
     add ebx, eax

     mov ecx, 2
     diagxloop2:
          add esi, TYPE DWORD           ;upper right to lower left diagonalfor position 4,7,10,13
          add esi, TYPE DWORD
	      add esi, TYPE DWORD
          mov eax, [esi]
          add ebx, eax
     loop diagxloop2

     mov edi, doubleXArray             ;assigning 3,5,7 position value to array
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 13
     mov [edi], edx

     mov edx, 4     ;checking for win with sum
     cmp ebx, edx
     jz winnrx

jmp XENDING         ;if no winner is found, must skip over winnrx

;winner
winnrx:
     mov edx, win2x
     mov eax, 1
     mov [edx], eax                ;set address to 1

XENDING:

RET                                                          ;return
xwincheck ENDP                                         

;---------------------------------------------------------------------------
;Proc to check winner with 4 straight Os to fill in doubleOArray with positions and update winerOO array

owincheck PROC , Oticprt : PTR DWORD, winnerOO: PTR DWORD, doubleOArray: PTR DWORD
 

.data
TimeThroughO DWORD 0

.code
mov esi, Oticprt    ;ESI = beginning of Oticprt array
mov eax, 0
mov TimeThroughO, 0
;go through the rows
mov ecx, 4

chk4rowsO:
     push ecx                      ;ESP = ecx
     mov eax, 0
     mov ecx, 4
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
     mov edx, 3
     cmp edx, TimeThroughO
     jz fourtho

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
     add edi, TYPE DWORD
     mov edx, 4
     mov [edi], edx
     jmp endofo

     secondo:                  ;2nd row
     mov edi, doubleOArray
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     jmp endofo

     thirdo:                   ;3rd row
     mov edi, doubleOArray
     mov edx, 9
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 10
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 12
     mov [edi], edx
	 jmp endofo

     fourtho:                   ;4th row
     mov edi, doubleOArray
     mov edx, 13
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 14
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 15
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx

     endofo:

add TimeThroughO, 1 

;check for wins
mov edx, 0          ;check if sum = 0
cmp eax, edx
jz winnro

mov ebx,1
cmp ecx, ebx        
jz ZeroX
sub ecx, 1
jmp chk4rowsO
     
ZeroX:

;column operation
mov ecx, 4
mov TimeThroughO, 0                          ;reset TimeThroughO = 0
mov esi, Oticprt                             ;reset esi to beginning of array
chk4colsO:
     push ecx
     mov eax, 0
     mov ecx, 4
     loop4colo:
          mov ebx, [esi]
          add eax, ebx
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD  
          loop loop4colo
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
     mov edx, 3
     cmp edx, TimeThroughO
     jz Ofourtho


     Ofirsto:                  ;1st col
     mov edi, doubleOArray
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 5
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 9
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 13
     mov [edi], edx
     jmp endofoO

     Osecondo:                 ;2nd col
     mov edi, doubleOArray
     mov edx, 2
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 10
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 14
     mov [edi], edx
     jmp endofoO

     Othirdo:                  ;3rd col
     mov edi, doubleOArray
     mov edx, 3
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 15
     mov [edi], edx
     jmp endofoO

	 Ofourtho:
     mov edi, doubleOArray
	 mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 8
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 12
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx

     endofoO:
;check for wins
     mov edx, 0
     cmp eax, edx
     jz winnro
 
     mov edx, 1
     cmp edx, TimeThroughO         ;check first col 
     jz coladd2o              ;go to 2nd loop
     mov esi, Oticprt
     add esi, TYPE DWORD
     jmp coladdendo
     coladd2o:
     mov esi, Oticprt              ;check 3rd col
     add esi, TYPE DWORD
     add esi, TYPE DWORD
     jmp coladdendo
     mov esi, Oticprt              ;check 4th col
     add esi, TYPE DWORD
     add esi, TYPE DWORD
	 add esi, TYPE DWORD

     coladdendo:
     mov ebx, 1
     cmp ecx, ebx                  ;check ecx counter
     jz odoneo                     
     sub ecx, 1     
     add TimeThroughO, 1
     jmp chk4colsO

     odoneo:

;diagonal win check
     mov esi, Oticprt              ;esi = beginning of Oticprt array
     mov ebx, 0
     mov eax, [esi]                ;adding position 1 of board, no need to increment
     add ebx, eax
     mov ecx, 2
     diagloopo:
          add esi, TYPE DWORD           ;upper left to lower right diagonalfor position 1,6,11,16
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD
          add esi, TYPE DWORD           ;needs to increment 5
          mov eax, [esi]
          add ebx, eax
     loop diagloopo

     mov edi, doubleOArray             ;assignment of the doubleOArray values 1,6,11,16
     mov edx, 1
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 6
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 16
     mov [edi], edx

     mov edx, 0                         ;check sum value for winner
     cmp ebx, edx
     jz winnro

     mov eax,0
     mov ebx, 0
     mov esi, Oticprt                   ;reset variables
     add esi, TYPE DWORD
     add esi, TYPE DWORD      
     add esi, TYPE DWORD  ; added once more
     mov eax, [esi]
     add ebx, eax

     mov ecx, 2
     diagloopo2:
          add esi, TYPE DWORD           ;upper right to lower left diagonalfor position 4,7,10,13
          add esi, TYPE DWORD
		  add esi, TYPE DWORD
          mov eax, [esi]
          add ebx, eax
     loop diagloopo2

     mov edi, doubleOArray             ;assignment of the doubleOArray values 4,7,10,13
     mov edx, 4
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 7
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 11
     mov [edi], edx
     add edi, TYPE DWORD
     mov edx, 13
     mov [edi], edx

     mov edx, 0     ;check sum value for winner
     cmp ebx, edx
     jz winnro

jmp endo1         ;no winner, move on

;winner
winnro:
     mov edx, winnerOO
     mov eax, 1
     mov [edx], eax                ;set dereferenced address to 1

endo1:

RET                                                          ;return
owincheck ENDP                                         

;---------------------------------------------------------------------------
;Procedure to display wins with either O or X, shows no colors for a draw

boardwinner PROC , wincomboard : PTR DWORD , winallx : PTR DWORD , winallo : PTR DWORD, doubleXArrayX : PTR DWORD, doubleOArrayO : PTR DWORD      

.data
posxW BYTE 2
posyW BYTE 0
emptyshellW BYTE "    |   |   |    ",0
displayOutCounterW DWORD 0
promptwinnrx BYTE "    X is the Winner!",0
promptwinnro BYTE "    O is the Winner!",0
promptNwinnro BYTE "The game ended in a draw...",0
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
mov ecx, 4
pipdisp11:;display pipes
     mov edx, OFFSET emptyshellW
     call WriteString
     call Crlf
     loop pipdisp11

mov wincomboard, esi             ;ESI = beginning of board array
startagain:
mov ecx, 4

disploopw:
     push edx                                 
     mov dh, posyW                               ;dh = posy
     mov dl, posxW                               ;dl = posx
     call Gotoxy                                  ;moves cursor to (x,y) on screen
     pop edx     

     ;set regular color
     mov eax, white + (black * 16)      
     call SetTextColor

     mov ebx, 16
     cmp [esi], ebx
     jz dispdas          ;to display -
     mov ebx, 1
     cmp [esi], ebx
     jz dispxxww             ;to display x
     mov ebx, 0
     cmp [esi], ebx
     jz odispw             ;to display o

     dispxxww:
          mov eax, 0
          cmp eax, winallx                      ;compare winallx
          push ecx
          jz dispjustx                         ;if yes, x did not win. 
          mov eax, doubleXArrayX                 ;if no, x won the game
          mov ebx, DisplayNumberW                 ;EBX = DisplayNumberW
          mov ecx, 4
          LOOPCHECKwinnrx:
               cmp [eax], ebx                     
               jz dispcolrx
               add eax, TYPE DWORD
          loop LOOPCHECKwinnrx
          jmp dispjustx                        ;if none found to be same, no color added
          dispcolrx:
          mov eax, black + (yellow * 16)           ;black letters w/ white background
          call SetTextColor                       
          dispjustx:
          pop ecx
          mov eax, 'x'
          call WriteChar
		  mov eax, white + (black * 16)           ;regular colors
          call SetTextColor
          jmp loopnxtchrw

     odispw:
          mov eax, 0
          push ecx
          cmp eax, winallo                      ;is winallo = 0?
          jz odispo                         ;if yes, x did not win. 
          mov eax, doubleOArrayO                 ;if no, x won the game
          mov ebx, DisplayNumberW                 ;EBX = DisplayNumberW
          mov ecx, 4
          LOOPCHECKwinnro:
               cmp [eax], ebx
               jz dispclro
               add eax, TYPE DWORD
          loop LOOPCHECKwinnro
          jmp odispo                        ;if none found to be same, no color added
          dispclro:
          mov eax, black + (yellow * 16)           ;black letters w/ white background
          call SetTextColor                       
          odispo:
          pop ecx
          mov eax, 'o'
          call WriteChar
		  mov eax, white + (black * 16)           ;regular colors
          call SetTextColor
          jmp loopnxtchrw

     dispdas:                                ;dashes never have color
          mov eax, '-'
          call WriteChar

     loopnxtchrw:
          add posxW, 4                          ;inc x coordinate
          add esi, TYPE DWORD
          add DisplayNumberW, 1
          mov eax, white + (black * 16)           ;regular colors
          call SetTextColor

     mov ebx, 1                                   ;since loop would be too far, must dec ecx by hand
     cmp ecx, ebx
     jz DONEDISPLAYINGXXX     
     sub ecx, 1
     jmp disploopw                             ;loops 4 times (for each row)

     DONEDISPLAYINGXXX:  

mov posxW, 2                                    ;reset x coordinate back to first column
add posyW, 1                                    ;inc to next row
add displayOutCounterW, 1
mov edx, 3
cmp displayOutCounterW, edx                       ; if displayOutCounterW hasn' reached 4, need to do agian
jbe startagain  


;to display CONGRATULATIONS
call Crlf
call Crlf
mov eax,winallo   
cmp winallx, eax                      ;no winner, equal number
jnz possiblewinner
mov edx, OFFSET promptNwinnro
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
jnz TRYwinnro
mov edx, OFFSET promptwinnrx
call WriteString                        ;X wins
jmp secondheader

TRYwinnro:                             ; if none of the above, o wins!
mov edx, OFFSET promptwinnro
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
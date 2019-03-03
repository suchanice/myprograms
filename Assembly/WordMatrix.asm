; Sucharita Das
; HW8

; Date: 11/26/2018

INCLUDE Irvine32.inc
.data

ROWSIZE = 5
SIZE1 = 5
COLSIZE = 5
vowels_count		DWORD	5
vowels			byte		"AEIOU"
consonants_count	DWORD	20
consonants		byte		"BCDFGHJKLMNPQRSTVWXYZ"
exitmsg			byte		"Press ENTER to finish",0
matrixarray byte 'X', ' ', ' ',' ', ' ',
            ' ', ' ', ' ',' ', ' ',
            ' ', ' ', ' ',' ', ' ',
			' ', ' ', ' ',' ', ' ',
			' ', ' ', ' ',' ', ' ',0
arrayLen  = 25;($ - matrixarray); / 5
comma BYTE ",",0
lettercount byte 0d
lettercount1 byte 0d
vowelcount byte 0d
row SBYTE 0d
col SBYTE 0d
count SBYTE 0d
xwins SBYTE 0d
message BYTE "X wins!", 0
startno SBYTE 0d
endno SBYTE 0d
wordyes byte " - This is a word",0
wordno byte " - This is NOT a word",0
wordmat byte "The Random Word Matrix is (5X5) :",0
rowwise byte "Checking row-wise :",0
colwise byte "Checking column-wise :",0
diagwiselr byte "Checking diagonally left to right:",0
diagwiserl byte "Checking diagonally right to left:",0
dash byte "--------------------------------",0

.code
main PROC
	mov	ECX, 1	; do 5 times (print matrix)
	call Randomize
_mainLoop:
	mov edx, offset wordmat
	call writestring
	call	PrintMatrix
	dec	ECX		; EXC=EXC-1
	jnz	_mainLoop	; if ECX != 0 - print next matrix
	mov  esi,OFFSET matrixarray	; point to the array
	mov  ecx,arrayLen	; set loop counter
	L1:	mov  eax,[esi]	; get integer from array
	;call Writechar	; write it in 
	mov  edx,OFFSET comma	; display a comma
	;call WriteString
	add  esi,TYPE matrixarray	; point to next array position
	loop L1
	pop edx
	;call crlf
	mov edx, offset rowwise
	call writestring
	call crlf
	mov edx, offset dash
	call writestring
	call crlf
	mov esi,OFFSET matrixarray	; point to the array
	;--------check for ROW wise
	inc startno
    L10:
	   mov vowelcount,0
        mov bl, row                    ;row coord in bl
        L20:
            mov cl, col                ;col coord in cl
            mov eax, 0                 ;clear eax
            mov al, ROWSIZE            ;cells per row
            mul bl                     ;times row
            add al, col                ;plus col => offset in bytes
            mov dl, [esi + eax ]        ;get char from array
			mov  [esp + eax] ,dl
			mov al,dl
			call writechar  
; vowel check			
cmp dl,'A'
je endcount
cmp dl,'E'
je endcount
cmp dl,'I'
je endcount
cmp dl,'O'
je endcount
cmp dl,'U'
je endcount
jne continue2
endcount:
inc vowelcount
continue2:

			inc count
			inc endno
			inc col                    ;move to next column
            cmp col, COLSIZE           ;is it column 4?
            jl  L20                      ;if not, go back up
			
            cmp count,ROWSIZE     ;if count is 5
            ;mov xwins, 1             ;x wins
						
			jne continue1
			je wordchecknow
			wordchecknow:
			cmp vowelcount,2
			jl continue1
			mov edx, offset wordyes
			call writestring			 
            call crlf
			jmp continue11
			continue1:
			mov edx, offset wordno
			call writestring
			call crlf
            continue11:
			mov count, 0               ;clear count
            mov col, 0                 ;start back at column 0
            inc row                    ;move to next row
            cmp row, ROWSIZE           ;is it row 4?
            jl  L10                     ;if not, do that row

        mov col, 0                     ;reset row and col
        mov row, 0
    ;--------check for COLUMN wise
	;call crlf
	mov edx, offset colwise
	call writestring
	call crlf
	mov edx, offset dash
	call writestring
	call crlf
    L3:
        mov cl, col                    ;col coord in cl
		mov vowelcount,0
        L4: mov bl, row             ;row coord in bl
            mov eax, 0                
            mov al, ROWSIZE                
            mul bl                    
            add al, col                
            mov dl, [esi + eax ]        ;get char from array
			mov  [esp + eax] ,dl
			mov al,dl
			call writechar
; vowel check			
cmp dl,'A'
je endcount2
cmp dl,'E'
je endcount2
cmp dl,'I'
je endcount2
cmp dl,'O'
je endcount2
cmp dl,'U'
je endcount2
jne continue22
endcount2:
inc vowelcount
continue22:

           inc count
            inc row                    ;move to next row
            cmp row, ROWSIZE           ;is it row 4?
            jl  L4                      ;if not, do next row
        cmp count,COLSIZE

    
			jne continue12
			je wordchecknow2
			wordchecknow2:
			cmp vowelcount,2
			jl continue12
			mov edx, offset wordyes
			call writestring			 
            call crlf
			jmp continue13
			continue12:
			mov edx, offset wordno
			call writestring
			call crlf
            continue13:
        mov count, 0
        mov row, 0                     ;reset for next row
        inc col                        ;move to next col
        cmp col, COLSIZE               ;is it col 4?
        jl  L3                          ;if not, do next col
            

        mov col, 0                     ;reset row and col
        mov row, 0
    ;--------check for Diagonal left to right
	;call crlf
	mov edx, offset diagwiselr
	call writestring
	call crlf
	mov edx, offset dash
	call writestring
	call crlf

			mov vowelcount,0
			mov ebx, 0
        L42: 
		    mov dl, [esi + ebx ]        ;get char from array	
			cmp dl,'A'		; vowel check
			je endcount3
			cmp dl,'E'
			je endcount3
			cmp dl,'I'
			je endcount3
			cmp dl,'O'
			je endcount3
			cmp dl,'U'
			je endcount3
			jne continue32
			endcount3:
			inc vowelcount
			continue32:
			mov al,dl
			call writechar
			add bl, 6
			inc col
			cmp col, COLSIZE
			jl L42

			cmp vowelcount,2
			jl continue14
			mov edx, offset wordyes
			call writestring			 
            call crlf
			jmp continue15
			continue14:
			mov edx, offset wordno
			call writestring
			call crlf
            continue15:
; add vowel comparison
					   
        mov col, 0                     ;reset row and col
        mov row, 0
	;--------check for Diagonal right to left
	;call crlf
	mov edx, offset diagwiserl
	call writestring
	call crlf
	mov edx, offset dash
	call writestring
	call crlf
			mov vowelcount,0
			mov ebx, 4
        L43: 
		    mov dl, [esi + ebx ]        ;get char from array
			cmp dl,'A'			; vowel check
			je endcount4
			cmp dl,'E'
			je endcount4
			cmp dl,'I'
			je endcount4
			cmp dl,'O'
			je endcount4
			cmp dl,'U'
			je endcount4
			jne continue35
			endcount4:
			inc vowelcount
			continue35:
			mov al,dl
			call writechar
			add bl, 4
			inc col
			cmp col, COLSIZE
			jl L43
			cmp vowelcount,2
			jl continue16
			mov edx, offset wordyes
			call writestring			 
            call crlf
			jmp continue17
			continue16:
			mov edx, offset wordno
			call writestring
			call crlf
            continue17:
; add vowel comparison					   
        mov col, 0                     ;reset row and col
        mov row, 0
	;call crlf
	mov edx, offset dash
	call writestring
	call crlf	   	  
	mov	EDX, offset exitmsg
	call	WriteString
	call ReadChar
	exit
main ENDP

; Print matrix 5x5 with
; vowels and consonants 
PrintMatrix PROC
	; local variables
	; ECX - short loop counter (chars in line)
	; EDX - long loop counter (line numbers)
	push EAX		; preserve registers, that we use
	push	ECX
	push	EDX
	mov	ECX, 5
	;mov EBX, OFFSET matrixarray
_PrintLineLoop:	; loop with post-condition (see below)
	call CrLf		; print end of line
	mov	EDX, 5
_PrintShortLoop:	
	mov	EAX, 2	; generate random number in range 0-1
	call RandomRange	; get random number from 0 to 1
	cmp	EAX, 0	; if 0 - print vowels
	jnz	_GetConsonant
	call GetRndVowel	; in AL is a vowel
	jmp	_WriteChar
_GetConsonant:
	call GetRndConsonant	; in AL is a consonant
_WriteChar:
	mov EBX, OFFSET matrixarray
	mov lettercount1, dl
	mov dl, lettercount
	mov [ebx+edx], al			; pushing the matrix to the array
	call	WriteChar			; print character from AL
	mov dl, lettercount1
	inc lettercount

	dec	EDX				; decrement internal loop counter	
	jnz	_PrintShortLoop
	dec	ECX				; decrement external loop counter
	jnz	_PrintLineLoop
	call	CrLf
	pop	EDX		; restore registers in back order
	pop	ECX
	pop	EAX
PrintMatrix ENDP

; Get ramdom vowel
; return vowel char in AL register
GetRndVowel PROC
	push EBX
	mov	EAX, vowels_count
	mov	EBX, offset vowels 
	call	RandomRange	; eax now from 0 to 5
	add	EBX, EAX	; EBX now points to random vowel
	mov	AL, [EBX]
	pop	EBX
	ret
GetRndVowel ENDP
; Get random consonant
; return consonant char in AL register
GetRndConsonant PROC
	push EBX
	mov	EAX, consonants_count
	mov	EBX, offset consonants
	call	RandomRange	; eax now from 0 to 20
	add	EBX, EAX	; EBX now points to random consonant
	mov	AL, [EBX]
	pop	EBX
	ret
GetRndConsonant ENDP

END main
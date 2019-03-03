
;//Sucharita Das



INCLUDE Irvine32.inc

.data
num1=0
num2=1 ;//taking all variables
arrayNum BYTE 7 DUP(?)            
ary BYTE 4 DUP(?)

.code
main proc
	mov esi,0    ;//esi=0
	mov al,num1
	mov ah,num2
	mov arrayNum[esi],al   ;//num1=0 
	mov arrayNum[esi+1],ah ;//num2=1 
	mov bl,arrayNum[esi]   ;//moving num1 to bl
	add bl,arrayNum[esi+1] ;//add num2 to bl, 
	mov arrayNum[esi+2],bl  ;//store 1 to index 2
	mov bh,arrayNum[esi+1]  ;//mov num1 to bl
	add bh,arrayNum[esi+2] ;//add num2 to bl
	mov arrayNum[esi+3],bh  ;//store 1 to index 3
	mov cl,arrayNum[esi+2];//mov num1 to bl
	add cl,arrayNum[esi+3] ;//add num2 to bl
	mov arrayNum[esi+4],cl;//store 1 to index 4
	mov ch,arrayNum[esi+3] ;//mov num1 to bl
	add ch,arrayNum[esi+4] ;//add num2 to bl
	mov arrayNum[esi+5],ch;//store 1 to index 5
	mov dl,arrayNum[esi+4]  ;//mov num1 to bl
	add dl,arrayNum[esi+5];//add fib1 to bl
	mov arrayNum[esi+6],dl ;//store 1 to index 6

	sub ebx,ebx;//clear ebx
	
	;//store the values to ary form 3rd index of arrayNum to  6th
     ;// mov esi,offset ary
     ;//mov byte ptr [esi],bl
	mov bl,arrayNum[esi+3]      
	mov ary[esi],bl
	mov bh, arrayNum[esi + 4]
	mov ary[esi+1],bh
	mov cl,arrayNum[esi + 5]
	mov ary[esi+2],cl
	mov ch,arrayNum[esi + 6]
	mov ary[esi+3],ch
	mov ebx,DWORD PTR ary             
		
call DumpRegs

exit
main endp
end main;//ending the program
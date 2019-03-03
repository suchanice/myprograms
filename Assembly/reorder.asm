; //Reorder the Array
;//Sucharita Das

INCLUDE Irvine32.inc

.data
arrayNum Dword 123,251,12;/declearing array ,starting point

.code
main proc
     mov eax,0;//eax = 0
     mov	eax,[arrayNum+8];//mov 12
     xchg eax,[arrayNum];//exchanging 12 with 123
     xchg eax,[arrayNum+4];//exchanging 123 with 251
     xchg eax,[arrayNum+8]
     ;//ending array numbers
     mov eax,[arrayNum];//mov 12 in the array
     mov eax,[arrayNum+4];//mov 123 in the array
     mov eax,[arrayNum+8];//mov 251 in the array
     
	call DumpRegs

exit
main endp
end main;//ending the program
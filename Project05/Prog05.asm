
TITLE Prog05 - Sorting Random Integers     (Prog05.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course: CS271_400_S2017
; Project ID: Prog05
; Date: 5/27/2017
; Description: This program generates a list of random
; integers. It displays the original list, sorts the list, 
; and calculates the median value. Finally, it displays the 
; list sorted in descending order.

INCLUDE Irvine32.inc

.data

MAX = 200	;max number of integers to display
MIN = 10	;minimum number of integers to display
HI = 999	;highest number to be randomly generated
LO = 100	;lowest number to be randomly generated

userNum		DWORD	?				;number as entered by the user
numArray	DWORD	MAX		DUP(?)	;array of random numbers
count		DWORD	?				;size of the array

titleMess	BYTE	"		Prog05 - Sorting Random Integers		by Taylor Liss", 0dh, 0ah, 0
intro01		BYTE	"This program generates random numbers in the range [100 .. 999],",0dh,0ah,0
intro02		BYTE	"displays the original list, sorts the list, and calculates the",0dh,0ah,0
intro03		BYTE	"median value. Finally, it displays the list sorted in descending order.",0dh,0ah,0
prompt01	BYTE	"How many numbers should be generated? [10 .. 200]:", 0
errorMess	BYTE	"Invalid input", 0dh, 0ah, 0
display01	BYTE	"The unsorted random numbers:", 0dh, 0ah, 0
spaces		BYTE	"   ", 0
display02	BYTE	"The sorted list:", 0dh, 0ah, 0
display03	BYTE	"The median is ", 0

.code
main PROC

	call Randomize

	;Introduction
	push OFFSET intro01
	push OFFSET intro02
	push OFFSET intro03
	push OFFSET titleMess
	call introduction

	call CrLf

	;Get user data
	push userNum
	push OFFSET prompt01
	push OFFSET errorMess
	call getData
	mov	 userNum, eax

	;Fill array with random numbers
	push OFFSET numArray
	push userNum
	call fillArray

	call CrLf

	;Display array unsorted array
	mov	 edx, OFFSET display01
	call WriteString
	push OFFSET numArray
	push userNum
	push OFFSET spaces
	call displayArray

	call CrLf
	call CrLf

	;Sort array	
	push OFFSET numArray
	push userNum
	call sortList

	;Display median number
	mov	 edx, OFFSET display03
	call WriteString
	push OFFSET numArray
	push userNum
	call displayMedian

	call CrLf
	call CrLf

	;Display sorted array
	mov	 edx, OFFSET display02
	call WriteString
	push OFFSET numArray
	push userNum
	push OFFSET spaces
	call displayArray

	call CrLf
	call CrLf

	exit

main ENDP

;----------------------------------------
;This procedure writes out the title of the program
;and explains what it does.
;Receives: titleMess, prompt01, prompt02, prompt03
;Returns: n/a
;Preconditions: 4 messages must be passed in
;Registers changed: edx
;---------------------------------------
introduction PROC

	push	ebp
	mov		ebp, esp
	mov		edx, [ebp+8]	;titleMess
	call	WriteString
	mov		edx, [ebp+20]	;prompt01
	call	WriteString
	mov		edx, [ebp+16]	;prompt02
	call	WriteString
	mov		edx, [ebp+12]	;prompt03
	call	WriteString
	pop		ebp
	ret		16		;offset of a word is 4 bits * 4 = 12

introduction ENDP

;----------------------------------------
;This procedure prompts the user to enter in
;the number of random numbers to be generated
;between 100 and 999.
;Receives: userNum, prompt01, errorMess
;Returns: userNum in eax
;Preconditions: variable and 2 messages must be passed in
;Registers changed: edx, eax
;---------------------------------------
getData	PROC

	push	ebp
	mov		ebp, esp

	retrieveNum:

	mov		edx, [ebp+12]
	call	WriteString

	call	ReadInt
	cmp		eax, MAX
	jg		invalid
	cmp		eax, MIN
	jl		invalid

	pop		ebp
	ret		16

	invalid:
	mov		edx, [ebp+8]
	call	writeString
	jmp		retrieveNum

getData ENDP

;----------------------------------------
;This procedure fills the array passed in
;with random numbers between 100 and 999
;Receives: userNum, numArray
;Returns: numArray sorted
;Preconditions: must have an array with values in it and the length of that array. HI and LO also need to be set and Randomize must have been called
;Registers changed: ecx, edi, eax
;---------------------------------------
fillArray	PROC

	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp+8]	;userNum
	mov		edi, [ebp+12]	;numArray

	generator:				;fills array with numbers between 100 and 999
		mov		eax, HI
		sub		eax, LO
		inc		eax
		call	RandomRange	;returns random integer in [0...N-1] where N is value in eax
		add		eax, LO
		mov		[edi], eax	;put the number in the array
		add		edi, 4		;set the next array slot
		loop	generator
	
	pop		ebp
	ret		8

fillArray	ENDP

;----------------------------------------
;This procedure displays the contents of the array passed in.
;Receives:numArray, userNum, spaces
;Returns: writes the contents of the array in rows of 10 integers
;Preconditions: must have an array with values in it and the length of that array as well as spaces to put between them
;Registers changed: esi, ecx, ebx, eax
;---------------------------------------

displayArray	PROC ;This coded is modified from the powerpoint slide "Display: version 0.1 (register indirect) in lecture 20

	push	ebp
	mov		ebp, esp
	mov		esi, [ebp+16]	;numArray
	mov		ecx, [ebp+12]	;userNum
	mov		ebx, 0			;counter for 10 integers on a line

	newLineCheck:
		inc		ebx
		cmp		ebx, 10
		jle		print
		mov		ebx, 1
		call	CrLf

	print:
		mov		eax, [esi]
		call	WriteDec
		mov		edx, [ebp+8]	;spaces
		call	WriteString
		add		esi, 4
		loop	newLineCheck
		
	pop		ebp
	ret		16

displayArray	ENDP

;----------------------------------------
;This procedure uses bubblesort to sort the list from greatest to least
;Receives:numArray, userNum
;Returns: sorted array
;Preconditions: must have an array with values in it and the length of that array
;Registers changed: ecx, esi, eax
;---------------------------------------

sortList		PROC		;Bubblesort code taken from textbook page 375

	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp+8]		;userNum
	dec		ecx

	L1:	
		push	ecx				;save outer loop count
		mov		esi, [ebp+12]	;numArray
	L2:
		mov		eax, [esi]		;get array value
		cmp		[esi+4], eax	;compare a pair of values
		jl		L3				;if [ESI] <= [ESI+4], no exchange
		xchg	eax, [esi+4]	;otherwise exhange the pair
		mov		[esi], eax
	L3:
		add		esi, 4			;move both pointers forward
		loop	L2				;inner loop

		pop		ecx				;retrieve outer loop count
		loop	L1				;else repeate outer loop
	L4:
		pop		ebp
		ret		8

sortList		ENDP

;----------------------------------------
;This procedure displays the median of an array of integers
;Receives:numArray, userNum
;Returns: median of array to the screen
;Preconditions: must have an array with values in it and the length of that array
;Registers changed: esi, eax, ebx, ecx
;---------------------------------------

displayMedian PROC

	push	ebp
	mov		ebp, esp
	mov		esi, [ebp+12]		;numArray
	mov		eax, [ebp+8]		;userNum
	cdq
	mov		ebx, 2
	div		ebx
	cmp		edx, 0				;no remainder = even
	je		evenNum

	oddNum:
		mov		ebx, [esi+eax*4]
		mov		eax, ebx
		call	WriteDec
		jmp		finished

	evenNum:
		dec		eax
		mov		ebx, [esi+eax*4]
		inc		eax
		mov		ecx, [esi+eax*4]
		mov		eax, ebx
		add		eax, ecx
		mov		ebx, 2
		div		ebx
		call	WriteDec

	finished:
		pop		ebp
		ret		12

displayMedian ENDP

END main

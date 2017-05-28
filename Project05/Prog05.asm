
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

MAX = 200
MIN = 10
HI = 999
LO = 100

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

.code
main PROC

	call Randomize

	push OFFSET intro01
	push OFFSET intro02
	push OFFSET intro03
	push OFFSET titleMess
	call introduction

	call CrLf

	push userNum
	push OFFSET prompt01
	push OFFSET errorMess
	call getData
	mov	 userNum, eax

	push OFFSET numArray
	push userNum
	call fillArray

	call CrLf

	mov	 edx, OFFSET display01
	call WriteString
	push OFFSET numArray
	push userNum
	push OFFSET spaces
	call displayArray

	call CrLf
	call CrLf

	push OFFSET numArray
	push userNum
	call sortList

	mov	 edx, OFFSET display02
	call WriteString
	push OFFSET numArray
	push userNum
	push OFFSET spaces
	call displayArray

	call CrLf

	exit

main ENDP

;----------------------------------------
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
introduction PROC

	push	ebp
	mov		ebp, esp
	mov		edx, [ebp+8]
	call	WriteString
	mov		edx, [ebp+20]
	call	WriteString
	mov		edx, [ebp+16]
	call	WriteString
	mov		edx, [ebp+12]
	call	WriteString
	pop		ebp
	ret		16		;offset of a word is 4 bits * 4 = 12

introduction ENDP

;----------------------------------------
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
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
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
fillArray	PROC

	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp+8]	;userNum
	mov		edi, [ebp+12]	;numArray

	generator:				;fills array with nubmers between 100 and 999
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
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------

displayArray	PROC ;This coded is modified from the poperpoint slide "Display: version 0.1 (register indirect) in lecture 20

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

END main

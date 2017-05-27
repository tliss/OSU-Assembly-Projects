
TITLE Prog05 - Composite Numbers     (Prog05.asm)

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
userNum		DWORD	?	;number as entered by the user
currentNum	DWORD	?	;number currently being test to see if it is a composite number
testNum		DWORD	?	;number being tested against
numCounter	DWORD	0	;used for counting how many numbers have been outputted (for formatting)

titleMess	BYTE	"		Prog04 - Composite Numbers		by Taylor Liss", 0dh, 0ah, 0
intro01		BYTE	"Enter the number of composite numbers you would like to see.",0dh,0ah,0
intro02		BYTE	"I'll accept orders for up to 400 composites.",0dh,0ah,0
prompt01	BYTE	"Enter the number of composites to display [1 .. 400]: ", 0
errorMess	BYTE	"Out of range. Try again.", 0dh, 0ah, 0
goodbye		BYTE	"Results certified by Taylor Liss. Goodbye.", 0dh, 0ah, 0
extraCred1	BYTE	"**EC 1: This program displays the output in columns.", 0dh, 0ah, 0

UPPERLIMIT = 1000
LOWERLIMIT = 1

;**EC 1: The following strings are used to display the numbers in aligned columns
space1		BYTE	" ", 0
space2		BYTE	"  ", 0
space3		BYTE	"   ", 0

.code
main PROC

	call introduction
	call getUserData
	call showComposites
	call farewell
	exit

main ENDP

;----------------------------------------
;This procedure displays the introduction
;message and the extra credit qualified for
;Receives: N/A
;Returns: N/A
;Preconditions: N/A
;Registers changed: edx
;---------------------------------------
introduction PROC

	mov		edx, OFFSET titleMess
	call	WriteString	
	mov		edx, OFFSET extraCred1
	call	WriteString
	mov		edx, OFFSET intro01
	call	WriteString
	mov		edx, OFFSET intro02
	call	WriteString

	call	CrLf
	ret

introduction ENDP

;----------------------------------------
;This procedure gets the number of component
;numbers to display and validates the user
;input through the validate procedure
;Receives: N/A
;Returns: value to userNum
;Preconditions: N/A
;Registers changed: eax, edx
;---------------------------------------
getUserData	PROC

	mov		edx, OFFSET prompt01
	call	WriteString
	call	ReadInt
	mov		userNum, eax
	call	validate

getUserData ENDP

;----------------------------------------
;This procedure validates that userNum
;is between lower and uper limit
;Receives: N/A
;Returns: value to userNum
;Preconditions: a number in userNum
;Registers changed: eax, edx
;---------------------------------------
validate PROC

	mov		eax, userNum
	cmp		eax, UPPERLIMIT
	jg		invalid
	cmp		eax, LOWERLIMIT
	jl		invalid
	ret

	invalid:
	mov		edx, OFFSET errorMess
	call	writeString
	jmp		getUserData

validate ENDP

;----------------------------------------
;This procedure displays a number of composites
;equal to userNum. It finds out if a number is
;a composite through the isComposite subroutine
;Receives: N/A
;Returns: composites to the console
;Preconditions: number in userNum
;Registers changed: eax, ecx, edx, currentNum, testNum, numCounter
;---------------------------------------
showComposites	PROC

	mov		ecx, userNum
	mov		currentNum, 1

	L1:	;start testing numbers
	inc		currentNum
	mov		testNum, 1
	jmp		L2

	L2: ;for every number below the current number
	inc		testNum
	mov		edx, 0
	mov		eax, currentNum
	cmp		eax, testNum
	je		continue
	cdq
	div		testNum

	cmp		edx, 0
	call	isComposite

	cmp		ecx, 0
	je		finishLoop

	jmp		L2

	continue:
	cmp		ecx, 0
	je		finishLoop
	jmp		L1

	finishLoop:
	ret

	;----------------------------------------
	;This procedure displays actually writes the
	;composite numbers to the screen and spaces
	;them correctly into columns.
	;Receives: N/A
	;Returns: composites to the console with spaces
	;Preconditions: integers in currentNum
	;Registers changed: ecx, eax, numCounter
	;---------------------------------------
	isComposite	PROC

		dec		ecx
		mov		eax, currentNum
		call	WriteDec
		inc		numCounter

		cmp		eax, 10
		jl		addThreeSpace

		cmp		eax, 100
		jl		addTwoSpace

		cmp		eax, 1000
		jl		addOneSpace

		addThreeSpace:
		mov		edx, OFFSET space3
		call	WriteString
		cmp		numCounter, 10
		je		newLine
		jmp		continue

		addTwoSpace:
		mov		edx, OFFSET space2
		call	WriteString
		cmp		numCounter, 10
		je		newLine
		jmp		continue

		addOneSpace:
		mov		edx, OFFSET space1
		call	WriteString
		cmp		numCounter, 10
		je		newLine
		jmp		continue

		newLine:
		call	CrLf
		mov		numCounter, 0
		jmp		continue

		continue:
		inc		currentNum
		mov		testNum, 1
		ret

	isComposite ENDP

showComposites	ENDP

;----------------------------------------
;This procedure displays a farwell greeting.
;Receives: N/A
;Returns: farewell to console
;Preconditions: N/A
;Registers changed: edx
;---------------------------------------
farewell PROC
	call	CrLf
	mov		edx, OFFSET goodbye
	call	CrLf
	call	WriteString
	call	CrLf
	ret
farewell ENDP

END main

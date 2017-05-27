
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
userNum		DWORD	?	;number as entered by the user

titleMess	BYTE	"		Prog05 - Sorting Random Integers		by Taylor Liss", 0dh, 0ah, 0
intro01		BYTE	"This program generates random numbers in the range [100 .. 999],",0dh,0ah,0
intro02		BYTE	"displays the original list, sorts the list, and calculates the",0dh,0ah,0
intro03		BYTE	"median value. Finally, it displays the list sorted in descending order.",0dh,0ah,0
prompt01	BYTE	"How many numbers should be generated? [10 .. 200]:", 0
errorMess	BYTE	"Invalid input", 0dh, 0ah, 0

MAX = 200
MIN = 10


.code
main PROC

	call Randomize

	push OFFSET intro01
	push OFFSET intro02
	push OFFSET intro03
	call introduction

	push userNum
	push OFFSET prompt01
	push OFFSET errorMess
	call getData

	;call showComposites
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

	mov		edx, [ebp+16]
	call	WriteString
		
	mov		edx, [ebp+12]
	call	WriteString

	mov		edx, [ebp+8]
	call	WriteString

	pop		ebp
	ret		12		;offset of a word is 4 bits * 3 = 12

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
showComposites	PROC

	ret

showComposites	ENDP

END main
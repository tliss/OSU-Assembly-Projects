
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
HIGH = 999
LO = 100

.code
main PROC

	call Randomize

	call introduction
	call getData
	call showComposites
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

	mov		edx, OFFSET titleMess
	call	WriteString	
	mov		edx, OFFSET intro01
	call	WriteString
	mov		edx, OFFSET intro02
	call	WriteString
	mov		edx, OFFSET intro03
	call	WriteString

	call	CrLf
	ret

introduction ENDP

;----------------------------------------
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
getData	PROC

	mov		edx, OFFSET prompt01
	call	WriteString
	call	ReadInt
	mov		userNum, eax
	call	validate

getData ENDP

;----------------------------------------
;
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
validate PROC

	mov		eax, userNum
	cmp		eax, MAX
	jg		invalid
	cmp		eax, MIN
	jl		invalid
	ret

	invalid:
	mov		edx, OFFSET errorMess
	call	writeString
	jmp		getData

validate ENDP

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

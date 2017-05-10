
TITLE Prog04 - Composite Numbers     (Prog04.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course: CS271_400_S2017
; Project ID: Prog04
; Date: 5/14/2017
; Description: This program calculates composite numbers.
;   A user enters in the number of composite numbers to
;   be displayed and the program calculates and siplays 
;	all of the composite numbers up to and including the 
;	nth composite.

INCLUDE Irvine32.inc

.data
userNum		DWORD	?	;number as entered by the user

titleMess	BYTE	"		Prog04 - Composite Numbers		by Taylor Liss", 0dh, 0ah, 0
intro01		BYTE	"Enter the number of composite numbers you would like to see.",0dh,0ah,0
intro02		BYTE	"I'll accept orders for up to 400 composites.",0dh,0ah,0
prompt01	BYTE	"Enter the number of composites to display [1 .. 400]: ", 0
errorMess	BYTE	"Out of range. Try again.", 0dh, 0ah, 0
validNum	BYTE	"Valid number entered!", 0dh, 0ah, 0

UPPERLIMIT = 400
LOWERLIMIT = 1

.code
main PROC

	call introduction
	call getUserData

	exit
main ENDP

introduction PROC

	;Display program title & instructions
	mov		edx, OFFSET titleMess
	call	WriteString	
	mov		edx, OFFSET intro01
	call	WriteString
	mov		edx, OFFSET intro02
	call	WriteString
	call	CrLf

introduction ENDP

getUserData	PROC

	;Get number
	mov		edx, OFFSET prompt01
	call	WriteString
	call	ReadInt
	mov		userNum, eax
	call	validate
	mov		edx, OFFSET validNum

getUserData ENDP

validate PROC

	validateLoop:
	mov		eax, userNum
	cmp		eax, UPPERLIMIT
	jg		invalid
	cmp		eax, LOWERLIMIT
	jl		invalid
	ret

	invalid:
	mov		edx, OFFSET errorMess
	call	writeString
	jmp		validateLoop

validate ENDP

END main

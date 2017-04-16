
TITLE Prog01 - Elementary Arithmetic     (Prog01.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course / Project ID  CS271_400_S2017 / Prog01
; Date: 4/15/2017
; Description: This program dsplays my name and the program
;	title on the output screen and instructs the user to
;	enter in two numbers. It then calculates the sum,
;	difference, product, (integer) quotent, and remainder
;	of the two numbers. It then displays a terminating
;	message.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
firstNum	DWORD	?	;first number to be entered by user
secondNum	DWORD	?	;second number to be entered by user
titleMess	BYTE	"		Prog01 - Elementary Arithmetic		by Taylor Liss",0dh,0ah,0ah,0
intro		BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.",0dh,0ah,0
prompt01	BYTE	"First number: ", 0
prompt02	BYTE	"Second number: ", 0
sumMess		BYTE	" + ", 0
diffMess	BYTE	" - ", 0
prodMess	BYTE	" x ", 0
quotMess	BYTE	" / ", 0
equMess		BYTE	" = ", 0
remMess		BYTE	" remainder ", 0
notBadMess	BYTE	"Not bad, huh?", 0dh, 0ah, 0
goodbyeMess	BYTE	"Goodbye!", 0dh, 0ah, 0
startAgain	BYTE	"Would you like to go again? (y/n)", 0
again		BYTE	?	;user's y/n response

.code
main PROC
	
startPoint: ;Program restarts to here when request.

;Display program title & instructions
	mov		edx, OFFSET titleMess
	call	WriteString
	mov		edx, OFFSET intro
	call	WriteString
	call	CrLf

;Get first number
	mov		edx, OFFSET prompt01
	call	WriteString
	call	ReadInt
	mov		firstNum, eax

;Get second number
	mov		edx, OFFSET prompt02
	call	WriteString
	call	ReadInt
	mov		secondNum, eax
	call	CrLf

;calculate and display sum
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET sumMess
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equMess
	call	WriteString

	mov		eax, firstNum
	add		eax, secondNum
	call	WriteDec
	call	CrLf

;calculate and display difference
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET diffMess
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equMess
	call	WriteString
	
	mov		eax, firstNum
	sub		eax, secondNum
	call	WriteDec
	call	CrLf

;calculate and display the product
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET prodMess
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equMess
	call	WriteString

	mov		eax, firstNum
	mov		ebx, secondNum
	mul		ebx
	call	WriteDec
	call	CrLf

;calculate and display the quotient
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET quotMess
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equMess
	call	WriteString

	cdq
	mov		eax, firstNum
	mov		ebx, secondNum
	div		ebx
	call	WriteDec
	
;display the remainder
	mov		eax, edx
	mov		edx, OFFSET remMess
	call	WriteString
	call	WriteDec
	call	CrLf
	call	CrLf

;display the 'not bad' message
	mov		edx, OFFSET notBadMess
	call	WriteString
	call	CrLf

;Check to see if user wants to restart the program
	mov		edx, OFFSET startAgain
	call	WriteString
	call	ReadChar
	call	WriteChar
	call	ClrScr
	cmp		al, 121
	jz		startPoint

;display the goodbye message
	mov		edx, OFFSET goodbyeMess
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

END main

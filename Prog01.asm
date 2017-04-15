
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
prompt01	BYTE	"This program performs elementary arithmetic on two numbers. Please enter a positive integer and then press enter.",0dh,0ah,0
prompt02	BYTE	"Please enter a second positive integer and then press enter.",0dh,0ah,0

.code
main PROC
	
;Display program title
	mov		edx, OFFSET titleMess
	call	WriteString

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

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main

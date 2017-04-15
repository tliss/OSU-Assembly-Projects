
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
sumMess		BYTE	"The sum of the two numbers is ", 0
diffMess	BYTE	"The difference of the two numbers is ", 0
prodMess	BYTE	"The product of the two numbers is ", 0
quotMess	BYTE	"The quotient of the two numbers is ", 0
remMess		BYTE	"The remainder of the two numbers is ", 0

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

;calculate and display sum
	mov		edx, OFFSET sumMess
	call	WriteString
	mov		eax, firstNum
	add		eax, secondNum
	call	WriteDec
	call	CrLf

;calculate and display difference
	mov		edx, OFFSET diffMess
	call	WriteString
	mov		eax, firstNum
	sub		eax, secondNum
	call	WriteDec
	call	CrLf

;calculate and display the product
	mov		edx, OFFSET prodMess
	call	WriteString
	mov		eax, firstNum
	mov		ebx, secondNum
	mul		ebx
	call	WriteDec
	call	CrLf

;calculate and display the difference
	mov		edx, OFFSET diffMess
	call	WriteString
	cdq
	mov		eax, firstNum
	mov		ebx, secondNum
	div		ebx
	call	WriteDec
	call	CrLf
	
;display the remainder
	mov		eax, edx
	mov		edx, OFFSET remMess
	call	WriteString
	call	WriteDec
	call	CrLf	



	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main


TITLE Prog02 - Fibonacci Numbers     (Prog02.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course / Project ID  CS271_400_S2017 / Prog02
; Date: 4/19/2017
; Description: This program calculates Fibonacci numbers. It
;	asks for the users name and displays a greeting and a
;	farewell to them. It also validates that the user only
;	enters terms between the range [1 .. 46]. It displays
;	the results in aligned columns.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
rangeNum	DWORD	?		;range of fibonacci terms
nextNum		DWORD	?		;next fibonacci number in the sequence
columnNum	DWORD	?		;counter for column place

UPPER_LIMIT = 46	;max size for Fibonacci range
LOWER_LIMIT = 1		;min size for Fibonacci range

userName	DWORD	80 DUP (?)

titleMes	BYTE	"		Prog02 - Fibonacci Numbers		by Taylor Liss", 0dh, 0ah, 0
EC1Mes		BYTE	"**EC #1: This program list the Fibonacci terms in aligned columns", 0dh, 0ah, 0
nameMes		BYTE	"What's your name? ", 0
helloMes	BYTE	"Hello, ", 0
fibPrompt	BYTE	"Enter the number of Fibonacci terms to be displayed", 0dh, 0ah, 0
fibPrompt2	BYTE	"Give the number as an integer in the range [1 .. 46]", 0dh, 0ah, 0
fibPrompt3	BYTE	"How many Fibonacci terms do you want? ", 0
certMes		BYTE	"Results certified by Taylor Liss", 0dh, 0ah, 0
goodbyeMes	BYTE	"Goodbye, ", 0

invalidMes	BYTE	"Out of range. Enter a number in [1 .. 46]", 0

;**EC 1: The following strings are used to display the numbers in aligned columns
space2		BYTE	"  ", 0
space3		BYTE	"   ", 0
space4		BYTE	"    ", 0
space5		BYTE	"     ", 0
space6		BYTE	"      ", 0
space7		BYTE	"       ", 0
space8		BYTE	"        ", 0
space9		BYTE	"         ", 0
space10		BYTE	"          ", 0

.code
main PROC
;-----introduction-----
;Display program title
	mov		edx, OFFSET titleMes
	call	WriteString	
	mov		edx, OFFSET EC1Mes
	call	WriteString
	call	CrLf

;Get user name
	mov		edx, OFFSET nameMes
	call	WriteString

	mov		edx, OFFSET userName
	mov		ecx, 80
	call	ReadString

;Say hello
	mov		edx, OFFSET helloMes
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

;-----userInstructions-----
;Ask for for number of Fibonacci terms
	mov		edx, OFFSET fibPrompt
	call	WriteString
	mov		edx, OFFSET fibPrompt2
	call	WriteString
	call	CrLf

;-----getUserData-----
rangePrompt:	;Get range
	mov		edx, OFFSET fibPrompt3
	call	WriteString
	call	ReadInt
	mov		rangeNum, eax

;Check to see if number is 1-46
	cmp		eax, LOWER_LIMIT
	jl		notValid
	cmp		eax, UPPER_LIMIT
	jg		notValid

;-----displayFibs-----
;Setup fibonacci loop
	mov		eax, 0
	mov		ebx, 1
	mov		ecx, rangeNum
	mov		nextNum, 1
	mov		columnNum, 1
fibLoop:	;displayFibs
	mov		nextNum, eax
	add		eax, ebx
	call	WriteDec
	mov		ebx, nextNum

;EC1: This code formats the strings into columns based on the length of the length of the integer
	cmp		eax, 10
	jl		addTenSpace

	cmp		eax, 100
	jl		addNineSpace

	cmp		eax, 1000
	jl		addEightSpace

	cmp		eax, 10000
	jl		addSevenSpace

	cmp		eax, 100000
	jl		addSixSpace

	cmp		eax, 1000000
	jl		addFiveSpace

	cmp		eax, 10000000
	jl		addFourSpace

	cmp		eax, 100000000
	jl		addThreeSpace

	cmp		eax, 1000000000
	jl		addTwoSpace

	jmp		columnCheck	;This ensures that a column check will always be done

continueLoop:
	loop	fibLoop

;-----farewell-----
;Farewell
	call	CrLf
	call	CrLf
	mov		edx, OFFSET certMes
	call	WriteString
	mov		edx, OFFSET goodbyeMes
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

	exit	;exit to operating system

notValid:	;invalid range entered
	mov		edx, OFFSET invalidMes
	call	WriteString
	call	CrLf
	jmp		rangePrompt

;EC 1: The following labels are used to format the numbers into columns
addTenSpace:
	mov		edx, OFFSET space10
	call	WriteString
	jmp		columnCheck

addNineSpace:
	mov		edx, OFFSET space9
	call	WriteString
	jmp		columnCheck

addEightSpace:
	mov		edx, OFFSET space8
	call	WriteString
	jmp		columnCheck

addSevenSpace:
	mov		edx, OFFSET space7
	call	WriteString
	jmp		columnCheck

addSixSpace:
	mov		edx, OFFSET space6
	call	WriteString
	jmp		columnCheck

addFiveSpace:
	mov		edx, OFFSET space5
	call	WriteString
	jmp		columnCheck

addFourSpace:
	mov		edx, OFFSET space4
	call	WriteString
	jmp		columnCheck

addThreeSpace:
	mov		edx, OFFSET space3
	call	WriteString
	jmp		columnCheck

addTwoSpace:
	mov		edx, OFFSET space2
	call	WriteString
	jmp		columnCheck

;This checks to see if the last number was placed into the fifth column
columnCheck:
	cmp		columnNum, 5
	je		addRow
	inc		columnNum
	jmp		continueLoop

addRow:		;adds a new row if the last number printed was the fifth number in a row.
	call	CrLf
	mov		columnNum, 1
	jmp		continueLoop

main ENDP

END main

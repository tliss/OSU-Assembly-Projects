
TITLE Prog02 - Fibonacci Numbers     (Prog02.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course / Project ID  CS271_400_S2017 / Prog02
; Date: 4/19/2017
; Description: This program dsplays my name and the program
;	title on the output screen and instructs the user to
;	enter in two numbers. It then calculates the sum,
;	difference, product, (integer) quotent, and remainder
;	of the two numbers. It then displays a terminating
;	message.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
rangeNum	DWORD	?		;range of fibonacci terms
nextNum		DWORD	?		;next fibonacci number in the sequence

UPPER_LIMIT = 46	;max size for Fibonacci range
LOWER_LIMIT = 1		;min size for Fibonacci range

userName	DWORD	80 DUP (?)

titleMes	BYTE	"		Prog02 - Fibonacci Numbers		by Taylor Liss", 0dh, 0ah, 0
nameMes		BYTE	"What's your name? ", 0
helloMes	BYTE	"Hello, ", 0
fibPrompt	BYTE	"Enter the number of Fibonacci terms to be displayed", 0dh, 0ah, 0
fibPrompt2	BYTE	"Give the number as an integer in the range [1 .. 46]", 0dh, 0ah, 0
fibPrompt3	BYTE	"How many Fibonacci terms do you want? ", 0
certMes		BYTE	"Results certified by Taylor Liss", 0dh, 0ah, 0
goodbyeMes	BYTE	"Goodbye, ", 0

invalidMes	BYTE	"Out of range. Enter a number in [1 .. 46]", 0

.code
main PROC
;-----introduction-----
;Display program title
	mov		edx, OFFSET titleMes
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
fibLoop:	;displayFibs
	mov		nextNum, eax
	add		eax, ebx
	call	WriteDec
	call	CrLf
	mov		ebx, nextNum
	loop	fibLoop

;-----farewell-----
;Farewell
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

main ENDP

END main

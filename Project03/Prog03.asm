
TITLE Prog01 - Elementary Arithmetic     (Prog01.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course / Project ID  CS271_400_S2017 / Prog03
; Date: 4/28/2017
; Due Date: 4/30/207
; Description: This program greets the user and
; prompts the user to enter in negative integers.
; The user will continue to be prompted until they
; enter a non-negative integerr. The program will
; then display the sum of all integers entered.
; The program will also display the average (rounded)
; of all integers entered. The program will then
; display a farewell message.

;**EC#1: This program numbers the lines during input
;**EC#2: This program calculates and displays the average as a floating-point number, rounded to the nearest .001
;**EC#3: This program

INCLUDE Irvine32.inc

.data
projName		BYTE	"Prog03 - Integer Accumulator", 0dh, 0ah, 0
authName		BYTE	"By Taylor Liss", 0dh, 0ah, 0
reqNameMess		BYTE	"What is your name? ", 0
helloMes		BYTE	"Hello, ", 0
instructMess1	BYTE	"Please enter numbers in [-100, -1].", 0dh, 0ah, 0
instructMess2	BYTE	"Enter a non-negative number when you are finished to see results.", 0dh, 0ah, 0
numberPrompt	BYTE	"Number #", 0
colon			BYTE	": ", 0
tooSmallMess	BYTE	"The number you entered is smaller than -100.", 0dh, 0ah, 0
totalNumMess1	BYTE	"You entered ", 0
totalNumMess2	BYTE	" valid numbers.", 0dh, 0ah, 0
sumMess			BYTE	"The sum of your valid numbers is ", 0
averMess		BYTE	"The rounded average is ", 0
dotMess			BYTE	".", 0
goodbyeMess		BYTE	"Goodbye, ", 0

ecMessage1		BYTE	"**EC#1: This program numbers the lines during input", 0dh, 0ah, 0
ecMessage2		BYTE	"**EC#2: This program calculates and displays the average as a floating-point number, rounded to the nearest .001", 0dh, 0ah, 0
ecMessage3		BYTE	"**EC#3: This program ", 0dh, 0ah, 0

userName		DWORD	80 DUP (?)

LOWER_LIMIT = -100
UPPER_LIMIT = -1

totalNums		DWORD	?	;keeps track of how many numbers were entered
userNum			DWORD	?	;the current number entered by the user
accumulator		DWORD	?	;where all numbers entered in are added together
average			DWORD	?	;the average of all numbers entered in
remainder		DWORD	?	;the remainder left over after averaging
doubleRem		DWORD	?	;double the value of the remainder

.code
main PROC

;Display program title & author name
	mov		edx, OFFSET projName
	call	WriteString	
	mov		edx, OFFSET authName
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ecMessage1
	call	WriteString
	mov		edx, OFFSET ecMessage2
	call	WriteString
	mov		edx, OFFSET ecMessage3
	call	WriteString
	call	CrLf

;Get user name
	mov		edx, OFFSET reqNameMess
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

;Display isntructions
	mov		edx, OFFSET instructMess1
	call	WriteString
	mov		edx, OFFSET instructMess2
	call	WriteString

	mov		totalNums, 0	;setup totalNums

mainLoop:	;this loop is where the user enters in values until they enter in a positive integer
	inc		totalNums
	mov		edx, OFFSET numberPrompt
	call	WriteString
	mov		eax, totalNums
	call	WriteDec
	mov		edx, OFFSET	colon
	call	WriteString

	call	ReadInt
	mov		userNum, eax
	cmp		userNum, LOWER_LIMIT	;if number less than -100 is entered
	jl		tooSmall
	cmp		userNum, UPPER_LIMIT	;if positive # is entered
	jg		finished

	add		accumulator, eax
	jmp		mainLoop

tooSmall:	;this is where you end up if the number entered is lower than -100
	mov		edx, OFFSET tooSmallMess
	call	WriteString
	mov		edx, OFFSET	instructMess1
	call	WriteString
	dec		totalNums
	jmp		mainLoop

finished:	;this is where you end up once a non-negative number is entered
	dec		totalNums
	mov		edx, OFFSET totalNumMess1
	call	WriteString
	mov		eax, totalNums
	call	WriteDec
	mov		edx, OFFSET	totalNumMess2
	call	WriteString
	mov		edx, OFFSET sumMess
	call	WriteString
	mov		eax, accumulator
	call	WriteInt

	;calculate average with the proper math to get the right decimal value
	mov		eax, accumulator
	mov		ebx, 1000
	mul		ebx
	mov		ebx, totalNums
	cdq
	idiv	ebx
	mov		average, eax
	neg		edx
	mov		remainder, edx
	call	CrLf

	;mulitply remainder by 2
	mov		eax, remainder
	mov		ebx, 2
	mul		ebx
	mov		doubleRem, eax

	;compare doubleRem to totalNums and decrement average (round down) if doubleRem is larger
	mov		eax, doubleRem
	cmp		eax, totalNums
	jge		decrementAverage
	
	jmp		displayResult

decrementAverage:	;decrement average here 
	mov		eax, average
	dec		average
	jmp		displayResult

displayResult:		;display the rounded decimal here
	mov		edx, OFFSET averMess
	call	WriteString

	mov		eax, average
	mov		ebx, 1000
	cdq
	idiv	ebx	
	call	WriteInt
	mov		eax, edx
	neg		eax
	mov		edx, OFFSET dotMess
	call	WriteString
	call	WriteDec
	call	CrLf

	;say goodbye
	mov		edx, OFFSET goodbyeMess
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
	call	CrLf

	exit	; exit to operating system
main ENDP

END main

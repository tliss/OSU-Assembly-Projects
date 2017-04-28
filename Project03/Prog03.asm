
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

INCLUDE Irvine32.inc

.data
projName		BYTE	"Prog03 - Integer Accumulator", 0dh, 0ah, 0
authName		BYTE	"By Taylor Liss", 0dh, 0ah, 0
reqNameMess		BYTE	"What is your name? ", 0
helloMes		BYTE	"Hello, ", 0
instructMess1	BYTE	"Please enter numbers in [-100, -1].", 0dh, 0ah, 0
instructMess2	BYTE	"Enter a non-negative number when you are finished to see results."
numberPrompt	BYTE	"Number #", 0
colon			BYTE	": ", 0
tooSmallMess	BYTE	"The number you entered is smaller than -100.", 0dh, 0ah, 0

userName		DWORD	80 DUP (?)

LOWER_LIMIT = -100
UPPER_LIMIT = -1

totalNums		DWORD	?
userNum			DWORD	?


.code
main PROC
	
startPoint: ;Program restarts to here when request.

;Display program title & author name
	mov		edx, OFFSET projName
	call	WriteString	
	mov		edx, OFFSET authName
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

L1:
	inc		totalNums
	mov		edx, OFFSET numberPrompt
	call	WriteString
	mov		eax, totalNums
	call	WriteDec
	mov		edx, OFFSET	colon
	call	WriteString

	call	ReadInt
	mov		userNum, eax
	cmp		userNum, LOWER_LIMIT
	jl		tooSmall
	cmp		userNum, UPPER_LIMIT
	jmp		finished

tooSmall:
	mov		edx, OFFSET tooSmall
	call	WriteString
	mov		edx, OFFSET	instructMess1
	call	WriteString
	dec		totalNums
	jmp		L1

finished:


	exit	; exit to operating system
main ENDP

END main

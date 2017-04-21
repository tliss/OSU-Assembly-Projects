
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
firstNum	DWORD	?		;first number placeholder
secondNum	DWORD	?		;second number placeholder
thirdNum	DWORD	?		;third number placeholder

MAX = 80
userName	DWORD	MAX+1 DUP (?)

titleMes	BYTE	"		Prog02 - Fibonacci Numbers		by Taylor Liss", 0dh, 0ah, 0
introMes	BYTE	"This program calculates a Fibonacci sequence.", 0dh, 0ah, 0
nameMes		BYTE	"Enter your name: ", 0
helloMes	BYTE	"Hello, ", 0

.code
main PROC

;Display program title & instructions
	mov		edx, OFFSET titleMes
	call	WriteString	
	call	CrLf
	mov		edx, OFFSET introMes
	call	WriteString

;Get user name
	mov		edx, OFFSET nameMes
	call	WriteString

	mov		edx, OFFSET userName
	mov		ecx, MAX
	call	ReadString

	mov		userName, edx ;need to null-termiante this somehow

;Say hello
	mov		edx, OFFSET helloMes
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

END main

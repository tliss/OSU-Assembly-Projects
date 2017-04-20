
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
firstNum	DWORD	?	;first number placeholder
secondNum	DWORD	?	;second number placeholder
thirdNum	DWORD	?	;third number placeholder

titleMes	BYTE	"		Prog02 - Fibonacci Numbers		by Taylor Liss", 0dh, 0ah, 0
introMes	BYTE	"This program calculates a Fibonacci sequence.", 0dh, 0ah, 0
nameMes		BYTE	"What's your name?",0dh,0ah,0

.code
main PROC

;Display program title & instructions
	mov		edx, OFFSET titleMes
	call	WriteString	
	call	CrLf
	mov		edx, OFFSET nameMes
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

;EC #2: This compare the numbers and stops the program if the second number is greater than the first
	mov		eax, firstNum
	mov		ebx, secondNum
	cmp		eax, ebx
	jl		lessJump

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
	mov		addResult, eax
	mov		eax, addResult
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
	mov		subResult, eax
	mov		eax, subResult
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
	mov		mulResult, eax
	mov		eax, mulResult
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
	mov		divResult, eax
	mov		remResult, edx
	mov		eax, divResult
	call	WriteDec
	
;display the remainder
	
	mov		edx, OFFSET remMess
	call	WriteString
	mov		eax, remResult
	call	WriteDec
	call	CrLf
	call	CrLf

;EC #3: This section calculates and displays the number as a floating point
		
		;Multiply firstNum by 10000 and divide it by seconNum
			mov		eax, firstNum
			mov		ebx, 1000
			mul		ebx
			mov		ebx, secondNum
			cdq
			div		ebx

		;Save the result and the remainder
			mov		firstDiv, eax
			mov		firstRem, edx
	
		;Multiply the remainder by 2
			mov		eax, firstRem
			mov		ebx, 2
			mul		ebx

		;save the result into doubRem
			mov		doubRem, eax

		;compare the the doubleRem to secondNum and increment firstDiv (round up) if doubleRem is larger
			cmp		eax, secondNum
			jge		incrementResult

			jmp		displayResult

;display the 'not bad' message
	mov		edx, OFFSET notBadMess
	call	WriteString
	call	CrLf

restart:	;Check to see if user wants to restart the program
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


lessJump:	;will jump here if the first number is less than the second
	mov		edx, OFFSET lessThan
	call	WriteString
	call	CrLf
	jmp		restart

incrementResult: ;EC #3: Here firstDiv is incremented (rounded up)
	inc		firstDiv
	jmp		displayResult

displayResult: ;EC #3: Here the floating-point value is calculated and displayed
	mov		eax, firstDiv
	mov		ebx, 1000
	cdq
	div		ebx
	mov		decNum, edx

	mov		edx, OFFSET ecMess
	call	WriteString
	mov		wholeNum, eax
	call	WriteDec
	mov		edx, OFFSET dotMess
	call	WriteString
	mov		eax, decNum
	call	WriteDec
	call	CrLf
	call	CrLf
	jmp		restart

	exit	; exit to operating system
main ENDP

END main

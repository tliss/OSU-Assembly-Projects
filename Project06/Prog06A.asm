
TITLE Prog06A - Designing low-level I/O procedures     (Prog06A.asm)

; Author: Taylor Liss
; Email: lisst@oregonstate.edu
; Course: CS271_400_S2017
; Project ID: Prog06A
; Date: 6/9/2017
; Description: 

INCLUDE Irvine32.inc

MAXSIZE = 10	;Max size of the array

.data
myArray			DWORD	MAXSIZE DUP(?)
passedValue		DWORD	10 DUP(0)
holdingSpot		BYTE	255 DUP(0)

titleMess	BYTE	"Prog06A - Designing low-level I/O procedures		by Taylor Liss", 0dh, 0ah, 0
intro01		BYTE	"Please provide 10 unsigned decimal integers",0dh,0ah,0
intro02		BYTE	"Each number needs to be small enough to fit inside a 32 bit register.",0dh,0ah,0
intro03		BYTE	"After you have finished inputting the raw numbers I will display a list",0dh,0ah,0
intro04		BYTE	"of the integers, their sum, and their average value.",0dh,0ah,0
prompt01	BYTE	"Please enter an unsigned number: ", 0
errorMess	BYTE	"ERROR: You did not enter an unsigned number or your number was too big.", 0dh, 0ah, 0
display01	BYTE	"You entered the following numbers:", 0dh, 0ah, 0
display02	BYTE	"The sum of these numbers is: ", 0dh, 0ah, 0
display03	BYTE	"The average is: ", 0
thanksMess	BYTE	"Thanks for playing!", 0dh, 0ah, 0

.code
main PROC

	;Calling ntroduction
	push	OFFSET intro01
	push	OFFSET intro02
	push	OFFSET intro03
	push	OFFSET intro04
	push	OFFSET titleMess
	call	introduction
	
	;Calling readVal
	;mov	ecx, MAXSIZE
	;push	OFFSET myArray
	;push	OFFSET passedValue
	push	OFFSET holdingSpot
	push	SIZEOF holdingSpot
	call	readVal

	exit

main ENDP

;----------------------------------------
;This procedure writes out the title of the program
;and explains what it does.
;Receives: titleMess, prompt01, prompt02, prompt03, prompt04
;Returns: n/a
;Preconditions: 5 messages must be passed in
;Registers changed: edx
;---------------------------------------
introduction PROC

	push	ebp
	mov		ebp, esp
	mov		edx, [ebp+8]	;titleMess
	call	WriteString
	call	CrLf
	mov		edx, [ebp+24]	;prompt01
	call	WriteString
	mov		edx, [ebp+20]	;prompt02
	call	WriteString
	mov		edx, [ebp+16]	;prompt03
	call	WriteString
	mov		edx, [ebp+12]	;prompt04
	call	WriteString
	call	CrLf
	pop		ebp
	ret		24		;offset of a word is 4 bits * 6 = 24

introduction ENDP

;----------------------------------------
; Displays a prompt, then gets the user’s keyboard input into a memory location
; From lecture #26, slide 8.
; For ReadSring, EDX contains the start point, ECX is the maximum # of characters
;----------------------------------------

getString MACRO value, value2

     push      ecx
     push      edx
     mov       edx, value
     mov       ecx, value2
     call      ReadString
     pop       edx
     pop       ecx

ENDM

;----------------------------------------
; Displays the string stored in a specified memory location
;----------------------------------------

displayString MACRO



ENDM

;----------------------------------------
; Invokes the getString macro to get the user’s string of digits. 
; It then converts the digit string to numeric, while validating 
; the user’s input.
;Receives: 
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
readVal PROC

	push		ebp
	mov			ebp, esp

	getString	[ebp+12], [ebp+8]	;passing in OFFSET and SIZEOF holdingSpot

	pop			ebp
	ret			8


readVal ENDP

;----------------------------------------
; Converts a numeric value to a string of digits, and invokes the 
; displayString macro to produce the output.
;Receives:
;Returns:
;Preconditions:
;Registers changed:
;---------------------------------------
writeVal PROC

writeVal ENDP

END main

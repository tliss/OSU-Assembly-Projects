
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

message01	BYTE "		Prog01 - Elementary Arithmetic		by Taylor Liss",0dh,0ah,0

.code
main PROC
	
	mov edx, OFFSET message01
	call WriteString

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main

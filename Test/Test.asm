TITLE Test     (Test.asm)

INCLUDE Irvine32.inc

.code
main PROC

	quiz4   MACRO p,q
			LOCAL here
			push   eax
			push   ecx
			mov    eax, p
			mov    ecx, q
	here:
			mul    P
			loop   here

			mov    p, eax
			pop    ecx
			pop    eax
	ENDM

	.data
	x       DWORD 3
	y       DWORD 3

quiz

END main


TITLE	lab08
; Programmer:	Marcus Ross
; Due:		25 April, 2014
; Description:	This serves as an external subprogram for the other lab 8 programs. A number from 0h to 63h must be in al. DispNum will display the number in al as a decimal number.

		.MODEL SMALL
		.386
;==========================
		.CODE
		PUBLIC DispNum
DispNum	PROC	NEAR
		mov	dl, 0ah	; for changing order of magnitude
		xor	ah, ah	; input is in al, so make sure ax = al
		div	dl		; ax / dl; 10's place -> al, 1's place -> ah
		add	al, 30h	; num -> ascii
		add	ah, '0'
		mov	dl, al	; prep to disp ascii in al
		mov	dh, ah	; ascii in ah -> dh; need ah for DOS call
		mov	ah, 02h
		int	21h		; disp ascii from al
		mov	dl, dh	; prep to disp ascii in dh
		int	21h		; disp next ascii
		ret
DispNum	ENDP
;==========================
		END
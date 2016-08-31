TITLE	lab08_24
; Programmer:	Marcus Ross
; Due:		25 April, 2014
; Description:	This lab displays the system time in a 24 hour format using an external subprogram in bin\lab08mr.obj.

		.MODEL SMALL
		.386
		.STACK 64
;==========================
		.DATA
msg1		DB	'The time is ', 24h
msg2		DB	' hours.', 0ah, 0dh, 24h
;==========================
		.CODE
		EXTRN	DispNum : NEAR

Main		PROC	NEAR
		mov	ax, @data	; init data
		mov	ds, ax	; segment register

		call	DispDate	; display date

		mov	ax, 4c00h	; return code 0
		int	21h
Main		ENDP
;==========================
DispDate	PROC	NEAR
		mov	dx, OFFSET msg1
		mov	ah, 09h
		int	21h		; display msg1
		mov	ah, 2ch
		int	21h		; get date
		mov	al, ch	; hour -> al
		call	DispNum	; display hour
		mov	al, cl	; minute -> al
		call	DispNum	; display minute
		mov	dx, OFFSET msg2
		mov	ah, 09h
		int	21h		; display msg2
		ret
		ENDP
;==========================
		END	Main
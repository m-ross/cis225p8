TITLE	lab08_12
; Programmer:	Marcus Ross
; Due:		25 April, 2014
; Description:	This lab displays the system time in a 12 hour format using an external subprogram in bin\lab08.obj.

		.MODEL SMALL
		.386
		.STACK 64
;==========================
		.DATA
msg1		DB	'The time is ', 24h
msg2		DB	' AM.', 0ah, 0dh, 24h
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
		int	21h			; display msg1
		mov	ah, 2ch
		int	21h			; get date
		mov	al, ch		; hour -> al
		cmp	al, 12		; hour - 12
		jb	am			; time is AM if hour < 12
		sub	al, 12		; convert from 12-23 to 0-11
		mov	[msg2 + 1], 'P'	; overwrite 'AM' in msg2 to be 'PM'
am:		cmp	al, 0			; hour - 0
		jne	disp			; goto display if hour != 0
		mov	al, 12		; if hour = 0, 12 -> hour
disp:		call	DispNum		; display hour
		mov	dl, 3ah		; 3ah = ':'
		mov	ah, 02h
		int	21h			; display colon
		mov	al, cl		; minute -> al
		call	DispNum		; display minute
		mov	dx, OFFSET msg2
		mov	ah, 09h
		int	21h			; display msg2
		ret
		ENDP
;==========================
		END	Main
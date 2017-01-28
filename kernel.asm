;-------------------------------------------------------------------------------
; Autor		: Stefan Brück
; E-Mail	: <mailbockx@freenet.de>
; Last change 	: 030828
;-------------------------------------------------------------------------------
org 0x0

jmp start

%include "system.inc"

msg 	db	'<l4t3n8> OS 0.1 ...',0x00
welcome	db	'Welcome to <l4t3n8> OS 0.1 !',0x00
line	db	'--------------------------------------------------------------------------------',0x00
endl_c	db	0x0D,0x0A,0x00
prompt	db	'>> ',0x00

;-------------------------------------------------------------------------------
start:
	mov ax, es		; Programm verraten wo die Daten liegen
	mov ds, ax

	mov ax, 0x2000		; Create a stack
	mov ss, ax
	mov sp, 0xFFFF

	mov si, msg
	call println

	call greet

	jmp exit
;-------------------------------------------------------------------------------
greet:
	mov si, line
	call println

	mov si, welcome
	call println

	mov si, endl_c
	call print

	mov si, prompt
	call print

	jmp hang

	ret
;-------------------------------------------------------------------------------
exit:
	mov al,0x0
	jmp reboot

;-------------------------------------------------------------------------------
times (5*512)-($-$$) 	db 0	; The Kernel Image is always five sectors

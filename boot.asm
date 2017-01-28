;-------------------------------------------------------------------------------
; Autor		: Stefan Brück
; E-Mail	: <mailbockx@freenet.de>
; Last change 	: 030828
;-------------------------------------------------------------------------------
org  0x7C00

jmp start

%include "system.inc"

msg		db 	'Bootloader : ',0x00
err_a		db 	'Loading failt : --={ P A N I K }=--',0x00
endl		db		0x0D,0x0A,0x00

;-------------------------------------------------------------------------------
start:
	mov ax, cs
	mov ds, ax

	mov  si, msg
	call print

	call loados
	jmp panik

;-------------------------------------------------------------------------------
loados:
	mov ax, 0x1000
	mov es, ax
	mov bx, 0

	mov ah, 0x02
	mov al, 0x05
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00
	mov dl, 0x00
	int 0x13

	jmp 0x1000:0x0000

	ret

;-------------------------------------------------------------------------------
panik:
	mov si, err_a
	call print

	mov al, 0x01
	jmp reboot

;-------------------------------------------------------------------------------
times 510-($-$$) 	db 0
			dw 0xAA55
;-------------------------------------------------------------------------------

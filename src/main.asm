org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main
;
;Prints a string to the screen
;Params:
;	ds:si points to string
;

puts:
	;save the registers that'll get modified
	push si
	push ax

.loop:
	lodsb			;loads the next char in al
	or al, al		;checks for null
	jz .done

	mov ah, 0x0e		;calling interupts
	mov bh, 0
	int 0x10

	jmp .loop

.done:
	pop ax
	pop si
	ret

main:
	;setup of data segments
	mov ax, 0
	mov ds, ax		;ds and es can't be modified directly
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7C00

	;print message
	mov si, msg_hello
	call puts
	
	cli
	hlt


msg_hello: db 'Hello world!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h

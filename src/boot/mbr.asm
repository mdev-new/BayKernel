[org 0x7C00]
[bits 16]
KERNEL_OFFSET equ 0x1000

; stack
; mov bp, 0x9000
; mov sp, bp

; call load_kernel
; call SwitchToLongMode ; right from real mode

[bits 16]
Main:
	jmp 0x0000:.flush_cs
.flush_cs:
	xor ax, ax
	mov ss, ax
	mov sp, Main
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	cld

	mov edi, 0x9000

	mov [BOOT_DRIVE], dl
	call Main.load_kernel ; i am not entirely sure where to place this

	jmp SwitchToLongMode

.load_kernel:
	mov bx, KERNEL_OFFSET
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 64]
.BEGIN_64BIT:
	;hlt
	call KERNEL_OFFSET
	jmp $ ; loop incase kernel returns

[bits 16]
%include "boot/disk.asm"
%include "arch/64bit-mode.asm"

BOOT_DRIVE db 0
times 510 - ($-$$) db 0
dw 0xAA55
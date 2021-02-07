[org 0x7C00]
[bits 16]
KERNEL_OFFSET equ 0x1000
mov [BOOT_DRIVE], dl

mov bp, 0x9000
mov sp, bp

call load_kernel
jmp SwitchToLongMode

jmp $

load_kernel:
	mov bx, KERNEL_OFFSET
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret ; ret because this is 16bit.

[bits 64]
BEGIN_64BIT:
	;hlt
	call KERNEL_OFFSET
	jmp $ ; hang incase kernel returns

[bits 16]
%include "boot/disk.asm"
%include "arch/64bit-mode.asm"

BOOT_DRIVE db 0
times 510 - ($-$$) db 0
dw 0xAA55
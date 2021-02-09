[org 0x7C00]
[bits 16]

; this KERNEL_SECORS always MUST be size of (baykernel.flp * 2)!
KERNEL_SECORS equ 18
PROGRAM_SPACE equ 0x7E00

mov [BOOT_DISK], dl
mov bp, 0x7C00
mov sp, bp

call load_extended
jmp PROGRAM_SPACE
hlt


[bits 16]
%include "boot/disk.asm"

load_extended:
	mov bx, PROGRAM_SPACE
	mov dh, KERNEL_SECORS
	mov dl, [BOOT_DISK]
	call disk_read
	ret

BOOT_DISK db 0
times 510-($-$$) db 0
dw 0xAA55
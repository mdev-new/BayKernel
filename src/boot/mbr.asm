[org 0x7c00]
[bits 16]

mov [BOOT_DISK], dl
PROGRAM_SPACE equ 0x7e00

mov bp, 0x7c00
mov sp, bp

call load_extended
jmp PROGRAM_SPACE
hlt


[bits 16]
%include "boot/disk.asm"

load_extended:
	mov bx, PROGRAM_SPACE
	mov dh, 45
	mov dl, [BOOT_DISK]
	call disk_read
	ret

BOOT_DISK db 0
times 510-($-$$) db 0
dw 0xaa55
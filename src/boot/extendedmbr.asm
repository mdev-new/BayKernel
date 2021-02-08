; origin is defined in linker command (-Ttext)
; [org 0x7e00]
[bits 16]

jmp Get64bit_AllInOne
hlt

; we dont call kmain right away because we need _start
[bits 64]
[global _start]
[extern kmain]
_start:
	call kmain
	jmp $

Bit64_code:
	jmp _start


[bits 16]
%include "arch/64bit-mode.asm"

; no padding required here
; times 1024-($-$$) db 0
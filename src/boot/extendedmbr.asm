[bits 16]

jmp Get64bit_AllInOne
hlt

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
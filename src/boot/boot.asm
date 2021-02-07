[bits 64]
[extern kmain]

global _start
_start:
	call kmain
	jmp $
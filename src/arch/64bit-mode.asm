GDT:
	.nullsec:
		dd 0
		dd 0
	.codesec:
		dw 0xFFFF
		dw 0x0000
		db 0x00
		db 10011010b
		db 11001111b
		db 0x00
	.datasec:
		dw 0xFFFF
		dw 0x0000
		db 0x00
		db 10010010b
		db 11001111b
		db 0x00
	.end:

GDT_descriptor:
	gdt_size:
		dw GDT.end - GDT.nullsec - 1
		dq GDT.nullsec

CODESEG equ GDT.codesec - GDT.nullsec
DATASEG equ GDT.datasec - GDT.nullsec
PageTableEntry equ 0x1000

[bits 16]
Get64bit_AllInOne:
	in al, 0x92
	or al, 2
	out 0x92, al

	cli
	lgdt[GDT_descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODESEG:Begin32

[bits 32]
EditGDT:
	mov [GDT.codesec + 6], byte 10101111b
	mov [GDT.datasec + 6], byte 10101111b
	ret

Begin32:
	mov ax, DATASEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax

	; move stack
	; mov ebp, 0x90000
	; mov esp, ebp

	jmp Enable64bit_mode

SetupIdentityPaging:
	mov edi, PageTableEntry
	mov cr3, edi

	mov dword [edi], 0x2003
	add edi, 0x1000
	mov dword [edi], 0x3003
	add edi, 0x1000
	mov dword [edi], 0x4003
	add edi, 0x1000

	mov ebx, 0x00000003
	mov ecx, 512

	.SetEntry:
		mov dword [edi], ebx
		add ebx, 0x1000
		add edi, 8
		loop .SetEntry

	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax

	mov ecx, 0xC0000080
	rdmsr
	or eax, 1 << 8
	wrmsr

	mov eax, cr0
	or eax, 1 << 31
	mov cr0, eax
	ret

Enable64bit_mode:
	call SetupIdentityPaging
	call EditGDT
	jmp CODESEG:Begin64

[bits 64]
Begin64:
	; assembly screen clear
	; mov edi, 0xb8000
	; mov rax, 0x1f201f201f201f20
	; mov ecx, 500
	;rep stosq
	jmp Bit64_code

[bits 16]
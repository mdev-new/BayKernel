#include "kernel.h"
#include "../drivers/video/vga.h"

void main(void)
{
	vga_clear();
	vga_puts("hello",7);
}

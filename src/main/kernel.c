#include "kernel.h"
#include "drivers/video/vga.h"

/* We don't call this main because it isn't real entrypoint */
/* Real entry point (_start) is in assembly */
void kmain(void)
{
	vga_clear();
	vga_puts("hello",7);
	return;
}

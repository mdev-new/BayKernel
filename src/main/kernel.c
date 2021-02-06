#include "kernel.h"
#include "drivers/video/vga.h"

/* We don't call this main because it isn't real entrypoint */
/* Real entry point is in assembly */
void kernel_main(void)
{
	vga_clear();
	vga_puts("hello",7);
}

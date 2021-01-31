#include "vga.h"


void vga_clear()
{
	// loops till we clear the screen.
	char* memory = (char*)0xb8000;
	unsigned int i = 0;
	do {
	   memory[i++] = 0;
	} while (i < 4000);

}

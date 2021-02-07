#include "vga.h"

char* video_memory = (char*)0xb8000;
unsigned int current_location;
void vga_clear()
{
	/* loops till we clear the screen. */
	unsigned int i = 0;
	do {
		video_memory[i++] = 0;
	} while (i < 4000);
}

void vga_puts(char* string, int color)
{
	unsigned int i = 0;
	while (string[i] != '\0') {
		video_memory[current_location++] = string[i++];
		video_memory[current_location++] = color;
	}

}

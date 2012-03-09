#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/
#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif


#ifndef PRIORITY 
#define PRIORITY 5	
#endif


#ifndef PROPORTIONAL 
#define PROPORTIONAL 1	
#endif


void
start(void)
{
	int i;
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
		sys_yield();
	}
    //by SK, now the system really exits
	sys_exit(0);
	// Yield forever.
	//while (1)
	//	sys_yield();
}

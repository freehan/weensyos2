#ifndef WEENSYOS_SCHEDOS_H
#define WEENSYOS_SCHEDOS_H
#include "types.h"

/*****************************************************************************
 * schedos.h
 *
 *   Constants and variables shared by SchedOS's kernel and applications.
 *
 *****************************************************************************/

// System call numbers.
// An application calls a system call by causing the specified interrupt.

#define INT_SYS_YIELD		48
#define INT_SYS_EXIT		49
#define INT_SYS_USER1		50
#define INT_SYS_USER2		51
#define INT_SYS_PRI 		52
#define INT_SYS_PROP		53
#define INT_SYS_GETTICKET   54
#define INT_SYS_ABORTTICKET 55
//XIA: syscall for printing out a char
#define INT_SYS_PRINTCHAR   56


// The current screen cursor position (stored at memory location 0x198000).

extern uint16_t * volatile cursorpos;
#define CURRENT_PART 1

//XIA: try add one lock
extern uint32_t lock;
#endif

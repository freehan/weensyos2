
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
  * Assign the priority to the certain process
  *
  ***************************/
static inline void
sys_priority(int pri){
	asm volatile("int %0\n"
  200000:	b8 05 00 00 00       	mov    $0x5,%eax
  200005:	cd 34                	int    $0x34
  * Assign the proportional to the certain process
  *
  ***************************/
static inline void
sys_proportional(int prop){
	asm volatile("int %0\n"
  200007:	b0 01                	mov    $0x1,%al
  200009:	cd 35                	int    $0x35
			: "cc", "memory");
}

static inline void
sys_getticket(){
	asm volatile("int %0\n"::"i" (INT_SYS_GETTICKET):"cc","memory");
  20000b:	cd 36                	int    $0x36
  20000d:	30 c0                	xor    %al,%al
	sys_proportional(PROPORTIONAL);
	sys_getticket();
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
#if CURRENT_PART == 1
		*cursorpos++ = PRINTCHAR;
  20000f:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200015:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  20001a:	83 c2 02             	add    $0x2,%edx
  20001d:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200023:	cd 30                	int    $0x30
{
	int i;
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	sys_getticket();
	for (i = 0; i < RUNCOUNT; i++) {
  200025:	40                   	inc    %eax
  200026:	3d 40 01 00 00       	cmp    $0x140,%eax
  20002b:	75 e2                	jne    20000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20002d:	66 31 c0             	xor    %ax,%ax
  200030:	cd 31                	int    $0x31
  200032:	eb fe                	jmp    200032 <start+0x32>

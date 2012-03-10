
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
  * Assign the priority to the certain process
  *
  ***************************/
static inline void
sys_priority(int pri){
	asm volatile("int %0\n"
  500000:	b8 02 00 00 00       	mov    $0x2,%eax
  500005:	cd 34                	int    $0x34
  * Assign the proportional to the certain process
  *
  ***************************/
static inline void
sys_proportional(int prop){
	asm volatile("int %0\n"
  500007:	b0 04                	mov    $0x4,%al
  500009:	cd 35                	int    $0x35
			: "cc", "memory");
}

static inline void
sys_getticket(){
	asm volatile("int %0\n"::"i" (INT_SYS_GETTICKET):"cc","memory");
  50000b:	cd 36                	int    $0x36
  50000d:	30 c0                	xor    %al,%al
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	sys_getticket();
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  50000f:	8b 15 00 80 19 00    	mov    0x198000,%edx
  500015:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  50001a:	83 c2 02             	add    $0x2,%edx
  50001d:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500023:	cd 30                	int    $0x30
{
	int i;
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	sys_getticket();
	for (i = 0; i < RUNCOUNT; i++) {
  500025:	40                   	inc    %eax
  500026:	3d 40 01 00 00       	cmp    $0x140,%eax
  50002b:	75 e2                	jne    50000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  50002d:	66 31 c0             	xor    %ax,%ax
  500030:	cd 31                	int    $0x31
  500032:	eb fe                	jmp    500032 <start+0x32>

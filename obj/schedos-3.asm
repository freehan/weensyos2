
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
  * Assign the priority to the certain process
  *
  ***************************/
static inline void
sys_priority(int pri){
	asm volatile("int %0\n"
  400000:	b8 03 00 00 00       	mov    $0x3,%eax
  400005:	cd 34                	int    $0x34
  * Assign the proportional to the certain process
  *
  ***************************/
static inline void
sys_proportional(int prop){
	asm volatile("int %0\n"
  400007:	cd 35                	int    $0x35
  400009:	30 c0                	xor    %al,%al
	int i;
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  40000b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  400011:	66 c7 02 33 09       	movw   $0x933,(%edx)
  400016:	83 c2 02             	add    $0x2,%edx
  400019:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40001f:	cd 30                	int    $0x30
start(void)
{
	int i;
	sys_priority(PRIORITY);
	sys_proportional(PROPORTIONAL);
	for (i = 0; i < RUNCOUNT; i++) {
  400021:	40                   	inc    %eax
  400022:	3d 40 01 00 00       	cmp    $0x140,%eax
  400027:	75 e2                	jne    40000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400029:	66 31 c0             	xor    %ax,%ax
  40002c:	cd 31                	int    $0x31
  40002e:	eb fe                	jmp    40002e <start+0x2e>

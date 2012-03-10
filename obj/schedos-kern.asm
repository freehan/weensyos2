
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 ca 00 00 00       	call   1000e3 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 58 03 00 00       	call   1003ca <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <delete_ticket>:
static pid_t tickets[MAX_TICKET_NUM];

void
delete_ticket(pid_t pid){
	int i;
	for(i = ticket_num-1; i>=0;i--){
  10009c:	8b 15 ac 79 10 00    	mov    0x1079ac,%edx
#define MAX_TICKET_NUM 100
static int ticket_num;
static pid_t tickets[MAX_TICKET_NUM];

void
delete_ticket(pid_t pid){
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
  1000a4:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	int i;
	for(i = ticket_num-1; i>=0;i--){
  1000a8:	4a                   	dec    %edx
  1000a9:	8d 0c 95 b0 79 10 00 	lea    0x1079b0(,%edx,4),%ecx
  1000b0:	89 d0                	mov    %edx,%eax
  1000b2:	eb 22                	jmp    1000d6 <delete_ticket+0x3a>
		if(tickets[i]==pid){
  1000b4:	8b 31                	mov    (%ecx),%esi
  1000b6:	83 e9 04             	sub    $0x4,%ecx
  1000b9:	39 de                	cmp    %ebx,%esi
  1000bb:	75 18                	jne    1000d5 <delete_ticket+0x39>
  1000bd:	8d 0c 85 b4 79 10 00 	lea    0x1079b4(,%eax,4),%ecx
  1000c4:	eb 09                	jmp    1000cf <delete_ticket+0x33>
			int j;
			for(j = i;j<ticket_num-1;j++){
				tickets[j] = tickets[j+1];
  1000c6:	8b 19                	mov    (%ecx),%ebx
  1000c8:	40                   	inc    %eax
  1000c9:	89 59 fc             	mov    %ebx,-0x4(%ecx)
  1000cc:	83 c1 04             	add    $0x4,%ecx
delete_ticket(pid_t pid){
	int i;
	for(i = ticket_num-1; i>=0;i--){
		if(tickets[i]==pid){
			int j;
			for(j = i;j<ticket_num-1;j++){
  1000cf:	39 d0                	cmp    %edx,%eax
  1000d1:	7c f3                	jl     1000c6 <delete_ticket+0x2a>
  1000d3:	eb 05                	jmp    1000da <delete_ticket+0x3e>
static pid_t tickets[MAX_TICKET_NUM];

void
delete_ticket(pid_t pid){
	int i;
	for(i = ticket_num-1; i>=0;i--){
  1000d5:	48                   	dec    %eax
  1000d6:	85 c0                	test   %eax,%eax
  1000d8:	79 da                	jns    1000b4 <delete_ticket+0x18>
			}
			break;
		}
	}
	ticket_num--;
}
  1000da:	5b                   	pop    %ebx
				tickets[j] = tickets[j+1];
			}
			break;
		}
	}
	ticket_num--;
  1000db:	89 15 ac 79 10 00    	mov    %edx,0x1079ac
}
  1000e1:	5e                   	pop    %esi
  1000e2:	c3                   	ret    

001000e3 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1000e3:	57                   	push   %edi
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1000e4:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1000e9:	56                   	push   %esi
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1000ea:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1000ec:	53                   	push   %ebx
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1000ed:	bb 3c 78 10 00       	mov    $0x10783c,%ebx

void
start(void)
{
	int i;
	ticket_num = 0;
  1000f2:	c7 05 ac 79 10 00 00 	movl   $0x0,0x1079ac
  1000f9:	00 00 00 

	// Set up hardware (schedos-x86.c)
	segments_init();
  1000fc:	e8 6b 03 00 00       	call   10046c <segments_init>
	interrupt_controller_init(0);
  100101:	83 ec 0c             	sub    $0xc,%esp
  100104:	6a 00                	push   $0x0
  100106:	e8 5c 04 00 00       	call   100567 <interrupt_controller_init>
	console_clear();
  10010b:	e8 e0 04 00 00       	call   1005f0 <console_clear>
	PlantSeeds(1);
  100110:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100117:	e8 f5 0b 00 00       	call   100d11 <PlantSeeds>
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10011c:	83 c4 0c             	add    $0xc,%esp
  10011f:	68 cc 01 00 00       	push   $0x1cc
  100124:	6a 00                	push   $0x0
  100126:	68 e0 77 10 00       	push   $0x1077e0
  10012b:	e8 a0 06 00 00       	call   1007d0 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100130:	83 c4 10             	add    $0x10,%esp
	console_clear();
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100133:	c7 05 e0 77 10 00 00 	movl   $0x0,0x1077e0
  10013a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10013d:	c7 05 28 78 10 00 00 	movl   $0x0,0x107828
  100144:	00 00 00 
	console_clear();
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100147:	c7 05 3c 78 10 00 01 	movl   $0x1,0x10783c
  10014e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100151:	c7 05 84 78 10 00 00 	movl   $0x0,0x107884
  100158:	00 00 00 
	console_clear();
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10015b:	c7 05 98 78 10 00 02 	movl   $0x2,0x107898
  100162:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100165:	c7 05 e0 78 10 00 00 	movl   $0x0,0x1078e0
  10016c:	00 00 00 
	console_clear();
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10016f:	c7 05 f4 78 10 00 03 	movl   $0x3,0x1078f4
  100176:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100179:	c7 05 3c 79 10 00 00 	movl   $0x0,0x10793c
  100180:	00 00 00 
	console_clear();
	PlantSeeds(1);
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100183:	c7 05 50 79 10 00 04 	movl   $0x4,0x107950
  10018a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10018d:	c7 05 98 79 10 00 00 	movl   $0x0,0x107998
  100194:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100197:	83 ec 0c             	sub    $0xc,%esp
  10019a:	53                   	push   %ebx
  10019b:	e8 04 05 00 00       	call   1006a4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1001a0:	58                   	pop    %eax
  1001a1:	5a                   	pop    %edx
  1001a2:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1001a5:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
#if CURRENT_PART == 1
		proc->p_priority = 0;
		proc->p_proportional = 1;
		proc->p_runtime = 0;
  1001a8:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1001ae:	50                   	push   %eax
  1001af:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
#if CURRENT_PART == 1
		proc->p_priority = 0;
		proc->p_proportional = 1;
		proc->p_runtime = 0;
  1001b0:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1001b1:	e8 2a 05 00 00       	call   1006e0 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1001b6:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1001b9:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
#if CURRENT_PART == 1
		proc->p_priority = 0;
  1001c0:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
		proc->p_proportional = 1;
  1001c7:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)
		proc->p_runtime = 0;
  1001ce:	c7 43 54 00 00 00 00 	movl   $0x0,0x54(%ebx)
  1001d5:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1001d8:	83 fe 04             	cmp    $0x4,%esi
  1001db:	75 ba                	jne    100197 <start+0xb4>
	// Switch to the first process.
#if CURRENT_PART == 1
	proc_array[1].p_runtime++;
#endif

	PlantSeeds(1);
  1001dd:	83 ec 0c             	sub    $0xc,%esp
  1001e0:	6a 01                	push   $0x1
	//scheduling_algorithm = 1;
    //scheduling_algorithm = 2;
    scheduling_algorithm = 3;
	// Switch to the first process.
#if CURRENT_PART == 1
	proc_array[1].p_runtime++;
  1001e2:	ff 05 90 78 10 00    	incl   0x107890
#endif
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1001e8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1001ef:	80 0b 00 
	// Initialize the scheduling algorithm.
	//by Sk
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 1;
    //scheduling_algorithm = 2;
    scheduling_algorithm = 3;
  1001f2:	c7 05 b4 83 10 00 03 	movl   $0x3,0x1083b4
  1001f9:	00 00 00 
	// Switch to the first process.
#if CURRENT_PART == 1
	proc_array[1].p_runtime++;
#endif

	PlantSeeds(1);
  1001fc:	e8 10 0b 00 00       	call   100d11 <PlantSeeds>
	
	run(&proc_array[1]);
  100201:	c7 04 24 3c 78 10 00 	movl   $0x10783c,(%esp)
  100208:	e8 80 04 00 00       	call   10068d <run>

0010020d <get_winner>:
	}
	ticket_num--;
}

pid_t
get_winner(void){
  10020d:	83 ec 1c             	sub    $0x1c,%esp
	int r = Random()*100000;
  100210:	e8 37 0a 00 00       	call   100c4c <Random>
  100215:	d9 7c 24 0e          	fnstcw 0xe(%esp)
  100219:	d8 0d 64 0e 10 00    	fmuls  0x100e64
  10021f:	66 8b 44 24 0e       	mov    0xe(%esp),%ax
  100224:	80 cc 0c             	or     $0xc,%ah
  100227:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  10022c:	d9 6c 24 0c          	fldcw  0xc(%esp)
  100230:	db 5c 24 08          	fistpl 0x8(%esp)
  100234:	d9 6c 24 0e          	fldcw  0xe(%esp)
  100238:	8b 44 24 08          	mov    0x8(%esp),%eax
  10023c:	99                   	cltd   
  10023d:	f7 3d ac 79 10 00    	idivl  0x1079ac
  100243:	8b 04 95 b0 79 10 00 	mov    0x1079b0(,%edx,4),%eax
	int winner = r%ticket_num;
	return tickets[winner];
}
  10024a:	83 c4 1c             	add    $0x1c,%esp
  10024d:	c3                   	ret    

0010024e <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10024e:	55                   	push   %ebp
  10024f:	57                   	push   %edi
  100250:	56                   	push   %esi
  100251:	53                   	push   %ebx
  100252:	83 ec 1c             	sub    $0x1c,%esp
	pid_t pid = current->p_pid;
  100255:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  10025a:	8b 08                	mov    (%eax),%ecx

	if (scheduling_algorithm == 0)
  10025c:	a1 b4 83 10 00       	mov    0x1083b4,%eax
  100261:	85 c0                	test   %eax,%eax
  100263:	75 1e                	jne    100283 <schedule+0x35>
		while (1) {
			pid = (pid + 1) % NPROCS;
  100265:	bb 05 00 00 00       	mov    $0x5,%ebx
  10026a:	8d 41 01             	lea    0x1(%ecx),%eax
  10026d:	99                   	cltd   
  10026e:	f7 fb                	idiv   %ebx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100270:	6b c2 5c             	imul   $0x5c,%edx,%eax
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  100273:	89 d1                	mov    %edx,%ecx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100275:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  10027c:	75 ec                	jne    10026a <schedule+0x1c>
  10027e:	e9 18 01 00 00       	jmp    10039b <schedule+0x14d>
				run(&proc_array[pid]);
		}
#if CURRENT_PART==1
	else if (scheduling_algorithm == 1){
  100283:	83 f8 01             	cmp    $0x1,%eax
  100286:	75 4c                	jne    1002d4 <schedule+0x86>
  100288:	31 db                	xor    %ebx,%ebx
  10028a:	31 ff                	xor    %edi,%edi
  10028c:	be e7 03 00 00       	mov    $0x3e7,%esi
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
  100291:	bd 05 00 00 00       	mov    $0x5,%ebp
  100296:	eb 25                	jmp    1002bd <schedule+0x6f>
  100298:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  10029b:	99                   	cltd   
  10029c:	f7 fd                	idiv   %ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  10029e:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1002a1:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  1002a8:	75 0e                	jne    1002b8 <schedule+0x6a>
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
  1002aa:	8b 80 2c 78 10 00    	mov    0x10782c(%eax),%eax
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1002b0:	39 f0                	cmp    %esi,%eax
  1002b2:	7f 04                	jg     1002b8 <schedule+0x6a>
  1002b4:	89 d7                	mov    %edx,%edi
  1002b6:	eb 02                	jmp    1002ba <schedule+0x6c>
  1002b8:	89 f0                	mov    %esi,%eax
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
				highest_pri_p = cur_pid;
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
  1002ba:	43                   	inc    %ebx
  1002bb:	89 c6                	mov    %eax,%esi
#if CURRENT_PART==1
	else if (scheduling_algorithm == 1){
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
  1002bd:	83 fb 04             	cmp    $0x4,%ebx
  1002c0:	7e d6                	jle    100298 <schedule+0x4a>
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		run(&proc_array[highest_pri_p]);
  1002c2:	6b ff 5c             	imul   $0x5c,%edi,%edi
  1002c5:	83 ec 0c             	sub    $0xc,%esp
  1002c8:	81 c7 e0 77 10 00    	add    $0x1077e0,%edi
  1002ce:	57                   	push   %edi
  1002cf:	e8 b9 03 00 00       	call   10068d <run>
	}
	else if(scheduling_algorithm == 2){
  1002d4:	83 f8 02             	cmp    $0x2,%eax
  1002d7:	0f 85 84 00 00 00    	jne    100361 <schedule+0x113>
  1002dd:	31 db                	xor    %ebx,%ebx
  1002df:	31 f6                	xor    %esi,%esi
  1002e1:	d9 05 68 0e 10 00    	flds   0x100e68
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
  1002e7:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  1002ea:	bf 05 00 00 00       	mov    $0x5,%edi
  1002ef:	99                   	cltd   
  1002f0:	f7 ff                	idiv   %edi
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  1002f2:	6b c2 5c             	imul   $0x5c,%edx,%eax
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1002f5:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  1002fc:	8b b8 34 78 10 00    	mov    0x107834(%eax),%edi
  100302:	8b a8 30 78 10 00    	mov    0x107830(%eax),%ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100308:	75 20                	jne    10032a <schedule+0xdc>
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  10030a:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  10030e:	db 44 24 0c          	fildl  0xc(%esp)
  100312:	57                   	push   %edi
  100313:	da 3c 24             	fidivrl (%esp)
  100316:	d9 c9                	fxch   %st(1)
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100318:	dd e1                	fucom  %st(1)
  10031a:	df e0                	fnstsw %ax
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  10031c:	83 c4 04             	add    $0x4,%esp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  10031f:	9e                   	sahf   
  100320:	72 06                	jb     100328 <schedule+0xda>
  100322:	dd d8                	fstp   %st(0)
  100324:	89 d6                	mov    %edx,%esi
  100326:	eb 02                	jmp    10032a <schedule+0xdc>
  100328:	dd d9                	fstp   %st(1)
					&& prop_value <= lowest_prop){
					winner = cur_pid;
					lowest_prop = prop_value;
			}
			i++;
  10032a:	43                   	inc    %ebx
	}
	else if(scheduling_algorithm == 2){
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
  10032b:	83 fb 04             	cmp    $0x4,%ebx
  10032e:	7e b7                	jle    1002e7 <schedule+0x99>
  100330:	d9 05 68 0e 10 00    	flds   0x100e68
  100336:	d9 c9                	fxch   %st(1)
  100338:	dd e1                	fucom  %st(1)
  10033a:	df e0                	fnstsw %ax
  10033c:	dd d9                	fstp   %st(1)
  10033e:	9e                   	sahf   
  10033f:	7a 06                	jp     100347 <schedule+0xf9>
  100341:	74 a4                	je     1002e7 <schedule+0x99>
  100343:	dd d8                	fstp   %st(0)
  100345:	eb 02                	jmp    100349 <schedule+0xfb>
  100347:	dd d8                	fstp   %st(0)
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  100349:	6b f6 5c             	imul   $0x5c,%esi,%esi
		run(&proc_array[winner]);
  10034c:	83 ec 0c             	sub    $0xc,%esp
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  10034f:	ff 86 34 78 10 00    	incl   0x107834(%esi)
		run(&proc_array[winner]);
  100355:	81 c6 e0 77 10 00    	add    $0x1077e0,%esi
  10035b:	56                   	push   %esi
  10035c:	e9 6e ff ff ff       	jmp    1002cf <schedule+0x81>
	}
	else if(scheduling_algorithm == 3){ //lottery
  100361:	83 f8 03             	cmp    $0x3,%eax
  100364:	75 43                	jne    1003a9 <schedule+0x15b>
		pid_t winner;
		if(ticket_num < NPROCS-1){
  100366:	83 3d ac 79 10 00 03 	cmpl   $0x3,0x1079ac
  10036d:	7f 1b                	jg     10038a <schedule+0x13c>
			while (1) {
				pid = (pid + 1) % NPROCS;
  10036f:	bb 05 00 00 00       	mov    $0x5,%ebx
  100374:	8d 41 01             	lea    0x1(%ecx),%eax
  100377:	99                   	cltd   
  100378:	f7 fb                	idiv   %ebx
				// Run the selected process, but skip
				// non-runnable processes.
				// Note that the 'run' function does not return.
				if (proc_array[pid].p_state == P_RUNNABLE)
  10037a:	6b c2 5c             	imul   $0x5c,%edx,%eax
	}
	else if(scheduling_algorithm == 3){ //lottery
		pid_t winner;
		if(ticket_num < NPROCS-1){
			while (1) {
				pid = (pid + 1) % NPROCS;
  10037d:	89 d1                	mov    %edx,%ecx
				// Run the selected process, but skip
				// non-runnable processes.
				// Note that the 'run' function does not return.
				if (proc_array[pid].p_state == P_RUNNABLE)
  10037f:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  100386:	75 ec                	jne    100374 <schedule+0x126>
  100388:	eb 11                	jmp    10039b <schedule+0x14d>
			}
		}
		else{
			winner = get_winner();
			while(proc_array[winner].p_state != P_RUNNABLE){
				winner = get_winner();
  10038a:	e8 7e fe ff ff       	call   10020d <get_winner>
					run(&proc_array[pid]);
			}
		}
		else{
			winner = get_winner();
			while(proc_array[winner].p_state != P_RUNNABLE){
  10038f:	6b c0 5c             	imul   $0x5c,%eax,%eax
  100392:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  100399:	75 ef                	jne    10038a <schedule+0x13c>
				winner = get_winner();
			}
		}
		run(&proc_array[winner]);
  10039b:	83 ec 0c             	sub    $0xc,%esp
  10039e:	05 e0 77 10 00       	add    $0x1077e0,%eax
  1003a3:	50                   	push   %eax
  1003a4:	e9 26 ff ff ff       	jmp    1002cf <schedule+0x81>
	}
#endif
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1003a9:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1003af:	50                   	push   %eax
  1003b0:	68 e0 0d 10 00       	push   $0x100de0
  1003b5:	68 00 01 00 00       	push   $0x100
  1003ba:	52                   	push   %edx
  1003bb:	e8 72 08 00 00       	call   100c32 <console_printf>
  1003c0:	83 c4 10             	add    $0x10,%esp
  1003c3:	a3 00 80 19 00       	mov    %eax,0x198000
  1003c8:	eb fe                	jmp    1003c8 <schedule+0x17a>

001003ca <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1003ca:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1003cb:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  1003d0:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1003d5:	56                   	push   %esi
  1003d6:	53                   	push   %ebx
  1003d7:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1003db:	8d 78 04             	lea    0x4(%eax),%edi
  1003de:	89 de                	mov    %ebx,%esi
  1003e0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1003e2:	8b 53 28             	mov    0x28(%ebx),%edx
  1003e5:	83 ea 20             	sub    $0x20,%edx
  1003e8:	83 fa 17             	cmp    $0x17,%edx
  1003eb:	77 7b                	ja     100468 <interrupt+0x9e>
  1003ed:	ff 24 95 04 0e 10 00 	jmp    *0x100e04(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1003f4:	e8 55 fe ff ff       	call   10024e <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1003f9:	a1 b0 83 10 00       	mov    0x1083b0,%eax
		current->p_exit_status = reg->reg_eax;
  1003fe:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100401:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100408:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  10040b:	e8 3e fe ff ff       	call   10024e <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100410:	83 ec 0c             	sub    $0xc,%esp
  100413:	eb 4b                	jmp    100460 <interrupt+0x96>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100415:	83 ec 0c             	sub    $0xc,%esp
  100418:	50                   	push   %eax
  100419:	e8 6f 02 00 00       	call   10068d <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10041e:	e8 2b fe ff ff       	call   10024e <schedule>
    
	case INT_SYS_PRI:
		current->p_priority = reg->reg_eax;
  100423:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  100428:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10042b:	89 50 4c             	mov    %edx,0x4c(%eax)
  10042e:	eb e5                	jmp    100415 <interrupt+0x4b>
		run(current);

	case INT_SYS_PROP:
		current->p_proportional = reg->reg_eax;
  100430:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100433:	89 50 50             	mov    %edx,0x50(%eax)
  100436:	eb dd                	jmp    100415 <interrupt+0x4b>
		run(current);

	case INT_SYS_GETTICKET:
		if(ticket_num<MAX_TICKET_NUM){
  100438:	8b 15 ac 79 10 00    	mov    0x1079ac,%edx
  10043e:	83 fa 63             	cmp    $0x63,%edx
  100441:	7f d2                	jg     100415 <interrupt+0x4b>
			tickets[ticket_num] = current->p_pid;
  100443:	8b 08                	mov    (%eax),%ecx
  100445:	89 0c 95 b0 79 10 00 	mov    %ecx,0x1079b0(,%edx,4)
			ticket_num++;
  10044c:	42                   	inc    %edx
  10044d:	89 15 ac 79 10 00    	mov    %edx,0x1079ac
  100453:	eb c0                	jmp    100415 <interrupt+0x4b>
		}
		run(current);
	case INT_SYS_ABORTTICKET:
		delete_ticket(current->p_pid);
  100455:	83 ec 0c             	sub    $0xc,%esp
  100458:	ff 30                	pushl  (%eax)
  10045a:	e8 3d fc ff ff       	call   10009c <delete_ticket>
		run(current);
  10045f:	59                   	pop    %ecx
  100460:	ff 35 b0 83 10 00    	pushl  0x1083b0
  100466:	eb b1                	jmp    100419 <interrupt+0x4f>
  100468:	eb fe                	jmp    100468 <interrupt+0x9e>
  10046a:	90                   	nop
  10046b:	90                   	nop

0010046c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10046c:	b8 40 7b 10 00       	mov    $0x107b40,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100471:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100476:	89 c2                	mov    %eax,%edx
  100478:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10047b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10047c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100481:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100484:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10048a:	c1 e8 18             	shr    $0x18,%eax
  10048d:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100493:	ba a8 7b 10 00       	mov    $0x107ba8,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100498:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10049d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10049f:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1004a6:	68 00 
  1004a8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1004af:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1004b6:	c7 05 44 7b 10 00 00 	movl   $0x180000,0x107b44
  1004bd:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1004c0:	66 c7 05 48 7b 10 00 	movw   $0x10,0x107b48
  1004c7:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004c9:	66 89 0c c5 a8 7b 10 	mov    %cx,0x107ba8(,%eax,8)
  1004d0:	00 
  1004d1:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004d8:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004dd:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1004e2:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1004e7:	40                   	inc    %eax
  1004e8:	3d 00 01 00 00       	cmp    $0x100,%eax
  1004ed:	75 da                	jne    1004c9 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004ef:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004f4:	ba a8 7b 10 00       	mov    $0x107ba8,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004f9:	66 a3 a8 7c 10 00    	mov    %ax,0x107ca8
  1004ff:	c1 e8 10             	shr    $0x10,%eax
  100502:	66 a3 ae 7c 10 00    	mov    %ax,0x107cae
  100508:	b8 30 00 00 00       	mov    $0x30,%eax
  10050d:	66 c7 05 aa 7c 10 00 	movw   $0x8,0x107caa
  100514:	08 00 
  100516:	c6 05 ac 7c 10 00 00 	movb   $0x0,0x107cac
  10051d:	c6 05 ad 7c 10 00 8e 	movb   $0x8e,0x107cad

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100524:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10052b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100532:	66 89 0c c5 a8 7b 10 	mov    %cx,0x107ba8(,%eax,8)
  100539:	00 
  10053a:	c1 e9 10             	shr    $0x10,%ecx
  10053d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100542:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100547:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10054c:	40                   	inc    %eax
  10054d:	83 f8 3a             	cmp    $0x3a,%eax
  100550:	75 d2                	jne    100524 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100552:	b0 28                	mov    $0x28,%al
  100554:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10055b:	0f 00 d8             	ltr    %ax
  10055e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100565:	5b                   	pop    %ebx
  100566:	c3                   	ret    

00100567 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100567:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100568:	b0 ff                	mov    $0xff,%al
  10056a:	57                   	push   %edi
  10056b:	56                   	push   %esi
  10056c:	53                   	push   %ebx
  10056d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100572:	89 da                	mov    %ebx,%edx
  100574:	ee                   	out    %al,(%dx)
  100575:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10057a:	89 ca                	mov    %ecx,%edx
  10057c:	ee                   	out    %al,(%dx)
  10057d:	be 11 00 00 00       	mov    $0x11,%esi
  100582:	bf 20 00 00 00       	mov    $0x20,%edi
  100587:	89 f0                	mov    %esi,%eax
  100589:	89 fa                	mov    %edi,%edx
  10058b:	ee                   	out    %al,(%dx)
  10058c:	b0 20                	mov    $0x20,%al
  10058e:	89 da                	mov    %ebx,%edx
  100590:	ee                   	out    %al,(%dx)
  100591:	b0 04                	mov    $0x4,%al
  100593:	ee                   	out    %al,(%dx)
  100594:	b0 03                	mov    $0x3,%al
  100596:	ee                   	out    %al,(%dx)
  100597:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10059c:	89 f0                	mov    %esi,%eax
  10059e:	89 ea                	mov    %ebp,%edx
  1005a0:	ee                   	out    %al,(%dx)
  1005a1:	b0 28                	mov    $0x28,%al
  1005a3:	89 ca                	mov    %ecx,%edx
  1005a5:	ee                   	out    %al,(%dx)
  1005a6:	b0 02                	mov    $0x2,%al
  1005a8:	ee                   	out    %al,(%dx)
  1005a9:	b0 01                	mov    $0x1,%al
  1005ab:	ee                   	out    %al,(%dx)
  1005ac:	b0 68                	mov    $0x68,%al
  1005ae:	89 fa                	mov    %edi,%edx
  1005b0:	ee                   	out    %al,(%dx)
  1005b1:	be 0a 00 00 00       	mov    $0xa,%esi
  1005b6:	89 f0                	mov    %esi,%eax
  1005b8:	ee                   	out    %al,(%dx)
  1005b9:	b0 68                	mov    $0x68,%al
  1005bb:	89 ea                	mov    %ebp,%edx
  1005bd:	ee                   	out    %al,(%dx)
  1005be:	89 f0                	mov    %esi,%eax
  1005c0:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1005c1:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1005c6:	89 da                	mov    %ebx,%edx
  1005c8:	19 c0                	sbb    %eax,%eax
  1005ca:	f7 d0                	not    %eax
  1005cc:	05 ff 00 00 00       	add    $0xff,%eax
  1005d1:	ee                   	out    %al,(%dx)
  1005d2:	b0 ff                	mov    $0xff,%al
  1005d4:	89 ca                	mov    %ecx,%edx
  1005d6:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1005d7:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1005dc:	74 0d                	je     1005eb <interrupt_controller_init+0x84>
  1005de:	b2 43                	mov    $0x43,%dl
  1005e0:	b0 34                	mov    $0x34,%al
  1005e2:	ee                   	out    %al,(%dx)
  1005e3:	b0 9c                	mov    $0x9c,%al
  1005e5:	b2 40                	mov    $0x40,%dl
  1005e7:	ee                   	out    %al,(%dx)
  1005e8:	b0 2e                	mov    $0x2e,%al
  1005ea:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1005eb:	5b                   	pop    %ebx
  1005ec:	5e                   	pop    %esi
  1005ed:	5f                   	pop    %edi
  1005ee:	5d                   	pop    %ebp
  1005ef:	c3                   	ret    

001005f0 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005f0:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005f1:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005f3:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005f4:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005fb:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005fe:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100604:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10060a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10060d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100612:	75 ea                	jne    1005fe <console_clear+0xe>
  100614:	be d4 03 00 00       	mov    $0x3d4,%esi
  100619:	b0 0e                	mov    $0xe,%al
  10061b:	89 f2                	mov    %esi,%edx
  10061d:	ee                   	out    %al,(%dx)
  10061e:	31 c9                	xor    %ecx,%ecx
  100620:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100625:	88 c8                	mov    %cl,%al
  100627:	89 da                	mov    %ebx,%edx
  100629:	ee                   	out    %al,(%dx)
  10062a:	b0 0f                	mov    $0xf,%al
  10062c:	89 f2                	mov    %esi,%edx
  10062e:	ee                   	out    %al,(%dx)
  10062f:	88 c8                	mov    %cl,%al
  100631:	89 da                	mov    %ebx,%edx
  100633:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100634:	5b                   	pop    %ebx
  100635:	5e                   	pop    %esi
  100636:	c3                   	ret    

00100637 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100637:	ba 64 00 00 00       	mov    $0x64,%edx
  10063c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10063d:	a8 01                	test   $0x1,%al
  10063f:	74 45                	je     100686 <console_read_digit+0x4f>
  100641:	b2 60                	mov    $0x60,%dl
  100643:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100644:	8d 50 fe             	lea    -0x2(%eax),%edx
  100647:	80 fa 08             	cmp    $0x8,%dl
  10064a:	77 05                	ja     100651 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10064c:	0f b6 c0             	movzbl %al,%eax
  10064f:	48                   	dec    %eax
  100650:	c3                   	ret    
	else if (data == 0x0B)
  100651:	3c 0b                	cmp    $0xb,%al
  100653:	74 35                	je     10068a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100655:	8d 50 b9             	lea    -0x47(%eax),%edx
  100658:	80 fa 02             	cmp    $0x2,%dl
  10065b:	77 07                	ja     100664 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10065d:	0f b6 c0             	movzbl %al,%eax
  100660:	83 e8 40             	sub    $0x40,%eax
  100663:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100664:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100667:	80 fa 02             	cmp    $0x2,%dl
  10066a:	77 07                	ja     100673 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10066c:	0f b6 c0             	movzbl %al,%eax
  10066f:	83 e8 47             	sub    $0x47,%eax
  100672:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100673:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100676:	80 fa 02             	cmp    $0x2,%dl
  100679:	77 07                	ja     100682 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10067b:	0f b6 c0             	movzbl %al,%eax
  10067e:	83 e8 4e             	sub    $0x4e,%eax
  100681:	c3                   	ret    
	else if (data == 0x53)
  100682:	3c 53                	cmp    $0x53,%al
  100684:	74 04                	je     10068a <console_read_digit+0x53>
  100686:	83 c8 ff             	or     $0xffffffff,%eax
  100689:	c3                   	ret    
  10068a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10068c:	c3                   	ret    

0010068d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10068d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100691:	a3 b0 83 10 00       	mov    %eax,0x1083b0

	asm volatile("movl %0,%%esp\n\t"
  100696:	83 c0 04             	add    $0x4,%eax
  100699:	89 c4                	mov    %eax,%esp
  10069b:	61                   	popa   
  10069c:	07                   	pop    %es
  10069d:	1f                   	pop    %ds
  10069e:	83 c4 08             	add    $0x8,%esp
  1006a1:	cf                   	iret   
  1006a2:	eb fe                	jmp    1006a2 <run+0x15>

001006a4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1006a4:	53                   	push   %ebx
  1006a5:	83 ec 0c             	sub    $0xc,%esp
  1006a8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1006ac:	6a 44                	push   $0x44
  1006ae:	6a 00                	push   $0x0
  1006b0:	8d 43 04             	lea    0x4(%ebx),%eax
  1006b3:	50                   	push   %eax
  1006b4:	e8 17 01 00 00       	call   1007d0 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1006b9:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1006bf:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1006c5:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1006cb:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1006d1:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1006d8:	83 c4 18             	add    $0x18,%esp
  1006db:	5b                   	pop    %ebx
  1006dc:	c3                   	ret    
  1006dd:	90                   	nop
  1006de:	90                   	nop
  1006df:	90                   	nop

001006e0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1006e0:	55                   	push   %ebp
  1006e1:	57                   	push   %edi
  1006e2:	56                   	push   %esi
  1006e3:	53                   	push   %ebx
  1006e4:	83 ec 1c             	sub    $0x1c,%esp
  1006e7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1006eb:	83 f8 03             	cmp    $0x3,%eax
  1006ee:	7f 04                	jg     1006f4 <program_loader+0x14>
  1006f0:	85 c0                	test   %eax,%eax
  1006f2:	79 02                	jns    1006f6 <program_loader+0x16>
  1006f4:	eb fe                	jmp    1006f4 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006f6:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006fd:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100703:	74 02                	je     100707 <program_loader+0x27>
  100705:	eb fe                	jmp    100705 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100707:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10070a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10070e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100710:	c1 e5 05             	shl    $0x5,%ebp
  100713:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100716:	eb 3f                	jmp    100757 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100718:	83 3b 01             	cmpl   $0x1,(%ebx)
  10071b:	75 37                	jne    100754 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10071d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100720:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100723:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100726:	01 c7                	add    %eax,%edi
	memsz += va;
  100728:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10072a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10072f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100733:	52                   	push   %edx
  100734:	89 fa                	mov    %edi,%edx
  100736:	29 c2                	sub    %eax,%edx
  100738:	52                   	push   %edx
  100739:	8b 53 04             	mov    0x4(%ebx),%edx
  10073c:	01 f2                	add    %esi,%edx
  10073e:	52                   	push   %edx
  10073f:	50                   	push   %eax
  100740:	e8 27 00 00 00       	call   10076c <memcpy>
  100745:	83 c4 10             	add    $0x10,%esp
  100748:	eb 04                	jmp    10074e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10074a:	c6 07 00             	movb   $0x0,(%edi)
  10074d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10074e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100752:	72 f6                	jb     10074a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100754:	83 c3 20             	add    $0x20,%ebx
  100757:	39 eb                	cmp    %ebp,%ebx
  100759:	72 bd                	jb     100718 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10075b:	8b 56 18             	mov    0x18(%esi),%edx
  10075e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100762:	89 10                	mov    %edx,(%eax)
}
  100764:	83 c4 1c             	add    $0x1c,%esp
  100767:	5b                   	pop    %ebx
  100768:	5e                   	pop    %esi
  100769:	5f                   	pop    %edi
  10076a:	5d                   	pop    %ebp
  10076b:	c3                   	ret    

0010076c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10076c:	56                   	push   %esi
  10076d:	31 d2                	xor    %edx,%edx
  10076f:	53                   	push   %ebx
  100770:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100774:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100778:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10077c:	eb 08                	jmp    100786 <memcpy+0x1a>
		*d++ = *s++;
  10077e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100781:	4e                   	dec    %esi
  100782:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100785:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100786:	85 f6                	test   %esi,%esi
  100788:	75 f4                	jne    10077e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10078a:	5b                   	pop    %ebx
  10078b:	5e                   	pop    %esi
  10078c:	c3                   	ret    

0010078d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10078d:	57                   	push   %edi
  10078e:	56                   	push   %esi
  10078f:	53                   	push   %ebx
  100790:	8b 44 24 10          	mov    0x10(%esp),%eax
  100794:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100798:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10079c:	39 c7                	cmp    %eax,%edi
  10079e:	73 26                	jae    1007c6 <memmove+0x39>
  1007a0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1007a3:	39 c6                	cmp    %eax,%esi
  1007a5:	76 1f                	jbe    1007c6 <memmove+0x39>
		s += n, d += n;
  1007a7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1007aa:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1007ac:	eb 07                	jmp    1007b5 <memmove+0x28>
			*--d = *--s;
  1007ae:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1007b1:	4a                   	dec    %edx
  1007b2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1007b5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1007b6:	85 d2                	test   %edx,%edx
  1007b8:	75 f4                	jne    1007ae <memmove+0x21>
  1007ba:	eb 10                	jmp    1007cc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1007bc:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1007bf:	4a                   	dec    %edx
  1007c0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1007c3:	41                   	inc    %ecx
  1007c4:	eb 02                	jmp    1007c8 <memmove+0x3b>
  1007c6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1007c8:	85 d2                	test   %edx,%edx
  1007ca:	75 f0                	jne    1007bc <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1007cc:	5b                   	pop    %ebx
  1007cd:	5e                   	pop    %esi
  1007ce:	5f                   	pop    %edi
  1007cf:	c3                   	ret    

001007d0 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1007d0:	53                   	push   %ebx
  1007d1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007d5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1007d9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1007dd:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1007df:	eb 04                	jmp    1007e5 <memset+0x15>
		*p++ = c;
  1007e1:	88 1a                	mov    %bl,(%edx)
  1007e3:	49                   	dec    %ecx
  1007e4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1007e5:	85 c9                	test   %ecx,%ecx
  1007e7:	75 f8                	jne    1007e1 <memset+0x11>
		*p++ = c;
	return v;
}
  1007e9:	5b                   	pop    %ebx
  1007ea:	c3                   	ret    

001007eb <strlen>:

size_t
strlen(const char *s)
{
  1007eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  1007ef:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007f1:	eb 01                	jmp    1007f4 <strlen+0x9>
		++n;
  1007f3:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007f4:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007f8:	75 f9                	jne    1007f3 <strlen+0x8>
		++n;
	return n;
}
  1007fa:	c3                   	ret    

001007fb <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007fb:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007ff:	31 c0                	xor    %eax,%eax
  100801:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100805:	eb 01                	jmp    100808 <strnlen+0xd>
		++n;
  100807:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100808:	39 d0                	cmp    %edx,%eax
  10080a:	74 06                	je     100812 <strnlen+0x17>
  10080c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100810:	75 f5                	jne    100807 <strnlen+0xc>
		++n;
	return n;
}
  100812:	c3                   	ret    

00100813 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100813:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100814:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100819:	53                   	push   %ebx
  10081a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10081c:	76 05                	jbe    100823 <console_putc+0x10>
  10081e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100823:	80 fa 0a             	cmp    $0xa,%dl
  100826:	75 2c                	jne    100854 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100828:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10082e:	be 50 00 00 00       	mov    $0x50,%esi
  100833:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100835:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100838:	99                   	cltd   
  100839:	f7 fe                	idiv   %esi
  10083b:	89 de                	mov    %ebx,%esi
  10083d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10083f:	eb 07                	jmp    100848 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100841:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100844:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100845:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100848:	83 f8 50             	cmp    $0x50,%eax
  10084b:	75 f4                	jne    100841 <console_putc+0x2e>
  10084d:	29 d0                	sub    %edx,%eax
  10084f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100852:	eb 0b                	jmp    10085f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100854:	0f b6 d2             	movzbl %dl,%edx
  100857:	09 ca                	or     %ecx,%edx
  100859:	66 89 13             	mov    %dx,(%ebx)
  10085c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10085f:	5b                   	pop    %ebx
  100860:	5e                   	pop    %esi
  100861:	c3                   	ret    

00100862 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100862:	56                   	push   %esi
  100863:	53                   	push   %ebx
  100864:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100868:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10086b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10086f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100874:	75 04                	jne    10087a <fill_numbuf+0x18>
  100876:	85 d2                	test   %edx,%edx
  100878:	74 10                	je     10088a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10087a:	89 d0                	mov    %edx,%eax
  10087c:	31 d2                	xor    %edx,%edx
  10087e:	f7 f1                	div    %ecx
  100880:	4b                   	dec    %ebx
  100881:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100884:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100886:	89 c2                	mov    %eax,%edx
  100888:	eb ec                	jmp    100876 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10088a:	89 d8                	mov    %ebx,%eax
  10088c:	5b                   	pop    %ebx
  10088d:	5e                   	pop    %esi
  10088e:	c3                   	ret    

0010088f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10088f:	55                   	push   %ebp
  100890:	57                   	push   %edi
  100891:	56                   	push   %esi
  100892:	53                   	push   %ebx
  100893:	83 ec 38             	sub    $0x38,%esp
  100896:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10089a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10089e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008a2:	e9 60 03 00 00       	jmp    100c07 <console_vprintf+0x378>
		if (*format != '%') {
  1008a7:	80 fa 25             	cmp    $0x25,%dl
  1008aa:	74 13                	je     1008bf <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1008ac:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008b0:	0f b6 d2             	movzbl %dl,%edx
  1008b3:	89 f0                	mov    %esi,%eax
  1008b5:	e8 59 ff ff ff       	call   100813 <console_putc>
  1008ba:	e9 45 03 00 00       	jmp    100c04 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008bf:	47                   	inc    %edi
  1008c0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1008c7:	00 
  1008c8:	eb 12                	jmp    1008dc <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1008ca:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1008cb:	8a 11                	mov    (%ecx),%dl
  1008cd:	84 d2                	test   %dl,%dl
  1008cf:	74 1a                	je     1008eb <console_vprintf+0x5c>
  1008d1:	89 e8                	mov    %ebp,%eax
  1008d3:	38 c2                	cmp    %al,%dl
  1008d5:	75 f3                	jne    1008ca <console_vprintf+0x3b>
  1008d7:	e9 3f 03 00 00       	jmp    100c1b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008dc:	8a 17                	mov    (%edi),%dl
  1008de:	84 d2                	test   %dl,%dl
  1008e0:	74 0b                	je     1008ed <console_vprintf+0x5e>
  1008e2:	b9 6c 0e 10 00       	mov    $0x100e6c,%ecx
  1008e7:	89 d5                	mov    %edx,%ebp
  1008e9:	eb e0                	jmp    1008cb <console_vprintf+0x3c>
  1008eb:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1008ed:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008f0:	3c 08                	cmp    $0x8,%al
  1008f2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008f9:	00 
  1008fa:	76 13                	jbe    10090f <console_vprintf+0x80>
  1008fc:	eb 1d                	jmp    10091b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008fe:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100903:	0f be c0             	movsbl %al,%eax
  100906:	47                   	inc    %edi
  100907:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10090b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10090f:	8a 07                	mov    (%edi),%al
  100911:	8d 50 d0             	lea    -0x30(%eax),%edx
  100914:	80 fa 09             	cmp    $0x9,%dl
  100917:	76 e5                	jbe    1008fe <console_vprintf+0x6f>
  100919:	eb 18                	jmp    100933 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10091b:	80 fa 2a             	cmp    $0x2a,%dl
  10091e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100925:	ff 
  100926:	75 0b                	jne    100933 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100928:	83 c3 04             	add    $0x4,%ebx
			++format;
  10092b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10092c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10092f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100933:	83 cd ff             	or     $0xffffffff,%ebp
  100936:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100939:	75 37                	jne    100972 <console_vprintf+0xe3>
			++format;
  10093b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10093c:	31 ed                	xor    %ebp,%ebp
  10093e:	8a 07                	mov    (%edi),%al
  100940:	8d 50 d0             	lea    -0x30(%eax),%edx
  100943:	80 fa 09             	cmp    $0x9,%dl
  100946:	76 0d                	jbe    100955 <console_vprintf+0xc6>
  100948:	eb 17                	jmp    100961 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10094a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10094d:	0f be c0             	movsbl %al,%eax
  100950:	47                   	inc    %edi
  100951:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100955:	8a 07                	mov    (%edi),%al
  100957:	8d 50 d0             	lea    -0x30(%eax),%edx
  10095a:	80 fa 09             	cmp    $0x9,%dl
  10095d:	76 eb                	jbe    10094a <console_vprintf+0xbb>
  10095f:	eb 11                	jmp    100972 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100961:	3c 2a                	cmp    $0x2a,%al
  100963:	75 0b                	jne    100970 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100965:	83 c3 04             	add    $0x4,%ebx
				++format;
  100968:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100969:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10096c:	85 ed                	test   %ebp,%ebp
  10096e:	79 02                	jns    100972 <console_vprintf+0xe3>
  100970:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100972:	8a 07                	mov    (%edi),%al
  100974:	3c 64                	cmp    $0x64,%al
  100976:	74 34                	je     1009ac <console_vprintf+0x11d>
  100978:	7f 1d                	jg     100997 <console_vprintf+0x108>
  10097a:	3c 58                	cmp    $0x58,%al
  10097c:	0f 84 a2 00 00 00    	je     100a24 <console_vprintf+0x195>
  100982:	3c 63                	cmp    $0x63,%al
  100984:	0f 84 bf 00 00 00    	je     100a49 <console_vprintf+0x1ba>
  10098a:	3c 43                	cmp    $0x43,%al
  10098c:	0f 85 d0 00 00 00    	jne    100a62 <console_vprintf+0x1d3>
  100992:	e9 a3 00 00 00       	jmp    100a3a <console_vprintf+0x1ab>
  100997:	3c 75                	cmp    $0x75,%al
  100999:	74 4d                	je     1009e8 <console_vprintf+0x159>
  10099b:	3c 78                	cmp    $0x78,%al
  10099d:	74 5c                	je     1009fb <console_vprintf+0x16c>
  10099f:	3c 73                	cmp    $0x73,%al
  1009a1:	0f 85 bb 00 00 00    	jne    100a62 <console_vprintf+0x1d3>
  1009a7:	e9 86 00 00 00       	jmp    100a32 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1009ac:	83 c3 04             	add    $0x4,%ebx
  1009af:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1009b2:	89 d1                	mov    %edx,%ecx
  1009b4:	c1 f9 1f             	sar    $0x1f,%ecx
  1009b7:	89 0c 24             	mov    %ecx,(%esp)
  1009ba:	31 ca                	xor    %ecx,%edx
  1009bc:	55                   	push   %ebp
  1009bd:	29 ca                	sub    %ecx,%edx
  1009bf:	68 74 0e 10 00       	push   $0x100e74
  1009c4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009c9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009cd:	e8 90 fe ff ff       	call   100862 <fill_numbuf>
  1009d2:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1009d6:	58                   	pop    %eax
  1009d7:	5a                   	pop    %edx
  1009d8:	ba 01 00 00 00       	mov    $0x1,%edx
  1009dd:	8b 04 24             	mov    (%esp),%eax
  1009e0:	83 e0 01             	and    $0x1,%eax
  1009e3:	e9 a5 00 00 00       	jmp    100a8d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1009e8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1009eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009f0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009f3:	55                   	push   %ebp
  1009f4:	68 74 0e 10 00       	push   $0x100e74
  1009f9:	eb 11                	jmp    100a0c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009fb:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009fe:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a01:	55                   	push   %ebp
  100a02:	68 88 0e 10 00       	push   $0x100e88
  100a07:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a0c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a10:	e8 4d fe ff ff       	call   100862 <fill_numbuf>
  100a15:	ba 01 00 00 00       	mov    $0x1,%edx
  100a1a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a1e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a20:	59                   	pop    %ecx
  100a21:	59                   	pop    %ecx
  100a22:	eb 69                	jmp    100a8d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a24:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a27:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a2a:	55                   	push   %ebp
  100a2b:	68 74 0e 10 00       	push   $0x100e74
  100a30:	eb d5                	jmp    100a07 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a32:	83 c3 04             	add    $0x4,%ebx
  100a35:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a38:	eb 40                	jmp    100a7a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a3a:	83 c3 04             	add    $0x4,%ebx
  100a3d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a40:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a44:	e9 bd 01 00 00       	jmp    100c06 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a49:	83 c3 04             	add    $0x4,%ebx
  100a4c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a4f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a53:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a58:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a5c:	88 44 24 24          	mov    %al,0x24(%esp)
  100a60:	eb 27                	jmp    100a89 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a62:	84 c0                	test   %al,%al
  100a64:	75 02                	jne    100a68 <console_vprintf+0x1d9>
  100a66:	b0 25                	mov    $0x25,%al
  100a68:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a6c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a71:	80 3f 00             	cmpb   $0x0,(%edi)
  100a74:	74 0a                	je     100a80 <console_vprintf+0x1f1>
  100a76:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a7e:	eb 09                	jmp    100a89 <console_vprintf+0x1fa>
				format--;
  100a80:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a84:	4f                   	dec    %edi
  100a85:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a89:	31 d2                	xor    %edx,%edx
  100a8b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a8d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a8f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a99:	74 1f                	je     100aba <console_vprintf+0x22b>
  100a9b:	89 04 24             	mov    %eax,(%esp)
  100a9e:	eb 01                	jmp    100aa1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100aa0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100aa1:	39 e9                	cmp    %ebp,%ecx
  100aa3:	74 0a                	je     100aaf <console_vprintf+0x220>
  100aa5:	8b 44 24 04          	mov    0x4(%esp),%eax
  100aa9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100aad:	75 f1                	jne    100aa0 <console_vprintf+0x211>
  100aaf:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100ab2:	89 0c 24             	mov    %ecx,(%esp)
  100ab5:	eb 1f                	jmp    100ad6 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100ab7:	42                   	inc    %edx
  100ab8:	eb 09                	jmp    100ac3 <console_vprintf+0x234>
  100aba:	89 d1                	mov    %edx,%ecx
  100abc:	8b 14 24             	mov    (%esp),%edx
  100abf:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100ac3:	8b 44 24 04          	mov    0x4(%esp),%eax
  100ac7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100acb:	75 ea                	jne    100ab7 <console_vprintf+0x228>
  100acd:	8b 44 24 08          	mov    0x8(%esp),%eax
  100ad1:	89 14 24             	mov    %edx,(%esp)
  100ad4:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100ad6:	85 c0                	test   %eax,%eax
  100ad8:	74 0c                	je     100ae6 <console_vprintf+0x257>
  100ada:	84 d2                	test   %dl,%dl
  100adc:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100ae3:	00 
  100ae4:	75 24                	jne    100b0a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100ae6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100aeb:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100af2:	00 
  100af3:	75 15                	jne    100b0a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100af5:	8b 44 24 14          	mov    0x14(%esp),%eax
  100af9:	83 e0 08             	and    $0x8,%eax
  100afc:	83 f8 01             	cmp    $0x1,%eax
  100aff:	19 c9                	sbb    %ecx,%ecx
  100b01:	f7 d1                	not    %ecx
  100b03:	83 e1 20             	and    $0x20,%ecx
  100b06:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b0a:	3b 2c 24             	cmp    (%esp),%ebp
  100b0d:	7e 0d                	jle    100b1c <console_vprintf+0x28d>
  100b0f:	84 d2                	test   %dl,%dl
  100b11:	74 40                	je     100b53 <console_vprintf+0x2c4>
			zeros = precision - len;
  100b13:	2b 2c 24             	sub    (%esp),%ebp
  100b16:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b1a:	eb 3f                	jmp    100b5b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b1c:	84 d2                	test   %dl,%dl
  100b1e:	74 33                	je     100b53 <console_vprintf+0x2c4>
  100b20:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b24:	83 e0 06             	and    $0x6,%eax
  100b27:	83 f8 02             	cmp    $0x2,%eax
  100b2a:	75 27                	jne    100b53 <console_vprintf+0x2c4>
  100b2c:	45                   	inc    %ebp
  100b2d:	75 24                	jne    100b53 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b2f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b31:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b34:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b39:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b3c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b3f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b43:	7d 0e                	jge    100b53 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b45:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b49:	29 ca                	sub    %ecx,%edx
  100b4b:	29 c2                	sub    %eax,%edx
  100b4d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b51:	eb 08                	jmp    100b5b <console_vprintf+0x2cc>
  100b53:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b5a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b5b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b5f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b61:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b65:	2b 2c 24             	sub    (%esp),%ebp
  100b68:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b6d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b70:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b73:	29 c5                	sub    %eax,%ebp
  100b75:	89 f0                	mov    %esi,%eax
  100b77:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b7f:	eb 0f                	jmp    100b90 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b81:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b85:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b8a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b8b:	e8 83 fc ff ff       	call   100813 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b90:	85 ed                	test   %ebp,%ebp
  100b92:	7e 07                	jle    100b9b <console_vprintf+0x30c>
  100b94:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b99:	74 e6                	je     100b81 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b9b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ba0:	89 c6                	mov    %eax,%esi
  100ba2:	74 23                	je     100bc7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ba4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ba9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bad:	e8 61 fc ff ff       	call   100813 <console_putc>
  100bb2:	89 c6                	mov    %eax,%esi
  100bb4:	eb 11                	jmp    100bc7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100bb6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bba:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100bbf:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100bc0:	e8 4e fc ff ff       	call   100813 <console_putc>
  100bc5:	eb 06                	jmp    100bcd <console_vprintf+0x33e>
  100bc7:	89 f0                	mov    %esi,%eax
  100bc9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100bcd:	85 f6                	test   %esi,%esi
  100bcf:	7f e5                	jg     100bb6 <console_vprintf+0x327>
  100bd1:	8b 34 24             	mov    (%esp),%esi
  100bd4:	eb 15                	jmp    100beb <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100bd6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bda:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100bdb:	0f b6 11             	movzbl (%ecx),%edx
  100bde:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100be2:	e8 2c fc ff ff       	call   100813 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100be7:	ff 44 24 04          	incl   0x4(%esp)
  100beb:	85 f6                	test   %esi,%esi
  100bed:	7f e7                	jg     100bd6 <console_vprintf+0x347>
  100bef:	eb 0f                	jmp    100c00 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100bf1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bf5:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bfa:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bfb:	e8 13 fc ff ff       	call   100813 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c00:	85 ed                	test   %ebp,%ebp
  100c02:	7f ed                	jg     100bf1 <console_vprintf+0x362>
  100c04:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c06:	47                   	inc    %edi
  100c07:	8a 17                	mov    (%edi),%dl
  100c09:	84 d2                	test   %dl,%dl
  100c0b:	0f 85 96 fc ff ff    	jne    1008a7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c11:	83 c4 38             	add    $0x38,%esp
  100c14:	89 f0                	mov    %esi,%eax
  100c16:	5b                   	pop    %ebx
  100c17:	5e                   	pop    %esi
  100c18:	5f                   	pop    %edi
  100c19:	5d                   	pop    %ebp
  100c1a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c1b:	81 e9 6c 0e 10 00    	sub    $0x100e6c,%ecx
  100c21:	b8 01 00 00 00       	mov    $0x1,%eax
  100c26:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c28:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c29:	09 44 24 14          	or     %eax,0x14(%esp)
  100c2d:	e9 aa fc ff ff       	jmp    1008dc <console_vprintf+0x4d>

00100c32 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c32:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c36:	50                   	push   %eax
  100c37:	ff 74 24 10          	pushl  0x10(%esp)
  100c3b:	ff 74 24 10          	pushl  0x10(%esp)
  100c3f:	ff 74 24 10          	pushl  0x10(%esp)
  100c43:	e8 47 fc ff ff       	call   10088f <console_vprintf>
  100c48:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c4b:	c3                   	ret    

00100c4c <Random>:
{
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c4c:	8b 0d a8 83 10 00    	mov    0x1083a8,%ecx
/* ----------------------------------------------------------------
 * Random returns a pseudo-random real number uniformly distributed 
 * between 0.0 and 1.0. 
 * ----------------------------------------------------------------
 */
{
  100c52:	56                   	push   %esi
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c53:	be c8 ad 00 00       	mov    $0xadc8,%esi
/* ----------------------------------------------------------------
 * Random returns a pseudo-random real number uniformly distributed 
 * between 0.0 and 1.0. 
 * ----------------------------------------------------------------
 */
{
  100c58:	53                   	push   %ebx
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c59:	bb 38 52 ff ff       	mov    $0xffff5238,%ebx
  100c5e:	8b 04 8d 60 10 10 00 	mov    0x101060(,%ecx,4),%eax
  100c65:	99                   	cltd   
  100c66:	f7 fb                	idiv   %ebx
  100c68:	69 d8 47 0d 00 00    	imul   $0xd47,%eax,%ebx
  100c6e:	8b 04 8d 60 10 10 00 	mov    0x101060(,%ecx,4),%eax
  100c75:	99                   	cltd   
  100c76:	f7 fe                	idiv   %esi
  100c78:	69 d2 8f bc 00 00    	imul   $0xbc8f,%edx,%edx
  100c7e:	01 d3                	add    %edx,%ebx
  if (t > 0) 
  100c80:	85 db                	test   %ebx,%ebx
  100c82:	7f 06                	jg     100c8a <Random+0x3e>
    seed[stream] = t;
  else 
    seed[stream] = t + MODULUS;
  100c84:	81 c3 ff ff ff 7f    	add    $0x7fffffff,%ebx
  100c8a:	89 1c 8d 60 10 10 00 	mov    %ebx,0x101060(,%ecx,4)
  100c91:	dd 05 a0 0e 10 00    	fldl   0x100ea0
  100c97:	da 3c 8d 60 10 10 00 	fidivrl 0x101060(,%ecx,4)
  return ((double) seed[stream] / MODULUS);
}
  100c9e:	5b                   	pop    %ebx
  100c9f:	5e                   	pop    %esi
  100ca0:	c3                   	ret    

00100ca1 <PutSeed>:
 *    if x > 0 then x is the state (unless too large)
 *    if x < 0 then the state is obtained from the system clock
 *    if x = 0 then the state is to be supplied interactively
 * ---------------------------------------------------------------
 */
{
  100ca1:	8b 54 24 04          	mov    0x4(%esp),%edx
  char ok = 0;

  if (x > 0)
  100ca5:	85 d2                	test   %edx,%edx
  100ca7:	7e 0a                	jle    100cb3 <PutSeed+0x12>
    x = x % MODULUS;                       /* correct if x is too large  */
  100ca9:	89 d0                	mov    %edx,%eax
  100cab:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
  100cb0:	99                   	cltd   
  100cb1:	f7 f9                	idiv   %ecx
  if (x < 0)                                 
  100cb3:	83 fa 00             	cmp    $0x0,%edx
  100cb6:	7c 02                	jl     100cba <PutSeed+0x19>
    x = 10086 % MODULUS;              
  if (x == 0)                                
  100cb8:	75 05                	jne    100cbf <PutSeed+0x1e>
  100cba:	ba 66 27 00 00       	mov    $0x2766,%edx
    x = 10086 % MODULUS;              
  seed[stream] = x;
  100cbf:	a1 a8 83 10 00       	mov    0x1083a8,%eax
  100cc4:	89 14 85 60 10 10 00 	mov    %edx,0x101060(,%eax,4)
}
  100ccb:	c3                   	ret    

00100ccc <GetSeed>:
 * Use this function to get the state of the current random number 
 * generator stream.                                                   
 * ---------------------------------------------------------------
 */
{
  *x = seed[stream];
  100ccc:	a1 a8 83 10 00       	mov    0x1083a8,%eax
  100cd1:	8b 14 85 60 10 10 00 	mov    0x101060(,%eax,4),%edx
  100cd8:	8b 44 24 04          	mov    0x4(%esp),%eax
  100cdc:	89 10                	mov    %edx,(%eax)
}
  100cde:	c3                   	ret    

00100cdf <SelectStream>:
/* ------------------------------------------------------------------
 * Use this function to set the current random number generator
 * stream -- that stream from which the next random number will come.
 * ------------------------------------------------------------------
 */
{
  100cdf:	83 ec 0c             	sub    $0xc,%esp
  stream = ((unsigned int) index) % STREAMS;
  100ce2:	8b 44 24 10          	mov    0x10(%esp),%eax
  100ce6:	25 ff 00 00 00       	and    $0xff,%eax
  if ((initialized == 0) && (stream != 0))   /* protect against        */
  100ceb:	83 3d ac 83 10 00 00 	cmpl   $0x0,0x1083ac
 * Use this function to set the current random number generator
 * stream -- that stream from which the next random number will come.
 * ------------------------------------------------------------------
 */
{
  stream = ((unsigned int) index) % STREAMS;
  100cf2:	a3 a8 83 10 00       	mov    %eax,0x1083a8
  if ((initialized == 0) && (stream != 0))   /* protect against        */
  100cf7:	75 14                	jne    100d0d <SelectStream+0x2e>
  100cf9:	85 c0                	test   %eax,%eax
  100cfb:	74 10                	je     100d0d <SelectStream+0x2e>
    PlantSeeds(DEFAULT);                     /* un-initialized streams */
  100cfd:	c7 44 24 10 15 cd 5b 	movl   $0x75bcd15,0x10(%esp)
  100d04:	07 
}
  100d05:	83 c4 0c             	add    $0xc,%esp
 * ------------------------------------------------------------------
 */
{
  stream = ((unsigned int) index) % STREAMS;
  if ((initialized == 0) && (stream != 0))   /* protect against        */
    PlantSeeds(DEFAULT);                     /* un-initialized streams */
  100d08:	e9 04 00 00 00       	jmp    100d11 <PlantSeeds>
}
  100d0d:	83 c4 0c             	add    $0xc,%esp
  100d10:	c3                   	ret    

00100d11 <PlantSeeds>:
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d11:	57                   	push   %edi
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d12:	bf ea 6d 01 00       	mov    $0x16dea,%edi
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d17:	56                   	push   %esi
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d18:	be 16 92 fe ff       	mov    $0xfffe9216,%esi
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d1d:	53                   	push   %ebx
  100d1e:	83 ec 1c             	sub    $0x1c,%esp
  const long R = MODULUS % A256;
        int  j;
        int  s;

  initialized = 1;
  s = stream;                            /* remember the current stream */
  100d21:	8b 1d a8 83 10 00    	mov    0x1083a8,%ebx
  SelectStream(0);                       /* change to stream 0          */
  100d27:	6a 00                	push   $0x0
  const long Q = MODULUS / A256;
  const long R = MODULUS % A256;
        int  j;
        int  s;

  initialized = 1;
  100d29:	c7 05 ac 83 10 00 01 	movl   $0x1,0x1083ac
  100d30:	00 00 00 
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  100d33:	e8 a7 ff ff ff       	call   100cdf <SelectStream>
  PutSeed(x);                            /* set seed[0]                 */
  100d38:	59                   	pop    %ecx
  100d39:	ff 74 24 2c          	pushl  0x2c(%esp)
  100d3d:	e8 5f ff ff ff       	call   100ca1 <PutSeed>
  stream = s;                            /* reset the current stream    */
  100d42:	b9 01 00 00 00       	mov    $0x1,%ecx
  100d47:	83 c4 10             	add    $0x10,%esp
  100d4a:	89 1d a8 83 10 00    	mov    %ebx,0x1083a8
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d50:	8b 04 8d 5c 10 10 00 	mov    0x10105c(,%ecx,4),%eax
  100d57:	99                   	cltd   
  100d58:	f7 fe                	idiv   %esi
  100d5a:	69 d8 1d 1c 00 00    	imul   $0x1c1d,%eax,%ebx
  100d60:	8b 04 8d 5c 10 10 00 	mov    0x10105c(,%ecx,4),%eax
  100d67:	99                   	cltd   
  100d68:	f7 ff                	idiv   %edi
  100d6a:	69 d2 8d 59 00 00    	imul   $0x598d,%edx,%edx
  100d70:	01 d3                	add    %edx,%ebx
    if (x > 0)
  100d72:	85 db                	test   %ebx,%ebx
  100d74:	7f 06                	jg     100d7c <PlantSeeds+0x6b>
      seed[j] = x;
    else
      seed[j] = x + MODULUS;
  100d76:	81 c3 ff ff ff 7f    	add    $0x7fffffff,%ebx
  100d7c:	89 1c 8d 60 10 10 00 	mov    %ebx,0x101060(,%ecx,4)
  initialized = 1;
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
  100d83:	41                   	inc    %ecx
  100d84:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  100d8a:	75 c4                	jne    100d50 <PlantSeeds+0x3f>
    if (x > 0)
      seed[j] = x;
    else
      seed[j] = x + MODULUS;
   }
}
  100d8c:	83 c4 10             	add    $0x10,%esp
  100d8f:	5b                   	pop    %ebx
  100d90:	5e                   	pop    %esi
  100d91:	5f                   	pop    %edi
  100d92:	c3                   	ret    

00100d93 <TestRandom>:
   void TestRandom(void)
/* ------------------------------------------------------------------
 * Use this (optional) function to test for a correct implementation.
 * ------------------------------------------------------------------    
 */
{
  100d93:	53                   	push   %ebx
  long   x;
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  PutSeed(1);                       /* and set the state to 1    */
  100d94:	31 db                	xor    %ebx,%ebx
   void TestRandom(void)
/* ------------------------------------------------------------------
 * Use this (optional) function to test for a correct implementation.
 * ------------------------------------------------------------------    
 */
{
  100d96:	83 ec 14             	sub    $0x14,%esp
  long   i;
  long   x;
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  100d99:	6a 00                	push   $0x0
  100d9b:	e8 3f ff ff ff       	call   100cdf <SelectStream>
  PutSeed(1);                       /* and set the state to 1    */
  100da0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100da7:	e8 f5 fe ff ff       	call   100ca1 <PutSeed>
  100dac:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 10000; i++)
  100daf:	43                   	inc    %ebx
    u = Random();
  100db0:	e8 97 fe ff ff       	call   100c4c <Random>
  100db5:	dd d8                	fstp   %st(0)
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  PutSeed(1);                       /* and set the state to 1    */
  for(i = 0; i < 10000; i++)
  100db7:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
  100dbd:	75 f0                	jne    100daf <TestRandom+0x1c>
    u = Random();
  GetSeed(&x);                      /* get the new state value   */
  ok = (x == CHECK);                /* and check for correctness */

  SelectStream(1);                  /* select stream 1                 */ 
  100dbf:	83 ec 0c             	sub    $0xc,%esp
  100dc2:	6a 01                	push   $0x1
  100dc4:	e8 16 ff ff ff       	call   100cdf <SelectStream>
  PlantSeeds(1);                    /* set the state of all streams    */
  100dc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100dd0:	e8 3c ff ff ff       	call   100d11 <PlantSeeds>
  GetSeed(&x);                      /* get the state of stream 1       */
  ok = ok && (x == A256);           /* x should be the jump multiplier */    
}
  100dd5:	83 c4 18             	add    $0x18,%esp
  100dd8:	5b                   	pop    %ebx
  100dd9:	c3                   	ret    

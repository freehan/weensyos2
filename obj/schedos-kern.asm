
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
  10006d:	e8 62 03 00 00       	call   1003d4 <interrupt>

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
  1000fc:	e8 8f 03 00 00       	call   100490 <segments_init>
	interrupt_controller_init(1);
  100101:	83 ec 0c             	sub    $0xc,%esp
  100104:	6a 01                	push   $0x1
  100106:	e8 80 04 00 00       	call   10058b <interrupt_controller_init>
	console_clear();
  10010b:	e8 04 05 00 00       	call   100614 <console_clear>
	PlantSeeds(1);
  100110:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100117:	e8 19 0c 00 00       	call   100d35 <PlantSeeds>
	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10011c:	83 c4 0c             	add    $0xc,%esp
  10011f:	68 cc 01 00 00       	push   $0x1cc
  100124:	6a 00                	push   $0x0
  100126:	68 e0 77 10 00       	push   $0x1077e0
  10012b:	e8 c4 06 00 00       	call   1007f4 <memset>
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
  10019b:	e8 28 05 00 00       	call   1006c8 <special_registers_init>

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
  1001b1:	e8 4e 05 00 00       	call   100704 <program_loader>
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
	scheduling_algorithm = 1;
        //scheduling_algorithm = 2;
        //scheduling_algorithm = 3;
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
	//XIA: try
	lock = (uint32_t) 0;
  1001f2:	c7 05 04 80 19 00 00 	movl   $0x0,0x198004
  1001f9:	00 00 00 

	// Initialize the scheduling algorithm.
	//by Sk
	//scheduling_algorithm = 0;
	scheduling_algorithm = 1;
  1001fc:	c7 05 b4 83 10 00 01 	movl   $0x1,0x1083b4
  100203:	00 00 00 
	// Switch to the first process.
#if CURRENT_PART == 1
	proc_array[1].p_runtime++;
#endif

	PlantSeeds(1);
  100206:	e8 2a 0b 00 00       	call   100d35 <PlantSeeds>
	
	run(&proc_array[1]);
  10020b:	c7 04 24 3c 78 10 00 	movl   $0x10783c,(%esp)
  100212:	e8 9a 04 00 00       	call   1006b1 <run>

00100217 <get_winner>:
	}
	ticket_num--;
}

pid_t
get_winner(void){
  100217:	83 ec 1c             	sub    $0x1c,%esp
	int r = Random()*100000;
  10021a:	e8 51 0a 00 00       	call   100c70 <Random>
  10021f:	d9 7c 24 0e          	fnstcw 0xe(%esp)
  100223:	d8 0d 88 0e 10 00    	fmuls  0x100e88
  100229:	66 8b 44 24 0e       	mov    0xe(%esp),%ax
  10022e:	80 cc 0c             	or     $0xc,%ah
  100231:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  100236:	d9 6c 24 0c          	fldcw  0xc(%esp)
  10023a:	db 5c 24 08          	fistpl 0x8(%esp)
  10023e:	d9 6c 24 0e          	fldcw  0xe(%esp)
  100242:	8b 44 24 08          	mov    0x8(%esp),%eax
  100246:	99                   	cltd   
  100247:	f7 3d ac 79 10 00    	idivl  0x1079ac
  10024d:	8b 04 95 b0 79 10 00 	mov    0x1079b0(,%edx,4),%eax
	int winner = r%ticket_num;
	return tickets[winner];
}
  100254:	83 c4 1c             	add    $0x1c,%esp
  100257:	c3                   	ret    

00100258 <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  100258:	55                   	push   %ebp
  100259:	57                   	push   %edi
  10025a:	56                   	push   %esi
  10025b:	53                   	push   %ebx
  10025c:	83 ec 1c             	sub    $0x1c,%esp
	pid_t pid = current->p_pid;
  10025f:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  100264:	8b 08                	mov    (%eax),%ecx

	if (scheduling_algorithm == 0)
  100266:	a1 b4 83 10 00       	mov    0x1083b4,%eax
  10026b:	85 c0                	test   %eax,%eax
  10026d:	75 1e                	jne    10028d <schedule+0x35>
		while (1) {
			pid = (pid + 1) % NPROCS;
  10026f:	bb 05 00 00 00       	mov    $0x5,%ebx
  100274:	8d 41 01             	lea    0x1(%ecx),%eax
  100277:	99                   	cltd   
  100278:	f7 fb                	idiv   %ebx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  10027a:	6b c2 5c             	imul   $0x5c,%edx,%eax
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  10027d:	89 d1                	mov    %edx,%ecx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  10027f:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  100286:	75 ec                	jne    100274 <schedule+0x1c>
  100288:	e9 18 01 00 00       	jmp    1003a5 <schedule+0x14d>
				run(&proc_array[pid]);
		}
#if CURRENT_PART==1
	else if (scheduling_algorithm == 1){
  10028d:	83 f8 01             	cmp    $0x1,%eax
  100290:	75 4c                	jne    1002de <schedule+0x86>
  100292:	31 db                	xor    %ebx,%ebx
  100294:	31 ff                	xor    %edi,%edi
  100296:	be e7 03 00 00       	mov    $0x3e7,%esi
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
  10029b:	bd 05 00 00 00       	mov    $0x5,%ebp
  1002a0:	eb 25                	jmp    1002c7 <schedule+0x6f>
  1002a2:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  1002a5:	99                   	cltd   
  1002a6:	f7 fd                	idiv   %ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1002a8:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1002ab:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  1002b2:	75 0e                	jne    1002c2 <schedule+0x6a>
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
  1002b4:	8b 80 2c 78 10 00    	mov    0x10782c(%eax),%eax
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1002ba:	39 f0                	cmp    %esi,%eax
  1002bc:	7f 04                	jg     1002c2 <schedule+0x6a>
  1002be:	89 d7                	mov    %edx,%edi
  1002c0:	eb 02                	jmp    1002c4 <schedule+0x6c>
  1002c2:	89 f0                	mov    %esi,%eax
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
				highest_pri_p = cur_pid;
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
  1002c4:	43                   	inc    %ebx
  1002c5:	89 c6                	mov    %eax,%esi
#if CURRENT_PART==1
	else if (scheduling_algorithm == 1){
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
  1002c7:	83 fb 04             	cmp    $0x4,%ebx
  1002ca:	7e d6                	jle    1002a2 <schedule+0x4a>
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		run(&proc_array[highest_pri_p]);
  1002cc:	6b ff 5c             	imul   $0x5c,%edi,%edi
  1002cf:	83 ec 0c             	sub    $0xc,%esp
  1002d2:	81 c7 e0 77 10 00    	add    $0x1077e0,%edi
  1002d8:	57                   	push   %edi
  1002d9:	e8 d3 03 00 00       	call   1006b1 <run>
	}
	else if(scheduling_algorithm == 2){
  1002de:	83 f8 02             	cmp    $0x2,%eax
  1002e1:	0f 85 84 00 00 00    	jne    10036b <schedule+0x113>
  1002e7:	31 db                	xor    %ebx,%ebx
  1002e9:	31 f6                	xor    %esi,%esi
  1002eb:	d9 05 8c 0e 10 00    	flds   0x100e8c
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
  1002f1:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  1002f4:	bf 05 00 00 00       	mov    $0x5,%edi
  1002f9:	99                   	cltd   
  1002fa:	f7 ff                	idiv   %edi
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  1002fc:	6b c2 5c             	imul   $0x5c,%edx,%eax
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1002ff:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100306:	8b b8 34 78 10 00    	mov    0x107834(%eax),%edi
  10030c:	8b a8 30 78 10 00    	mov    0x107830(%eax),%ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100312:	75 20                	jne    100334 <schedule+0xdc>
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100314:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  100318:	db 44 24 0c          	fildl  0xc(%esp)
  10031c:	57                   	push   %edi
  10031d:	da 3c 24             	fidivrl (%esp)
  100320:	d9 c9                	fxch   %st(1)
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100322:	dd e1                	fucom  %st(1)
  100324:	df e0                	fnstsw %ax
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100326:	83 c4 04             	add    $0x4,%esp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100329:	9e                   	sahf   
  10032a:	72 06                	jb     100332 <schedule+0xda>
  10032c:	dd d8                	fstp   %st(0)
  10032e:	89 d6                	mov    %edx,%esi
  100330:	eb 02                	jmp    100334 <schedule+0xdc>
  100332:	dd d9                	fstp   %st(1)
					&& prop_value <= lowest_prop){
					winner = cur_pid;
					lowest_prop = prop_value;
			}
			i++;
  100334:	43                   	inc    %ebx
	}
	else if(scheduling_algorithm == 2){
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
  100335:	83 fb 04             	cmp    $0x4,%ebx
  100338:	7e b7                	jle    1002f1 <schedule+0x99>
  10033a:	d9 05 8c 0e 10 00    	flds   0x100e8c
  100340:	d9 c9                	fxch   %st(1)
  100342:	dd e1                	fucom  %st(1)
  100344:	df e0                	fnstsw %ax
  100346:	dd d9                	fstp   %st(1)
  100348:	9e                   	sahf   
  100349:	7a 06                	jp     100351 <schedule+0xf9>
  10034b:	74 a4                	je     1002f1 <schedule+0x99>
  10034d:	dd d8                	fstp   %st(0)
  10034f:	eb 02                	jmp    100353 <schedule+0xfb>
  100351:	dd d8                	fstp   %st(0)
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  100353:	6b f6 5c             	imul   $0x5c,%esi,%esi
		run(&proc_array[winner]);
  100356:	83 ec 0c             	sub    $0xc,%esp
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  100359:	ff 86 34 78 10 00    	incl   0x107834(%esi)
		run(&proc_array[winner]);
  10035f:	81 c6 e0 77 10 00    	add    $0x1077e0,%esi
  100365:	56                   	push   %esi
  100366:	e9 6e ff ff ff       	jmp    1002d9 <schedule+0x81>
	}
	else if(scheduling_algorithm == 3){ //lottery
  10036b:	83 f8 03             	cmp    $0x3,%eax
  10036e:	75 43                	jne    1003b3 <schedule+0x15b>
		pid_t winner;
		if(ticket_num < NPROCS-1){
  100370:	83 3d ac 79 10 00 03 	cmpl   $0x3,0x1079ac
  100377:	7f 1b                	jg     100394 <schedule+0x13c>
			while (1) {
				pid = (pid + 1) % NPROCS;
  100379:	bb 05 00 00 00       	mov    $0x5,%ebx
  10037e:	8d 41 01             	lea    0x1(%ecx),%eax
  100381:	99                   	cltd   
  100382:	f7 fb                	idiv   %ebx
				// Run the selected process, but skip
				// non-runnable processes.
				// Note that the 'run' function does not return.
				if (proc_array[pid].p_state == P_RUNNABLE)
  100384:	6b c2 5c             	imul   $0x5c,%edx,%eax
	}
	else if(scheduling_algorithm == 3){ //lottery
		pid_t winner;
		if(ticket_num < NPROCS-1){
			while (1) {
				pid = (pid + 1) % NPROCS;
  100387:	89 d1                	mov    %edx,%ecx
				// Run the selected process, but skip
				// non-runnable processes.
				// Note that the 'run' function does not return.
				if (proc_array[pid].p_state == P_RUNNABLE)
  100389:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  100390:	75 ec                	jne    10037e <schedule+0x126>
  100392:	eb 11                	jmp    1003a5 <schedule+0x14d>
			}
		}
		else{
			winner = get_winner();
			while(proc_array[winner].p_state != P_RUNNABLE){
				winner = get_winner();
  100394:	e8 7e fe ff ff       	call   100217 <get_winner>
					run(&proc_array[pid]);
			}
		}
		else{
			winner = get_winner();
			while(proc_array[winner].p_state != P_RUNNABLE){
  100399:	6b c0 5c             	imul   $0x5c,%eax,%eax
  10039c:	83 b8 28 78 10 00 01 	cmpl   $0x1,0x107828(%eax)
  1003a3:	75 ef                	jne    100394 <schedule+0x13c>
				winner = get_winner();
			}
		}
		run(&proc_array[winner]);
  1003a5:	83 ec 0c             	sub    $0xc,%esp
  1003a8:	05 e0 77 10 00       	add    $0x1077e0,%eax
  1003ad:	50                   	push   %eax
  1003ae:	e9 26 ff ff ff       	jmp    1002d9 <schedule+0x81>
	}
#endif
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1003b3:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1003b9:	50                   	push   %eax
  1003ba:	68 00 0e 10 00       	push   $0x100e00
  1003bf:	68 00 01 00 00       	push   $0x100
  1003c4:	52                   	push   %edx
  1003c5:	e8 8c 08 00 00       	call   100c56 <console_printf>
  1003ca:	83 c4 10             	add    $0x10,%esp
  1003cd:	a3 00 80 19 00       	mov    %eax,0x198000
  1003d2:	eb fe                	jmp    1003d2 <schedule+0x17a>

001003d4 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1003d4:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1003d5:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  1003da:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1003df:	56                   	push   %esi
  1003e0:	53                   	push   %ebx
  1003e1:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1003e5:	8d 78 04             	lea    0x4(%eax),%edi
  1003e8:	89 de                	mov    %ebx,%esi
  1003ea:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	switch (reg->reg_intno) {
  1003ec:	8b 53 28             	mov    0x28(%ebx),%edx
  1003ef:	83 ea 20             	sub    $0x20,%edx
  1003f2:	83 fa 18             	cmp    $0x18,%edx
  1003f5:	0f 87 92 00 00 00    	ja     10048d <interrupt+0xb9>
  1003fb:	ff 24 95 24 0e 10 00 	jmp    *0x100e24(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100402:	e8 51 fe ff ff       	call   100258 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100407:	a1 b0 83 10 00       	mov    0x1083b0,%eax
		current->p_exit_status = reg->reg_eax;
  10040c:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10040f:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100416:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100419:	e8 3a fe ff ff       	call   100258 <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  10041e:	83 ec 0c             	sub    $0xc,%esp
  100421:	eb 4b                	jmp    10046e <interrupt+0x9a>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100423:	83 ec 0c             	sub    $0xc,%esp
  100426:	50                   	push   %eax
  100427:	e8 85 02 00 00       	call   1006b1 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10042c:	e8 27 fe ff ff       	call   100258 <schedule>
    
	case INT_SYS_PRI:
		current->p_priority = reg->reg_eax;
  100431:	a1 b0 83 10 00       	mov    0x1083b0,%eax
  100436:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100439:	89 50 4c             	mov    %edx,0x4c(%eax)
  10043c:	eb e5                	jmp    100423 <interrupt+0x4f>
		run(current);

	case INT_SYS_PROP:
		current->p_proportional = reg->reg_eax;
  10043e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100441:	89 50 50             	mov    %edx,0x50(%eax)
  100444:	eb dd                	jmp    100423 <interrupt+0x4f>
		run(current);

	case INT_SYS_GETTICKET:
		if(ticket_num<MAX_TICKET_NUM){
  100446:	8b 15 ac 79 10 00    	mov    0x1079ac,%edx
  10044c:	83 fa 63             	cmp    $0x63,%edx
  10044f:	7f d2                	jg     100423 <interrupt+0x4f>
			tickets[ticket_num] = current->p_pid;
  100451:	8b 08                	mov    (%eax),%ecx
  100453:	89 0c 95 b0 79 10 00 	mov    %ecx,0x1079b0(,%edx,4)
			ticket_num++;
  10045a:	42                   	inc    %edx
  10045b:	89 15 ac 79 10 00    	mov    %edx,0x1079ac
  100461:	eb c0                	jmp    100423 <interrupt+0x4f>
		}
		run(current);
	case INT_SYS_ABORTTICKET:
		delete_ticket(current->p_pid);
  100463:	83 ec 0c             	sub    $0xc,%esp
  100466:	ff 30                	pushl  (%eax)
  100468:	e8 2f fc ff ff       	call   10009c <delete_ticket>
		run(current);
  10046d:	59                   	pop    %ecx
  10046e:	ff 35 b0 83 10 00    	pushl  0x1083b0
  100474:	eb b1                	jmp    100427 <interrupt+0x53>
	case INT_SYS_PRINTCHAR:
		*cursorpos++ = (uint16_t) reg->reg_eax;
  100476:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10047c:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  10047f:	66 89 0a             	mov    %cx,(%edx)
  100482:	83 c2 02             	add    $0x2,%edx
  100485:	89 15 00 80 19 00    	mov    %edx,0x198000
  10048b:	eb 96                	jmp    100423 <interrupt+0x4f>
  10048d:	eb fe                	jmp    10048d <interrupt+0xb9>
  10048f:	90                   	nop

00100490 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100490:	b8 40 7b 10 00       	mov    $0x107b40,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100495:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10049a:	89 c2                	mov    %eax,%edx
  10049c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10049f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004a0:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1004a5:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004a8:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1004ae:	c1 e8 18             	shr    $0x18,%eax
  1004b1:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004b7:	ba a8 7b 10 00       	mov    $0x107ba8,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004bc:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004c1:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004c3:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1004ca:	68 00 
  1004cc:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1004d3:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1004da:	c7 05 44 7b 10 00 00 	movl   $0x180000,0x107b44
  1004e1:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1004e4:	66 c7 05 48 7b 10 00 	movw   $0x10,0x107b48
  1004eb:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004ed:	66 89 0c c5 a8 7b 10 	mov    %cx,0x107ba8(,%eax,8)
  1004f4:	00 
  1004f5:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004fc:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100501:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100506:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10050b:	40                   	inc    %eax
  10050c:	3d 00 01 00 00       	cmp    $0x100,%eax
  100511:	75 da                	jne    1004ed <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100513:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100518:	ba a8 7b 10 00       	mov    $0x107ba8,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10051d:	66 a3 a8 7c 10 00    	mov    %ax,0x107ca8
  100523:	c1 e8 10             	shr    $0x10,%eax
  100526:	66 a3 ae 7c 10 00    	mov    %ax,0x107cae
  10052c:	b8 30 00 00 00       	mov    $0x30,%eax
  100531:	66 c7 05 aa 7c 10 00 	movw   $0x8,0x107caa
  100538:	08 00 
  10053a:	c6 05 ac 7c 10 00 00 	movb   $0x0,0x107cac
  100541:	c6 05 ad 7c 10 00 8e 	movb   $0x8e,0x107cad

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100548:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10054f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100556:	66 89 0c c5 a8 7b 10 	mov    %cx,0x107ba8(,%eax,8)
  10055d:	00 
  10055e:	c1 e9 10             	shr    $0x10,%ecx
  100561:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100566:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10056b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100570:	40                   	inc    %eax
  100571:	83 f8 3a             	cmp    $0x3a,%eax
  100574:	75 d2                	jne    100548 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100576:	b0 28                	mov    $0x28,%al
  100578:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10057f:	0f 00 d8             	ltr    %ax
  100582:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100589:	5b                   	pop    %ebx
  10058a:	c3                   	ret    

0010058b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10058b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10058c:	b0 ff                	mov    $0xff,%al
  10058e:	57                   	push   %edi
  10058f:	56                   	push   %esi
  100590:	53                   	push   %ebx
  100591:	bb 21 00 00 00       	mov    $0x21,%ebx
  100596:	89 da                	mov    %ebx,%edx
  100598:	ee                   	out    %al,(%dx)
  100599:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10059e:	89 ca                	mov    %ecx,%edx
  1005a0:	ee                   	out    %al,(%dx)
  1005a1:	be 11 00 00 00       	mov    $0x11,%esi
  1005a6:	bf 20 00 00 00       	mov    $0x20,%edi
  1005ab:	89 f0                	mov    %esi,%eax
  1005ad:	89 fa                	mov    %edi,%edx
  1005af:	ee                   	out    %al,(%dx)
  1005b0:	b0 20                	mov    $0x20,%al
  1005b2:	89 da                	mov    %ebx,%edx
  1005b4:	ee                   	out    %al,(%dx)
  1005b5:	b0 04                	mov    $0x4,%al
  1005b7:	ee                   	out    %al,(%dx)
  1005b8:	b0 03                	mov    $0x3,%al
  1005ba:	ee                   	out    %al,(%dx)
  1005bb:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1005c0:	89 f0                	mov    %esi,%eax
  1005c2:	89 ea                	mov    %ebp,%edx
  1005c4:	ee                   	out    %al,(%dx)
  1005c5:	b0 28                	mov    $0x28,%al
  1005c7:	89 ca                	mov    %ecx,%edx
  1005c9:	ee                   	out    %al,(%dx)
  1005ca:	b0 02                	mov    $0x2,%al
  1005cc:	ee                   	out    %al,(%dx)
  1005cd:	b0 01                	mov    $0x1,%al
  1005cf:	ee                   	out    %al,(%dx)
  1005d0:	b0 68                	mov    $0x68,%al
  1005d2:	89 fa                	mov    %edi,%edx
  1005d4:	ee                   	out    %al,(%dx)
  1005d5:	be 0a 00 00 00       	mov    $0xa,%esi
  1005da:	89 f0                	mov    %esi,%eax
  1005dc:	ee                   	out    %al,(%dx)
  1005dd:	b0 68                	mov    $0x68,%al
  1005df:	89 ea                	mov    %ebp,%edx
  1005e1:	ee                   	out    %al,(%dx)
  1005e2:	89 f0                	mov    %esi,%eax
  1005e4:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1005e5:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1005ea:	89 da                	mov    %ebx,%edx
  1005ec:	19 c0                	sbb    %eax,%eax
  1005ee:	f7 d0                	not    %eax
  1005f0:	05 ff 00 00 00       	add    $0xff,%eax
  1005f5:	ee                   	out    %al,(%dx)
  1005f6:	b0 ff                	mov    $0xff,%al
  1005f8:	89 ca                	mov    %ecx,%edx
  1005fa:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1005fb:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100600:	74 0d                	je     10060f <interrupt_controller_init+0x84>
  100602:	b2 43                	mov    $0x43,%dl
  100604:	b0 34                	mov    $0x34,%al
  100606:	ee                   	out    %al,(%dx)
  100607:	b0 55                	mov    $0x55,%al
  100609:	b2 40                	mov    $0x40,%dl
  10060b:	ee                   	out    %al,(%dx)
  10060c:	b0 02                	mov    $0x2,%al
  10060e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10060f:	5b                   	pop    %ebx
  100610:	5e                   	pop    %esi
  100611:	5f                   	pop    %edi
  100612:	5d                   	pop    %ebp
  100613:	c3                   	ret    

00100614 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100614:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100615:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100617:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100618:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10061f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100622:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100628:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10062e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100631:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100636:	75 ea                	jne    100622 <console_clear+0xe>
  100638:	be d4 03 00 00       	mov    $0x3d4,%esi
  10063d:	b0 0e                	mov    $0xe,%al
  10063f:	89 f2                	mov    %esi,%edx
  100641:	ee                   	out    %al,(%dx)
  100642:	31 c9                	xor    %ecx,%ecx
  100644:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100649:	88 c8                	mov    %cl,%al
  10064b:	89 da                	mov    %ebx,%edx
  10064d:	ee                   	out    %al,(%dx)
  10064e:	b0 0f                	mov    $0xf,%al
  100650:	89 f2                	mov    %esi,%edx
  100652:	ee                   	out    %al,(%dx)
  100653:	88 c8                	mov    %cl,%al
  100655:	89 da                	mov    %ebx,%edx
  100657:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100658:	5b                   	pop    %ebx
  100659:	5e                   	pop    %esi
  10065a:	c3                   	ret    

0010065b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10065b:	ba 64 00 00 00       	mov    $0x64,%edx
  100660:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100661:	a8 01                	test   $0x1,%al
  100663:	74 45                	je     1006aa <console_read_digit+0x4f>
  100665:	b2 60                	mov    $0x60,%dl
  100667:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100668:	8d 50 fe             	lea    -0x2(%eax),%edx
  10066b:	80 fa 08             	cmp    $0x8,%dl
  10066e:	77 05                	ja     100675 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100670:	0f b6 c0             	movzbl %al,%eax
  100673:	48                   	dec    %eax
  100674:	c3                   	ret    
	else if (data == 0x0B)
  100675:	3c 0b                	cmp    $0xb,%al
  100677:	74 35                	je     1006ae <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100679:	8d 50 b9             	lea    -0x47(%eax),%edx
  10067c:	80 fa 02             	cmp    $0x2,%dl
  10067f:	77 07                	ja     100688 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100681:	0f b6 c0             	movzbl %al,%eax
  100684:	83 e8 40             	sub    $0x40,%eax
  100687:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100688:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10068b:	80 fa 02             	cmp    $0x2,%dl
  10068e:	77 07                	ja     100697 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100690:	0f b6 c0             	movzbl %al,%eax
  100693:	83 e8 47             	sub    $0x47,%eax
  100696:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100697:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10069a:	80 fa 02             	cmp    $0x2,%dl
  10069d:	77 07                	ja     1006a6 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10069f:	0f b6 c0             	movzbl %al,%eax
  1006a2:	83 e8 4e             	sub    $0x4e,%eax
  1006a5:	c3                   	ret    
	else if (data == 0x53)
  1006a6:	3c 53                	cmp    $0x53,%al
  1006a8:	74 04                	je     1006ae <console_read_digit+0x53>
  1006aa:	83 c8 ff             	or     $0xffffffff,%eax
  1006ad:	c3                   	ret    
  1006ae:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1006b0:	c3                   	ret    

001006b1 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1006b1:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1006b5:	a3 b0 83 10 00       	mov    %eax,0x1083b0

	asm volatile("movl %0,%%esp\n\t"
  1006ba:	83 c0 04             	add    $0x4,%eax
  1006bd:	89 c4                	mov    %eax,%esp
  1006bf:	61                   	popa   
  1006c0:	07                   	pop    %es
  1006c1:	1f                   	pop    %ds
  1006c2:	83 c4 08             	add    $0x8,%esp
  1006c5:	cf                   	iret   
  1006c6:	eb fe                	jmp    1006c6 <run+0x15>

001006c8 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1006c8:	53                   	push   %ebx
  1006c9:	83 ec 0c             	sub    $0xc,%esp
  1006cc:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1006d0:	6a 44                	push   $0x44
  1006d2:	6a 00                	push   $0x0
  1006d4:	8d 43 04             	lea    0x4(%ebx),%eax
  1006d7:	50                   	push   %eax
  1006d8:	e8 17 01 00 00       	call   1007f4 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1006dd:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1006e3:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1006e9:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1006ef:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1006f5:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1006fc:	83 c4 18             	add    $0x18,%esp
  1006ff:	5b                   	pop    %ebx
  100700:	c3                   	ret    
  100701:	90                   	nop
  100702:	90                   	nop
  100703:	90                   	nop

00100704 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100704:	55                   	push   %ebp
  100705:	57                   	push   %edi
  100706:	56                   	push   %esi
  100707:	53                   	push   %ebx
  100708:	83 ec 1c             	sub    $0x1c,%esp
  10070b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10070f:	83 f8 03             	cmp    $0x3,%eax
  100712:	7f 04                	jg     100718 <program_loader+0x14>
  100714:	85 c0                	test   %eax,%eax
  100716:	79 02                	jns    10071a <program_loader+0x16>
  100718:	eb fe                	jmp    100718 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10071a:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100721:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100727:	74 02                	je     10072b <program_loader+0x27>
  100729:	eb fe                	jmp    100729 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10072b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10072e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100732:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100734:	c1 e5 05             	shl    $0x5,%ebp
  100737:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10073a:	eb 3f                	jmp    10077b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10073c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10073f:	75 37                	jne    100778 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100741:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100744:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100747:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10074a:	01 c7                	add    %eax,%edi
	memsz += va;
  10074c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10074e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100753:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100757:	52                   	push   %edx
  100758:	89 fa                	mov    %edi,%edx
  10075a:	29 c2                	sub    %eax,%edx
  10075c:	52                   	push   %edx
  10075d:	8b 53 04             	mov    0x4(%ebx),%edx
  100760:	01 f2                	add    %esi,%edx
  100762:	52                   	push   %edx
  100763:	50                   	push   %eax
  100764:	e8 27 00 00 00       	call   100790 <memcpy>
  100769:	83 c4 10             	add    $0x10,%esp
  10076c:	eb 04                	jmp    100772 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10076e:	c6 07 00             	movb   $0x0,(%edi)
  100771:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100772:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100776:	72 f6                	jb     10076e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100778:	83 c3 20             	add    $0x20,%ebx
  10077b:	39 eb                	cmp    %ebp,%ebx
  10077d:	72 bd                	jb     10073c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10077f:	8b 56 18             	mov    0x18(%esi),%edx
  100782:	8b 44 24 34          	mov    0x34(%esp),%eax
  100786:	89 10                	mov    %edx,(%eax)
}
  100788:	83 c4 1c             	add    $0x1c,%esp
  10078b:	5b                   	pop    %ebx
  10078c:	5e                   	pop    %esi
  10078d:	5f                   	pop    %edi
  10078e:	5d                   	pop    %ebp
  10078f:	c3                   	ret    

00100790 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100790:	56                   	push   %esi
  100791:	31 d2                	xor    %edx,%edx
  100793:	53                   	push   %ebx
  100794:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100798:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10079c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007a0:	eb 08                	jmp    1007aa <memcpy+0x1a>
		*d++ = *s++;
  1007a2:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1007a5:	4e                   	dec    %esi
  1007a6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1007a9:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007aa:	85 f6                	test   %esi,%esi
  1007ac:	75 f4                	jne    1007a2 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1007ae:	5b                   	pop    %ebx
  1007af:	5e                   	pop    %esi
  1007b0:	c3                   	ret    

001007b1 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1007b1:	57                   	push   %edi
  1007b2:	56                   	push   %esi
  1007b3:	53                   	push   %ebx
  1007b4:	8b 44 24 10          	mov    0x10(%esp),%eax
  1007b8:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1007bc:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1007c0:	39 c7                	cmp    %eax,%edi
  1007c2:	73 26                	jae    1007ea <memmove+0x39>
  1007c4:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1007c7:	39 c6                	cmp    %eax,%esi
  1007c9:	76 1f                	jbe    1007ea <memmove+0x39>
		s += n, d += n;
  1007cb:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1007ce:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1007d0:	eb 07                	jmp    1007d9 <memmove+0x28>
			*--d = *--s;
  1007d2:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1007d5:	4a                   	dec    %edx
  1007d6:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1007d9:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1007da:	85 d2                	test   %edx,%edx
  1007dc:	75 f4                	jne    1007d2 <memmove+0x21>
  1007de:	eb 10                	jmp    1007f0 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1007e0:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1007e3:	4a                   	dec    %edx
  1007e4:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1007e7:	41                   	inc    %ecx
  1007e8:	eb 02                	jmp    1007ec <memmove+0x3b>
  1007ea:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1007ec:	85 d2                	test   %edx,%edx
  1007ee:	75 f0                	jne    1007e0 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1007f0:	5b                   	pop    %ebx
  1007f1:	5e                   	pop    %esi
  1007f2:	5f                   	pop    %edi
  1007f3:	c3                   	ret    

001007f4 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1007f4:	53                   	push   %ebx
  1007f5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007f9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1007fd:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100801:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100803:	eb 04                	jmp    100809 <memset+0x15>
		*p++ = c;
  100805:	88 1a                	mov    %bl,(%edx)
  100807:	49                   	dec    %ecx
  100808:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100809:	85 c9                	test   %ecx,%ecx
  10080b:	75 f8                	jne    100805 <memset+0x11>
		*p++ = c;
	return v;
}
  10080d:	5b                   	pop    %ebx
  10080e:	c3                   	ret    

0010080f <strlen>:

size_t
strlen(const char *s)
{
  10080f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100813:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100815:	eb 01                	jmp    100818 <strlen+0x9>
		++n;
  100817:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100818:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10081c:	75 f9                	jne    100817 <strlen+0x8>
		++n;
	return n;
}
  10081e:	c3                   	ret    

0010081f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10081f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100823:	31 c0                	xor    %eax,%eax
  100825:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100829:	eb 01                	jmp    10082c <strnlen+0xd>
		++n;
  10082b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10082c:	39 d0                	cmp    %edx,%eax
  10082e:	74 06                	je     100836 <strnlen+0x17>
  100830:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100834:	75 f5                	jne    10082b <strnlen+0xc>
		++n;
	return n;
}
  100836:	c3                   	ret    

00100837 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100837:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100838:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10083d:	53                   	push   %ebx
  10083e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100840:	76 05                	jbe    100847 <console_putc+0x10>
  100842:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100847:	80 fa 0a             	cmp    $0xa,%dl
  10084a:	75 2c                	jne    100878 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10084c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100852:	be 50 00 00 00       	mov    $0x50,%esi
  100857:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100859:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10085c:	99                   	cltd   
  10085d:	f7 fe                	idiv   %esi
  10085f:	89 de                	mov    %ebx,%esi
  100861:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100863:	eb 07                	jmp    10086c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100865:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100868:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100869:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10086c:	83 f8 50             	cmp    $0x50,%eax
  10086f:	75 f4                	jne    100865 <console_putc+0x2e>
  100871:	29 d0                	sub    %edx,%eax
  100873:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100876:	eb 0b                	jmp    100883 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100878:	0f b6 d2             	movzbl %dl,%edx
  10087b:	09 ca                	or     %ecx,%edx
  10087d:	66 89 13             	mov    %dx,(%ebx)
  100880:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100883:	5b                   	pop    %ebx
  100884:	5e                   	pop    %esi
  100885:	c3                   	ret    

00100886 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100886:	56                   	push   %esi
  100887:	53                   	push   %ebx
  100888:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10088c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10088f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100893:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100898:	75 04                	jne    10089e <fill_numbuf+0x18>
  10089a:	85 d2                	test   %edx,%edx
  10089c:	74 10                	je     1008ae <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10089e:	89 d0                	mov    %edx,%eax
  1008a0:	31 d2                	xor    %edx,%edx
  1008a2:	f7 f1                	div    %ecx
  1008a4:	4b                   	dec    %ebx
  1008a5:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1008a8:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1008aa:	89 c2                	mov    %eax,%edx
  1008ac:	eb ec                	jmp    10089a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1008ae:	89 d8                	mov    %ebx,%eax
  1008b0:	5b                   	pop    %ebx
  1008b1:	5e                   	pop    %esi
  1008b2:	c3                   	ret    

001008b3 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1008b3:	55                   	push   %ebp
  1008b4:	57                   	push   %edi
  1008b5:	56                   	push   %esi
  1008b6:	53                   	push   %ebx
  1008b7:	83 ec 38             	sub    $0x38,%esp
  1008ba:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1008be:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1008c2:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008c6:	e9 60 03 00 00       	jmp    100c2b <console_vprintf+0x378>
		if (*format != '%') {
  1008cb:	80 fa 25             	cmp    $0x25,%dl
  1008ce:	74 13                	je     1008e3 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1008d0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008d4:	0f b6 d2             	movzbl %dl,%edx
  1008d7:	89 f0                	mov    %esi,%eax
  1008d9:	e8 59 ff ff ff       	call   100837 <console_putc>
  1008de:	e9 45 03 00 00       	jmp    100c28 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008e3:	47                   	inc    %edi
  1008e4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1008eb:	00 
  1008ec:	eb 12                	jmp    100900 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1008ee:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1008ef:	8a 11                	mov    (%ecx),%dl
  1008f1:	84 d2                	test   %dl,%dl
  1008f3:	74 1a                	je     10090f <console_vprintf+0x5c>
  1008f5:	89 e8                	mov    %ebp,%eax
  1008f7:	38 c2                	cmp    %al,%dl
  1008f9:	75 f3                	jne    1008ee <console_vprintf+0x3b>
  1008fb:	e9 3f 03 00 00       	jmp    100c3f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100900:	8a 17                	mov    (%edi),%dl
  100902:	84 d2                	test   %dl,%dl
  100904:	74 0b                	je     100911 <console_vprintf+0x5e>
  100906:	b9 90 0e 10 00       	mov    $0x100e90,%ecx
  10090b:	89 d5                	mov    %edx,%ebp
  10090d:	eb e0                	jmp    1008ef <console_vprintf+0x3c>
  10090f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100911:	8d 42 cf             	lea    -0x31(%edx),%eax
  100914:	3c 08                	cmp    $0x8,%al
  100916:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10091d:	00 
  10091e:	76 13                	jbe    100933 <console_vprintf+0x80>
  100920:	eb 1d                	jmp    10093f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100922:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100927:	0f be c0             	movsbl %al,%eax
  10092a:	47                   	inc    %edi
  10092b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10092f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100933:	8a 07                	mov    (%edi),%al
  100935:	8d 50 d0             	lea    -0x30(%eax),%edx
  100938:	80 fa 09             	cmp    $0x9,%dl
  10093b:	76 e5                	jbe    100922 <console_vprintf+0x6f>
  10093d:	eb 18                	jmp    100957 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10093f:	80 fa 2a             	cmp    $0x2a,%dl
  100942:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100949:	ff 
  10094a:	75 0b                	jne    100957 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10094c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10094f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100950:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100953:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100957:	83 cd ff             	or     $0xffffffff,%ebp
  10095a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10095d:	75 37                	jne    100996 <console_vprintf+0xe3>
			++format;
  10095f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100960:	31 ed                	xor    %ebp,%ebp
  100962:	8a 07                	mov    (%edi),%al
  100964:	8d 50 d0             	lea    -0x30(%eax),%edx
  100967:	80 fa 09             	cmp    $0x9,%dl
  10096a:	76 0d                	jbe    100979 <console_vprintf+0xc6>
  10096c:	eb 17                	jmp    100985 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10096e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100971:	0f be c0             	movsbl %al,%eax
  100974:	47                   	inc    %edi
  100975:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100979:	8a 07                	mov    (%edi),%al
  10097b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10097e:	80 fa 09             	cmp    $0x9,%dl
  100981:	76 eb                	jbe    10096e <console_vprintf+0xbb>
  100983:	eb 11                	jmp    100996 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100985:	3c 2a                	cmp    $0x2a,%al
  100987:	75 0b                	jne    100994 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100989:	83 c3 04             	add    $0x4,%ebx
				++format;
  10098c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10098d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100990:	85 ed                	test   %ebp,%ebp
  100992:	79 02                	jns    100996 <console_vprintf+0xe3>
  100994:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100996:	8a 07                	mov    (%edi),%al
  100998:	3c 64                	cmp    $0x64,%al
  10099a:	74 34                	je     1009d0 <console_vprintf+0x11d>
  10099c:	7f 1d                	jg     1009bb <console_vprintf+0x108>
  10099e:	3c 58                	cmp    $0x58,%al
  1009a0:	0f 84 a2 00 00 00    	je     100a48 <console_vprintf+0x195>
  1009a6:	3c 63                	cmp    $0x63,%al
  1009a8:	0f 84 bf 00 00 00    	je     100a6d <console_vprintf+0x1ba>
  1009ae:	3c 43                	cmp    $0x43,%al
  1009b0:	0f 85 d0 00 00 00    	jne    100a86 <console_vprintf+0x1d3>
  1009b6:	e9 a3 00 00 00       	jmp    100a5e <console_vprintf+0x1ab>
  1009bb:	3c 75                	cmp    $0x75,%al
  1009bd:	74 4d                	je     100a0c <console_vprintf+0x159>
  1009bf:	3c 78                	cmp    $0x78,%al
  1009c1:	74 5c                	je     100a1f <console_vprintf+0x16c>
  1009c3:	3c 73                	cmp    $0x73,%al
  1009c5:	0f 85 bb 00 00 00    	jne    100a86 <console_vprintf+0x1d3>
  1009cb:	e9 86 00 00 00       	jmp    100a56 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1009d0:	83 c3 04             	add    $0x4,%ebx
  1009d3:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1009d6:	89 d1                	mov    %edx,%ecx
  1009d8:	c1 f9 1f             	sar    $0x1f,%ecx
  1009db:	89 0c 24             	mov    %ecx,(%esp)
  1009de:	31 ca                	xor    %ecx,%edx
  1009e0:	55                   	push   %ebp
  1009e1:	29 ca                	sub    %ecx,%edx
  1009e3:	68 98 0e 10 00       	push   $0x100e98
  1009e8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009ed:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009f1:	e8 90 fe ff ff       	call   100886 <fill_numbuf>
  1009f6:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1009fa:	58                   	pop    %eax
  1009fb:	5a                   	pop    %edx
  1009fc:	ba 01 00 00 00       	mov    $0x1,%edx
  100a01:	8b 04 24             	mov    (%esp),%eax
  100a04:	83 e0 01             	and    $0x1,%eax
  100a07:	e9 a5 00 00 00       	jmp    100ab1 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a0c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a0f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a14:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a17:	55                   	push   %ebp
  100a18:	68 98 0e 10 00       	push   $0x100e98
  100a1d:	eb 11                	jmp    100a30 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a1f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a22:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a25:	55                   	push   %ebp
  100a26:	68 ac 0e 10 00       	push   $0x100eac
  100a2b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a30:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a34:	e8 4d fe ff ff       	call   100886 <fill_numbuf>
  100a39:	ba 01 00 00 00       	mov    $0x1,%edx
  100a3e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a42:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a44:	59                   	pop    %ecx
  100a45:	59                   	pop    %ecx
  100a46:	eb 69                	jmp    100ab1 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a48:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a4b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a4e:	55                   	push   %ebp
  100a4f:	68 98 0e 10 00       	push   $0x100e98
  100a54:	eb d5                	jmp    100a2b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a56:	83 c3 04             	add    $0x4,%ebx
  100a59:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a5c:	eb 40                	jmp    100a9e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a5e:	83 c3 04             	add    $0x4,%ebx
  100a61:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a64:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a68:	e9 bd 01 00 00       	jmp    100c2a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a6d:	83 c3 04             	add    $0x4,%ebx
  100a70:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a73:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a77:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a7c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a80:	88 44 24 24          	mov    %al,0x24(%esp)
  100a84:	eb 27                	jmp    100aad <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a86:	84 c0                	test   %al,%al
  100a88:	75 02                	jne    100a8c <console_vprintf+0x1d9>
  100a8a:	b0 25                	mov    $0x25,%al
  100a8c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a90:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a95:	80 3f 00             	cmpb   $0x0,(%edi)
  100a98:	74 0a                	je     100aa4 <console_vprintf+0x1f1>
  100a9a:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a9e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aa2:	eb 09                	jmp    100aad <console_vprintf+0x1fa>
				format--;
  100aa4:	8d 54 24 24          	lea    0x24(%esp),%edx
  100aa8:	4f                   	dec    %edi
  100aa9:	89 54 24 04          	mov    %edx,0x4(%esp)
  100aad:	31 d2                	xor    %edx,%edx
  100aaf:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100ab1:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100ab3:	83 fd ff             	cmp    $0xffffffff,%ebp
  100ab6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100abd:	74 1f                	je     100ade <console_vprintf+0x22b>
  100abf:	89 04 24             	mov    %eax,(%esp)
  100ac2:	eb 01                	jmp    100ac5 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100ac4:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100ac5:	39 e9                	cmp    %ebp,%ecx
  100ac7:	74 0a                	je     100ad3 <console_vprintf+0x220>
  100ac9:	8b 44 24 04          	mov    0x4(%esp),%eax
  100acd:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100ad1:	75 f1                	jne    100ac4 <console_vprintf+0x211>
  100ad3:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100ad6:	89 0c 24             	mov    %ecx,(%esp)
  100ad9:	eb 1f                	jmp    100afa <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100adb:	42                   	inc    %edx
  100adc:	eb 09                	jmp    100ae7 <console_vprintf+0x234>
  100ade:	89 d1                	mov    %edx,%ecx
  100ae0:	8b 14 24             	mov    (%esp),%edx
  100ae3:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100ae7:	8b 44 24 04          	mov    0x4(%esp),%eax
  100aeb:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100aef:	75 ea                	jne    100adb <console_vprintf+0x228>
  100af1:	8b 44 24 08          	mov    0x8(%esp),%eax
  100af5:	89 14 24             	mov    %edx,(%esp)
  100af8:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100afa:	85 c0                	test   %eax,%eax
  100afc:	74 0c                	je     100b0a <console_vprintf+0x257>
  100afe:	84 d2                	test   %dl,%dl
  100b00:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b07:	00 
  100b08:	75 24                	jne    100b2e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b0a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b0f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b16:	00 
  100b17:	75 15                	jne    100b2e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b19:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b1d:	83 e0 08             	and    $0x8,%eax
  100b20:	83 f8 01             	cmp    $0x1,%eax
  100b23:	19 c9                	sbb    %ecx,%ecx
  100b25:	f7 d1                	not    %ecx
  100b27:	83 e1 20             	and    $0x20,%ecx
  100b2a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b2e:	3b 2c 24             	cmp    (%esp),%ebp
  100b31:	7e 0d                	jle    100b40 <console_vprintf+0x28d>
  100b33:	84 d2                	test   %dl,%dl
  100b35:	74 40                	je     100b77 <console_vprintf+0x2c4>
			zeros = precision - len;
  100b37:	2b 2c 24             	sub    (%esp),%ebp
  100b3a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b3e:	eb 3f                	jmp    100b7f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b40:	84 d2                	test   %dl,%dl
  100b42:	74 33                	je     100b77 <console_vprintf+0x2c4>
  100b44:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b48:	83 e0 06             	and    $0x6,%eax
  100b4b:	83 f8 02             	cmp    $0x2,%eax
  100b4e:	75 27                	jne    100b77 <console_vprintf+0x2c4>
  100b50:	45                   	inc    %ebp
  100b51:	75 24                	jne    100b77 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b53:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b55:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b58:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b5d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b60:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b63:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b67:	7d 0e                	jge    100b77 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b69:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b6d:	29 ca                	sub    %ecx,%edx
  100b6f:	29 c2                	sub    %eax,%edx
  100b71:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b75:	eb 08                	jmp    100b7f <console_vprintf+0x2cc>
  100b77:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b7e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b7f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b83:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b85:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b89:	2b 2c 24             	sub    (%esp),%ebp
  100b8c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b91:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b94:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b97:	29 c5                	sub    %eax,%ebp
  100b99:	89 f0                	mov    %esi,%eax
  100b9b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b9f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100ba3:	eb 0f                	jmp    100bb4 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100ba5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ba9:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bae:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100baf:	e8 83 fc ff ff       	call   100837 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bb4:	85 ed                	test   %ebp,%ebp
  100bb6:	7e 07                	jle    100bbf <console_vprintf+0x30c>
  100bb8:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100bbd:	74 e6                	je     100ba5 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100bbf:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bc4:	89 c6                	mov    %eax,%esi
  100bc6:	74 23                	je     100beb <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100bc8:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100bcd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bd1:	e8 61 fc ff ff       	call   100837 <console_putc>
  100bd6:	89 c6                	mov    %eax,%esi
  100bd8:	eb 11                	jmp    100beb <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100bda:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bde:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100be3:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100be4:	e8 4e fc ff ff       	call   100837 <console_putc>
  100be9:	eb 06                	jmp    100bf1 <console_vprintf+0x33e>
  100beb:	89 f0                	mov    %esi,%eax
  100bed:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100bf1:	85 f6                	test   %esi,%esi
  100bf3:	7f e5                	jg     100bda <console_vprintf+0x327>
  100bf5:	8b 34 24             	mov    (%esp),%esi
  100bf8:	eb 15                	jmp    100c0f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100bfa:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bfe:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100bff:	0f b6 11             	movzbl (%ecx),%edx
  100c02:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c06:	e8 2c fc ff ff       	call   100837 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c0b:	ff 44 24 04          	incl   0x4(%esp)
  100c0f:	85 f6                	test   %esi,%esi
  100c11:	7f e7                	jg     100bfa <console_vprintf+0x347>
  100c13:	eb 0f                	jmp    100c24 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c15:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c19:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c1e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c1f:	e8 13 fc ff ff       	call   100837 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c24:	85 ed                	test   %ebp,%ebp
  100c26:	7f ed                	jg     100c15 <console_vprintf+0x362>
  100c28:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c2a:	47                   	inc    %edi
  100c2b:	8a 17                	mov    (%edi),%dl
  100c2d:	84 d2                	test   %dl,%dl
  100c2f:	0f 85 96 fc ff ff    	jne    1008cb <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c35:	83 c4 38             	add    $0x38,%esp
  100c38:	89 f0                	mov    %esi,%eax
  100c3a:	5b                   	pop    %ebx
  100c3b:	5e                   	pop    %esi
  100c3c:	5f                   	pop    %edi
  100c3d:	5d                   	pop    %ebp
  100c3e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c3f:	81 e9 90 0e 10 00    	sub    $0x100e90,%ecx
  100c45:	b8 01 00 00 00       	mov    $0x1,%eax
  100c4a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c4c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c4d:	09 44 24 14          	or     %eax,0x14(%esp)
  100c51:	e9 aa fc ff ff       	jmp    100900 <console_vprintf+0x4d>

00100c56 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c56:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c5a:	50                   	push   %eax
  100c5b:	ff 74 24 10          	pushl  0x10(%esp)
  100c5f:	ff 74 24 10          	pushl  0x10(%esp)
  100c63:	ff 74 24 10          	pushl  0x10(%esp)
  100c67:	e8 47 fc ff ff       	call   1008b3 <console_vprintf>
  100c6c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c6f:	c3                   	ret    

00100c70 <Random>:
{
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c70:	8b 0d a8 83 10 00    	mov    0x1083a8,%ecx
/* ----------------------------------------------------------------
 * Random returns a pseudo-random real number uniformly distributed 
 * between 0.0 and 1.0. 
 * ----------------------------------------------------------------
 */
{
  100c76:	56                   	push   %esi
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c77:	be c8 ad 00 00       	mov    $0xadc8,%esi
/* ----------------------------------------------------------------
 * Random returns a pseudo-random real number uniformly distributed 
 * between 0.0 and 1.0. 
 * ----------------------------------------------------------------
 */
{
  100c7c:	53                   	push   %ebx
  const long Q = MODULUS / MULTIPLIER;
  const long R = MODULUS % MULTIPLIER;
        long t;

  t = MULTIPLIER * (seed[stream] % Q) - R * (seed[stream] / Q);
  100c7d:	bb 38 52 ff ff       	mov    $0xffff5238,%ebx
  100c82:	8b 04 8d 60 10 10 00 	mov    0x101060(,%ecx,4),%eax
  100c89:	99                   	cltd   
  100c8a:	f7 fb                	idiv   %ebx
  100c8c:	69 d8 47 0d 00 00    	imul   $0xd47,%eax,%ebx
  100c92:	8b 04 8d 60 10 10 00 	mov    0x101060(,%ecx,4),%eax
  100c99:	99                   	cltd   
  100c9a:	f7 fe                	idiv   %esi
  100c9c:	69 d2 8f bc 00 00    	imul   $0xbc8f,%edx,%edx
  100ca2:	01 d3                	add    %edx,%ebx
  if (t > 0) 
  100ca4:	85 db                	test   %ebx,%ebx
  100ca6:	7f 06                	jg     100cae <Random+0x3e>
    seed[stream] = t;
  else 
    seed[stream] = t + MODULUS;
  100ca8:	81 c3 ff ff ff 7f    	add    $0x7fffffff,%ebx
  100cae:	89 1c 8d 60 10 10 00 	mov    %ebx,0x101060(,%ecx,4)
  100cb5:	dd 05 c0 0e 10 00    	fldl   0x100ec0
  100cbb:	da 3c 8d 60 10 10 00 	fidivrl 0x101060(,%ecx,4)
  return ((double) seed[stream] / MODULUS);
}
  100cc2:	5b                   	pop    %ebx
  100cc3:	5e                   	pop    %esi
  100cc4:	c3                   	ret    

00100cc5 <PutSeed>:
 *    if x > 0 then x is the state (unless too large)
 *    if x < 0 then the state is obtained from the system clock
 *    if x = 0 then the state is to be supplied interactively
 * ---------------------------------------------------------------
 */
{
  100cc5:	8b 54 24 04          	mov    0x4(%esp),%edx
  char ok = 0;

  if (x > 0)
  100cc9:	85 d2                	test   %edx,%edx
  100ccb:	7e 0a                	jle    100cd7 <PutSeed+0x12>
    x = x % MODULUS;                       /* correct if x is too large  */
  100ccd:	89 d0                	mov    %edx,%eax
  100ccf:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
  100cd4:	99                   	cltd   
  100cd5:	f7 f9                	idiv   %ecx
  if (x < 0)                                 
  100cd7:	83 fa 00             	cmp    $0x0,%edx
  100cda:	7c 02                	jl     100cde <PutSeed+0x19>
    x = 10086 % MODULUS;              
  if (x == 0)                                
  100cdc:	75 05                	jne    100ce3 <PutSeed+0x1e>
  100cde:	ba 66 27 00 00       	mov    $0x2766,%edx
    x = 10086 % MODULUS;              
  seed[stream] = x;
  100ce3:	a1 a8 83 10 00       	mov    0x1083a8,%eax
  100ce8:	89 14 85 60 10 10 00 	mov    %edx,0x101060(,%eax,4)
}
  100cef:	c3                   	ret    

00100cf0 <GetSeed>:
 * Use this function to get the state of the current random number 
 * generator stream.                                                   
 * ---------------------------------------------------------------
 */
{
  *x = seed[stream];
  100cf0:	a1 a8 83 10 00       	mov    0x1083a8,%eax
  100cf5:	8b 14 85 60 10 10 00 	mov    0x101060(,%eax,4),%edx
  100cfc:	8b 44 24 04          	mov    0x4(%esp),%eax
  100d00:	89 10                	mov    %edx,(%eax)
}
  100d02:	c3                   	ret    

00100d03 <SelectStream>:
/* ------------------------------------------------------------------
 * Use this function to set the current random number generator
 * stream -- that stream from which the next random number will come.
 * ------------------------------------------------------------------
 */
{
  100d03:	83 ec 0c             	sub    $0xc,%esp
  stream = ((unsigned int) index) % STREAMS;
  100d06:	8b 44 24 10          	mov    0x10(%esp),%eax
  100d0a:	25 ff 00 00 00       	and    $0xff,%eax
  if ((initialized == 0) && (stream != 0))   /* protect against        */
  100d0f:	83 3d ac 83 10 00 00 	cmpl   $0x0,0x1083ac
 * Use this function to set the current random number generator
 * stream -- that stream from which the next random number will come.
 * ------------------------------------------------------------------
 */
{
  stream = ((unsigned int) index) % STREAMS;
  100d16:	a3 a8 83 10 00       	mov    %eax,0x1083a8
  if ((initialized == 0) && (stream != 0))   /* protect against        */
  100d1b:	75 14                	jne    100d31 <SelectStream+0x2e>
  100d1d:	85 c0                	test   %eax,%eax
  100d1f:	74 10                	je     100d31 <SelectStream+0x2e>
    PlantSeeds(DEFAULT);                     /* un-initialized streams */
  100d21:	c7 44 24 10 15 cd 5b 	movl   $0x75bcd15,0x10(%esp)
  100d28:	07 
}
  100d29:	83 c4 0c             	add    $0xc,%esp
 * ------------------------------------------------------------------
 */
{
  stream = ((unsigned int) index) % STREAMS;
  if ((initialized == 0) && (stream != 0))   /* protect against        */
    PlantSeeds(DEFAULT);                     /* un-initialized streams */
  100d2c:	e9 04 00 00 00       	jmp    100d35 <PlantSeeds>
}
  100d31:	83 c4 0c             	add    $0xc,%esp
  100d34:	c3                   	ret    

00100d35 <PlantSeeds>:
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d35:	57                   	push   %edi
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d36:	bf ea 6d 01 00       	mov    $0x16dea,%edi
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d3b:	56                   	push   %esi
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d3c:	be 16 92 fe ff       	mov    $0xfffe9216,%esi
 * with all states dictated by the state of the default stream. 
 * The sequence of planted states is separated one from the next by 
 * 8,367,782 calls to Random().
 * ---------------------------------------------------------------------
 */
{
  100d41:	53                   	push   %ebx
  100d42:	83 ec 1c             	sub    $0x1c,%esp
  const long R = MODULUS % A256;
        int  j;
        int  s;

  initialized = 1;
  s = stream;                            /* remember the current stream */
  100d45:	8b 1d a8 83 10 00    	mov    0x1083a8,%ebx
  SelectStream(0);                       /* change to stream 0          */
  100d4b:	6a 00                	push   $0x0
  const long Q = MODULUS / A256;
  const long R = MODULUS % A256;
        int  j;
        int  s;

  initialized = 1;
  100d4d:	c7 05 ac 83 10 00 01 	movl   $0x1,0x1083ac
  100d54:	00 00 00 
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  100d57:	e8 a7 ff ff ff       	call   100d03 <SelectStream>
  PutSeed(x);                            /* set seed[0]                 */
  100d5c:	59                   	pop    %ecx
  100d5d:	ff 74 24 2c          	pushl  0x2c(%esp)
  100d61:	e8 5f ff ff ff       	call   100cc5 <PutSeed>
  stream = s;                            /* reset the current stream    */
  100d66:	b9 01 00 00 00       	mov    $0x1,%ecx
  100d6b:	83 c4 10             	add    $0x10,%esp
  100d6e:	89 1d a8 83 10 00    	mov    %ebx,0x1083a8
  for (j = 1; j < STREAMS; j++) {
    x = A256 * (seed[j - 1] % Q) - R * (seed[j - 1] / Q);
  100d74:	8b 04 8d 5c 10 10 00 	mov    0x10105c(,%ecx,4),%eax
  100d7b:	99                   	cltd   
  100d7c:	f7 fe                	idiv   %esi
  100d7e:	69 d8 1d 1c 00 00    	imul   $0x1c1d,%eax,%ebx
  100d84:	8b 04 8d 5c 10 10 00 	mov    0x10105c(,%ecx,4),%eax
  100d8b:	99                   	cltd   
  100d8c:	f7 ff                	idiv   %edi
  100d8e:	69 d2 8d 59 00 00    	imul   $0x598d,%edx,%edx
  100d94:	01 d3                	add    %edx,%ebx
    if (x > 0)
  100d96:	85 db                	test   %ebx,%ebx
  100d98:	7f 06                	jg     100da0 <PlantSeeds+0x6b>
      seed[j] = x;
    else
      seed[j] = x + MODULUS;
  100d9a:	81 c3 ff ff ff 7f    	add    $0x7fffffff,%ebx
  100da0:	89 1c 8d 60 10 10 00 	mov    %ebx,0x101060(,%ecx,4)
  initialized = 1;
  s = stream;                            /* remember the current stream */
  SelectStream(0);                       /* change to stream 0          */
  PutSeed(x);                            /* set seed[0]                 */
  stream = s;                            /* reset the current stream    */
  for (j = 1; j < STREAMS; j++) {
  100da7:	41                   	inc    %ecx
  100da8:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  100dae:	75 c4                	jne    100d74 <PlantSeeds+0x3f>
    if (x > 0)
      seed[j] = x;
    else
      seed[j] = x + MODULUS;
   }
}
  100db0:	83 c4 10             	add    $0x10,%esp
  100db3:	5b                   	pop    %ebx
  100db4:	5e                   	pop    %esi
  100db5:	5f                   	pop    %edi
  100db6:	c3                   	ret    

00100db7 <TestRandom>:
   void TestRandom(void)
/* ------------------------------------------------------------------
 * Use this (optional) function to test for a correct implementation.
 * ------------------------------------------------------------------    
 */
{
  100db7:	53                   	push   %ebx
  long   x;
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  PutSeed(1);                       /* and set the state to 1    */
  100db8:	31 db                	xor    %ebx,%ebx
   void TestRandom(void)
/* ------------------------------------------------------------------
 * Use this (optional) function to test for a correct implementation.
 * ------------------------------------------------------------------    
 */
{
  100dba:	83 ec 14             	sub    $0x14,%esp
  long   i;
  long   x;
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  100dbd:	6a 00                	push   $0x0
  100dbf:	e8 3f ff ff ff       	call   100d03 <SelectStream>
  PutSeed(1);                       /* and set the state to 1    */
  100dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100dcb:	e8 f5 fe ff ff       	call   100cc5 <PutSeed>
  100dd0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 10000; i++)
  100dd3:	43                   	inc    %ebx
    u = Random();
  100dd4:	e8 97 fe ff ff       	call   100c70 <Random>
  100dd9:	dd d8                	fstp   %st(0)
  double u;
  char   ok = 0;  

  SelectStream(0);                  /* select the default stream */
  PutSeed(1);                       /* and set the state to 1    */
  for(i = 0; i < 10000; i++)
  100ddb:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
  100de1:	75 f0                	jne    100dd3 <TestRandom+0x1c>
    u = Random();
  GetSeed(&x);                      /* get the new state value   */
  ok = (x == CHECK);                /* and check for correctness */

  SelectStream(1);                  /* select stream 1                 */ 
  100de3:	83 ec 0c             	sub    $0xc,%esp
  100de6:	6a 01                	push   $0x1
  100de8:	e8 16 ff ff ff       	call   100d03 <SelectStream>
  PlantSeeds(1);                    /* set the state of all streams    */
  100ded:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100df4:	e8 3c ff ff ff       	call   100d35 <PlantSeeds>
  GetSeed(&x);                      /* get the state of stream 1       */
  ok = ok && (x == A256);           /* x should be the jump multiplier */    
}
  100df9:	83 c4 18             	add    $0x18,%esp
  100dfc:	5b                   	pop    %ebx
  100dfd:	c3                   	ret    

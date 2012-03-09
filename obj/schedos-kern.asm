
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
  100014:	e8 33 02 00 00       	call   10024c <start>
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
  10006d:	e8 64 01 00 00       	call   1001d6 <interrupt>

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

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	55                   	push   %ebp
  10009d:	57                   	push   %edi
  10009e:	56                   	push   %esi
  10009f:	53                   	push   %ebx
  1000a0:	83 ec 1c             	sub    $0x1c,%esp
	pid_t pid = current->p_pid;
  1000a3:	a1 48 7d 10 00       	mov    0x107d48,%eax
  1000a8:	8b 08                	mov    (%eax),%ecx

	if (scheduling_algorithm == 0)
  1000aa:	a1 4c 7d 10 00       	mov    0x107d4c,%eax
  1000af:	85 c0                	test   %eax,%eax
  1000b1:	75 24                	jne    1000d7 <schedule+0x3b>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b3:	bb 05 00 00 00       	mov    $0x5,%ebx
  1000b8:	8d 41 01             	lea    0x1(%ecx),%eax
  1000bb:	99                   	cltd   
  1000bc:	f7 fb                	idiv   %ebx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000be:	6b c2 5c             	imul   $0x5c,%edx,%eax
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000c1:	89 d1                	mov    %edx,%ecx
			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000c3:	83 b8 5c 73 10 00 01 	cmpl   $0x1,0x10735c(%eax)
  1000ca:	75 ec                	jne    1000b8 <schedule+0x1c>
				run(&proc_array[pid]);
  1000cc:	83 ec 0c             	sub    $0xc,%esp
  1000cf:	05 14 73 10 00       	add    $0x107314,%eax
  1000d4:	50                   	push   %eax
  1000d5:	eb 4c                	jmp    100123 <schedule+0x87>
		}
	else if (scheduling_algorithm == 1){
  1000d7:	83 f8 01             	cmp    $0x1,%eax
  1000da:	75 4c                	jne    100128 <schedule+0x8c>
  1000dc:	31 db                	xor    %ebx,%ebx
  1000de:	31 ff                	xor    %edi,%edi
  1000e0:	be e7 03 00 00       	mov    $0x3e7,%esi
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
  1000e5:	bd 05 00 00 00       	mov    $0x5,%ebp
  1000ea:	eb 25                	jmp    100111 <schedule+0x75>
  1000ec:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  1000ef:	99                   	cltd   
  1000f0:	f7 fd                	idiv   %ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  1000f2:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000f5:	83 b8 5c 73 10 00 01 	cmpl   $0x1,0x10735c(%eax)
  1000fc:	75 0e                	jne    10010c <schedule+0x70>
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
  1000fe:	8b 80 60 73 10 00    	mov    0x107360(%eax),%eax
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
			pid_t cur_pid = (i+pid) % NPROCS;
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100104:	39 f0                	cmp    %esi,%eax
  100106:	7f 04                	jg     10010c <schedule+0x70>
  100108:	89 d7                	mov    %edx,%edi
  10010a:	eb 02                	jmp    10010e <schedule+0x72>
  10010c:	89 f0                	mov    %esi,%eax
					&& proc_array[cur_pid].p_priority<=cur_highest_pri){
				highest_pri_p = cur_pid;
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
  10010e:	43                   	inc    %ebx
  10010f:	89 c6                	mov    %eax,%esi
		}
	else if (scheduling_algorithm == 1){
		int cur_highest_pri = 999;
		pid_t highest_pri_p = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || highest_pri_p == 999){
  100111:	83 fb 04             	cmp    $0x4,%ebx
  100114:	7e d6                	jle    1000ec <schedule+0x50>
				cur_highest_pri = proc_array[cur_pid].p_priority;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		run(&proc_array[highest_pri_p]);
  100116:	6b ff 5c             	imul   $0x5c,%edi,%edi
  100119:	83 ec 0c             	sub    $0xc,%esp
  10011c:	81 c7 14 73 10 00    	add    $0x107314,%edi
  100122:	57                   	push   %edi
  100123:	e8 51 04 00 00       	call   100579 <run>
	}
	else if(scheduling_algorithm == 2){
  100128:	83 f8 02             	cmp    $0x2,%eax
  10012b:	0f 85 84 00 00 00    	jne    1001b5 <schedule+0x119>
  100131:	31 db                	xor    %ebx,%ebx
  100133:	31 f6                	xor    %esi,%esi
  100135:	d9 05 b4 0b 10 00    	flds   0x100bb4
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
  10013b:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
  10013e:	bf 05 00 00 00       	mov    $0x5,%edi
  100143:	99                   	cltd   
  100144:	f7 ff                	idiv   %edi
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100146:	6b c2 5c             	imul   $0x5c,%edx,%eax
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100149:	83 b8 5c 73 10 00 01 	cmpl   $0x1,0x10735c(%eax)
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100150:	8b b8 68 73 10 00    	mov    0x107368(%eax),%edi
  100156:	8b a8 64 73 10 00    	mov    0x107364(%eax),%ebp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  10015c:	75 20                	jne    10017e <schedule+0xe2>
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  10015e:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  100162:	db 44 24 0c          	fildl  0xc(%esp)
  100166:	57                   	push   %edi
  100167:	da 3c 24             	fidivrl (%esp)
  10016a:	d9 c9                	fxch   %st(1)
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  10016c:	dd e1                	fucom  %st(1)
  10016e:	df e0                	fnstsw %ax
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
			pid_t cur_pid = (i+pid) % NPROCS;
			float prop_value = (float)proc_array[cur_pid].p_runtime/(float)proc_array[cur_pid].p_proportional;
  100170:	83 c4 04             	add    $0x4,%esp
			//cursorpos = console_printf(cursorpos, 0x100, "highest_pri_p is %d\n",highest_pri_p);
			if(proc_array[cur_pid].p_state == P_RUNNABLE 
  100173:	9e                   	sahf   
  100174:	72 06                	jb     10017c <schedule+0xe0>
  100176:	dd d8                	fstp   %st(0)
  100178:	89 d6                	mov    %edx,%esi
  10017a:	eb 02                	jmp    10017e <schedule+0xe2>
  10017c:	dd d9                	fstp   %st(1)
					&& prop_value <= lowest_prop){
					winner = cur_pid;
					lowest_prop = prop_value;
			}
			i++;
  10017e:	43                   	inc    %ebx
	}
	else if(scheduling_algorithm == 2){
		float lowest_prop = 65535;
		pid_t winner = 0;
		int i = 0; //the initial 0 process should be scheduled?
		while(i<NPROCS || lowest_prop == 65535){
  10017f:	83 fb 04             	cmp    $0x4,%ebx
  100182:	7e b7                	jle    10013b <schedule+0x9f>
  100184:	d9 05 b4 0b 10 00    	flds   0x100bb4
  10018a:	d9 c9                	fxch   %st(1)
  10018c:	dd e1                	fucom  %st(1)
  10018e:	df e0                	fnstsw %ax
  100190:	dd d9                	fstp   %st(1)
  100192:	9e                   	sahf   
  100193:	7a 06                	jp     10019b <schedule+0xff>
  100195:	74 a4                	je     10013b <schedule+0x9f>
  100197:	dd d8                	fstp   %st(0)
  100199:	eb 02                	jmp    10019d <schedule+0x101>
  10019b:	dd d8                	fstp   %st(0)
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  10019d:	6b f6 5c             	imul   $0x5c,%esi,%esi
		run(&proc_array[winner]);
  1001a0:	83 ec 0c             	sub    $0xc,%esp
					lowest_prop = prop_value;
			}
			i++;
		}
		//cursorpos = console_printf(cursorpos, 0x100, "running %d!\n", highest_pri_p);
		proc_array[winner].p_runtime++;
  1001a3:	ff 86 68 73 10 00    	incl   0x107368(%esi)
		run(&proc_array[winner]);
  1001a9:	81 c6 14 73 10 00    	add    $0x107314,%esi
  1001af:	56                   	push   %esi
  1001b0:	e9 6e ff ff ff       	jmp    100123 <schedule+0x87>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001b5:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001bb:	50                   	push   %eax
  1001bc:	68 38 0b 10 00       	push   $0x100b38
  1001c1:	68 00 01 00 00       	push   $0x100
  1001c6:	52                   	push   %edx
  1001c7:	e8 52 09 00 00       	call   100b1e <console_printf>
  1001cc:	83 c4 10             	add    $0x10,%esp
  1001cf:	a3 00 80 19 00       	mov    %eax,0x198000
  1001d4:	eb fe                	jmp    1001d4 <schedule+0x138>

001001d6 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001d6:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001d7:	a1 48 7d 10 00       	mov    0x107d48,%eax
  1001dc:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001e1:	56                   	push   %esi
  1001e2:	53                   	push   %ebx
  1001e3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001e7:	8d 78 04             	lea    0x4(%eax),%edi
  1001ea:	89 de                	mov    %ebx,%esi
  1001ec:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001ee:	8b 53 28             	mov    0x28(%ebx),%edx
  1001f1:	83 ea 20             	sub    $0x20,%edx
  1001f4:	83 fa 15             	cmp    $0x15,%edx
  1001f7:	77 51                	ja     10024a <interrupt+0x74>
  1001f9:	ff 24 95 5c 0b 10 00 	jmp    *0x100b5c(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100200:	e8 97 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100205:	a1 48 7d 10 00       	mov    0x107d48,%eax
		current->p_exit_status = reg->reg_eax;
  10020a:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10020d:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100214:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100217:	e8 80 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  10021c:	83 ec 0c             	sub    $0xc,%esp
  10021f:	ff 35 48 7d 10 00    	pushl  0x107d48
  100225:	eb 04                	jmp    10022b <interrupt+0x55>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100227:	83 ec 0c             	sub    $0xc,%esp
  10022a:	50                   	push   %eax
  10022b:	e8 49 03 00 00       	call   100579 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100230:	e8 67 fe ff ff       	call   10009c <schedule>
    
	case INT_SYS_PRI:
		current->p_priority = reg->reg_eax;
  100235:	a1 48 7d 10 00       	mov    0x107d48,%eax
  10023a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10023d:	89 50 4c             	mov    %edx,0x4c(%eax)
  100240:	eb e5                	jmp    100227 <interrupt+0x51>
		run(current);

	case INT_SYS_PROP:
		current->p_proportional = reg->reg_eax;
  100242:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100245:	89 50 50             	mov    %edx,0x50(%eax)
  100248:	eb dd                	jmp    100227 <interrupt+0x51>
  10024a:	eb fe                	jmp    10024a <interrupt+0x74>

0010024c <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10024c:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024d:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100252:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100253:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100255:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100256:	bb 70 73 10 00       	mov    $0x107370,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10025b:	e8 f8 00 00 00       	call   100358 <segments_init>
	interrupt_controller_init(0);
  100260:	83 ec 0c             	sub    $0xc,%esp
  100263:	6a 00                	push   $0x0
  100265:	e8 e9 01 00 00       	call   100453 <interrupt_controller_init>
	console_clear();
  10026a:	e8 6d 02 00 00       	call   1004dc <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10026f:	83 c4 0c             	add    $0xc,%esp
  100272:	68 cc 01 00 00       	push   $0x1cc
  100277:	6a 00                	push   $0x0
  100279:	68 14 73 10 00       	push   $0x107314
  10027e:	e8 39 04 00 00       	call   1006bc <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100283:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100286:	c7 05 14 73 10 00 00 	movl   $0x0,0x107314
  10028d:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100290:	c7 05 5c 73 10 00 00 	movl   $0x0,0x10735c
  100297:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10029a:	c7 05 70 73 10 00 01 	movl   $0x1,0x107370
  1002a1:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002a4:	c7 05 b8 73 10 00 00 	movl   $0x0,0x1073b8
  1002ab:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ae:	c7 05 cc 73 10 00 02 	movl   $0x2,0x1073cc
  1002b5:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b8:	c7 05 14 74 10 00 00 	movl   $0x0,0x107414
  1002bf:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c2:	c7 05 28 74 10 00 03 	movl   $0x3,0x107428
  1002c9:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002cc:	c7 05 70 74 10 00 00 	movl   $0x0,0x107470
  1002d3:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d6:	c7 05 84 74 10 00 04 	movl   $0x4,0x107484
  1002dd:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e0:	c7 05 cc 74 10 00 00 	movl   $0x0,0x1074cc
  1002e7:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002ea:	83 ec 0c             	sub    $0xc,%esp
  1002ed:	53                   	push   %ebx
  1002ee:	e8 9d 02 00 00       	call   100590 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002f3:	58                   	pop    %eax
  1002f4:	5a                   	pop    %edx
  1002f5:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002f8:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
		proc->p_priority = 0;
		proc->p_proportional = 1;
		proc->p_runtime = 0;
  1002fb:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100301:	50                   	push   %eax
  100302:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
		proc->p_priority = 0;
		proc->p_proportional = 1;
		proc->p_runtime = 0;
  100303:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100304:	e8 c3 02 00 00       	call   1005cc <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100309:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10030c:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
		proc->p_priority = 0;
  100313:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
		proc->p_proportional = 1;
  10031a:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)
		proc->p_runtime = 0;
  100321:	c7 43 54 00 00 00 00 	movl   $0x0,0x54(%ebx)
  100328:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10032b:	83 fe 04             	cmp    $0x4,%esi
  10032e:	75 ba                	jne    1002ea <start+0x9e>
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 1;
    scheduling_algorithm = 2;
	// Switch to the first process.
	proc_array[1].p_runtime++;
	run(&proc_array[1]);
  100330:	83 ec 0c             	sub    $0xc,%esp
  100333:	68 70 73 10 00       	push   $0x107370
	//by Sk
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 1;
    scheduling_algorithm = 2;
	// Switch to the first process.
	proc_array[1].p_runtime++;
  100338:	ff 05 c4 73 10 00    	incl   0x1073c4
		proc->p_runtime = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10033e:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100345:	80 0b 00 

	// Initialize the scheduling algorithm.
	//by Sk
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 1;
    scheduling_algorithm = 2;
  100348:	c7 05 4c 7d 10 00 02 	movl   $0x2,0x107d4c
  10034f:	00 00 00 
	// Switch to the first process.
	proc_array[1].p_runtime++;
	run(&proc_array[1]);
  100352:	e8 22 02 00 00       	call   100579 <run>
  100357:	90                   	nop

00100358 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100358:	b8 e0 74 10 00       	mov    $0x1074e0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10035d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100362:	89 c2                	mov    %eax,%edx
  100364:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100367:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100368:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10036d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100370:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100376:	c1 e8 18             	shr    $0x18,%eax
  100379:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10037f:	ba 48 75 10 00       	mov    $0x107548,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100384:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100389:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10038b:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100392:	68 00 
  100394:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10039b:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003a2:	c7 05 e4 74 10 00 00 	movl   $0x180000,0x1074e4
  1003a9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003ac:	66 c7 05 e8 74 10 00 	movw   $0x10,0x1074e8
  1003b3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b5:	66 89 0c c5 48 75 10 	mov    %cx,0x107548(,%eax,8)
  1003bc:	00 
  1003bd:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003c4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003c9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003ce:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003d3:	40                   	inc    %eax
  1003d4:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003d9:	75 da                	jne    1003b5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003db:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e0:	ba 48 75 10 00       	mov    $0x107548,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003e5:	66 a3 48 76 10 00    	mov    %ax,0x107648
  1003eb:	c1 e8 10             	shr    $0x10,%eax
  1003ee:	66 a3 4e 76 10 00    	mov    %ax,0x10764e
  1003f4:	b8 30 00 00 00       	mov    $0x30,%eax
  1003f9:	66 c7 05 4a 76 10 00 	movw   $0x8,0x10764a
  100400:	08 00 
  100402:	c6 05 4c 76 10 00 00 	movb   $0x0,0x10764c
  100409:	c6 05 4d 76 10 00 8e 	movb   $0x8e,0x10764d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100410:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100417:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10041e:	66 89 0c c5 48 75 10 	mov    %cx,0x107548(,%eax,8)
  100425:	00 
  100426:	c1 e9 10             	shr    $0x10,%ecx
  100429:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10042e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100433:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100438:	40                   	inc    %eax
  100439:	83 f8 3a             	cmp    $0x3a,%eax
  10043c:	75 d2                	jne    100410 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10043e:	b0 28                	mov    $0x28,%al
  100440:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100447:	0f 00 d8             	ltr    %ax
  10044a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100451:	5b                   	pop    %ebx
  100452:	c3                   	ret    

00100453 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100453:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100454:	b0 ff                	mov    $0xff,%al
  100456:	57                   	push   %edi
  100457:	56                   	push   %esi
  100458:	53                   	push   %ebx
  100459:	bb 21 00 00 00       	mov    $0x21,%ebx
  10045e:	89 da                	mov    %ebx,%edx
  100460:	ee                   	out    %al,(%dx)
  100461:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100466:	89 ca                	mov    %ecx,%edx
  100468:	ee                   	out    %al,(%dx)
  100469:	be 11 00 00 00       	mov    $0x11,%esi
  10046e:	bf 20 00 00 00       	mov    $0x20,%edi
  100473:	89 f0                	mov    %esi,%eax
  100475:	89 fa                	mov    %edi,%edx
  100477:	ee                   	out    %al,(%dx)
  100478:	b0 20                	mov    $0x20,%al
  10047a:	89 da                	mov    %ebx,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	b0 04                	mov    $0x4,%al
  10047f:	ee                   	out    %al,(%dx)
  100480:	b0 03                	mov    $0x3,%al
  100482:	ee                   	out    %al,(%dx)
  100483:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100488:	89 f0                	mov    %esi,%eax
  10048a:	89 ea                	mov    %ebp,%edx
  10048c:	ee                   	out    %al,(%dx)
  10048d:	b0 28                	mov    $0x28,%al
  10048f:	89 ca                	mov    %ecx,%edx
  100491:	ee                   	out    %al,(%dx)
  100492:	b0 02                	mov    $0x2,%al
  100494:	ee                   	out    %al,(%dx)
  100495:	b0 01                	mov    $0x1,%al
  100497:	ee                   	out    %al,(%dx)
  100498:	b0 68                	mov    $0x68,%al
  10049a:	89 fa                	mov    %edi,%edx
  10049c:	ee                   	out    %al,(%dx)
  10049d:	be 0a 00 00 00       	mov    $0xa,%esi
  1004a2:	89 f0                	mov    %esi,%eax
  1004a4:	ee                   	out    %al,(%dx)
  1004a5:	b0 68                	mov    $0x68,%al
  1004a7:	89 ea                	mov    %ebp,%edx
  1004a9:	ee                   	out    %al,(%dx)
  1004aa:	89 f0                	mov    %esi,%eax
  1004ac:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004ad:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004b2:	89 da                	mov    %ebx,%edx
  1004b4:	19 c0                	sbb    %eax,%eax
  1004b6:	f7 d0                	not    %eax
  1004b8:	05 ff 00 00 00       	add    $0xff,%eax
  1004bd:	ee                   	out    %al,(%dx)
  1004be:	b0 ff                	mov    $0xff,%al
  1004c0:	89 ca                	mov    %ecx,%edx
  1004c2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004c3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004c8:	74 0d                	je     1004d7 <interrupt_controller_init+0x84>
  1004ca:	b2 43                	mov    $0x43,%dl
  1004cc:	b0 34                	mov    $0x34,%al
  1004ce:	ee                   	out    %al,(%dx)
  1004cf:	b0 9c                	mov    $0x9c,%al
  1004d1:	b2 40                	mov    $0x40,%dl
  1004d3:	ee                   	out    %al,(%dx)
  1004d4:	b0 2e                	mov    $0x2e,%al
  1004d6:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004d7:	5b                   	pop    %ebx
  1004d8:	5e                   	pop    %esi
  1004d9:	5f                   	pop    %edi
  1004da:	5d                   	pop    %ebp
  1004db:	c3                   	ret    

001004dc <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004dc:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004dd:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004df:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004e0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004e7:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004ea:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004f0:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004f6:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004f9:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004fe:	75 ea                	jne    1004ea <console_clear+0xe>
  100500:	be d4 03 00 00       	mov    $0x3d4,%esi
  100505:	b0 0e                	mov    $0xe,%al
  100507:	89 f2                	mov    %esi,%edx
  100509:	ee                   	out    %al,(%dx)
  10050a:	31 c9                	xor    %ecx,%ecx
  10050c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100511:	88 c8                	mov    %cl,%al
  100513:	89 da                	mov    %ebx,%edx
  100515:	ee                   	out    %al,(%dx)
  100516:	b0 0f                	mov    $0xf,%al
  100518:	89 f2                	mov    %esi,%edx
  10051a:	ee                   	out    %al,(%dx)
  10051b:	88 c8                	mov    %cl,%al
  10051d:	89 da                	mov    %ebx,%edx
  10051f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100520:	5b                   	pop    %ebx
  100521:	5e                   	pop    %esi
  100522:	c3                   	ret    

00100523 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100523:	ba 64 00 00 00       	mov    $0x64,%edx
  100528:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100529:	a8 01                	test   $0x1,%al
  10052b:	74 45                	je     100572 <console_read_digit+0x4f>
  10052d:	b2 60                	mov    $0x60,%dl
  10052f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100530:	8d 50 fe             	lea    -0x2(%eax),%edx
  100533:	80 fa 08             	cmp    $0x8,%dl
  100536:	77 05                	ja     10053d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100538:	0f b6 c0             	movzbl %al,%eax
  10053b:	48                   	dec    %eax
  10053c:	c3                   	ret    
	else if (data == 0x0B)
  10053d:	3c 0b                	cmp    $0xb,%al
  10053f:	74 35                	je     100576 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100541:	8d 50 b9             	lea    -0x47(%eax),%edx
  100544:	80 fa 02             	cmp    $0x2,%dl
  100547:	77 07                	ja     100550 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100549:	0f b6 c0             	movzbl %al,%eax
  10054c:	83 e8 40             	sub    $0x40,%eax
  10054f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100550:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100553:	80 fa 02             	cmp    $0x2,%dl
  100556:	77 07                	ja     10055f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100558:	0f b6 c0             	movzbl %al,%eax
  10055b:	83 e8 47             	sub    $0x47,%eax
  10055e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10055f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100562:	80 fa 02             	cmp    $0x2,%dl
  100565:	77 07                	ja     10056e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100567:	0f b6 c0             	movzbl %al,%eax
  10056a:	83 e8 4e             	sub    $0x4e,%eax
  10056d:	c3                   	ret    
	else if (data == 0x53)
  10056e:	3c 53                	cmp    $0x53,%al
  100570:	74 04                	je     100576 <console_read_digit+0x53>
  100572:	83 c8 ff             	or     $0xffffffff,%eax
  100575:	c3                   	ret    
  100576:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100578:	c3                   	ret    

00100579 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100579:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10057d:	a3 48 7d 10 00       	mov    %eax,0x107d48

	asm volatile("movl %0,%%esp\n\t"
  100582:	83 c0 04             	add    $0x4,%eax
  100585:	89 c4                	mov    %eax,%esp
  100587:	61                   	popa   
  100588:	07                   	pop    %es
  100589:	1f                   	pop    %ds
  10058a:	83 c4 08             	add    $0x8,%esp
  10058d:	cf                   	iret   
  10058e:	eb fe                	jmp    10058e <run+0x15>

00100590 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100590:	53                   	push   %ebx
  100591:	83 ec 0c             	sub    $0xc,%esp
  100594:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100598:	6a 44                	push   $0x44
  10059a:	6a 00                	push   $0x0
  10059c:	8d 43 04             	lea    0x4(%ebx),%eax
  10059f:	50                   	push   %eax
  1005a0:	e8 17 01 00 00       	call   1006bc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005a5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005ab:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005b1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005b7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005bd:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005c4:	83 c4 18             	add    $0x18,%esp
  1005c7:	5b                   	pop    %ebx
  1005c8:	c3                   	ret    
  1005c9:	90                   	nop
  1005ca:	90                   	nop
  1005cb:	90                   	nop

001005cc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005cc:	55                   	push   %ebp
  1005cd:	57                   	push   %edi
  1005ce:	56                   	push   %esi
  1005cf:	53                   	push   %ebx
  1005d0:	83 ec 1c             	sub    $0x1c,%esp
  1005d3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005d7:	83 f8 03             	cmp    $0x3,%eax
  1005da:	7f 04                	jg     1005e0 <program_loader+0x14>
  1005dc:	85 c0                	test   %eax,%eax
  1005de:	79 02                	jns    1005e2 <program_loader+0x16>
  1005e0:	eb fe                	jmp    1005e0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005e2:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005e9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005ef:	74 02                	je     1005f3 <program_loader+0x27>
  1005f1:	eb fe                	jmp    1005f1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005f3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005f6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005fa:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005fc:	c1 e5 05             	shl    $0x5,%ebp
  1005ff:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100602:	eb 3f                	jmp    100643 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100604:	83 3b 01             	cmpl   $0x1,(%ebx)
  100607:	75 37                	jne    100640 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100609:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10060c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10060f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100612:	01 c7                	add    %eax,%edi
	memsz += va;
  100614:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100616:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10061b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10061f:	52                   	push   %edx
  100620:	89 fa                	mov    %edi,%edx
  100622:	29 c2                	sub    %eax,%edx
  100624:	52                   	push   %edx
  100625:	8b 53 04             	mov    0x4(%ebx),%edx
  100628:	01 f2                	add    %esi,%edx
  10062a:	52                   	push   %edx
  10062b:	50                   	push   %eax
  10062c:	e8 27 00 00 00       	call   100658 <memcpy>
  100631:	83 c4 10             	add    $0x10,%esp
  100634:	eb 04                	jmp    10063a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100636:	c6 07 00             	movb   $0x0,(%edi)
  100639:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10063a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10063e:	72 f6                	jb     100636 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100640:	83 c3 20             	add    $0x20,%ebx
  100643:	39 eb                	cmp    %ebp,%ebx
  100645:	72 bd                	jb     100604 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100647:	8b 56 18             	mov    0x18(%esi),%edx
  10064a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10064e:	89 10                	mov    %edx,(%eax)
}
  100650:	83 c4 1c             	add    $0x1c,%esp
  100653:	5b                   	pop    %ebx
  100654:	5e                   	pop    %esi
  100655:	5f                   	pop    %edi
  100656:	5d                   	pop    %ebp
  100657:	c3                   	ret    

00100658 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100658:	56                   	push   %esi
  100659:	31 d2                	xor    %edx,%edx
  10065b:	53                   	push   %ebx
  10065c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100660:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100664:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100668:	eb 08                	jmp    100672 <memcpy+0x1a>
		*d++ = *s++;
  10066a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10066d:	4e                   	dec    %esi
  10066e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100671:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100672:	85 f6                	test   %esi,%esi
  100674:	75 f4                	jne    10066a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100676:	5b                   	pop    %ebx
  100677:	5e                   	pop    %esi
  100678:	c3                   	ret    

00100679 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100679:	57                   	push   %edi
  10067a:	56                   	push   %esi
  10067b:	53                   	push   %ebx
  10067c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100680:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100684:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100688:	39 c7                	cmp    %eax,%edi
  10068a:	73 26                	jae    1006b2 <memmove+0x39>
  10068c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10068f:	39 c6                	cmp    %eax,%esi
  100691:	76 1f                	jbe    1006b2 <memmove+0x39>
		s += n, d += n;
  100693:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100696:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100698:	eb 07                	jmp    1006a1 <memmove+0x28>
			*--d = *--s;
  10069a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10069d:	4a                   	dec    %edx
  10069e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006a1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006a2:	85 d2                	test   %edx,%edx
  1006a4:	75 f4                	jne    10069a <memmove+0x21>
  1006a6:	eb 10                	jmp    1006b8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006a8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006ab:	4a                   	dec    %edx
  1006ac:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006af:	41                   	inc    %ecx
  1006b0:	eb 02                	jmp    1006b4 <memmove+0x3b>
  1006b2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006b4:	85 d2                	test   %edx,%edx
  1006b6:	75 f0                	jne    1006a8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006b8:	5b                   	pop    %ebx
  1006b9:	5e                   	pop    %esi
  1006ba:	5f                   	pop    %edi
  1006bb:	c3                   	ret    

001006bc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006bc:	53                   	push   %ebx
  1006bd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006c1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006c5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006c9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006cb:	eb 04                	jmp    1006d1 <memset+0x15>
		*p++ = c;
  1006cd:	88 1a                	mov    %bl,(%edx)
  1006cf:	49                   	dec    %ecx
  1006d0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006d1:	85 c9                	test   %ecx,%ecx
  1006d3:	75 f8                	jne    1006cd <memset+0x11>
		*p++ = c;
	return v;
}
  1006d5:	5b                   	pop    %ebx
  1006d6:	c3                   	ret    

001006d7 <strlen>:

size_t
strlen(const char *s)
{
  1006d7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006db:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006dd:	eb 01                	jmp    1006e0 <strlen+0x9>
		++n;
  1006df:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006e0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006e4:	75 f9                	jne    1006df <strlen+0x8>
		++n;
	return n;
}
  1006e6:	c3                   	ret    

001006e7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006e7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006eb:	31 c0                	xor    %eax,%eax
  1006ed:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006f1:	eb 01                	jmp    1006f4 <strnlen+0xd>
		++n;
  1006f3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006f4:	39 d0                	cmp    %edx,%eax
  1006f6:	74 06                	je     1006fe <strnlen+0x17>
  1006f8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006fc:	75 f5                	jne    1006f3 <strnlen+0xc>
		++n;
	return n;
}
  1006fe:	c3                   	ret    

001006ff <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006ff:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100700:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100705:	53                   	push   %ebx
  100706:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100708:	76 05                	jbe    10070f <console_putc+0x10>
  10070a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10070f:	80 fa 0a             	cmp    $0xa,%dl
  100712:	75 2c                	jne    100740 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100714:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10071a:	be 50 00 00 00       	mov    $0x50,%esi
  10071f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100721:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100724:	99                   	cltd   
  100725:	f7 fe                	idiv   %esi
  100727:	89 de                	mov    %ebx,%esi
  100729:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10072b:	eb 07                	jmp    100734 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10072d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100730:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100731:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100734:	83 f8 50             	cmp    $0x50,%eax
  100737:	75 f4                	jne    10072d <console_putc+0x2e>
  100739:	29 d0                	sub    %edx,%eax
  10073b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10073e:	eb 0b                	jmp    10074b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100740:	0f b6 d2             	movzbl %dl,%edx
  100743:	09 ca                	or     %ecx,%edx
  100745:	66 89 13             	mov    %dx,(%ebx)
  100748:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10074b:	5b                   	pop    %ebx
  10074c:	5e                   	pop    %esi
  10074d:	c3                   	ret    

0010074e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10074e:	56                   	push   %esi
  10074f:	53                   	push   %ebx
  100750:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100754:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100757:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10075b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100760:	75 04                	jne    100766 <fill_numbuf+0x18>
  100762:	85 d2                	test   %edx,%edx
  100764:	74 10                	je     100776 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100766:	89 d0                	mov    %edx,%eax
  100768:	31 d2                	xor    %edx,%edx
  10076a:	f7 f1                	div    %ecx
  10076c:	4b                   	dec    %ebx
  10076d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100770:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100772:	89 c2                	mov    %eax,%edx
  100774:	eb ec                	jmp    100762 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100776:	89 d8                	mov    %ebx,%eax
  100778:	5b                   	pop    %ebx
  100779:	5e                   	pop    %esi
  10077a:	c3                   	ret    

0010077b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10077b:	55                   	push   %ebp
  10077c:	57                   	push   %edi
  10077d:	56                   	push   %esi
  10077e:	53                   	push   %ebx
  10077f:	83 ec 38             	sub    $0x38,%esp
  100782:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100786:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10078a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10078e:	e9 60 03 00 00       	jmp    100af3 <console_vprintf+0x378>
		if (*format != '%') {
  100793:	80 fa 25             	cmp    $0x25,%dl
  100796:	74 13                	je     1007ab <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100798:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10079c:	0f b6 d2             	movzbl %dl,%edx
  10079f:	89 f0                	mov    %esi,%eax
  1007a1:	e8 59 ff ff ff       	call   1006ff <console_putc>
  1007a6:	e9 45 03 00 00       	jmp    100af0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007ab:	47                   	inc    %edi
  1007ac:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007b3:	00 
  1007b4:	eb 12                	jmp    1007c8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007b6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007b7:	8a 11                	mov    (%ecx),%dl
  1007b9:	84 d2                	test   %dl,%dl
  1007bb:	74 1a                	je     1007d7 <console_vprintf+0x5c>
  1007bd:	89 e8                	mov    %ebp,%eax
  1007bf:	38 c2                	cmp    %al,%dl
  1007c1:	75 f3                	jne    1007b6 <console_vprintf+0x3b>
  1007c3:	e9 3f 03 00 00       	jmp    100b07 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007c8:	8a 17                	mov    (%edi),%dl
  1007ca:	84 d2                	test   %dl,%dl
  1007cc:	74 0b                	je     1007d9 <console_vprintf+0x5e>
  1007ce:	b9 b8 0b 10 00       	mov    $0x100bb8,%ecx
  1007d3:	89 d5                	mov    %edx,%ebp
  1007d5:	eb e0                	jmp    1007b7 <console_vprintf+0x3c>
  1007d7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007d9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007dc:	3c 08                	cmp    $0x8,%al
  1007de:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007e5:	00 
  1007e6:	76 13                	jbe    1007fb <console_vprintf+0x80>
  1007e8:	eb 1d                	jmp    100807 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007ea:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007ef:	0f be c0             	movsbl %al,%eax
  1007f2:	47                   	inc    %edi
  1007f3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007fb:	8a 07                	mov    (%edi),%al
  1007fd:	8d 50 d0             	lea    -0x30(%eax),%edx
  100800:	80 fa 09             	cmp    $0x9,%dl
  100803:	76 e5                	jbe    1007ea <console_vprintf+0x6f>
  100805:	eb 18                	jmp    10081f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100807:	80 fa 2a             	cmp    $0x2a,%dl
  10080a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100811:	ff 
  100812:	75 0b                	jne    10081f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100814:	83 c3 04             	add    $0x4,%ebx
			++format;
  100817:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100818:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10081b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10081f:	83 cd ff             	or     $0xffffffff,%ebp
  100822:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100825:	75 37                	jne    10085e <console_vprintf+0xe3>
			++format;
  100827:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100828:	31 ed                	xor    %ebp,%ebp
  10082a:	8a 07                	mov    (%edi),%al
  10082c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10082f:	80 fa 09             	cmp    $0x9,%dl
  100832:	76 0d                	jbe    100841 <console_vprintf+0xc6>
  100834:	eb 17                	jmp    10084d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100836:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100839:	0f be c0             	movsbl %al,%eax
  10083c:	47                   	inc    %edi
  10083d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100841:	8a 07                	mov    (%edi),%al
  100843:	8d 50 d0             	lea    -0x30(%eax),%edx
  100846:	80 fa 09             	cmp    $0x9,%dl
  100849:	76 eb                	jbe    100836 <console_vprintf+0xbb>
  10084b:	eb 11                	jmp    10085e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10084d:	3c 2a                	cmp    $0x2a,%al
  10084f:	75 0b                	jne    10085c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100851:	83 c3 04             	add    $0x4,%ebx
				++format;
  100854:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100855:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100858:	85 ed                	test   %ebp,%ebp
  10085a:	79 02                	jns    10085e <console_vprintf+0xe3>
  10085c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10085e:	8a 07                	mov    (%edi),%al
  100860:	3c 64                	cmp    $0x64,%al
  100862:	74 34                	je     100898 <console_vprintf+0x11d>
  100864:	7f 1d                	jg     100883 <console_vprintf+0x108>
  100866:	3c 58                	cmp    $0x58,%al
  100868:	0f 84 a2 00 00 00    	je     100910 <console_vprintf+0x195>
  10086e:	3c 63                	cmp    $0x63,%al
  100870:	0f 84 bf 00 00 00    	je     100935 <console_vprintf+0x1ba>
  100876:	3c 43                	cmp    $0x43,%al
  100878:	0f 85 d0 00 00 00    	jne    10094e <console_vprintf+0x1d3>
  10087e:	e9 a3 00 00 00       	jmp    100926 <console_vprintf+0x1ab>
  100883:	3c 75                	cmp    $0x75,%al
  100885:	74 4d                	je     1008d4 <console_vprintf+0x159>
  100887:	3c 78                	cmp    $0x78,%al
  100889:	74 5c                	je     1008e7 <console_vprintf+0x16c>
  10088b:	3c 73                	cmp    $0x73,%al
  10088d:	0f 85 bb 00 00 00    	jne    10094e <console_vprintf+0x1d3>
  100893:	e9 86 00 00 00       	jmp    10091e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100898:	83 c3 04             	add    $0x4,%ebx
  10089b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10089e:	89 d1                	mov    %edx,%ecx
  1008a0:	c1 f9 1f             	sar    $0x1f,%ecx
  1008a3:	89 0c 24             	mov    %ecx,(%esp)
  1008a6:	31 ca                	xor    %ecx,%edx
  1008a8:	55                   	push   %ebp
  1008a9:	29 ca                	sub    %ecx,%edx
  1008ab:	68 c0 0b 10 00       	push   $0x100bc0
  1008b0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008b5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008b9:	e8 90 fe ff ff       	call   10074e <fill_numbuf>
  1008be:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008c2:	58                   	pop    %eax
  1008c3:	5a                   	pop    %edx
  1008c4:	ba 01 00 00 00       	mov    $0x1,%edx
  1008c9:	8b 04 24             	mov    (%esp),%eax
  1008cc:	83 e0 01             	and    $0x1,%eax
  1008cf:	e9 a5 00 00 00       	jmp    100979 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008d4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008dc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008df:	55                   	push   %ebp
  1008e0:	68 c0 0b 10 00       	push   $0x100bc0
  1008e5:	eb 11                	jmp    1008f8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008e7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008ea:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008ed:	55                   	push   %ebp
  1008ee:	68 d4 0b 10 00       	push   $0x100bd4
  1008f3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008f8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008fc:	e8 4d fe ff ff       	call   10074e <fill_numbuf>
  100901:	ba 01 00 00 00       	mov    $0x1,%edx
  100906:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10090a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10090c:	59                   	pop    %ecx
  10090d:	59                   	pop    %ecx
  10090e:	eb 69                	jmp    100979 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100910:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100913:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100916:	55                   	push   %ebp
  100917:	68 c0 0b 10 00       	push   $0x100bc0
  10091c:	eb d5                	jmp    1008f3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10091e:	83 c3 04             	add    $0x4,%ebx
  100921:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100924:	eb 40                	jmp    100966 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100926:	83 c3 04             	add    $0x4,%ebx
  100929:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10092c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100930:	e9 bd 01 00 00       	jmp    100af2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100935:	83 c3 04             	add    $0x4,%ebx
  100938:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10093b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10093f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100944:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100948:	88 44 24 24          	mov    %al,0x24(%esp)
  10094c:	eb 27                	jmp    100975 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10094e:	84 c0                	test   %al,%al
  100950:	75 02                	jne    100954 <console_vprintf+0x1d9>
  100952:	b0 25                	mov    $0x25,%al
  100954:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100958:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10095d:	80 3f 00             	cmpb   $0x0,(%edi)
  100960:	74 0a                	je     10096c <console_vprintf+0x1f1>
  100962:	8d 44 24 24          	lea    0x24(%esp),%eax
  100966:	89 44 24 04          	mov    %eax,0x4(%esp)
  10096a:	eb 09                	jmp    100975 <console_vprintf+0x1fa>
				format--;
  10096c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100970:	4f                   	dec    %edi
  100971:	89 54 24 04          	mov    %edx,0x4(%esp)
  100975:	31 d2                	xor    %edx,%edx
  100977:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100979:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10097b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10097e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100985:	74 1f                	je     1009a6 <console_vprintf+0x22b>
  100987:	89 04 24             	mov    %eax,(%esp)
  10098a:	eb 01                	jmp    10098d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10098c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10098d:	39 e9                	cmp    %ebp,%ecx
  10098f:	74 0a                	je     10099b <console_vprintf+0x220>
  100991:	8b 44 24 04          	mov    0x4(%esp),%eax
  100995:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100999:	75 f1                	jne    10098c <console_vprintf+0x211>
  10099b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10099e:	89 0c 24             	mov    %ecx,(%esp)
  1009a1:	eb 1f                	jmp    1009c2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009a3:	42                   	inc    %edx
  1009a4:	eb 09                	jmp    1009af <console_vprintf+0x234>
  1009a6:	89 d1                	mov    %edx,%ecx
  1009a8:	8b 14 24             	mov    (%esp),%edx
  1009ab:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009af:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009b3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009b7:	75 ea                	jne    1009a3 <console_vprintf+0x228>
  1009b9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009bd:	89 14 24             	mov    %edx,(%esp)
  1009c0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009c2:	85 c0                	test   %eax,%eax
  1009c4:	74 0c                	je     1009d2 <console_vprintf+0x257>
  1009c6:	84 d2                	test   %dl,%dl
  1009c8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009cf:	00 
  1009d0:	75 24                	jne    1009f6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009d2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009d7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009de:	00 
  1009df:	75 15                	jne    1009f6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009e1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009e5:	83 e0 08             	and    $0x8,%eax
  1009e8:	83 f8 01             	cmp    $0x1,%eax
  1009eb:	19 c9                	sbb    %ecx,%ecx
  1009ed:	f7 d1                	not    %ecx
  1009ef:	83 e1 20             	and    $0x20,%ecx
  1009f2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009f6:	3b 2c 24             	cmp    (%esp),%ebp
  1009f9:	7e 0d                	jle    100a08 <console_vprintf+0x28d>
  1009fb:	84 d2                	test   %dl,%dl
  1009fd:	74 40                	je     100a3f <console_vprintf+0x2c4>
			zeros = precision - len;
  1009ff:	2b 2c 24             	sub    (%esp),%ebp
  100a02:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a06:	eb 3f                	jmp    100a47 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a08:	84 d2                	test   %dl,%dl
  100a0a:	74 33                	je     100a3f <console_vprintf+0x2c4>
  100a0c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a10:	83 e0 06             	and    $0x6,%eax
  100a13:	83 f8 02             	cmp    $0x2,%eax
  100a16:	75 27                	jne    100a3f <console_vprintf+0x2c4>
  100a18:	45                   	inc    %ebp
  100a19:	75 24                	jne    100a3f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a1b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a1d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a20:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a25:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a28:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a2b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a2f:	7d 0e                	jge    100a3f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a31:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a35:	29 ca                	sub    %ecx,%edx
  100a37:	29 c2                	sub    %eax,%edx
  100a39:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a3d:	eb 08                	jmp    100a47 <console_vprintf+0x2cc>
  100a3f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a46:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a47:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a4b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a4d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a51:	2b 2c 24             	sub    (%esp),%ebp
  100a54:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a59:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a5c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a5f:	29 c5                	sub    %eax,%ebp
  100a61:	89 f0                	mov    %esi,%eax
  100a63:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a67:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a6b:	eb 0f                	jmp    100a7c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a6d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a71:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a76:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a77:	e8 83 fc ff ff       	call   1006ff <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a7c:	85 ed                	test   %ebp,%ebp
  100a7e:	7e 07                	jle    100a87 <console_vprintf+0x30c>
  100a80:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a85:	74 e6                	je     100a6d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a87:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a8c:	89 c6                	mov    %eax,%esi
  100a8e:	74 23                	je     100ab3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a90:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a95:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a99:	e8 61 fc ff ff       	call   1006ff <console_putc>
  100a9e:	89 c6                	mov    %eax,%esi
  100aa0:	eb 11                	jmp    100ab3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100aa2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aa6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100aab:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100aac:	e8 4e fc ff ff       	call   1006ff <console_putc>
  100ab1:	eb 06                	jmp    100ab9 <console_vprintf+0x33e>
  100ab3:	89 f0                	mov    %esi,%eax
  100ab5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ab9:	85 f6                	test   %esi,%esi
  100abb:	7f e5                	jg     100aa2 <console_vprintf+0x327>
  100abd:	8b 34 24             	mov    (%esp),%esi
  100ac0:	eb 15                	jmp    100ad7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ac2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ac6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100ac7:	0f b6 11             	movzbl (%ecx),%edx
  100aca:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ace:	e8 2c fc ff ff       	call   1006ff <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ad3:	ff 44 24 04          	incl   0x4(%esp)
  100ad7:	85 f6                	test   %esi,%esi
  100ad9:	7f e7                	jg     100ac2 <console_vprintf+0x347>
  100adb:	eb 0f                	jmp    100aec <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100add:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ae1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ae6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ae7:	e8 13 fc ff ff       	call   1006ff <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100aec:	85 ed                	test   %ebp,%ebp
  100aee:	7f ed                	jg     100add <console_vprintf+0x362>
  100af0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100af2:	47                   	inc    %edi
  100af3:	8a 17                	mov    (%edi),%dl
  100af5:	84 d2                	test   %dl,%dl
  100af7:	0f 85 96 fc ff ff    	jne    100793 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100afd:	83 c4 38             	add    $0x38,%esp
  100b00:	89 f0                	mov    %esi,%eax
  100b02:	5b                   	pop    %ebx
  100b03:	5e                   	pop    %esi
  100b04:	5f                   	pop    %edi
  100b05:	5d                   	pop    %ebp
  100b06:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b07:	81 e9 b8 0b 10 00    	sub    $0x100bb8,%ecx
  100b0d:	b8 01 00 00 00       	mov    $0x1,%eax
  100b12:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b14:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b15:	09 44 24 14          	or     %eax,0x14(%esp)
  100b19:	e9 aa fc ff ff       	jmp    1007c8 <console_vprintf+0x4d>

00100b1e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b1e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b22:	50                   	push   %eax
  100b23:	ff 74 24 10          	pushl  0x10(%esp)
  100b27:	ff 74 24 10          	pushl  0x10(%esp)
  100b2b:	ff 74 24 10          	pushl  0x10(%esp)
  100b2f:	e8 47 fc ff ff       	call   10077b <console_vprintf>
  100b34:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b37:	c3                   	ret    

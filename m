From: Bo Hansen <bh@newtec.dk>
Subject: Re: hrtimer problem on AT91RM9200
Date: Mon, 14 Sep 2009 12:50:32 +0200
Message-ID: <4AAE1FF8.90007@newtec.dk>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de> <20090911230735.GA23652@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030502070809010503040507"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:56890 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbZINKud (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 06:50:33 -0400
In-Reply-To: <20090911230735.GA23652@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030502070809010503040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

I tried to apply your patch and enabled ftrace but have not been able to 
reproduce
the panic.
It should also be noted that the panic is much more rare if I apply the 
first patch you
sent.

The only panic I got was using your first patch and enabling ftrace. I 
have not yet had
the time to try changing pr_info/pr_emerg.
It seems to run stable when something like: "hrtimer: interrupt too 
slow, forcing clock
min delta to 480771 ns" is found in the dmesg output, but I cannot be 
sure as I don't
know if this is also written to the log just before the panic.

Unfortunately I don't have much time for testing this at the moment but 
I'll get back
as soon as possible.


Best regards,
Bo

Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Sep 11, 2009 at 05:20:44PM +0200, Uwe Kleine-König wrote:
>   
>> Hello Bo,
>>
>> In the meantime I got access to an at91rm9200, too.  To help me
>> reproducing the problem:
>>     
> I still cannot reproduce, but I found something anyhow.
>
> The problem is that hrtimer_interrupt_hanging decreases min_delta_ns.
> (Initially it's 61036.)
>
> I talked to jstultz on irc and both of us are unsure if asserting that
> min_delta_ns isn't decreased in hrtimer_interrupt_hanging is enough or
> if there is another problem.
>
> Bo, can you please apply the patch below, pass the kernel parameter
> ftrace_dump_on_oops (or alternatively do 
>
> 	# echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
>
> ), reproduce the problem and send the resulting oops?
>
> Best regards
> Uwe
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 51bd089..cd72ca9 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -18,6 +18,7 @@
>  #include <linux/personality.h>
>  #include <linux/kallsyms.h>
>  #include <linux/delay.h>
> +#include <linux/kdebug.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
>  #include <linux/uaccess.h>
> @@ -223,6 +224,8 @@ static void __die(const char *str, int err, struct thread_info *thread, struct p
>  		dump_backtrace(regs, tsk);
>  		dump_instr(regs);
>  	}
> +
> +	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
>  }
>  
>  DEFINE_RAW_SPINLOCK(die_lock);
> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> index 9e308ab..a0c05f3 100644
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
> @@ -1390,8 +1390,16 @@ void hrtimer_interrupt(struct clock_event_device *dev)
>  
>  	/* Reprogramming necessary ? */
>  	if (expires_next.tv64 != KTIME_MAX) {
> -		if (tick_program_event(expires_next, force_clock_reprogram))
> +		if (tick_program_event(expires_next, force_clock_reprogram)) {
> +			if (nr_retries > 1)
> +				trace_printk("tick_program_event failed, "
> +						"now=%lld, expires_next=%lld, "
> +						"nr_retries=%d\n",
> +					(long long)now.tv64,
> +					(long long)expires_next.tv64,
> +				       	nr_retries);
>  			goto retry;
> +		}
>  	}
>  
>  	if (raise)
>
>   

--------------030502070809010503040507
Content-Type: text/plain;
 name="140909_kernel_panic_2.6.29.6-rt23-debug-uwe-ftrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="140909_kernel_panic_2.6.29.6-rt23-debug-uwe-ftrace"

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c3a38000
[00000000] *pgd=23a0c031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29.6-rt23 #1)
PC is at clkevt32k_next_event+0x98/0xdc
LR is at rt_mutex_unlock+0x14/0x18
pc : [<c0030580>]    lr : [<c027e2cc>]    psr: 00000093
sp : c3a3dc58  ip : c3a3db68  fp : c3a3dc7c
r10: 00000000  r9 : 00000000  r8 : c0322dd8
r7 : 00000067  r6 : 00000000  r5 : 00000001  r4 : 00000000
r3 : 00000000  r2 : 00010003  r1 : 60000093  r0 : 00000062
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: c000717f  Table: 23a38000  DAC: 00000015
Process cyclictest (pid: 572, stack limit = 0xc3a3c270)
Stack: (0xc3a3dc58 to 0xc3a3e000)
dc40:                                                       0000d026 c0322dd8 
dc60: c3a3dce0 00000000 000225c1 00000000 c3a3dca4 c3a3dc80 c005d7f4 c00304f8 
dc80: 00000067 38db444d 00000067 38db1ca8 00000067 c0322dd8 c3a3dcf4 c3a3dca8 
dca0: c005e514 c005d704 38db1ca8 00000067 38daf15c 00000000 00000000 c3a3dd38 
dcc0: 38db1ca8 00000067 38726a67 38db444d 00000067 00000067 c03271f8 38db444d 
dce0: 00000067 c3a3c000 c3a3dd14 c3a3dcf8 c005e5c0 c005e454 00000001 00000001 
dd00: c03271f8 38daf15c c3a3dd74 c3a3dd18 c00551a0 c005e59c 3fcd8e40 c0322dd8 
dd20: 38daf15c 00000067 c0378b90 c03271f8 00000001 00000000 38daf15c 00000067 
dd40: 14f46b04 c0030cf0 00000000 c0322db0 c3a3c000 c0322db0 00010003 00000001 
dd60: c3a3c000 00000000 c3a3dd94 c3a3dd78 c003067c c0054f68 c0033944 c0322db0 
dd80: c3a3c000 c0322db0 c3a3ddcc c3a3dd98 c0068fbc c00305d4 c393601c 00000000 
dda0: 00000000 c0328068 c3a3c000 c0322db0 00000001 00000002 c3a3c000 c03247a8 
ddc0: c3a3ddec c3a3ddd0 c006b9b0 c0068f64 00000001 c0335330 00000000 00000003 
dde0: c3a3de0c c3a3ddf0 c0026070 c006b8b8 c0033944 ffffffff fefff000 00000001 
de00: c3a3de7c c3a3de10 c00269fc c0026010 c38ce120 00000001 00000013 0000086c 
de20: 00000000 c3a3c000 c3918800 c3918990 c38ce120 00000000 c03247a8 c3a3de7c 
de40: c3a3de30 c3a3de58 c0031c64 c027d0d0 00000013 ffffffff c3a3c000 00000000 
de60: 00000000 00000000 00000000 c3a3def8 c3a3de94 c3a3de80 c027d5b8 c027cfa4 
de80: 00000001 3b9aca00 c3a3ded4 c3a3de98 c027de28 c027d59c 00000000 00000000 
dea0: c3a3c000 00000000 c003f52c 00000000 00000000 00000000 c3a3df80 c3a3c000 
dec0: 00000000 00000000 c3a3df64 c3a3ded8 c0055ae8 c027dd60 00000000 00000000 
dee0: 007610eb 00000000 39aff350 00000067 00000000 00000000 c3a77ef8 00000000 
df00: 00000000 00000000 39aff350 00000067 39aff350 00000067 c0054e74 c03271f8 
df20: 00000001 c3a3df24 c3a3df24 00000001 c3918800 c003de3c c3a3df88 00000001 
df40: 00000001 00000000 c3a3df80 c0026fa8 c3a3c000 00017194 c3a3df7c c3a3df68 
df60: c004f578 c0055a3c c0026fa8 00000001 c3a3dfa4 c3a3df80 c004f6ac c004f558 
df80: 00000067 39aff350 00000001 00000000 4516ddec 00000109 00000000 c3a3dfa8 
dfa0: c0026de0 c004f58c 00000001 00000000 00000001 00000001 4516ddec 00000000 
dfc0: 00000001 00000000 4516ddec 00000109 00000001 00015c60 00017194 4516ddf4 
dfe0: 00000000 4516dc50 4004680c 4004682c 60000010 00000001 00000000 00000000 
Backtrace: 
[<c00304e8>] (clkevt32k_next_event+0x0/0xdc) from [<c005d7f4>] (clockevents_program_event+0x100/0x16c)
 r6:00000000 r5:000225c1 r4:00000000
[<c005d6f4>] (clockevents_program_event+0x0/0x16c) from [<c005e514>] (tick_dev_program_event+0xd0/0xfc)
 r8:c0322dd8 r7:00000067 r6:38db1ca8 r5:00000067 r4:38db444d
[<c005e444>] (tick_dev_program_event+0x0/0xfc) from [<c005e5c0>] (tick_program_event+0x34/0x40)
[<c005e58c>] (tick_program_event+0x0/0x40) from [<c00551a0>] (hrtimer_interrupt+0x248/0x2ec)
 r5:38daf15c r4:c03271f8
[<c0054f58>] (hrtimer_interrupt+0x0/0x2ec) from [<c003067c>] (at91rm9200_timer_interrupt+0xb8/0xcc)
[<c00305c4>] (at91rm9200_timer_interrupt+0x0/0xcc) from [<c0068fbc>] (handle_IRQ_event+0x68/0x1d8)
 r6:c0322db0 r5:c3a3c000 r4:c0322db0
[<c0068f54>] (handle_IRQ_event+0x0/0x1d8) from [<c006b9b0>] (handle_level_irq+0x108/0x178)
[<c006b8a8>] (handle_level_irq+0x0/0x178) from [<c0026070>] (_text+0x70/0x90)
 r7:00000003 r6:00000000 r5:c0335330 r4:00000001
[<c0026000>] (_text+0x0/0x90) from [<c00269fc>] (__irq_svc+0x3c/0x80)
Exception stack(0xc3a3de10 to 0xc3a3de58)
de00:                                     c38ce120 00000001 00000013 0000086c 
de20: 00000000 c3a3c000 c3918800 c3918990 c38ce120 00000000 c03247a8 c3a3de7c 
de40: c3a3de30 c3a3de58 c0031c64 c027d0d0 00000013 ffffffff                   
 r6:00000001 r5:fefff000 r4:ffffffff
[<c027cf94>] (__schedule+0x0/0x3b0) from [<c027d5b8>] (schedule+0x2c/0x48)
[<c027d58c>] (schedule+0x0/0x48) from [<c027de28>] (do_nanosleep+0xd8/0x118)
 r4:3b9aca00
[<c027dd50>] (do_nanosleep+0x0/0x118) from [<c0055ae8>] (hrtimer_nanosleep+0xbc/0x144)
[<c0055a2c>] (hrtimer_nanosleep+0x0/0x144) from [<c004f578>] (common_nsleep+0x30/0x34)
[<c004f548>] (common_nsleep+0x0/0x34) from [<c004f6ac>] (sys_clock_nanosleep+0x130/0x154)
 r4:00000001
[<c004f57c>] (sys_clock_nanosleep+0x0/0x154) from [<c0026de0>] (ret_fast_syscall+0x0/0x2c)
 r7:00000109 r6:4516ddec r5:00000000 r4:00000001
Code: e59f1040 e88d5000 eb00269f e3a03000 (e5833000) 
Kernel panic - not syncing: Fatal exception in interrupt
Dumping ftrace buffer:
   (ftrace buffer empty)


--------------030502070809010503040507--

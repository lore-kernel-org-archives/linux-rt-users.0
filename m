From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:917
Date: Fri, 4 Sep 2015 19:46:51 +0300
Message-ID: <55E9CAFB.9070002@ti.com>
References: <55CB8FAE.9020309@ti.com> <20150816114241.GC7004@linutronix.de>
 <55D201DC.5070604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>,
	<linux-rt-users@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51850 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569AbbIDQrp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Sep 2015 12:47:45 -0400
In-Reply-To: <55D201DC.5070604@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

On 08/17/2015 06:46 PM, Grygorii Strashko wrote:
> On 08/16/2015 02:42 PM, Sebastian Andrzej Siewior wrote:
>> * Grygorii Strashko | 2015-08-12 21:25:50 [+0300]:
>>>
>>> I can constantly see below error report with RT-kernel on TI ARM dra7-evm
>>> if I'm trying to do Suspend to RAM.
>>
>> do you see the same problem on x86 with -RT?
> 
> Unfortunately, I'm not working with x86 now, and I'm not sure I'll be able
> to try it in the nearest future.
> 
> Below, I've tried to analyze involved code path and it seems expected
> to call clear_tasks_mm_cpumask() in atomic context, as the whole
> take_cpu_down() call chain expected to be atomic.
> 
>>
>>> Disabling non-boot CPUs ...
>>> PM: noirq suspend of devices complete after 7.295 msecs
>>> [  100.285729] Disabling non-boot CPUs ...
>>> [  100.287575] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
>>> [  100.287580] in_atomic(): 1, irqs_disabled(): 128, pid: 18, name: migration/1
>>> [  100.287583] INFO: lockdep is turned off.
>>> [  100.287586] irq event stamp: 122
>>> [  100.287600] hardirqs last  enabled at (121): [<c06ac0ac>] _raw_spin_unlock_irqrestore+0x88/0x90
>>> [  100.287609] hardirqs last disabled at (122): [<c06abed0>] _raw_spin_lock_irq+0x28/0x5c
>>> [  100.287620] softirqs last  enabled at (0): [<c003d294>] copy_process.part.52+0x410/0x19d8
>>> [  100.287625] softirqs last disabled at (0): [<  (null)>]   (null)
>>> [  100.287630] Preemption disabled at:[<  (null)>]   (null)
>>> [  100.287631]
>>> [  100.287639] CPU: 1 PID: 18 Comm: migration/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
>>> [  100.287642] Hardware name: Generic DRA74X (Flattened Device Tree)
>>> [  100.287659] [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
>>> [  100.287671] [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
>>> [  100.287681] [<c06a70f4>] (dump_stack) from [<c006cab8>] (___might_sleep+0x198/0x2a8)
>>> [  100.287689] [<c006cab8>] (___might_sleep) from [<c06ac4dc>] (rt_spin_lock+0x30/0x70)
>>> [  100.287699] [<c06ac4dc>] (rt_spin_lock) from [<c013f790>] (find_lock_task_mm+0x9c/0x174)
>>
>> this is task_lock() which takes a sleeping lock.
>>
>>> [  100.287710] [<c013f790>] (find_lock_task_mm) from [<c00409ac>] (clear_tasks_mm_cpumask+0xb4/0x1ac)
>>> [  100.287720] [<c00409ac>] (clear_tasks_mm_cpumask) from [<c00166a4>] (__cpu_disable+0x98/0xbc)
>>> [  100.287728] [<c00166a4>] (__cpu_disable) from [<c06a2e8c>] (take_cpu_down+0x1c/0x50)
>>> [  100.287742] [<c06a2e8c>] (take_cpu_down) from [<c00f2600>] (multi_cpu_stop+0x11c/0x158)
>>> [  100.287754] [<c00f2600>] (multi_cpu_stop) from [<c00f2a9c>] (cpu_stopper_thread+0xc4/0x184)
>>
>> this function contains local_save_flags().
> 
> multi_cpu_stop:
> 	local_save_flags(flags);
> 
> 	if (!msdata->active_cpus)
> 		is_active = cpu == cpumask_first(cpu_online_mask);
> 	else
> 		is_active = cpumask_test_cpu(cpu, msdata->active_cpus);
> 
> 	/* Simple state machine */
> 	do {
> 		/* Chill out and ensure we re-read multi_stop_state. */
> 		cpu_relax();
> 		if (msdata->state != curstate) {
> 			curstate = msdata->state;
> 			switch (curstate) {
> 			case MULTI_STOP_DISABLE_IRQ:
> 				local_irq_disable();
> 				hard_irq_disable(); <==== Step 2 disable IRQs
> 				break;
> 			case MULTI_STOP_RUN:
> 				if (is_active)
> 					err = msdata->fn(msdata->data); ===> Step 3 take_cpu_down()
> 				break;
> 			default:
> 				break;
> 			}
> 			ack_state(msdata);
> 		}
> 	} while (curstate != MULTI_STOP_EXIT);
> 
> 	local_irq_restore(flags);
> 
>>
>>> [  100.287767] [<c00f2a9c>] (cpu_stopper_thread) from [<c0069058>] (smpboot_thread_fn+0x18c/0x324)
> 
> cpu_stopper_thread:
> 		preempt_disable();
> 
> 		ret = fn(arg); ===> multi_cpu_stop()
> 		if (ret)
> 			done->ret = ret;
> 
> 		preempt_enable();
> 
> 
>>> [  100.287779] [<c0069058>] (smpboot_thread_fn) from [<c00649c4>] (kthread+0xe8/0x104)
>>> [  100.287791] [<c00649c4>] (kthread) from [<c0010058>] (ret_from_fork+0x14/0x3c)
>>> [  100.288114] CPU1: shutdown
>>
>> The local_save_flags() should be probably replaced with something else.
>>
> 
> Below is list of clear_tasks_mm_cpumask() users:
> arch/arm/kernel/smp.c
>    int __cpu_disable(void)
>    216: clear_tasks_mm_cpumask(cpu);
> arch/arm64/kernel/smp.c
>    int __cpu_disable(void)
>    238: clear_tasks_mm_cpumask(cpu);
> arch/metag/kernel/smp.c
>    int __cpu_disable(void)
>    290: clear_tasks_mm_cpumask(cpu);
> 
> arch/powerpc/mm/mmu_context_nohash.c
> _cpu_down()
> + cpu_notify_nofail(CPU_DEAD | mod, hcpu);
>    + mmu_context_cpu_notify()
>      400: clear_tasks_mm_cpumask(cpu);
> 
> arch/sh/kernel/smp.c
>    int __cpu_disable(void)
>    155: clear_tasks_mm_cpumask(cpu);
> arch/xtensa/kernel/smp.c
>    int __cpu_disable(void)
>    279: clear_tasks_mm_cpumask(cpu);
> 
> As per above, in all case, except *powerpc*, the clear_tasks_mm_cpumask()
> is called from __cpu_disable() (atomic context).
> While in powerpc case it's called from  _cpu_down() (if I understand right,
> in non-atomic context).
> 

Below diff fixes issue for me. More over, with this change I can do
CPU1 plug/unplug many times and suspend/resume works much more stable
(before it stuck some times after "Disabling non-boot CPUs ...").

I'd very appreciated for comments.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3d6b782..20b5741 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -215,8 +215,6 @@ int __cpu_disable(void)
        flush_cache_louis();
        local_flush_tlb_all();
 
-       clear_tasks_mm_cpumask(cpu);

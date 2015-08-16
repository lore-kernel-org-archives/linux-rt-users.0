From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:917
Date: Sun, 16 Aug 2015 13:42:41 +0200
Message-ID: <20150816114241.GC7004@linutronix.de>
References: <55CB8FAE.9020309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50086 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbHPLmn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Aug 2015 07:42:43 -0400
Content-Disposition: inline
In-Reply-To: <55CB8FAE.9020309@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Grygorii Strashko | 2015-08-12 21:25:50 [+0300]:

>Hi All,
>
>I can constantly see below error report with RT-kernel on TI ARM dra7-evm 
>if I'm trying to do Suspend to RAM.

do you see the same problem on x86 with -RT?

> Disabling non-boot CPUs ...
> PM: noirq suspend of devices complete after 7.295 msecs
>[  100.285729] Disabling non-boot CPUs ...
>[  100.287575] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
>[  100.287580] in_atomic(): 1, irqs_disabled(): 128, pid: 18, name: migration/1
>[  100.287583] INFO: lockdep is turned off.
>[  100.287586] irq event stamp: 122
>[  100.287600] hardirqs last  enabled at (121): [<c06ac0ac>] _raw_spin_unlock_irqrestore+0x88/0x90
>[  100.287609] hardirqs last disabled at (122): [<c06abed0>] _raw_spin_lock_irq+0x28/0x5c
>[  100.287620] softirqs last  enabled at (0): [<c003d294>] copy_process.part.52+0x410/0x19d8
>[  100.287625] softirqs last disabled at (0): [<  (null)>]   (null)
>[  100.287630] Preemption disabled at:[<  (null)>]   (null)
>[  100.287631] 
>[  100.287639] CPU: 1 PID: 18 Comm: migration/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
>[  100.287642] Hardware name: Generic DRA74X (Flattened Device Tree)
>[  100.287659] [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
>[  100.287671] [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
>[  100.287681] [<c06a70f4>] (dump_stack) from [<c006cab8>] (___might_sleep+0x198/0x2a8)
>[  100.287689] [<c006cab8>] (___might_sleep) from [<c06ac4dc>] (rt_spin_lock+0x30/0x70)
>[  100.287699] [<c06ac4dc>] (rt_spin_lock) from [<c013f790>] (find_lock_task_mm+0x9c/0x174)

this is task_lock() which takes a sleeping lock.

>[  100.287710] [<c013f790>] (find_lock_task_mm) from [<c00409ac>] (clear_tasks_mm_cpumask+0xb4/0x1ac)
>[  100.287720] [<c00409ac>] (clear_tasks_mm_cpumask) from [<c00166a4>] (__cpu_disable+0x98/0xbc)
>[  100.287728] [<c00166a4>] (__cpu_disable) from [<c06a2e8c>] (take_cpu_down+0x1c/0x50)
>[  100.287742] [<c06a2e8c>] (take_cpu_down) from [<c00f2600>] (multi_cpu_stop+0x11c/0x158)
>[  100.287754] [<c00f2600>] (multi_cpu_stop) from [<c00f2a9c>] (cpu_stopper_thread+0xc4/0x184)

this function contains local_save_flags().

>[  100.287767] [<c00f2a9c>] (cpu_stopper_thread) from [<c0069058>] (smpboot_thread_fn+0x18c/0x324)
>[  100.287779] [<c0069058>] (smpboot_thread_fn) from [<c00649c4>] (kthread+0xe8/0x104)
>[  100.287791] [<c00649c4>] (kthread) from [<c0010058>] (ret_from_fork+0x14/0x3c)
>[  100.288114] CPU1: shutdown

The local_save_flags() should be probably replaced with something else. 

>regards,
>-grygorii

Sebastian

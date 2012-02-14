From: Tim Blechmann <tim@klingt.org>
Subject: Re: possible problem with sem_post
Date: Tue, 14 Feb 2012 19:51:46 +0100
Message-ID: <jheag2$26b$1@dough.gmane.org>
References: <201202131342.q1DDgG7p001794@klingt.org> <jhbor4$ngh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38309 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab2BNSwD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Feb 2012 13:52:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1RxNTq-0001zx-8H
	for linux-rt-users@vger.kernel.org; Tue, 14 Feb 2012 19:51:58 +0100
Received: from 85-127-90-215.dynamic.xdsl-line.inode.at ([85.127.90.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Feb 2012 19:51:58 +0100
Received: from tim by 85-127-90-215.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Feb 2012 19:51:58 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> i am experiencing a strange issue with lockups of my application. have
>> multiple high-priority real-time threads (as many threads as there are
>> physical cpus) and one of the threads seems to lock inside sem_post(). these
>> lookups only occur very rarely, after stressing the application (and the
>> semaphore) for a rather long time.
>> 
>> sem_post seems to call sys_futex with FUTEX_WAKE. this issue only occurred
>> recently after installing the 3.0 rt kernel (currently 3.0.20-rt35). but
>> haven't seen this behavior on any non-rt kernel (currently running another
>> stress-test). the machine is a thinkpad t410, x86_64.
>> 
>> if this is a problem of the rt-kernel, is there any way to debug it? or is it
>> in general unsafe to call sem_post from real-time threads?
> 
> ok, i ran the same test on a stock ubuntu kernel for a few hours without any
> problem.
> 
> the situation: 2 cpus, 2 high-priority SCHED_FIFO threads. several
> low-priority threads, one of them waiting for a semaphore, that is posted by
> the rt threads. my guess is that the low-priority thread acquires a spinlock
> but then gets preempted, but the high-priority thread waits for this spinlock
> ... is this possible?

for the record:

[  999.660730] BUG: sleeping function called from invalid context at kernel/rtmutex.c:646
[  999.660735] in_atomic(): 1, irqs_disabled(): 1, pid: 22, name: irq/9-acpi
[  999.660738] 1 lock held by irq/9-acpi/22:
[  999.660739]  #0:  (acpi_gbl_gpe_lock){......}, at: [<ffffffff812c2c1c>] acpi_ev_gpe_detect+0x2c/0x108
[  999.660752] irq event stamp: 84018
[  999.660753] hardirqs last  enabled at (84017): [<ffffffff8158bb5b>] _raw_spin_unlock_irq+0x2b/0x60
[  999.660761] hardirqs last disabled at (84018): [<ffffffff8158b974>] _raw_spin_lock_irqsave+0x24/0x70
[  999.660765] softirqs last  enabled at (0): [<ffffffff8104e1f4>] copy_process+0x6c4/0x1680
[  999.660772] softirqs last disabled at (0): [<          (null)>]           (null)
[  999.660776] Pid: 22, comm: irq/9-acpi Not tainted 3.0.20-rt36+ #76
[  999.660778] Call Trace:
[  999.660787]  [<ffffffff81085330>] ? print_irqtrace_events+0xd0/0xe0
[  999.660791]  [<ffffffff8103ec7a>] __might_sleep+0xea/0x120
[  999.660795]  [<ffffffff8158b1af>] rt_spin_lock+0x1f/0x60
[  999.660802]  [<ffffffff81108b13>] kmem_cache_alloc+0x83/0x210
[  999.660807]  [<ffffffff812b7cef>] ? acpi_ec_sync_query+0xbf/0xbf
[  999.660813]  [<ffffffff812b26db>] __acpi_os_execute+0x2c/0x10c
[  999.660817]  [<ffffffff812b27c6>] acpi_os_execute+0xb/0xd
[  999.660820]  [<ffffffff812b8389>] acpi_ec_gpe_handler+0x69/0x72
[  999.660824]  [<ffffffff812c2b77>] acpi_ev_gpe_dispatch+0xc0/0x139
[  999.660827]  [<ffffffff812c2ca0>] acpi_ev_gpe_detect+0xb0/0x108
[  999.660834]  [<ffffffff810ba070>] ? irq_thread_fn+0x50/0x50
[  999.660838]  [<ffffffff812c137d>] acpi_ev_sci_xrupt_handler+0x1d/0x26
[  999.660841]  [<ffffffff812b2831>] acpi_irq+0x11/0x2c
[  999.660845]  [<ffffffff810ba099>] irq_forced_thread_fn+0x29/0x70
[  999.660848]  [<ffffffff810b9fa2>] irq_thread+0x172/0x1f0
[  999.660853]  [<ffffffff810b9e30>] ? irq_finalize_oneshot+0x120/0x120
[  999.660858]  [<ffffffff810706fc>] kthread+0x9c/0xb0
[  999.660865]  [<ffffffff81592964>] kernel_thread_helper+0x4/0x10
[  999.660869]  [<ffffffff8103ea67>] ? finish_task_switch+0x87/0x110
[  999.660873]  [<ffffffff8158bfd8>] ? retint_restore_args+0x13/0x13
[  999.660877]  [<ffffffff81070660>] ? __init_kthread_worker+0xa0/0xa0
[  999.660881]  [<ffffffff81592960>] ? gs_change+0x13/0x13

thnx, tim



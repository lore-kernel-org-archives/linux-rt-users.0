From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: AW: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Fri, 21 Dec 2012 09:55:45 -0500
Message-ID: <1356101745.5896.102.camel@gandalf.local.home>
References: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
	 <alpine.LFD.2.02.1212201856140.3148@ionos>
	 <F9467A784CC48947B1D879F07370839E0EBCEE96@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jan Kiszka <jan.kiszka@web.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5796 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2LUOzr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 09:55:47 -0500
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBCEE96@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-21 at 08:23 +0000, Koehrer Mathias (ETAS/ESS2) wrote:

> > That's an indicator that something is really wrong. Can you just run
> > the same crap on a non-rt kernel with CONFIG_PROVE_LOCKING enabled ?
> 
> I did. It shows actually an error.
> Here is the relevant dmesg output:
> 
> --------------- BEGIN dmesg output -----------------
> vboxdrv: Found 4 processor cores.
> vboxdrv: fAsync=0 offMin=0x50c offMax=0x5940
> 
> =================================
> [ INFO: inconsistent lock state ]
> 3.2.34-2 #1
> ---------------------------------
> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>  (&(&pThis->Spinlock)->rlock){?.+...}, at: [<f883c7a9>] VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
> {HARDIRQ-ON-W} state was registered at:
>   [<c104b99a>] __lock_acquire+0x509/0x1337
>   [<c104cb3a>] lock_acquire+0x42/0x59
>   [<c13204d5>] _raw_spin_lock+0x25/0x34
>   [<f883c7b3>] VBoxHost_RTSpinlockAcquire+0x1f/0x24 [vboxdrv]
>   [<f883986f>] VBoxHost_RTMpNotificationRegister+0x36/0x11a [vboxdrv]
>   [<f88324f8>] supdrvInitDevExt+0x4f4/0x65c [vboxdrv]
>   [<f8868053>] VBoxDrvLinuxInit+0x53/0xcd [vboxdrv]
>   [<c100106b>] do_one_initcall+0x6b/0x10c
>   [<c1054299>] sys_init_module+0x122f/0x13fa
>   [<c1321990>] sysenter_do_call+0x12/0x36
> irq event stamp: 278096
> hardirqs last  enabled at (278093): [<c1007c3a>] mwait_idle+0x57/0x7c
> hardirqs last disabled at (278094): [<c1320f34>] call_function_interrupt+0x28/0x34
> softirqs last  enabled at (278096): [<c102e3db>] _local_bh_enable+0xd/0xf
> softirqs last disabled at (278095): [<c102e7a8>] irq_enter+0x29/0x4e
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&(&pThis->Spinlock)->rlock);
>   <Interrupt>
>     lock(&(&pThis->Spinlock)->rlock);
> 
>  *** DEADLOCK ***

So this is an obvious bug in virtualbox. No need to send us a config.
This bug has nothing to do with RT. It's just that RT can expose bugs in
mainline (or anything added to mainline) much easier.

Funny thing is, this deadlock isn't even possible in RT, so there's
probably many more bugs in the virtualbox driver.

-- Steve

> 
> no locks held by swapper/1/0.
> 
> stack backtrace:
> Pid: 0, comm: swapper/1 Tainted: G           O 3.2.34-2 #1
> Call Trace:
>  [<c131c0bb>] print_usage_bug.part.27+0x1f0/0x1fa
>  [<c104b313>] mark_lock+0x334/0x4b2
>  [<c104a95b>] ? check_usage_backwards+0xce/0xce
>  [<c104b92d>] __lock_acquire+0x49c/0x1337
>  [<c104cb3a>] lock_acquire+0x42/0x59
>  [<f883c7a9>] ? VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
>  [<c1320583>] _raw_spin_lock_irqsave+0x2e/0x3e
>  [<f883c7a9>] ? VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
>  [<f883c7a9>] VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
>  [<f8831d69>] ? supdrvGipMpEventOnline+0x14d/0x14d [vboxdrv]
>  [<f8831c77>] supdrvGipMpEventOnline+0x5b/0x14d [vboxdrv]
>  [<f8831d69>] ? supdrvGipMpEventOnline+0x14d/0x14d [vboxdrv]
>  [<f8831d77>] supdrvGipInitOnCpu+0xe/0x10 [vboxdrv]
>  [<f883b688>] rtmpLinuxWrapper+0x22/0x2d [vboxdrv]
>  [<f883b666>] ? VBoxHost_RTMpCpuId+0xa/0xa [vboxdrv]
>  [<c1051253>] generic_smp_call_function_interrupt+0x6b/0x112
>  [<c1014595>] smp_call_function_interrupt+0x20/0x2e
>  [<c1320f3b>] call_function_interrupt+0x2f/0x34
>  [<c104007b>] ? __run_hrtimer.isra.28+0x33/0x9e
>  [<c1007c42>] ? mwait_idle+0x5f/0x7c
>  [<c10014c2>] cpu_idle+0x4d/0x76
>  [<c14ff2e8>] start_secondary+0x1ab/0x1b2
> vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
> vboxdrv: Successfully loaded version 4.2.4 (interface 0x001a0004).
> vboxpci: pci-stub module not available, cannot detach PCI devices
> vboxpci: IOMMU not found (not compiled)
> --------------- END dmesg output -----------------
> 
> I attached the kernel configuration used for this test.
> 
> Thanks for the support.
> 
> Regards and merry Christmas.
> 
> Mathias
> 



From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT v2] kernel/res_counter.c: Change lock of struct
 res_counter to raw_spinlock_t
Date: Fri, 13 Feb 2015 16:30:17 -0500
Message-ID: <20150213213016.GC7102@windriver.com>
References: <1420745917-50747-1-git-send-email-tmac@hp.com>
 <1422644389-33074-1-git-send-email-tmac@hp.com>
 <20150213191909.GA8299@windriver.com>
 <54DE6AD5.9070000@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thavatchai Makphaibulchoke <tmac@hp.com>, <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54DE6AD5.9070000@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Re: [PATCH RT v2] kernel/res_counter.c: Change lock of struct res_counter to raw_spinlock_t] On 13/02/2015 (Fri 14:21) Thavatchai Makphaibulchoke wrote:

> 
> 
> On 02/13/2015 12:19 PM, Paul Gortmaker wrote:
> > 
> > I think there is more to this issue than just a lock conversion.
> > Firstly, if we look at the existing -rt patches, we've got the old
> > patch from ~2009 that is:
> > 
> 
> Thanks Paul for testing and reporting the problem.
> 
> Yes, looks like the issue probably involve more than converting to a
> raw_spinlock_t.
> 
> >  From: Ingo Molnar <mingo@elte.hu>
> >  Date: Fri, 3 Jul 2009 08:44:33 -0500
> >  Subject: [PATCH] core: Do not disable interrupts on RT in res_counter.c
> > 
> > which changed the local_irq_save to local_irq_save_nort in order to
> > avoid such a raw lock conversion.
> > 
> 
> The patch did not quite state explicitly that the fix was to avoid raw
> lock conversion.  I guess one could infer so.

Yes, it is kind of the implicit choice ; don't disable interrupts, or
don't use a sleeping lock.

> 
> Anyway as the patch also mentioned, the code needs a second look.
> 
> I'll try to see if I could rework my patch.
> 
> > Also, when I test this patch on a larger machine with lots of cores, I
> > get boot up issues (general protection fault while trying to access the
> > raw lock) or RCU stalls that trigger broadcast NMI backtraces; both which
> > implicate the same code area, and they go away with a revert.
> > 
> 
> Could you please let me know how many cores/threads you are running.

Interestingly, when I did a quick sanity test on a core2-duo (~5year old
desktop) it seemed fine.  Only on the larger machine did it really go
pear shaped.  That machine looks like this:

root@yow-intel-canoe-pass-4-21774:~# cat /proc/cpuinfo |grep name|uniq
model name      : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz
root@yow-intel-canoe-pass-4-21774:~# cat /proc/cpuinfo |grep name|wc -l
20
root@yow-intel-canoe-pass-4-21774:~#

> 
> Could you please also send me a stack trace for the protection fault
> problem, if available.

I rebooted several times and the rcu fail seemed to be the most common
fail.  The machine was writing logs to /var/volatile so I don't have
a saved copy of that one :(  -- if time permits I'll have a go at
rebooting a few more times with the patch to see if I can capture it.

Paul.
--

> 
> Thanks again for reporting the problem.
> 
> Thanks,
> Mak.
> 
> 
> > Stuff like the below. Figured I'd better mention it since Steve was
> > talking about rounding up patches for stable, and the solution to the
> > original problem reported here seems to need to be revisited.
> > 
> > Paul.
> > --
> > 
> > 
> > [   38.615736] NMI backtrace for cpu 15
> > [   38.615739] CPU: 15 PID: 835 Comm: ovirt-engine.py Not tainted 3.14.33-rt28-WR7.0.0.0_ovp+ #3
> > [   38.615740] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
> > [   38.615742] task: ffff880faca80000 ti: ffff880f9d890000 task.ti: ffff880f9d890000
> > [   38.615751] RIP: 0010:[<ffffffff810820a1>]  [<ffffffff810820a1>] preempt_count_add+0x41/0xb0
> > [   38.615752] RSP: 0018:ffff880ffd5e3d00  EFLAGS: 00000097
> > [   38.615754] RAX: 0000000000010002 RBX: 0000000000000001 RCX: 0000000000000000
> > [   38.615755] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000001
> > [   38.615756] RBP: ffff880ffd5e3d08 R08: ffffffff82317700 R09: 0000000000000028
> > [   38.615757] R10: 000000000000000f R11: 0000000000017484 R12: 0000000000044472
> > [   38.615758] R13: 000000000000000f R14: 00000000c42caa68 R15: 0000000000000010
> > [   38.615760] FS:  00007effa30c2700(0000) GS:ffff880ffd5e0000(0000) knlGS:0000000000000000
> > [   38.615761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   38.615762] CR2: 00007f19e3c29320 CR3: 0000000f9f9a3000 CR4: 00000000001407e0
> > [   38.615763] Stack:
> > [   38.615765]  00000000c42caa20 ffff880ffd5e3d38 ffffffff8140e524 0000000000001000
> > [   38.615767]  00000000000003e9 0000000000000400 0000000000000002 ffff880ffd5e3d48
> > [   38.615769]  ffffffff8140e43f ffff880ffd5e3d58 ffffffff8140e477 ffff880ffd5e3d78
> > [   38.615769] Call Trace:
> > [   38.615771]  <IRQ>
> > [   38.615779]  [<ffffffff8140e524>] delay_tsc+0x44/0xd0
> > [   38.615782]  [<ffffffff8140e43f>] __delay+0xf/0x20
> > [   38.615784]  [<ffffffff8140e477>] __const_udelay+0x27/0x30
> > [   38.615788]  [<ffffffff810355da>] native_safe_apic_wait_icr_idle+0x2a/0x60
> > [   38.615792]  [<ffffffff81036c80>] default_send_IPI_mask_sequence_phys+0xc0/0xe0
> > [   38.615798]  [<ffffffff8103a5f7>] physflat_send_IPI_all+0x17/0x20
> > [   38.615801]  [<ffffffff81036e80>] arch_trigger_all_cpu_backtrace+0x70/0xb0
> > [   38.615807]  [<ffffffff810b4d41>] rcu_check_callbacks+0x4f1/0x840
> > [   38.615814]  [<ffffffff8105365e>] ? raise_softirq_irqoff+0xe/0x40
> > [   38.615821]  [<ffffffff8105cc52>] update_process_times+0x42/0x70
> > [   38.615826]  [<ffffffff810c0336>] tick_sched_handle.isra.15+0x36/0x50
> > [   38.615829]  [<ffffffff810c0394>] tick_sched_timer+0x44/0x70
> > [   38.615835]  [<ffffffff8107598b>] __run_hrtimer+0x9b/0x2a0
> > [   38.615838]  [<ffffffff810c0350>] ? tick_sched_handle.isra.15+0x50/0x50
> > [   38.615842]  [<ffffffff81076cbe>] hrtimer_interrupt+0x12e/0x2e0
> > [   38.615845]  [<ffffffff810352c7>] local_apic_timer_interrupt+0x37/0x60
> > [   38.615851]  [<ffffffff81a376ef>] smp_apic_timer_interrupt+0x3f/0x50
> > [   38.615854]  [<ffffffff81a3664a>] apic_timer_interrupt+0x6a/0x70
> > [   38.615855]  <EOI>
> > [   38.615861]  [<ffffffff810dc604>] ? __res_counter_charge+0xc4/0x170
> > [   38.615866]  [<ffffffff81a34487>] ? _raw_spin_lock+0x47/0x60
> > [   38.615882]  [<ffffffff81a34457>] ? _raw_spin_lock+0x17/0x60
> > [   38.615885]  [<ffffffff810dc604>] __res_counter_charge+0xc4/0x170
> > [   38.615888]  [<ffffffff810dc6c0>] res_counter_charge+0x10/0x20
> > [   38.615896]  [<ffffffff81186645>] vm_cgroup_charge_shmem+0x35/0x50
> > [   38.615900]  [<ffffffff8113a686>] shmem_getpage_gfp+0x4b6/0x8e0
> > [   38.615904]  [<ffffffff8108201d>] ? get_parent_ip+0xd/0x50
> > [   38.615908]  [<ffffffff8113b626>] shmem_symlink+0xe6/0x210
> > [   38.615914]  [<ffffffff81195361>] ? __inode_permission+0x41/0xd0
> > [   38.615917]  [<ffffffff811961f0>] vfs_symlink+0x90/0xd0
> > [   38.615923]  [<ffffffff8119a762>] SyS_symlinkat+0x62/0xc0
> > [   38.615927]  [<ffffffff8119a7d6>] SyS_symlink+0x16/0x20
> > [   38.615930]  [<ffffffff81a359d6>] system_call_fastpath+0x1a/0x1f
> > 
> > 

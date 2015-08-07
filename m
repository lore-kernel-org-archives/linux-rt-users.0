From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Fri, 7 Aug 2015 08:42:23 +0200
Message-ID: <55C4534F.9040409@bmw-carit.de>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <paul.gortmaker@windriver.com>, <peterz@infradead.org>,
	<bigeasy@linutronix.de>, <tglx@linutronix.de>,
	<paulmck@linux.vnet.ibm.com>, <rostedt@goodmis.org>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:39341 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbbHGGsB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2015 02:48:01 -0400
In-Reply-To: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/2015 03:30 PM, Daniel Wagner wrote:
> My test system didn't crash or showed any obvious defects, so I
> decided to apply some benchmarks utilizing mmtests. I have picked some

As it turns out, this is not really true. I forgot to enable lockdep:

[    0.053193] =================================
[    0.053490] [ INFO: inconsistent lock state ]
[    0.053790] 4.2.0-rc5-00022-g6d2f78c #63 Not tainted
[    0.054000] ---------------------------------
[    0.054000] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[    0.054000] rcu_preempt/7 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    0.054000]  (rcu_node_0){+.?...}, at: [<ffffffff81133643>] rcu_gp_kthread+0xfe3/0x2390
[    0.054000] {IN-SOFTIRQ-W} state was registered at:
[    0.054000]   [<ffffffff81108a6c>] __lock_acquire+0xbfc/0x2050
[    0.054000]   [<ffffffff8110acbf>] lock_acquire+0xdf/0x2b0
[    0.054000]   [<ffffffff81913b19>] _raw_spin_lock_irqsave+0x59/0xa0
[    0.054000]   [<ffffffff811357e9>] rcu_process_callbacks+0x109/0xf00
[    0.054000]   [<ffffffff810b195d>] __do_softirq+0x14d/0x670
[    0.054000]   [<ffffffff810b20d1>] irq_exit+0x101/0x110
[    0.054000]   [<ffffffff81916d16>] smp_apic_timer_interrupt+0x46/0x60
[    0.054000]   [<ffffffff81914cf0>] apic_timer_interrupt+0x70/0x80
[    0.054000]   [<ffffffff814d7a97>] vsnprintf+0x367/0x530
[    0.054000]   [<ffffffff814d7d03>] snprintf+0x43/0x60
[    0.054000]   [<ffffffff810d90cf>] register_sched_domain_sysctl+0xdf/0x670
[    0.054000]   [<ffffffff8217c74d>] sched_init_smp+0x524/0x5d7
[    0.054000]   [<ffffffff8215a1e8>] kernel_init_freeable+0x171/0x28f
[    0.054000]   [<ffffffff818fe3be>] kernel_init+0xe/0xe0
[    0.054000]   [<ffffffff8191419f>] ret_from_fork+0x3f/0x70
[    0.054000] irq event stamp: 46
[    0.054000] hardirqs last  enabled at (45): [<ffffffff819131a0>] _raw_spin_unlock_irq+0x30/0x60
[    0.054000] hardirqs last disabled at (46): [<ffffffff81912ebf>] _raw_spin_lock_irq+0x1f/0x90
[    0.054000] softirqs last  enabled at (0): [<ffffffff810a8c98>] copy_process.part.26+0x628/0x1ce0
[    0.054000] softirqs last disabled at (0): [<          (null)>]           (null)
[    0.054000] 
[    0.054000] other info that might help us debug this:
[    0.054000]  Possible unsafe locking scenario:
[    0.054000] 
[    0.054000]        CPU0
[    0.054000]        ----
[    0.054000]   lock(rcu_node_0);
[    0.054000]   <Interrupt>
[    0.054000]     lock(rcu_node_0);
[    0.054000] 
[    0.054000]  *** DEADLOCK ***
[    0.054000] 
[    0.054000] 1 lock held by rcu_preempt/7:
[    0.054000]  #0:  (rcu_node_0){+.?...}, at: [<ffffffff81133643>] rcu_gp_kthread+0xfe3/0x2390
[    0.054000] 
[    0.054000] stack backtrace:
[    0.054000] CPU: 0 PID: 7 Comm: rcu_preempt Not tainted 4.2.0-rc5-00022-g6d2f78c #63
[    0.054000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[    0.054000]  0000000000000000 00000000be272de7 ffff88007c0e7b98 ffffffff81908ed7
[    0.054000]  0000000000000000 ffff88007c0e8000 ffff88007c0e7bf8 ffffffff81107195
[    0.054000]  0000000000000000 ffff880000000001 ffff880000000001 ffffffff8102fa9f
[    0.054000] Call Trace:
[    0.054000]  [<ffffffff81908ed7>] dump_stack+0x4f/0x7b
[    0.054000]  [<ffffffff81107195>] print_usage_bug+0x215/0x240
[    0.054000]  [<ffffffff8102fa9f>] ? save_stack_trace+0x2f/0x50
[    0.054000]  [<ffffffff81107767>] mark_lock+0x5a7/0x670
[    0.054000]  [<ffffffff811066d0>] ? check_usage_forwards+0x150/0x150
[    0.054000]  [<ffffffff811078ad>] mark_held_locks+0x7d/0xb0
[    0.054000]  [<ffffffff819131a0>] ? _raw_spin_unlock_irq+0x30/0x60
[    0.054000]  [<ffffffff81107a48>] trace_hardirqs_on_caller+0x168/0x220
[    0.054000]  [<ffffffff81107b0d>] trace_hardirqs_on+0xd/0x10
[    0.054000]  [<ffffffff819131a0>] _raw_spin_unlock_irq+0x30/0x60
[    0.054000]  [<ffffffff810fc0bb>] swake_up_all+0xbb/0xe0
[    0.054000]  [<ffffffff811336cd>] rcu_gp_kthread+0x106d/0x2390
[    0.054000]  [<ffffffff819131a0>] ? _raw_spin_unlock_irq+0x30/0x60
[    0.054000]  [<ffffffff8190c575>] ? __schedule+0x885/0x9e0
[    0.054000]  [<ffffffff810d2329>] ? kthread+0xd9/0x120
[    0.054000]  [<ffffffff81132660>] ? rcu_barrier+0x20/0x20
[    0.054000]  [<ffffffff810d2354>] kthread+0x104/0x120
[    0.054000]  [<ffffffff819131a0>] ? _raw_spin_unlock_irq+0x30/0x60
[    0.054000]  [<ffffffff810d2250>] ? kthread_create_on_node+0x260/0x260
[    0.054000]  [<ffffffff8191419f>] ret_from_fork+0x3f/0x70
[    0.054000]  [<ffffffff810d2250>] ? kthread_create_on_node+0x260/0x260

If I decoded this correctly the call to rcu_future_gp_cleanup() is
supposed to run with IRQs disabled. swake_up_all() though will reenable the
IRQs:

rcu_gp_cleanup() 
	rcu_for_each_node_breadth_first(rsp, rnp) {
		raw_spin_lock_irq(&rnp->lock);

		nocb += rcu_future_gp_cleanup(rsp, rnp);
		raw_spin_unlock_irq(&rnp->lock);
	}

rcu_future_gp_cleanup()
	rcu_nocb_gp_cleanup()
		swake_up_all()


With IRQs enabled again and we end up in rcu_process_callbacks
under SOFTIRQ. rcu_process_callbacks aquires the RCU lock again.

Not sure what to do here.

cheers,
daniel
      



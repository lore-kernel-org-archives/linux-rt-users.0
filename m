From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Wed, 4 Jul 2012 10:15:20 -0300
Message-ID: <20120704131520.GH9200@uudg.org>
References: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60BC983@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: PRINGLE Chris <chris.pringle@miranda.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64344 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab2GDNVu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jul 2012 09:21:50 -0400
Received: by yenl2 with SMTP id l2so6413927yen.19
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Jul 2012 06:21:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, Jul 04, 2012 at 12:55:17PM +0000, PRINGLE Chris wrote:
| Is anyone able to give the test driver demonstrating the problem a try? If more information is needed please let me know and I'll try and supply it. All you need is a Linux kernel with full preemption enabled and you'll see the issue with my test driver.
| 
| Thanks,
| Chris

Yes, I was able to reproduce the issue on 3.4.4-rt13. I ran a few tests
under ftrace and got a bit more of information.

The problem seems to happen in kmem_cache_free(), at this piece of code:

        local_lock_irqsave(slab_lock, flags);
        __cache_free(cachep, objp, __builtin_return_address(0));
        unlock_slab_and_free_delayed(flags);

It seems to fail at the local_lock_irqsave() statement with:

	[  149.328013] kernel BUG at kernel/rtmutex.c:725!
	[  149.328013] invalid opcode: 0000 [#1] PREEMPT SMP

And by the end I see:

	[  149.420228] note: insmod[2801] exited with preempt_count 1

Here it is the ftrace log followed by the backtrace:

[  149.262424] Creating
[  149.264768] Allocating
[  149.306679] Freeing
[  149.324816] Shrinking
[  149.327237] ------------[ cut here ]------------


[  149.328013]   insmod-2801    1..... 49497848us : kmem_cache_shrink <-test_func
[  149.328013]   insmod-2801    1..... 49497849us : get_online_cpus <-kmem_cache_shrink
[  149.328013]   insmod-2801    1..... 49497850us : rt_spin_lock <-get_online_cpus
[  149.328013]   insmod-2801    1..... 49497850us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1..... 49497850us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...1. 49497851us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...1. 49497851us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...1. 49497852us : _raw_spin_unlock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1..... 49497853us : rt_spin_unlock <-get_online_cpus
[  149.328013]   insmod-2801    1..... 49497853us : rt_spin_lock_slowunlock <-rt_spin_unlock
[  149.328013]   insmod-2801    1..... 49497854us : _raw_spin_lock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1...1. 49497854us : _raw_spin_unlock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1..... 49497855us : _mutex_lock <-kmem_cache_shrink
[  149.328013]   insmod-2801    1..... 49497855us : rt_mutex_lock <-_mutex_lock
[  149.328013]   insmod-2801    1..... 49497856us : rt_mutex_slowlock <-rt_mutex_lock
[  149.328013]   insmod-2801    1..... 49497856us : _raw_spin_lock <-rt_mutex_slowlock
[  149.328013]   insmod-2801    1...1. 49497857us : __try_to_take_rt_mutex <-rt_mutex_slowlock
[  149.328013]   insmod-2801    1...1. 49497857us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...1. 49497858us : _raw_spin_unlock <-rt_mutex_slowlock
[  149.328013]   insmod-2801    1..... 49497858us : __cache_shrink <-kmem_cache_shrink
[  149.328013]   insmod-2801    1..... 49497859us : do_drain <-__cache_shrink
[  149.328013]   insmod-2801    1..... 49497859us : migrate_disable <-do_drain
[  149.328013]   insmod-2801    1...1. 49497860us : pin_current_cpu <-migrate_disable
[  149.328013]   insmod-2801    1....1 49497860us : rt_spin_lock <-do_drain
[  149.328013]   insmod-2801    1....1 49497860us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1....1 49497860us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...11 49497861us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...11 49497862us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...11 49497862us : _raw_spin_unlock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1....1 49497863us : migrate_disable <-do_drain
[  149.328013]   insmod-2801    1....2 49497863us : rt_spin_lock <-do_drain
[  149.328013]   insmod-2801    1....2 49497863us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1....2 49497864us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...12 49497864us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...12 49497865us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...12 49497865us : _raw_spin_unlock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1....2 49497866us : free_block <-do_drain
[  149.328013]   insmod-2801    1....2 49497866us : rt_spin_unlock <-do_drain
[  149.328013]   insmod-2801    1....2 49497867us : rt_spin_lock_slowunlock <-rt_spin_unlock
[  149.328013]   insmod-2801    1....2 49497867us : _raw_spin_lock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1...12 49497867us : _raw_spin_unlock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1....2 49497868us : migrate_enable <-do_drain
[  149.328013]   insmod-2801    1....1 49497868us : rt_spin_unlock <-do_drain
[  149.328013]   insmod-2801    1....1 49497869us : rt_spin_lock_slowunlock <-rt_spin_unlock
[  149.328013]   insmod-2801    1....1 49497869us : _raw_spin_lock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1...11 49497870us : _raw_spin_unlock <-rt_spin_lock_slowunlock
[  149.328013]   insmod-2801    1....1 49497870us : migrate_enable <-do_drain
[  149.328013]   insmod-2801    1...1. 49497871us : unpin_current_cpu <-migrate_enable
[  149.328013]   insmod-2801    1..... 49497871us : free_delayed <-do_drain
[  149.328013]   insmod-2801    1..... 49497871us : do_drain <-__cache_shrink
[  149.328013]   insmod-2801    1..... 49497872us : migrate_disable <-do_drain
[  149.328013]   insmod-2801    1...1. 49497872us : pin_current_cpu <-migrate_disable
[  149.328013]   insmod-2801    1....1 49497872us : rt_spin_lock <-do_drain
[  149.328013]   insmod-2801    1....1 49497873us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1....1 49497873us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...11 49497873us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...11 49497874us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...11 49497874us : _raw_spin_unlock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1....1 49497875us : migrate_disable <-do_drain
[  149.328013]   insmod-2801    1....2 49497875us : rt_spin_lock <-do_drain
[  149.328013]   insmod-2801    1....2 49497875us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1....2 49497876us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...12 49497876us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...12 49497877us : rt_mutex_set_owner <-__try_to_take_rt_mutex
[  149.328013]   insmod-2801    1...12 49497877us : _raw_spin_unlock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1....2 49497878us : free_block <-do_drain
[  149.328013]   insmod-2801    1....2 49497878us : __phys_addr <-virt_to_head_page
[  149.328013]   insmod-2801    1....2 49497879us : slab_destroy <-free_block
[  149.328013]   insmod-2801    1....2 49497879us : kmem_freepages <-slab_destroy
[  149.328013]   insmod-2801    1....2 49497879us : __phys_addr <-kmem_freepages
[  149.328013]   insmod-2801    1....2 49497879us : mod_zone_page_state <-kmem_freepages
[  149.328013]   insmod-2801    1....2 49497880us : kmem_cache_free <-slab_destroy
[  149.328013]   insmod-2801    1....2 49497880us : migrate_disable <-kmem_cache_free
[  149.328013]   insmod-2801    1....3 49497881us : migrate_disable <-__local_lock_irq
[  149.328013]   insmod-2801    1....4 49497881us : rt_spin_lock <-__local_lock_irq
[  149.328013]   insmod-2801    1....4 49497881us : rt_spin_lock_slowlock <-rt_spin_lock
[  149.328013]   insmod-2801    1....4 49497882us : _raw_spin_lock <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1...14 49497882us : __try_to_take_rt_mutex <-rt_spin_lock_slowlock
[  149.328013]   insmod-2801    1d..14 49497883us : do_invalid_op <-invalid_op
[  149.328013]   insmod-2801    1d..14 49497883us : atomic_notifier_call_chain <-notify_die
[  149.328013]   insmod-2801    1d..14 49497883us : __atomic_notifier_call_chain <-atomic_notifier_call_chain
[  149.328013]   insmod-2801    1d..14 49497884us : __rcu_read_lock <-__atomic_notifier_call_chain
[  149.328013]   insmod-2801    1d..14 49497884us : notifier_call_chain <-__atomic_notifier_call_chain
[  149.328013]   insmod-2801    1d..14 49497885us : hw_breakpoint_exceptions_notify <-notifier_call_chain
[  149.328013]   insmod-2801    1d..14 49497886us : kprobe_exceptions_notify <-notifier_call_chain
[  149.328013]   insmod-2801    1d..14 49497886us : __rcu_read_unlock <-__atomic_notifier_call_chain
[  149.328013]   insmod-2801    1...14 49497887us : do_trap <-do_invalid_op
[  149.328013]   insmod-2801    1...14 49497887us : fixup_exception <-do_trap
[  149.328013]   insmod-2801    1...14 49497888us : search_exception_tables <-fixup_exception
[  149.328013]   insmod-2801    1...14 49497889us : search_module_extables <-search_exception_tables
[  149.328013]   insmod-2801    1...14 49497895us : die <-do_trap
[  149.328013]   insmod-2801    1...14 49497896us : oops_begin <-die
[  149.328013]   insmod-2801    1...14 49497896us : oops_enter <-oops_begin
[  149.328013] ---------------------------------
[  149.328013] kernel BUG at kernel/rtmutex.c:725!
[  149.328013] invalid opcode: 0000 [#1] PREEMPT SMP 
[  149.328013] CPU 1 
[  149.328013] Modules linked in: lookaside_cache_BUG_reproducer_ftrace(O+) ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat ipta]
[  149.328013] 
[  149.328013] Pid: 2801, comm: insmod Tainted: G           O 3.4.4-rt13+ #53 LENOVO 8810A56/LENOVO
[  149.328013] RIP: 0010:[<ffffffff813e0df1>]  [<ffffffff813e0df1>] rt_spin_lock_slowlock+0x80/0x287
[  149.328013] RSP: 0018:ffff880075d5fb58  EFLAGS: 00010246
[  149.328013] RAX: ffff880076d21c00 RBX: ffff88007edce6c0 RCX: 0000000000000001
[  149.328013] RDX: ffff880076d21c01 RSI: ffff880076d21c00 RDI: ffff88007edce6c0
[  149.328013] RBP: ffff880075d5fc38 R08: 0000000000000000 R09: ffffffff813e0db9
[  149.328013] R10: ffff88007f6ab800 R11: ffff88007f6ab800 R12: ffff880076d21c00
[  149.328013] R13: 00000000001ce6c0 R14: ffff880075d5fb88 R15: ffff88003742cc90
[  149.328013] FS:  00007fedbd024700(0000) GS:ffff88007ec00000(0000) knlGS:0000000000000000
[  149.328013] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  149.328013] CR2: 00007fadc5862e30 CR3: 0000000077285000 CR4: 00000000000007e0
[  149.328013] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.328013] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  149.328013] Process insmod (pid: 2801, threadinfo ffff880075d5e000, task ffff880076d21c00)
[  149.328013] Stack:
[  149.328013]  ffffffff8110468f ffffffff813e1433 ffff880075d5fb88 ffffffff810a9c0a
[  149.328013]  0000000000000000 ffff880077181a30 111111110000008c ffff880075d5fb90
[  149.328013]  ffff880075d5fb90 ffff880075d5fba0 ffff880075d5fba0 111111110000008c
[  149.328013] Call Trace:
[  149.328013]  [<ffffffff8110468f>] ? __local_lock_irq+0x22/0x75
[  149.328013]  [<ffffffff813e1433>] ? rt_spin_lock+0x9/0x40
[  149.328013]  [<ffffffff810a9c0a>] ? ring_buffer_unlock_commit+0x39/0x5e
[  149.328013]  [<ffffffff813e1440>] rt_spin_lock+0x16/0x40
[  149.328013]  [<ffffffff8110468f>] __local_lock_irq+0x22/0x75
[  149.328013]  [<ffffffff811046fd>] __local_lock_irqsave+0x1b/0x2d
[  149.328013]  [<ffffffff81105782>] kmem_cache_free+0x3e/0xa4
[  149.328013]  [<ffffffff8110583e>] slab_destroy+0x56/0x5b
[  149.328013]  [<ffffffff81105298>] free_block+0xb8/0x100
[  149.328013]  [<ffffffff81105c14>] do_drain+0x92/0xf7
[  149.328013]  [<ffffffff81107c94>] __cache_shrink+0x28/0x158
[  149.328013]  [<ffffffff813e1595>] ? _mutex_lock+0x3c/0x43
[  149.328013]  [<ffffffff81107e12>] kmem_cache_shrink+0x4e/0x6c
[  149.328013]  [<ffffffffa001211d>] test_func+0x11d/0x148 [lookaside_cache_BUG_reproducer_ftrace]
[  149.328013]  [<ffffffffa001c000>] ? 0xffffffffa001bfff
[  149.328013]  [<ffffffffa001c009>] test_init+0x9/0x1b [lookaside_cache_BUG_reproducer_ftrace]
[  149.328013]  [<ffffffff81000241>] do_one_initcall+0x7f/0x136
[  149.328013]  [<ffffffff81080a30>] sys_init_module+0x15f7/0x1877
[  149.328013]  [<ffffffff813e7ca9>] system_call_fastpath+0x16/0x1b
[  149.328013] Code: 00 00 4c 89 e6 48 89 df e8 ce 8d c9 ff 85 c0 74 0d 48 89 df e8 1b 10 00 00 e9 02 02 00 00 48 8b 43 58 48 83 e0 fe  
[  149.328013] RIP  [<ffffffff813e0df1>] rt_spin_lock_slowlock+0x80/0x287
[  149.328013]  RSP <ffff880075d5fb58>
[  149.420215] ---[ end trace 0000000000000002 ]---
[  149.420228] note: insmod[2801] exited with preempt_count 1

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]


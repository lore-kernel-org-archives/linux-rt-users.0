From: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: schedule under irqs_disabled in SLUB problem
Date: Wed, 1 Nov 2017 14:31:18 +0300
Message-ID: <59F9B086.6010202@mcst.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tretyak2.mcst.ru ([80.84.125.22]:41929 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753593AbdKALgo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Nov 2017 07:36:44 -0400
Received: from frog.lab.sun.mcst.ru (root@frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (8.13.4/8.12.11) with ESMTP id vA1BVQ5F011981
        for <linux-rt-users@vger.kernel.org>; Wed, 1 Nov 2017 14:31:34 +0300
Received: from [192.168.1.7] (e2k7.lab.sun.mcst.ru [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id vA1BVJkq018053
        for <linux-rt-users@vger.kernel.org>; Wed, 1 Nov 2017 14:31:19 +0300
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello! I have a problem on kernel 3.14.79-rt85 and I don't know, if it's 
solved on current kernel or, may be, it's our additions problem. Could 
you help me, please?

Kernel is broken in migrate_enable():
         WARN_ON_ONCE(p->migrate_disable <= 0);

I have a trace, where I see, that it happened, because few 
migrate_disable() were called under irqs_disabled (migrate_disable 
counter wasn't changed). But after schedule() call irqs were enabled and 
the following migrate_disable() and migrate_enable() changed 
migrate_disable counter. I suppose, that problem is schedule() call 
under irqs_disabled. There is a stack:
PROCESS: kworker/u8:4, PID: 744, CPU: 3, state: R oncpu (0x0), flags: 
0x4208060
  ---------------------------------------------------------------------
IP (hex) FILENAME PROCEDURE
---------------------------------------------------------------------
e200020e0700 <kernel> __schedule+0x1b60/0x1f90
e200020e0da8 <kernel> schedule+0x278/0x2e8
e200020e8a68 <kernel> rt_spin_lock_slowlock+0x740/0x15c8
e200020f5088 <kernel> rt_spin_lock+0x3b8/0x408
e20000578290 <kernel> get_page_from_freelist+0x1528/0x1b48
e20000579b28 <kernel> __alloc_pages_nodemask+0x270/0x1b90
e200006ac9d8 <kernel> alloc_pages_current+0x638/0xad0
e200006b24d8 <kernel> allocate_slab+0x210/0xa70
e200006b9468 <kernel> __slab_alloc+0x1300/0x1d80
e200006ba900 <kernel> kmem_cache_alloc+0xa18/0xa78
e2000101ed78 <kernel> radix_tree_node_alloc+0x280/0x478
e2000101f2a8 <kernel> radix_tree_extend+0x248/0x588
e2000101f6c0 <kernel> radix_tree_insert+0xd8/0x1258
e20000550e10 <kernel> page_cache_tree_insert+0xd0/0x498
e200005513e8 <kernel> add_to_page_cache_locked+0x210/0x7b0
e2000055d7f8 <kernel> __read_cache_page+0x160/0x7e8
e2000055df00 <kernel> do_read_cache_page+0x80/0xab8
e2000055e9c8 <kernel> read_cache_page+0x90/0xa8
e20000fdf110 <kernel> read_dev_sector+0xa8/0x180
e20000fe0178 <kernel> parse_extended+0x198/0x8f0
e20000fe1288 <kernel> msdos_partition+0x7a8/0xed8
e20000fdf790 <kernel> check_partition+0x508/0x870
e20000fddfe8 <kernel> rescan_partitions+0x3a8/0x1128
e20000818328 <kernel> __blkdev_get+0xcb8/0xe48
e20000818d20 <kernel> blkdev_get+0x868/0xf90
e20000fcd100 <kernel> register_disk+0x890/0xad0
e20000fcda08 <kernel> add_disk+0x6c8/0xc98
e20001801ab0 <kernel> sd_probe_async+0x328/0x648
e200002935a8 <kernel> async_run_entry_fn+0x100/0x598
e2000023fd28 <kernel> process_one_work+0x5a0/0x1940
e20000241508 <kernel> worker_thread+0x440/0xff8
e2000026c1a8 <kernel> kthread+0x4e8/0x5a0

As I see, in allocate_slab() kernel could be under irqs_disabled. And 
irqs would be enabled in case of SYSTEM_RUNNING (why only in case of 
SYSTEM_RUNNING?). But in our case system isn't running yet (it's always 
before /sbin/init), so irqs wouldn't be enabled:

         enableirqs = (flags & __GFP_WAIT) != 0;
         #ifdef CONFIG_PREEMPT_RT_FULL
         enableirqs |= system_state == SYSTEM_RUNNING;
         #endif
         if (enableirqs)
                 local_irq_enable();

So we call schedule() under irqs_disabled in 
...->get_page_from_freelist->buffered_rmqueue->local_spin_lock_irqsave->local_lock_irqsave->__local_lock_irqsave->__local_lock_irq->spin_lock_irqsave->spin_lock->rt_spin_lock->rt_spin_lock_slowlock->schedule_rt_mutex.

P. S.
Today I reproduced this on 4.9.47-rt37. Try to reproduce on x86.


Best regards,
Pavel V. Panteleev

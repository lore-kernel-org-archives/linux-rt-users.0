From: "Cowell, Matt (NSN - US/Arlington Heights)" <matt.cowell@nsn.com>
Subject: [PATCH RT] rtmutex: fix deadlock in spin_trylock
Date: Wed, 30 Oct 2013 15:53:41 +0000
Message-ID: <641D1EBAB8EAD046954CD69996C8FE00164297@USCHMBX003.nsn-intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:14516 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3J3PyV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Oct 2013 11:54:21 -0400
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r9UFs1Hr007761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2013 16:54:19 +0100
Received: from USCHHTC002.nsn-intra.net ([10.159.161.15])
	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r9UFrv2S027937
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2013 16:54:00 +0100
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Repost to linux-rt-users list, as there has been no response on the linux-kernel list and it missed several rt patch releases.  Originally seen on 3.10.10-rt7.


There is a deadlock condition with RT spin_locks that may use trylock in
hardirq context.  The main user of this is get_next_timer_interrupt, which
will deadlock if an IRQ preempts a timer wheel modification.

Since this is a trylock and if the wait_lock is already held it means that
some other user is either locking, about to wait for, or unlocking the
rtmutex, we should not wait and return failure anyway.  This likely also
reduces latency.

Detected by spinlock lockup debug:
   BUG: spinlock lockup suspected on CPU#1, ncp_nca_0_grp_5/133
    lock: 0xee02a000, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
   CPU: 1 PID: 133 Comm: ncp_nca_0_grp_5 Tainted: G           O 3.10.10-rt7 #53
   [<c041539c>] (unwind_backtrace+0x0/0xf8) from [<c0411914>] (show_stack+0x10/0x14)
   [<c0411914>] (show_stack+0x10/0x14) from [<c06059b0>] (do_raw_spin_lock+0x100/0x164)
   [<c06059b0>] (do_raw_spin_lock+0x100/0x164) from [<c07afbc0>] (rt_spin_trylock+0x14/0xc4)
   [<c07afbc0>] (rt_spin_trylock+0x14/0xc4) from [<c04310fc>] (get_next_timer_interrupt+0x54/0x2b8)
   [<c04310fc>] (get_next_timer_interrupt+0x54/0x2b8) from [<c0467c44>] (tick_nohz_stop_sched_tick+0x204/0x2e4)
   [<c0467c44>] (tick_nohz_stop_sched_tick+0x204/0x2e4) from [<c0468534>] (tick_nohz_irq_exit+0x98/0xb8)
   [<c0468534>] (tick_nohz_irq_exit+0x98/0xb8) from [<c042b2b8>] (irq_exit+0xc0/0x164)
   [<c042b2b8>] (irq_exit+0xc0/0x164) from [<c04137ec>] (handle_IPI+0x9c/0x124)
   [<c04137ec>] (handle_IPI+0x9c/0x124) from [<c04085b4>] (axxia_gic_handle_irq+0xac/0xec)
   [<c04085b4>] (axxia_gic_handle_irq+0xac/0xec) from [<c07b0ac4>] (__irq_svc+0x44/0x8c)
   Exception stack(0xed859df8 to 0xed859e40)
   9de0:                                                       ee02a000 00000000
   9e00: 00000000 00000001 ee02a000 ee02a000 ee02a000 ed858000 ee02a000 00000000
   9e20: ed858000 00000000 ed858000 ed859e40 c07af9a8 c0605914 60000013 ffffffff
   [<c07b0ac4>] (__irq_svc+0x44/0x8c) from [<c0605914>] (do_raw_spin_lock+0x64/0x164)
   [<c0605914>] (do_raw_spin_lock+0x64/0x164) from [<c07af9a8>] (rt_spin_lock_slowunlock+0xc/0x68)
   [<c07af9a8>] (rt_spin_lock_slowunlock+0xc/0x68) from [<c07adbb0>] (schedule_timeout+0x138/0x1fc)
   [<c07adbb0>] (schedule_timeout+0x138/0x1fc) from [<bf067f0c>] (ncp_nca_thread_notifier+0xd0/0x12c [ncp])
   [<bf067f0c>] (ncp_nca_thread_notifier+0xd0/0x12c [ncp]) from [<bf083cac>] (ncp_nca_thread+0x24/0x78 [ncp])
   [<bf083cac>] (ncp_nca_thread+0x24/0x78 [ncp]) from [<c04440ec>] (kthread+0x9c/0xa4)
   [<c04440ec>] (kthread+0x9c/0xa4) from [<c040ddb8>] (ret_from_fork+0x14/0x3c)
---
 kernel/rtmutex.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 5d76634..25ad02d 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1057,7 +1057,9 @@ rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
 	int ret = 0;
 
-	raw_spin_lock(&lock->wait_lock);
+	if (!raw_spin_trylock(&lock->wait_lock)) {
+		return 0;
+	}
 	init_lists(lock);
 
 	if (likely(rt_mutex_owner(lock) != current)) {
-- 
1.7.10.1


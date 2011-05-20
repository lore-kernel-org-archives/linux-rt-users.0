From: Emmanuel Deloget <emmanuel.deloget@efixo.com>
Subject: How do I get rid of these "BUG: sleeping function called from ...
 kernel/rtmutex.c:707"?
Date: Fri, 20 May 2011 16:30:21 +0200
Message-ID: <4DD67AFD.2080709@efixo.com>
Reply-To: emmanuel.deloget@efixo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.21]:13938 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916Ab1ETOVq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 May 2011 10:21:46 -0400
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2311.sfr.fr (SMTP Server) with ESMTP id 223757000095
	for <linux-rt-users@vger.kernel.org>; Fri, 20 May 2011 16:21:45 +0200 (CEST)
Received: from [192.168.100.182] (21.67.64.86.rev.sfr.net [86.64.67.21])
	by msfrf2311.sfr.fr (SMTP Server) with ESMTP id EF692700008F
	for <linux-rt-users@vger.kernel.org>; Fri, 20 May 2011 16:21:43 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I hope this message will find its way to the linux-rt mailing list. I 
subscribed but for reasons that are unknown to me I cannot receive 
anything from this list (I contacted the owner to sort out the problem). 
As I side note, for this very reason, I'll appreciate if you CC me 
whenever you answer to this mail, otherwise I might miss it. Thanks in 
advance.

I am using 2.6.33.7-rt30 (platform in arm/mach-ixp4xx ; distro is 
OpenWRT with 2.6.33.7 re-imported (it has been removed from OpenWRT)).

When I up a network interface with ifconfig, I systematically get the 
following error message in dmesg :

[   64.205417] BUG: sleeping function called from invalid context at 
kernel/rtmutex.c:707
[   64.205453] pcnt: 0 0 in_atomic(): 0, irqs_disabled(): 128, pid: 
1047, name: ifconfig
[   64.205472] Backtrace:
[   64.205521] [<c002b6c0>] (dump_backtrace+0x0/0x110) from [<c02dbe20>] 
(dump_stack+0x18/0x1c)
[   64.205545]  r7:c780daa0 r6:c780daa0 r5:00000020 r4:00000000
[   64.205591] [<c02dbe08>] (dump_stack+0x0/0x1c) from [<c0032f7c>] 
(__might_sleep+0xf8/0x118)
[   64.205629] [<c0032e84>] (__might_sleep+0x0/0x118) from [<c02de468>] 
(rt_spin_lock+0x34/0x64)
[   64.205650]  r4:c03a18d8
[   64.205689] [<c02de434>] (rt_spin_lock+0x0/0x64) from [<c0095908>] 
(kmem_cache_alloc+0x40/0x15c)
[   64.205711]  r4:c5bd1df0
[   64.205744] [<c00958c8>] (kmem_cache_alloc+0x0/0x15c) from 
[<c01c749c>] (__alloc_skb+0x30/0x104)
[   64.205778] [<c01c746c>] (__alloc_skb+0x0/0x104) from [<c01c813c>] 
(dev_alloc_skb+0x20/0x44)
[   64.205800]  r8:a0000013 r7:c42f4340 r6:c42f4000 r5:c5ae1540 r4:c5bd1df0
[   64.205866] [<c01c811c>] (dev_alloc_skb+0x0/0x44) from [<bf0d9a88>] 
(do_dev_stop+0x11c/0x2e4 [ixp400_eth])
[   64.205909] [<bf0d9a60>] (do_dev_stop+0xf4/0x2e4 [ixp400_eth]) from 
[<bf0d9ba8>] (do_dev_stop+0x23c/0x2e4 [ixp400_eth])
[   64.205952] [<bf0d9b30>] (do_dev_stop+0x1c4/0x2e4 [ixp400_eth]) from 
[<bf0da230>] (do_dev_open+0x24/0xa4 [ixp400_eth])
[   64.205977]  r6:00001043 r5:bf0db448 r4:c42f4000
[   64.206020] [<bf0da20c>] (do_dev_open+0x0/0xa4 [ixp400_eth]) from 
[<c01d0e0c>] (dev_open+0xcc/0x134)
[   64.206042]  r5:bf0db1d0 r4:c42f4000
[   64.206086] [<c01d0d40>] (dev_open+0x0/0x134) from [<c01d0204>] 
(dev_change_flags+0xb0/0x190)
[   64.206107]  r5:00000041 r4:c42f4000
[   64.206154] [<c01d0154>] (dev_change_flags+0x0/0x190) from 
[<c0256444>] (devinet_ioctl+0x2f0/0x6b0)
[   64.206177]  r7:c5bd1e80 r6:c59e0600 r5:c788c4e0 r4:00000000
[   64.206226] [<c0256154>] (devinet_ioctl+0x0/0x6b0) from [<c02579a8>] 
(inet_ioctl+0xd0/0x10c)
[   64.206270] [<c02578d8>] (inet_ioctl+0x0/0x10c) from [<c01be7c8>] 
(sock_ioctl+0x1fc/0x25c)
[   64.206291]  r4:c4ab3ec0
[   64.206318] [<c01be5cc>] (sock_ioctl+0x0/0x25c) from [<c00a57bc>] 
(vfs_ioctl+0x34/0xb4)
[   64.206338]  r6:be8cdd60 r5:00008914 r4:c4ab3ec0
[   64.206375] [<c00a5788>] (vfs_ioctl+0x0/0xb4) from [<c00a5e98>] 
(do_vfs_ioctl+0x548/0x5b4)
[   64.206396]  r6:00000003 r5:c4ab3ec0 r4:c6014afc
[   64.206433] [<c00a5950>] (do_vfs_ioctl+0x0/0x5b4) from [<c00a5f44>] 
(sys_ioctl+0x40/0x60)
[   64.206477] [<c00a5f04>] (sys_ioctl+0x0/0x60) from [<c0027f20>] 
(ret_fast_syscall+0x0/0x28)
[   64.206499]  r7:00000036 r6:000001c3 r5:00000004 r4:000508e7

It seems that this message does not prevent ifconfig to work correctly. 
The code at kernel/rtmutex.c:707 says:

/* 701 */ static inline void
/* 702 */ rt_spin_lock_fastlock(struct rt_mutex *lock,
/* 703 */         void  (*slowfn)(struct rt_mutex *lock))
/* 704 */ {
/* 705 */     /* Temporary HACK! */
/* 706 */     if (likely(!current->in_printk))
/* 707 */         might_sleep();
/* 708 */     else if (in_atomic() || irqs_disabled())
/* 709 */         /* don't grab locks for printk in atomic */
/* 710 */         return;
/* 711 */
/* 712 */     if (likely(rt_mutex_cmpxchg(lock, NULL, current)))
/* 713 */         rt_mutex_deadlock_account_lock(lock, current);
/* 714 */     else
/* 715 */         slowfn(lock);
/* 716 */ }

I did my homework, and found that a similar message have been seen here 
and there ([1], [2]). But the solution provided in [1] (avoid the 
dynamic allocation, reserve an automatic (as in C 'auto' keyword) 
buffer) is not helping much in my case : I'm not going to ask to 
dev_alloc_skb() to not perform static allocations, while [2] do not 
provide any kind of solution.

Now, I want to get rid of these messages in the correct way. I can 
implement a bizzare hack to remove this issue, but I have no guarantee 
that this hack will be sensible. What I'm searching for is a correct (in 
the linux kernel way) to do this.

Can anybody help?

Thanks in advance,

-- Emmanuel Deloget

[1] http://www.spinics.net/lists/linux-rt-users/msg06048.html
[2] http://comments.gmane.org/gmane.linux.kernel.firewire.devel/14648


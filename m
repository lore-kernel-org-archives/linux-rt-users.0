From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Cyclictest results on Sparc64 with PREEMPT_RT
Date: Fri, 07 Feb 2014 14:25:38 +0100
Message-ID: <52F4DED2.3010800@linutronix.de>
References: <52E616DB.2040202@oracle.com> <20140207123529.GA2382@linutronix.de> <52F4D474.6080107@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, davem@davemloft.net
To: Allen Pais <allen.pais@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45270 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbaBGNZk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 08:25:40 -0500
In-Reply-To: <52F4D474.6080107@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/07/2014 01:41 PM, Allen Pais wrote:
> Sebastian,

Hi Allen,

> I haven't made much progress yet. These appear when the machine is under
> stress(hackbench/dd). There's also another issue that popped up while
> I ran hack bench, here's the brief trace
> 
> [ 6694.884398] kernel BUG at kernel/rtmutex.c:738!
> [ 6694.884402]               \|/ ____ \|/
> [ 6694.884402]               "@'/ .. \`@"
> [ 6694.884402]               /_| \__/ |_\
> [ 6694.884402]                  \__U_/

I think we need this in generic code. I'm actually a little jealous
that only sparc has this.

> [ 6694.884403] hackbench(18821): Kernel bad sw trap 5 [#2]
> [ 6694.884408] CPU: 8 PID: 18821 Comm: hackbench Tainted: G      D W    3.10.24-rt22+ #11
> [ 6694.884410] task: fffff80f8f4a2580 ti: fffff80f8ebd4000 task.ti: fffff80f8ebd4000
> [ 6694.884413] TSTATE: 0000004411001603 TPC: 0000000000878ec4 TNPC: 0000000000878ec8 Y: 00000000    Tainted: G      D W   
> [ 6694.884425] TPC: <rt_spin_lock_slowlock+0x304/0x340>
> [ 6694.884427] g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000de5800
> [ 6694.884429] g4: fffff80f8f4a2580 g5: fffff80fd089c000 g6: fffff80f8ebd4000 g7: 726e656c2f72746d
> [ 6694.884430] o0: 00000000009bfaf0 o1: 00000000000002e2 o2: 0000000000000000 o3: 0000000000000001
> [ 6694.884432] o4: 0000000000000002 o5: 0000000000000000 sp: fffff80fff9b70d1 ret_pc: 0000000000878ebc
> [ 6694.884434] RPC: <rt_spin_lock_slowlock+0x2fc/0x340>
> [ 6694.884437] l0: fffff80fff9b7990 l1: fffff80f8f4a2580 l2: fffff80f8f4a2bd0 l3: 000001001fb75040
> [ 6694.884438] l4: 0000000000000000 l5: 0000000000e25c00 l6: 0000000000000008 l7: 0000000000000008
> [ 6694.884440] i0: fffff80f97836070 i1: 0000000000512400 i2: 0000000000000001 i3: 0000000000000000
> [ 6694.884441] i4: 0000000000000002 i5: 0000000000000000 i6: fffff80fff9b7211 i7: 00000000008790ac
> [ 6694.884444] I7: <rt_spin_lock+0xc/0x40>
> [ 6694.884445] Call Trace:
> [ 6694.884448]  [00000000008790ac] rt_spin_lock+0xc/0x40
> [ 6694.884454]  [000000000052e30c] unmap_single_vma+0x1ec/0x6c0
> [ 6694.884456]  [000000000052e808] unmap_vmas+0x28/0x60
> [ 6694.884459]  [0000000000530cc8] exit_mmap+0x88/0x160
> [ 6694.884465]  [000000000045e0d4] mmput+0x34/0xe0
> [ 6694.884469]  [00000000004669fc] do_exit+0x1fc/0xa40
> [ 6694.884473]  [000000000087a650] perfctr_irq+0x3d0/0x420
> [ 6694.884477]  [00000000004209f4] tl0_irq15+0x14/0x20
> [ 6694.884482]  [0000000000671e4c] do_raw_spin_lock+0xac/0x120
> [ 6694.884485]  [0000000000879cc8] _raw_spin_lock_irqsave+0x68/0xa0
> [ 6694.884488]  [0000000000452074] flush_tsb_user+0x14/0x120
> [ 6694.884490]  [00000000004515a8] flush_tlb_pending+0x68/0xe0
> [ 6694.884492]  [0000000000451800] tlb_batch_add+0x1e0/0x200
> [ 6694.884496]  [000000000053bef8] ptep_clear_flush+0x38/0x60
> [ 6694.884498]  [000000000052a9fc] do_wp_page+0x1dc/0x860
> [ 6694.884500]  [000000000052b3f8] handle_pte_fault+0x378/0x7c0
> 
> These are the two issues I have ran into with stress. Otherwise the machine is quite stable
> with light load(compress/decompress and building the kernel).

This is a dead lock. Whatever lock you go after, you are already
holding it in this context / hackbench. I don't know how you got from
perfctr_irq() to do_exit() but you shouldn't do this in hardirq
context.

But calling do_exit() is probably error recovery since it would kill
hackbench and I assume it wasn't done yet.
I see also tl0_irq15() in your stack trace. This is that evil NMI that
checks if the system is stalling. I think that you stuck in
flush_tsb_user() on that raw_lock and somebody is not letting it go and
so you spin for ever. Maybe full lockdep shows you some informations
about wrong context locking etc.

> Thanks,
> 
> Allen
> 

Sebastian

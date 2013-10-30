From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [V2 PATCH] rt: Don't call schedule_work_on in preemption disabled
 context
Date: Wed, 30 Oct 2013 10:22:40 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1310301020400.19212@ionos.tec.linutronix.de>
References: <1380923937-19506-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
	paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59734 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab3J3JWp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Oct 2013 05:22:45 -0400
In-Reply-To: <1380923937-19506-1-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 4 Oct 2013, Yang Shi wrote:

> The following trace is triggered when running ltp oom test cases:
> 
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
> in_atomic(): 1, irqs_disabled(): 0, pid: 17188, name: oom03
> Preemption disabled at:[<ffffffff8112ba70>] mem_cgroup_reclaim+0x90/0xe0
> 
> CPU: 2 PID: 17188 Comm: oom03 Not tainted 3.10.10-rt3 #2
> Hardware name: Intel Corporation Calpella platform/MATXM-CORE-411-B, BIOS 4.6.3 08/18/2010
> ffff88007684d730 ffff880070df9b58 ffffffff8169918d ffff880070df9b70
> ffffffff8106db31 ffff88007688b4a0 ffff880070df9b88 ffffffff8169d9c0
> ffff88007688b4a0 ffff880070df9bc8 ffffffff81059da1 0000000170df9bb0
> Call Trace:
> [<ffffffff8169918d>] dump_stack+0x19/0x1b
> [<ffffffff8106db31>] __might_sleep+0xf1/0x170
> [<ffffffff8169d9c0>] rt_spin_lock+0x20/0x50
> [<ffffffff81059da1>] queue_work_on+0x61/0x100
> [<ffffffff8112b361>] drain_all_stock+0xe1/0x1c0
> [<ffffffff8112ba70>] mem_cgroup_reclaim+0x90/0xe0
> [<ffffffff8112beda>] __mem_cgroup_try_charge+0x41a/0xc40
> [<ffffffff810f1c91>] ? release_pages+0x1b1/0x1f0
> [<ffffffff8106f200>] ? sched_exec+0x40/0xb0
> [<ffffffff8112cc87>] mem_cgroup_charge_common+0x37/0x70
> [<ffffffff8112e2c6>] mem_cgroup_newpage_charge+0x26/0x30
> [<ffffffff8110af68>] handle_pte_fault+0x618/0x840
> [<ffffffff8103ecf6>] ? unpin_current_cpu+0x16/0x70
> [<ffffffff81070f94>] ? migrate_enable+0xd4/0x200
> [<ffffffff8110cde5>] handle_mm_fault+0x145/0x1e0
> [<ffffffff810301e1>] __do_page_fault+0x1a1/0x4c0
> [<ffffffff8169c9eb>] ? preempt_schedule_irq+0x4b/0x70
> [<ffffffff8169e3b7>] ? retint_kernel+0x37/0x40
> [<ffffffff8103053e>] do_page_fault+0xe/0x10
> [<ffffffff8169e4c2>] page_fault+0x22/0x30
> 
> So, to prevent schedule_work_on from being called in preempt disabled context,
> remove the pair of get_cpu/put_cpu and drain_local_stock shortcut.

Simply replace get/put_cpu() with get/put_cpu_light() and the problem is fixed
with 2 lines of change.
 
Thanks,

	tglx

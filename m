From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH -rt] drop spurious rcu unlock
Date: Sun, 22 Jul 2007 20:13:59 -0700
Message-ID: <20070723031359.GA25590@linux.vnet.ibm.com>
References: <1185124958.2573.13.camel@imap.mvista.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43020 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbXGWDOB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Jul 2007 23:14:01 -0400
Content-Disposition: inline
In-Reply-To: <1185124958.2573.13.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Jul 22, 2007 at 10:22:37AM -0700, Daniel Walker wrote:
> 
> Strange rcu_read_unlock() which causes a imbalance, and boot hang.. I
> didn't notice a reason for it, and removing it allows my system to make
> progress.
> 
> This should go into the preempt-realtime-sched.patch

Strange.  I have been getting boots, kernbench runs, and rcutorture
tests despite its being present.  Though perhaps it was the cause
of the (non-fatal) "scheduling while atomic" I got during a kernbench
run -- I was assuming it was my fault somehow.  Non-reproducible.  :-/

						Thanx, Paul

BUG: sleeping function called from invalid context cc1(29651) at kernel/rtmutex.c:636
in_atomic():1 [00000001], irqs_disabled():0
 [<c0119f50>] __might_sleep+0xf3/0xf9
 [<c031600e>] __rt_spin_lock+0x21/0x3c
 [<c014102c>] get_zone_pcp+0x20/0x29
 [<c0141a40>] free_hot_cold_page+0xdc/0x167
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c0110d92>] pgd_dtor+0x0/0x1
 [<c015d865>] quicklist_trim+0xb7/0xe3
 [<c0111025>] check_pgt_cache+0x19/0x1c
 [<c0148df5>] free_pgtables+0x54/0x12c
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c014e5be>] unmap_region+0xeb/0x13b
BUG: scheduling while atomic: cc1/0x00000002/29745, CPU#0
 [<c03146c8>] __sched_text_start+0xb0/0x4fe
 [<c0116432>] try_to_wake_up+0x31b/0x326
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c0314bfc>] schedule+0xe6/0x100
 [<c03158db>] rt_spin_lock_slowlock+0xc5/0x145
 [<c0316027>] __rt_spin_lock+0x3a/0x3c
 [<c014102c>] get_zone_pcp+0x20/0x29
 [<c0141a40>] free_hot_cold_page+0xdc/0x167
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c0110d92>] pgd_dtor+0x0/0x1
 [<c015d865>] quicklist_trim+0xb7/0xe3
 [<c0111025>] check_pgt_cache+0x19/0x1c
 [<c0148df5>] free_pgtables+0x54/0x12c
 [<c013a3f4>] add_preempt_count+0x12/0xcc
 [<c014e5be>] unmap_region+0xeb/0x13b
 [<c014e861>] do_munmap+0xea/0xff
 [<c014e8a7>] sys_munmap+0x31/0x40
 [<c010276a>] syscall_call+0x7/0xb
 [<c0310000>] _shift_data_right_pages+0xb9/0xd1
 =======================
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c015d7c8>] .... quicklist_trim+0x1a/0xe3
.....[<00000000>] ..   ( <= _stext+0x3fefff50/0x14)
.. [<c031462b>] .... __sched_text_start+0x13/0x4fe
.....[<00000000>] ..   ( <= _stext+0x3fefff50/0x14)

> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.22.1/kernel/sched.c
> ===================================================================
> --- linux-2.6.22.1.orig/kernel/sched.c	2007-07-22 16:47:37.000000000 +0000
> +++ linux-2.6.22.1/kernel/sched.c	2007-07-22 16:16:48.000000000 +0000
> @@ -4900,7 +4900,6 @@ asmlinkage long sys_sched_yield(void)
>  	 * no need to preempt or enable interrupts:
>  	 */
>  	spin_unlock_no_resched(&rq->lock);
> -	rcu_read_unlock();
> 
>  	__schedule();
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SLAB leaks filep in 3.4.13-rt21 with PREEMPT_RT_FULL
Date: Sat, 20 Oct 2012 21:30:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210202125560.2719@ionos>
References: <5082C7B9.9010502@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34004 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab2JTTa6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Oct 2012 15:30:58 -0400
In-Reply-To: <5082C7B9.9010502@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 20 Oct 2012, Stanislav Meduna wrote:
> Looking at the slabtop output the "filp" is responsible for
> most of the allocations, but there are more, even the "pid"
> is rising although the number of threads in the system stays
> the same.

It's a UP problem in tiny RCU. Fix is below.

Thanks,

	tglx

-------------------------->
Subject: rcu: rcutiny: Prevent RCU stall
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 16 Oct 2012 18:36:51 +0200

rcu_read_unlock_special() checks in_serving_softirq() and leaves early
when true. On RT this is obviously wrong as softirq processing context
can be preempted and therefor such a task can be on the gp_tasks
list. Leaving early here will leave the task on the list and therefor
block RCU processing forever.

This cannot happen on mainline because softirq processing context
cannot be preempted and therefor this can never happen at all.

In fact this check looks quite questionable in general. Neither irq
context nor softirq processing context in mainline can ever be
preempted in mainline so the special unlock case should not ever be
invoked in such context. Now the only explanation might be a
rcu_read_unlock() being interrupted and therefor leave the rcu nest
count at 0 before the special unlock bit has been cleared. That looks
fragile. At least it's missing a big fat comment. Paul ????

See mainline commits: ec433f0c5 and 8762705a for further enlightment.

Reported-by: Kristian Lehmann <krleit00@hs-esslingen.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org

---
 kernel/rcutiny_plugin.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-stable/kernel/rcutiny_plugin.h
===================================================================
--- linux-stable.orig/kernel/rcutiny_plugin.h
+++ linux-stable/kernel/rcutiny_plugin.h
@@ -560,7 +560,7 @@ void rcu_read_unlock_special(struct task
 		rcu_preempt_cpu_qs();
 
 	/* Hardware IRQ handlers cannot block. */
-	if (in_irq() || in_serving_softirq()) {
+	if (preempt_count() & (HARDIRQ_MASK | SOFTIRQ_OFFSET)) {
 		local_irq_restore(flags);
 		return;
 	}

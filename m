From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: kernel-rt rcuc lock contention problem
Date: Mon, 26 Jan 2015 14:14:03 -0500
Message-ID: <20150126141403.469dc92f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbbAZTOJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Jan 2015 14:14:09 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Paul,

We're running some measurements with cyclictest running inside a
KVM guest where we could observe spinlock contention among rcuc
threads.

Basically, we have a 16-CPU NUMA machine very well setup for RT.
This machine and the guest run the RT kernel. As our test-case
requires an application in the guest taking 100% of the CPU, the
RT priority configuration that gives the best latency is this one:

 263  FF   3  [rcuc/15]
  13  FF   3  [rcub/1]
  12  FF   3  [rcub/0]
 265  FF   2  [ksoftirqd/15]
3181  FF   1  qemu-kvm

In this configuration, the rcuc can preempt the guest's vcpu
thread. This shouldn't be a problem, except for the fact that
we're seeing that in some cases the rcuc/15 thread spends 10us
or more spinning in this spinlock (note that IRQs are disabled
during this period):

__rcu_process_callbacks()
{
...
	local_irq_save(flags);
	if (cpu_needs_another_gp(rsp, rdp)) {
		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
		rcu_start_gp(rsp);
		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
...

We've tried playing with the rcu_nocbs= option. However, it
did not help because, for reasons we don't understand, the rcuc
threads have to handle grace period start even when callback
offloading is used. Handling this case requires this code path
to be executed.

We've cooked the following extremely dirty patch, just to see
what would happen:

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index eaed1ef..c0771cc 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -2298,9 +2298,19 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	/* Does this CPU require a not-yet-started grace period? */
 	local_irq_save(flags);
 	if (cpu_needs_another_gp(rsp, rdp)) {
-		raw_spin_lock(&rcu_get_root(rsp)->lock); /* irqs disabled. */
-		rcu_start_gp(rsp);
-		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
+		for (;;) {
+			if (!raw_spin_trylock(&rcu_get_root(rsp)->lock)) {
+				local_irq_restore(flags);
+				local_bh_enable();
+				schedule_timeout_interruptible(2);
+				local_bh_disable();
+				local_irq_save(flags);
+				continue;
+			}
+			rcu_start_gp(rsp);
+			raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
+			break;
+		}
 	} else {
 		local_irq_restore(flags);
 	}

With this patch rcuc is gone from our traces and the scheduling
latency is reduced by 3us in our CPU-bound test-case.

Could you please advice on how to solve this contention problem?

Can we test whether the local CPU is nocb, and in that case, 
skip rcu_start_gp entirely for example?

Thanks!

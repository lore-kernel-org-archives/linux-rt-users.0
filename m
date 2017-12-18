From: <gregkh@linuxfoundation.org>
Subject: Patch "sched/rt: Do not pull from current CPU if only one CPU to pull" has been added to the 4.9-stable tree
Date: Mon, 18 Dec 2017 13:02:08 +0100
Message-ID: <1513598528187205@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
To: rostedt@goodmis.org, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-rt-users@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, wagi@monom.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758673AbdLRMDN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Dec 2017 07:03:13 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    sched/rt: Do not pull from current CPU if only one CPU to pull

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched-rt-do-not-pull-from-current-cpu-if-only-one-cpu-to-pull.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From f73c52a5bcd1710994e53fbccc378c42b97a06b6 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 2 Dec 2017 13:04:54 -0500
Subject: sched/rt: Do not pull from current CPU if only one CPU to pull

From: Steven Rostedt <rostedt@goodmis.org>

commit f73c52a5bcd1710994e53fbccc378c42b97a06b6 upstream.

Daniel Wagner reported a crash on the BeagleBone Black SoC.

This is a single CPU architecture, and does not have a functional
arch_send_call_function_single_ipi() implementation which can crash
the kernel if that is called.

As it only has one CPU, it shouldn't be called, but if the kernel is
compiled for SMP, the push/pull RT scheduling logic now calls it for
irq_work if the one CPU is overloaded, it can use that function to call
itself and crash the kernel.

Ideally, we should disable the SCHED_FEAT(RT_PUSH_IPI) if the system
only has a single CPU. But SCHED_FEAT is a constant if sched debugging
is turned off. Another fix can also be used, and this should also help
with normal SMP machines. That is, do not initiate the pull code if
there's only one RT overloaded CPU, and that CPU happens to be the
current CPU that is scheduling in a lower priority task.

Even on a system with many CPUs, if there's many RT tasks waiting to
run on a single CPU, and that CPU schedules in another RT task of lower
priority, it will initiate the PULL logic in case there's a higher
priority RT task on another CPU that is waiting to run. But if there is
no other CPU with waiting RT tasks, it will initiate the RT pull logic
on itself (as it still has RT tasks waiting to run). This is a wasted
effort.

Not only does this help with SMP code where the current CPU is the only
one with RT overloaded tasks, it should also solve the issue that
Daniel encountered, because it will prevent the PULL logic from
executing, as there's only one CPU on the system, and the check added
here will cause it to exit the RT pull code.

Reported-by: Daniel Wagner <wagi@monom.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Fixes: 4bdced5c9 ("sched/rt: Simplify the IPI based RT balancing logic")
Link: http://lkml.kernel.org/r/20171202130454.4cbbfe8d@vmware.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/rt.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2022,8 +2022,9 @@ static void pull_rt_task(struct rq *this
 	bool resched = false;
 	struct task_struct *p;
 	struct rq *src_rq;
+	int rt_overload_count = rt_overloaded(this_rq);
 
-	if (likely(!rt_overloaded(this_rq)))
+	if (likely(!rt_overload_count))
 		return;
 
 	/*
@@ -2032,6 +2033,11 @@ static void pull_rt_task(struct rq *this
 	 */
 	smp_rmb();
 
+	/* If we are the only overloaded CPU do nothing */
+	if (rt_overload_count == 1 &&
+	    cpumask_test_cpu(this_rq->cpu, this_rq->rd->rto_mask))
+		return;
+
 #ifdef HAVE_RT_PUSH_IPI
 	if (sched_feat(RT_PUSH_IPI)) {
 		tell_cpu_to_push(this_rq);


Patches currently in stable-queue which might be from rostedt@goodmis.org are

queue-4.9/sched-rt-do-not-pull-from-current-cpu-if-only-one-cpu-to-pull.patch
queue-4.9/tracing-allocate-mask_str-buffer-dynamically.patch

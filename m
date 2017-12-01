From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] sched/rt: Do not do push/pull when there is only one CPU
Date: Fri, 1 Dec 2017 13:32:22 -0500
Message-ID: <20171201133222.66d41219@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Daniel Wagner reported a crash on the beaglebone black. This is a
single CPU architecture, and does not have a functional:
arch_send_call_function_single_ipi() and can crash if that is called.

As it only has one CPU, it shouldn't be called, but if the kernel is
compiled for SMP, the push/pull RT scheduling logic now calls it for
irq_work if the one CPU is overloaded, it can use that function to call
itself and crash the kernel.

There's no reason for the push/pull logic to even be called if there's
only one CPU online. Have it bail if it sees that's the case.

Link: http://lkml.kernel.org/r/8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org
Fixes: 4bdced5c9 ("sched/rt: Simplify the IPI based RT balancing logic")
Cc: stable@vger.kernel.org
Reported-by: Daniel Wagner <wagi@monom.org>
---
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4056c19ca3f0..50d2f8179f70 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1784,6 +1784,10 @@ static int push_rt_task(struct rq *rq)
 	if (!rq->rt.overloaded)
 		return 0;
 
+	/* If we are the only CPU, don't bother */
+	if (num_online_cpus() == 1)
+		return 0;
+
 	next_task = pick_next_pushable_task(rq);
 	if (!next_task)
 		return 0;
@@ -2038,6 +2042,10 @@ static void pull_rt_task(struct rq *this_rq)
 	if (likely(!rt_overloaded(this_rq)))
 		return;
 
+	/* If we are the only CPU, don't bother */
+	if (num_online_cpus() == 1)
+		return;
+
 	/*
 	 * Match the barrier from rt_set_overloaded; this guarantees that if we
 	 * see overloaded we must also see the rto_mask bit.

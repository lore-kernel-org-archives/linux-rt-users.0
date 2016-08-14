From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH] Make output of RT throttling more verbose
Date: Sun, 14 Aug 2016 02:12:35 +0200
Message-ID: <99b19596-c11b-0b92-7376-b1a07f1aaa88@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:50836 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbcHNKDD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Aug 2016 06:03:03 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Make output of RT throttling more verbose.

Most of the time when a system is hit by RT throttling
activation it is evident which task is running havoc.
Sometimes, however, the culprit may be more difficult
to detect. Add some more debug output to the RT
throttling activation message for such cases.

Test it:
Generate an artificial block of an RT task using the blocksys driver
# chrt -r 99 taskset -c 7 echo 4500000000 >/dev/blocksys
Kernel messages
# dmesg | tail -20 | grep -e blocksys -e sched
blocksys: preemption and interrupts of CPU #7 will be blocked for 4500000000 nops
sched: RT throttling activated cmd echo cpu 7 pid 4780 prio 99 us 1155825 flags 0x10000088
blocksys: preemption and interrupts of CPU #7 blocked for about 1311139 us

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 kernel/sched/rt.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-4.6.5-rt10/kernel/sched/rt.c
===================================================================
--- linux-4.6.5-rt10.orig/kernel/sched/rt.c
+++ linux-4.6.5-rt10/kernel/sched/rt.c
@@ -899,7 +899,8 @@ static inline int rt_se_prio(struct sche
 	return rt_task_of(rt_se)->prio;
 }
 
-static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
+static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq,
+				     struct task_struct *curr, u64 delta_exec)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
 
@@ -923,7 +924,11 @@ static int sched_rt_runtime_exceeded(str
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
+			printk_deferred("sched: RT throttling activated cmd %s "
+			   "cpu %d pid %d prio %d us %llu flags 0x%08lx\n",
+			   curr->comm, task_cpu(curr), task_pid_nr(curr),
+			   MAX_RT_PRIO-1 - curr->prio, delta_exec >> 10,
+			   (unsigned long) task_thread_info(curr)->flags);
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
@@ -983,7 +988,7 @@ static void update_curr_rt(struct rq *rq
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			if (sched_rt_runtime_exceeded(rt_rq))
+			if (sched_rt_runtime_exceeded(rt_rq, curr, delta_exec))
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		}

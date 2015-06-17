From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT 4.1] sched/rt: Have the schedule IPI irq_work run in
 hard irq context
Date: Wed, 17 Jun 2015 15:52:25 -0400
Message-ID: <20150617155225.0fa2f6f4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:56563 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752334AbbFQTw2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2015 15:52:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


[ Sebastian, you'll need this for porting to 4.1 ]

As the sched rt pull work has moved to using irq_work IPI, having it
delayed to threading pretty much defeats the purpose. The handle also
expects interrupts to be disabled when called as it takes the rq locks.

Set the rt push ipi irq_work handle flag HARD_IRQ

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/rt.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-test.git/kernel/sched/rt.c
===================================================================
--- linux-test.git.orig/kernel/sched/rt.c	2015-06-17 09:30:02.430137824 -0400
+++ linux-test.git/kernel/sched/rt.c	2015-06-17 15:30:57.543881386 -0400
@@ -90,6 +90,7 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->push_cpu = nr_cpu_ids;
 	raw_spin_lock_init(&rt_rq->push_lock);
 	init_irq_work(&rt_rq->push_work, push_irq_work_func);
+	rt_rq->push_work.flags |= IRQ_WORK_HARD_IRQ;
 #endif
 #endif /* CONFIG_SMP */
 	/* We start is dequeued state, because no RT tasks are queued */

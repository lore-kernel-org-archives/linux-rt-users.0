Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:37484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbeGJSf2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:28 -0400
Date: Tue, 10 Jul 2018 18:53:18 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 8/6] sched, tracing: Fix trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180710165318.ibnwxuipxczf2x6t@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4ff648decf4712d39f184fc2df3163f43975575a ]

Since the following commit:

  b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")

the sched_pi_setprio trace point shows the "newprio" during a deboost:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=3D98
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio=120

This patch open codes __rt_effective_prio() in the tracepoint as the
'newprio' to get the old behaviour back / the correct priority:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"20 oldprio newprio=3D120
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"20 prev_prio=120

Peter suggested to open code the new priority so people using tracehook
could get the deadline data out.

Reported-by: Mansky Christian <man@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Link: http://lkml.kernel.org/r/20180524132647.gg6ziuogczdmjjzu@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/trace/events/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 516ae88cddf4..742682079acf 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -429,7 +429,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 
-- 
2.18.0


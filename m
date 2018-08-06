From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 08/22] sched, tracing: Fix trace_sched_pi_setprio() for deboosting
Date: Mon,  6 Aug 2018 04:17:24 -0500
Message-ID: <4e6fa907dfa79aafc97aa3fd2386b12ef6a42446.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit 4ff648decf4712d39f184fc2df3163f43975575a ]

Since the following commit:

  b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")

the sched_pi_setprio trace point shows the "newprio" during a deboost:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=98
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio0

This patch open codes __rt_effective_prio() in the tracepoint as the
'newprio' to get the old behaviour back / the correct priority:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"20 oldprio newprio=120
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"20 prev_prio0

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
Signed-off-by: Julia Cartwright <julia@ni.com>
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

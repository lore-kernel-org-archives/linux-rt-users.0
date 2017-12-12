From: Claudio Scordino <claudio@evidence.eu.com>
Subject: [PATCH v3] sched/deadline: runtime overrun signal
Date: Tue, 12 Dec 2017 12:10:24 +0100
Message-ID: <1513077024-25461-1-git-send-email-claudio@evidence.eu.com>
Cc: Juri Lelli <juri.lelli@gmail.com>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Juri Lelli <juri.lelli@gmail.com>

This patch adds the possibility of getting the delivery of a SIGXCPU
signal whenever there is a runtime overrun. The request is done through
the sched_flags field within the sched_attr structure.

Forward port of https://lkml.org/lkml/2009/10/16/170

Signed-off-by: Juri Lelli <juri.lelli@gmail.com>
Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>
CC: linux-rt-users <linux-rt-users@vger.kernel.org>
---
Changes from v2:

 - do not use a dubious signed bitfield for the dl_overrun flag

Changes from v1:

 - fix: do not send the signal in case of yield (reported by Mathieu Poirier)
 - removed the deadline miss signal because not needed in most of the cases
---
 include/linux/sched.h          |  4 ++++
 include/uapi/linux/sched.h     |  1 +
 kernel/sched/core.c            |  3 ++-
 kernel/sched/deadline.c        |  7 +++++++
 kernel/time/posix-cpu-timers.c | 20 ++++++++++++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 21991d6..a62a2f1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -472,11 +472,15 @@ struct sched_dl_entity {
 	 * has not been executed yet. This flag is useful to avoid race
 	 * conditions between the inactive timer handler and the wakeup
 	 * code.
+	 *
+	 * @dl_overrun tells if the task asked to be informed about runtime
+	 * overruns.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_boosted        : 1;
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
+	unsigned int			dl_overrun	  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 30a9e51..beb8ecd 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -49,5 +49,6 @@
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
+#define SCHED_FLAG_DL_OVERRUN		0x04
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75554f3..5bb67af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4041,7 +4041,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (attr->sched_flags &
-		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
+		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM |
+			SCHED_FLAG_DL_OVERRUN))
 		return -EINVAL;
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2473736..72554d1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1155,6 +1155,12 @@ static void update_curr_dl(struct rq *rq)
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
+
+		/* If requested, inform the user about runtime overruns. */
+		if (dl_runtime_exceeded(dl_se) &&
+				(dl_se->flags & SCHED_FLAG_DL_OVERRUN))
+			dl_se->dl_overrun = 1;
+
 		__dequeue_task_dl(rq, curr, 0);
 		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
@@ -2566,6 +2572,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_throttled = 0;
 	dl_se->dl_yielded = 0;
 	dl_se->dl_non_contending = 0;
+	dl_se->dl_overrun = 0;
 }
 
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 1f27887a..48281d9 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -14,6 +14,7 @@
 #include <linux/tick.h>
 #include <linux/workqueue.h>
 #include <linux/compat.h>
+#include <linux/sched/deadline.h>
 
 #include "posix-timers.h"
 
@@ -791,6 +792,16 @@ check_timers_list(struct list_head *timers,
 	return 0;
 }
 
+static inline void check_dl_overrun(struct task_struct *tsk)
+{
+	if (tsk->dl.dl_overrun) {
+		tsk->dl.dl_overrun = 0;
+		pr_info("runtime overrun: %s[%d]\n",
+				tsk->comm, task_pid_nr(tsk));
+		__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+	}
+}
+
 /*
  * Check for any per-thread CPU timers that have fired and move them off
  * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
@@ -804,6 +815,9 @@ static void check_thread_timers(struct task_struct *tsk,
 	u64 expires;
 	unsigned long soft;
 
+	if (dl_task(tsk))
+		check_dl_overrun(tsk);
+
 	/*
 	 * If cputime_expires is zero, then there are no active
 	 * per thread CPU timers.
@@ -906,6 +920,9 @@ static void check_process_timers(struct task_struct *tsk,
 	struct task_cputime cputime;
 	unsigned long soft;
 
+	if (dl_task(tsk))
+		check_dl_overrun(tsk);
+
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
@@ -1111,6 +1128,9 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
 			return 1;
 	}
 
+	if (dl_task(tsk) && tsk->dl.dl_overrun)
+		return 1;
+
 	return 0;
 }
 
-- 
2.7.4

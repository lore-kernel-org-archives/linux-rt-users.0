From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/7] simplewait: do we make barriers reflect what was in use in -rt?
Date: Fri, 17 Oct 2014 20:23:02 -0400
Message-ID: <1413591782-23453-8-git-send-email-paul.gortmaker@windriver.com>
References: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

 *** not for merge ; for discussion only ***

This matches the simple wait code barrier usage with what was
in use in the -rt version of simplewait support - where without
this commit, it is matching the barrier usage from the existing
mainline complex wait code.

After the previous submission of simple wait for mainline, there was
some discussion about the valididty of the barriers between Steve
and Peter on IRC, so I'm putting this here as a point of discussion
to continue/close on that previous discussion.

One of the original -rt additions from Steve can be seen here:
	https://lkml.org/lkml/2013/8/19/275

With the delta highlighted here in this standalone change, it
almost seems that the additional barriers used in -rt are a
consequence of -rt using __set_current_state() instead of the
barrier version set_current_state() -- as the complex wait
version has an explicit comment of why it needs the barrier
enabled version of set_current_state() vs. the non-barrier one.

But that is just my guess; the barrier experts need to throw
their $0.02 into this discussion.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Not-signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 46e2591c22b6..21271b61aec8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -181,6 +181,8 @@ static inline int cwait_active(struct cwait_head *q)
 
 static inline int swait_active(struct swait_head *q)
 {
+	/* Make sure the condition is visible before checking list_empty() */
+	smp_mb();
 	return !list_empty(&q->task_list);
 }
 
@@ -205,6 +207,8 @@ static inline void __add_cwait(struct cwait_head *head, struct cwait *new)
 static inline void __add_swait(struct swait_head *head, struct swait *new)
 {
 	list_add(&new->node, &head->task_list);
+	/* We can't let the condition leak before the setting of head */
+	smp_mb();
 }
 
 /*
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 25e5886ed8d9..c0575973d4d4 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -298,7 +298,7 @@ void prepare_to_swait(struct swait_head *q, struct swait *wait, int state)
 
 	raw_spin_lock_irqsave(&q->lock, flags);
 	__prepare_to_swait(q, wait);
-	set_current_state(state);
+	__set_current_state(state);	/* urk! see cwait barrier note above */
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(prepare_to_swait);
-- 
1.9.2

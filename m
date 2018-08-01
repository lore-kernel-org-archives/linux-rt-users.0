From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] sched: drop is_special_task_state() check from
 __set_current_state_no_track()
Date: Wed, 1 Aug 2018 11:05:25 +0200
Message-ID: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The is_special_task_state() check in __set_current_state_no_track()
has been wrongly placed. __set_current_state_no_track() is used in RT
while a sleeping lock is acquired. It is used at the begin of the wait
loop with TASK_UNINTERRUPTIBLE and while leaving it and restoring the
original state. The latter part triggers the warning.

Drop the special state check. This is only used within the sleeping lock
implementation and the assignment happens while the PI lock is held.
While at it, drop set_current_state_no_track() because it has no users.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a0c1c0cae992..b20264e17b02 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -132,16 +132,9 @@ struct task_group;
 
 #define __set_current_state_no_track(state_value)		\
 	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->state = (state_value);			\
 	} while (0)
 
-#define set_current_state_no_track(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		smp_store_mb(current->state, (state_value));	\
-	} while (0)
-
 #define set_special_state(state_value)					\
 	do {								\
 		unsigned long flags; /* may shadow */			\
@@ -196,7 +189,6 @@ struct task_group;
 	smp_store_mb(current->state, (state_value))
 
 #define __set_current_state_no_track(state_value)	__set_current_state(state_value)
-#define set_current_state_no_track(state_value)		set_current_state(state_value)
 
 /*
  * set_special_state() should be used for those states when the blocking task
-- 
2.18.0

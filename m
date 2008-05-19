From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 2/8] rearrange rt_spin_lock_slowlock sleeping code
Date: Mon, 19 May 2008 13:07:22 -0400
Message-ID: <20080519170721.6820.47680.stgit@novell1.haskins.net>
References: <20080519170356.6820.5274.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	pavel@ucw.cz, acme@redhat.com, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com, ghaskins@novell.com
To: mingo@elte.hu, peterz@infradead.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762675AbYESRkn@vger.kernel.org>
In-Reply-To: <20080519170356.6820.5274.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current logic makes rather coarse adjustments to current->state since
it is planning on sleeping anyway.  We want to eventually move to an
adaptive (e.g. optional sleep) algorithm, so we tighten the scope of the
adjustments to bracket the schedule().  This should yield correct behavior
with or without the adaptive features that are added later in the series.
We add it here as a separate patch for greater review clarity on smaller
changes.

Thanks to Steven Rostedt for suggesting a cleanup to remove an extra
update_current(RUNNING_MUTEX) left over from the early days of
instrumentation.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/rtmutex.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 0d3f76f..223557f 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -666,6 +666,14 @@ rt_spin_lock_fastunlock(struct rt_mutex *lock,
 		slowfn(lock);
 }
 
+static inline void
+update_current(unsigned long new_state, unsigned long *saved_state)
+{
+	unsigned long state = xchg(&current->state, new_state);
+	if (unlikely(state == TASK_RUNNING))
+		*saved_state = TASK_RUNNING;
+}
+
 /*
  * Slow path lock function spin_lock style: this variant is very
  * careful not to miss any non-lock wakeups.
@@ -705,7 +713,7 @@ rt_spin_lock_slowlock(struct rt_mutex *lock)
 	 * saved_state accordingly. If we did not get a real wakeup
 	 * then we return with the saved state.
 	 */
-	saved_state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
+	saved_state = current->state;
 
 	for (;;) {
 		unsigned long saved_flags;
@@ -737,14 +745,13 @@ rt_spin_lock_slowlock(struct rt_mutex *lock)
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		schedule_rt_mutex(lock);
+		update_current(TASK_UNINTERRUPTIBLE, &saved_state);
+		if (waiter.task)
+			schedule_rt_mutex(lock);
 
 		spin_lock_irqsave(&lock->wait_lock, flags);
 		current->flags |= saved_flags;
 		current->lock_depth = saved_lock_depth;
-		state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
-		if (unlikely(state == TASK_RUNNING))
-			saved_state = TASK_RUNNING;
 	}
 
 	state = xchg(&current->state, saved_state);

From: Alexander Fyodorov <halcy@yandex.ru>
Subject: [PATCH rt] Fix races in ptrace
Date: Wed, 24 Jul 2013 20:23:27 +0400
Message-ID: <102271374683007@web8f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward12.mail.yandex.net ([95.108.130.94]:41687 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350Ab3GXQ3K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Jul 2013 12:29:10 -0400
Received: from web8f.yandex.ru (web8f.yandex.ru [95.108.130.105])
	by forward12.mail.yandex.net (Yandex) with ESMTP id 18009C2184E
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2013 20:23:28 +0400 (MSK)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I ran into a race on 2.6.33-rt kernel which I think still exists in the latest RT patches. The following patch fixes it but it may be incomplete: probably spinlock should be taken in all other places that check saved_state too.  I only compile-tested this patch for 3.6-rt.


read_lock(&tasklist_lock) in ptrace_stop() is converted to mutex on RT kernel, and it can remove __TASK_TRACED from task->state (by moving it to task->saved_state). If parent does wait() on child followed by a sys_ptrace call, the following race can happen:

 - child sets __TASK_TRACED in ptrace_stop()
 - parent does wait() which eventually calls wait_task_stopped() and returns child's pid
 - child blocks on read_lock(&tasklist_lock) in ptrace_stop() and moves __TASK_TRACED flag to saved_state
 - parent calls sys_ptrace, which calls ptrace_check_attach() and wait_task_inactive()

ptrace_check_attach() checks only child->state and will fail, and wait_task_inactive() checks both child->state and child->saved_state but it doesn't hold child->pi_lock so it can fail because of memory ordering too. Locking child->pi_lock and checking saved_state solves both races.

Signed-off-by: Alexander Fyodorov <halcy <at> yandex.ru>

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a232bb5..79b5f5d 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -159,8 +159,20 @@ int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 		spin_lock_irq(&child->sighand->siglock);
 		WARN_ON_ONCE(task_is_stopped(child));
 		if (ignore_state || (task_is_traced(child) &&
-				     !(child->jobctl & JOBCTL_LISTENING)))
+				     !(child->jobctl & JOBCTL_LISTENING))) {
 			ret = 0;
+		} else {
+			/*
+			 * Test again before failing, but this time take
+			 * the spinlock and look at child->saved_state
+			 */
+			raw_spin_lock(&child->pi_lock);
+			if ((task_is_traced(child) ||
+					(child->saved_state & __TASK_TRACED)) &&
+					!(child->jobctl & JOBCTL_LISTENING))
+				ret = 0;
+			raw_spin_unlock(&child->pi_lock);
+		}
 		spin_unlock_irq(&child->sighand->siglock);
 	}
 	read_unlock(&tasklist_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5051ca6..a9cb295 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1215,8 +1215,21 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 */
 		while (task_running(rq, p)) {
 			if (match_state && unlikely(p->state != match_state)
-			    && unlikely(p->saved_state != match_state))
-				return 0;
+			    && unlikely(p->saved_state != match_state)) {
+				/*
+				 * Check again under spinlock
+				 */
+				raw_spin_lock_irqsave(&p->pi_lock, flags);
+
+				if (unlikely(p->state != match_state &&
+					     p->saved_state != match_state)) {
+					raw_spin_unlock_irqrestore(&p->pi_lock,
+							flags);
+					return 0;
+				}
+
+				raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+			}
 			cpu_relax();
 		}
 

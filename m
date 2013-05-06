From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.8.11-rt8
Date: Mon, 6 May 2013 12:25:34 +0200
Message-ID: <20130506102534.GC22348@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51459 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab3EFKZf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 May 2013 06:25:35 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.8.11-rt8 release.

changes since v3.8.11-rt7:
- suspend / resume related fix has been fixed
- don't wakeup blocked workers (Steven Rostedt) 

Known issues:

    - SLxB is broken on PowerPC, e500 based cpus. Can't repdroduce the
      problem on mpc5200 based board.

The delta patch against v3.8.11-rt7 is appended below and can be found here:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.8/incr/patch-3.8.11-rt7-rt8.patch.xz

The RT patch against 3.8.11 can be found here:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.8.11-rt8.patch.xz

The split quilt queue is available at:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patches-3.8.11-rt8.tar.xz

Sebastian

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ec9d1f..505e08f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3144,8 +3144,10 @@ static void __sched __schedule(void)
 			 * If a worker went to sleep, notify and ask workqueue
 			 * whether it wants to wake up a task to maintain
 			 * concurrency.
+			 * Only call wake up if prev isn't blocked on a sleeping
+			 * spin lock.
 			 */
-			if (prev->flags & PF_WQ_WORKER) {
+			if (prev->flags & PF_WQ_WORKER && !prev->saved_state) {
 				struct task_struct *to_wakeup;
 
 				to_wakeup = wq_worker_sleeping(prev, cpu);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 99f943b..ea93e56 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -776,7 +776,7 @@ static void timekeeping_resume(void)
 		__timekeeping_inject_sleeptime(tk, &ts);
 	}
 	/* re-base the last cycle value */
-	tk->clock->cycle_last = tk->clock->read(tk->clock);
+	tk->cycle_last = tk->clock->cycle_last = tk->clock->read(tk->clock);
 	tk->ntp_error = 0;
 	timekeeping_suspended = 0;
 	timekeeping_update(tk, false, true);
diff --git a/localversion-rt b/localversion-rt
index 0454789..700c857 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8

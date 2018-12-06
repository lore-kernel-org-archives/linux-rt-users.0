From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] hrtimer: move state change before hrtimer_cancel in
 do_nanosleep()
Date: Thu, 6 Dec 2018 11:15:55 +0100
Message-ID: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

There is a small window between setting t->task to NULL and waking the
task up (which would set TASK_RUNNING). So the timer would fire, run and
set ->task to NULL while the other side/do_nanosleep() wouldn't enter
freezable_schedule(). After all we are peemptible here (in
do_nanosleep() and on the timer wake up path) and on KVM/virt the
virt-CPU might get preempted.
So do_nanosleep() wouldn't enter freezable_schedule() but cancel the
timer which is still running and wait for it via
hrtimer_wait_for_timer(). Then wait_event()/might_sleep() would complain
that it is invoked with state != TASK_RUNNING.
This isn't a problem since it would be reset to TASK_RUNNING later
anyway and we don't rely on the previous state.

Move the state update to TASK_RUNNING before hrtimer_cancel() so there
are no complains from might_sleep() about wrong state.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index bf0ec3fbbe797..851b2134e77f4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1785,12 +1785,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 		if (likely(t->task))
 			freezable_schedule();
 
+		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
-	__set_current_state(TASK_RUNNING);
 
 	if (!t->task)
 		return 0;
-- 
2.20.0.rc2

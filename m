From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/13] hrtimer: move state change before hrtimer_cancel in do_nanosleep()
Date: Mon, 07 Jan 2019 14:53:01 -0500
Message-ID: <20190107195333.322706801@goodmis.org>
References: <20190107195252.599921907@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 8115ac730fd5aa27134f002cf710204b5dd7cd5e ]

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

Cc: stable-rt@vger.kernel.org
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b59e009087a9..c8d806126381 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1753,12 +1753,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
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
2.19.2

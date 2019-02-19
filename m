From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
Date: Tue, 19 Feb 2019 17:08:43 +0100
Message-ID: <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
 <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In cpu_chill() the state is set to TASK_UNINTERRUPTIBLE and a timer is
programmed. On return the state is always TASK_RUNNING which means we
lose the state if it was something other than RUNNING. Also
set_current_state() sets ->task_state_change to within cpu_chill() which
is not expected.

Save the task state on entry and restore it on return. Simply set the
state in order to avoid updating ->task_state_change.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 851b2134e77f4..6f2736ec4b8ef 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1902,15 +1902,18 @@ void cpu_chill(void)
 {
 	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
+	long saved_state;
 
+	saved_state = current->state;
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
+	__set_current_state_no_track(saved_state);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
-- 
2.20.1

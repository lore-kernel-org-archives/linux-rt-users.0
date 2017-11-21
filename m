From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/8] timer/hrtimer: check properly for a running timer
Date: Tue, 21 Nov 2017 11:06:55 -0500
Message-ID: <20171121160705.806323930@goodmis.org>
References: <20171121160654.493640386@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org, Alexander Gerasiov <gq@cs.msu.su>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-timer-hrtimer-check-properly-for-a-running-timer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.97-rt111-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hrtimer_callback_running() checks only whether a timmer is running on a
CPU in hardirq-context. This is okay for !RT. For RT environment we move
most timers to the timer-softirq and therefore we therefore need to
check if the timer is running in the softirq context.

Cc: stable-rt@vger.kernel.org
Reported-by: Alexander Gerasiov <gq@cs.msu.su>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/hrtimer.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 8fbcdfa5dc77..ff317006d3e8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -455,7 +455,13 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  */
 static inline int hrtimer_callback_running(const struct hrtimer *timer)
 {
-	return timer->base->cpu_base->running == timer;
+	if (timer->base->cpu_base->running == timer)
+		return 1;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (timer->base->cpu_base->running_soft == timer)
+		return 1;
+#endif
+	return 0;
 }
 
 /* Forward a hrtimer so it expires after now: */
-- 
2.13.2

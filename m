From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/9] kernel/hrtimer: migrate deferred timer on CPU down
Date: Fri, 01 Dec 2017 20:37:01 -0500
Message-ID: <20171202013711.705546858@goodmis.org>
References: <20171202013658.149533964@goodmis.org>
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
        stable-rt@vger.kernel.org, Mike Galbraith <efault@gmx.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-kernel-hrtimer-migrate-deferred-timer-on-CPU-down.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.102-rt117-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hrtimers, which were deferred to the softirq context, and expire between
softirq shutdown and hrtimer migration are dangling around. If the CPU
goes back up the list head will be initialized and this corrupts the
timer's list. It will remain unnoticed until a hrtimer_cancel().
This moves those timers so they will expire.

Cc: stable-rt@vger.kernel.org
Reported-by: Mike Galbraith <efault@gmx.de>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ba3d60144838..759913626eec 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1880,6 +1880,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	if (!list_empty(&new_base->expired))
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+#endif
 }
 
 static void migrate_hrtimers(int scpu)
-- 
2.13.2

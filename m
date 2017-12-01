From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/15] kernel/hrtimer: migrate deferred timer on CPU down
Date: Fri, 01 Dec 2017 10:48:44 -0500
Message-ID: <20171201154912.462911236@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
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
Content-Disposition: inline; filename=0007-kernel-hrtimer-migrate-deferred-timer-on-CPU-down.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc1 stable review patch.
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
index 0797bd6eadb4..39e4435b8451 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1860,6 +1860,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	if (!list_empty(&new_base->expired))
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+#endif
 }
 
 int hrtimers_dead_cpu(unsigned int scpu)
-- 
2.13.2

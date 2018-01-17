From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/13] kernel/hrtimer: migrate deferred timer on CPU down
Date: Wed, 17 Jan 2018 10:14:13 -0500
Message-ID: <20180117151431.888304466@goodmis.org>
References: <20180117151404.093229667@goodmis.org>
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
Content-Disposition: inline; filename=0009-kernel-hrtimer-migrate-deferred-timer-on-CPU-down.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.91-rt98-rc1 stable review patch.
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
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/hrtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2c1597d2bd6d..2e869c707628 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1959,6 +1959,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		/* Clear the migration state bit */
 		timer->state &= ~HRTIMER_STATE_MIGRATE;
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

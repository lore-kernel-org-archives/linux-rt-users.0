From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 3/4] kernel/hrtimer: migrate deferred timer on CPU down
Date: Fri, 10 Nov 2017 10:33:25 -0600
Message-ID: <325304ee540e3c916d6c7b15f6e860b7729d138c.1510269414.git.julia@ni.com>
References: <cover.1510269414.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510269414.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.46-rt52-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
(cherry picked from commit b3c08bffdcdd23f1b3ca8d9c01e3b8a715e03d46)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/time/hrtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2c6be169bdc7..75c990b00525 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1951,6 +1951,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
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
2.14.2

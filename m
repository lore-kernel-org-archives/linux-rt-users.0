From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/24] sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
Date: Fri, 07 Sep 2018 16:58:58 -0400
Message-ID: <20180907205929.901024799@goodmis.org>
References: <20180907205857.262840394@goodmis.org>
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
        Mike Galbraith <efault@gmx.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

[ Upstream commit df7e8acc0c9a84979a448d215b8ef889efe4ac5a ]

CFS bandwidth control yields the inversion gripe below, moving
handling quells it.

|========================================================
|WARNING: possible irq lock inversion dependency detected
|4.16.7-rt1-rt #2 Tainted: G            E
|--------------------------------------------------------
|sirq-hrtimer/0/15 just changed the state of lock:
| (&cfs_b->lock){+...}, at: [<000000009adb5cf7>] sched_cfs_period_timer+0x28/0x140
|but this lock was taken by another, HARDIRQ-safe lock in the past: (&rq->lock){-...}
|and interrupts could create inverse lock ordering between them.
|other info that might help us debug this:
| Possible interrupt unsafe locking scenario:
|       CPU0                    CPU1
|       ----                    ----
|  lock(&cfs_b->lock);
|                               local_irq_disable();
|                               lock(&rq->lock);
|                               lock(&cfs_b->lock);
|  <Interrupt>
|    lock(&rq->lock);

Cc: stable-rt@vger.kernel.org
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36ef77839be4..51ecea4f5d16 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4684,9 +4684,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
-- 
2.18.0

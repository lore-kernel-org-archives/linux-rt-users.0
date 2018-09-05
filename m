From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 20/22] sched: Allow pinned user tasks to be awakened to the CPU they pinned
Date: Wed, 05 Sep 2018 08:28:14 -0400
Message-ID: <20180905122837.674583106@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
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

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

[ Upstream commit cd4d35ef89948221f7cd1751cee453943967364c ]

Since commit 7af443ee16976 ("sched/core: Require cpu_active() in
select_task_rq(), for user tasks") select_fallback_rq() will BUG() if
the CPU to which a task has pinned itself and pinned becomes
!cpu_active() while it slept.
The task will continue running on the to-be-removed CPU and will remove
itself from the CPU during takedown_cpu() (while cpuhp_pin_lock will be
acquired) and move to another CPU based on its mask after the
migrate_disable() section has been left.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a5ce37b90fca..6e6bd5262f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
-- 
2.18.0

From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [RFC 3/3] rt: Check if the task needs to migrate when re-enabling migration
Date: Fri, 16 Jun 2017 12:39:48 +0200
Message-ID: <99de119c39e3af618efdb2f79bf30e60ca42a6ec.1497607974.git.bristot@redhat.com>
References: <cover.1497607974.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497607974.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In the case of an affinity change during a migrate_disable section,
__set_cpus_allowed_ptr will not try to move the task from a CPU
in which it cannot execute anymore.

So, after enabling migration, if the current task cannot execute in
the current CPU anymore, migrate it away.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0396bf2..207bc85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3462,6 +3462,34 @@ void migrate_enable(void)
 			task_rq(p)->dl.dl_nr_migratory++;
 	}
 
+	/*
+	 * Check if the task can still run on this CPU. In the case of an
+	 * affinity change during a migrate_disable section,
+	 * __set_cpus_allowed_ptr will not try to move the task from a CPU
+	 * that the task cannot execute anymore.
+	 *
+	 * So, if the current task cannot execute in the current CPU anymore,
+	 * migrate it away.
+	 */
+	if (unlikely(!cpumask_test_cpu(task_cpu(p), &p->cpus_allowed))) {
+		const struct cpumask *cpu_mask = (p->flags & PF_KTHREAD) ?
+			cpu_online_mask : cpu_active_mask;
+
+		int dest_cpu = cpumask_any_and(cpu_mask, &p->cpus_allowed);
+		struct migration_arg arg = {p, dest_cpu};
+
+		/* Need help from migration thread: drop lock and wait. */
+		task_rq_unlock(rq, p, &rf);
+		unpin_current_cpu();
+		preempt_enable();
+		preempt_lazy_enable();
+
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+		tlb_migrate_finish(p->mm);
+
+		return;
+	}
+
 	task_rq_unlock(rq, p, &rf);
 	unpin_current_cpu();
 	preempt_enable();
-- 
2.9.4

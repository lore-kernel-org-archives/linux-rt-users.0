From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/13] sched/migrate_disable: Add export_symbol_gpl for __migrate_disabled
Date: Mon, 07 Jan 2019 14:52:57 -0500
Message-ID: <20190107195332.509917755@goodmis.org>
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
        tom.zanussi@linux.intel.com,
        Jonathan Rajott <jonathan.rajotte-julien@efficios.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c0f0dd3ced7abe307d8e89477dae2929e488ba6c ]

Jonathan reported that lttng/modules can't use __migrate_disabled().
This function is only used by sched/core itself and the tracing
infrastructure to report the migrate counter (lttng does probably the
same). Since the rework migrate_disable() it moved from sched.h to
preempt.h and is became an exported function instead of a "static
inline" due to the header recursion of preempt vs sched.

Since the compiler inlines the function for sched/core usage, add a
EXPORT_SYMBOL_GPL to allow the module/LTTNG usage.

Reported-by: Jonathan Rajott <jonathan.rajotte-julien@efficios.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ce950f24a7f..7c960cf07e7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1112,6 +1112,7 @@ int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
 }
+EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
 static void __do_set_cpus_allowed_tail(struct task_struct *p,
-- 
2.19.2

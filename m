From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [RFC 2/3] rt: Update nr_cpus_allowed if the affinity of a task changes while its migration is disabled
Date: Fri, 16 Jun 2017 12:39:47 +0200
Message-ID: <b141030d15fa0a465a1fb437111c68bc18add95d.1497607974.git.bristot@redhat.com>
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

Currently, if the affinity of a task changes when it is with migration
disabled, the nr_cpus_allowed is not being updated, creating an
inconsistency between nr_cpus_allowed and cpumask_weight(cpus_allowed)

This patch fixes this problem by calling set_cpus_allowed_common()
if the cpumask of a task changes while it is with migration disable.

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
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aeb3e12..0396bf2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1146,7 +1146,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	lockdep_assert_held(&p->pi_lock);
 
 	if (__migrate_disabled(p)) {
-		cpumask_copy(&p->cpus_allowed, new_mask);
+		set_cpus_allowed_common(p, new_mask);
 		return;
 	}
 
-- 
2.9.4

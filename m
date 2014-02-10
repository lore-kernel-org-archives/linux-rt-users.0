From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT 3/5] allow preemption in check_task_state
Date: Mon, 10 Feb 2014 17:28:16 +0100
Message-ID: <20140210162816.GA24267@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


A lockfree approach to check_task_state

This treates the state as an indicator variable and use it to probe 
saved_state lock free. There is actually no consistency demand on 
state/saved_state but rather a consistency demand on the transitions 
of the two variables but those transition, based on path inspection,
are not independent.

Its probably not faster than the lock/unlock case if uncontended - atleast
it does not show up in benchmark results, but it would never be hit by a 
full pi-boost cycle as there is no contention.

This also was tested against the test-case from Sebastian as well as 
rnning a few scripted gdb breakpoint debugging/single-stepping loops
to trigger this.

Tested-by: Andreas Platschek <platschek@ict.tuwien.ac.at>
Tested-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/sched/core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf93f63..5690ba3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1074,11 +1074,17 @@ static int migration_cpu_stop(void *data);
 static bool check_task_state(struct task_struct *p, long match_state)
 {
 	bool match = false;
+	long state, saved_state;
+
+	/* catch restored state */
+	do {
+		state = p->state;
+		saved_state = p->saved_state;
+		rmb();  /* make sure we actually catch updates */
+	} while (state != p->state);
 
-	raw_spin_lock_irq(&p->pi_lock);
 	if (p->state == match_state || p->saved_state == match_state)
 		match = true;
-	raw_spin_unlock_irq(&p->pi_lock);
 
 	return match;
 }
-- 
1.7.2.5

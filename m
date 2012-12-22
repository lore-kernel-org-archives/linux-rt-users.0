From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] sched: Adjust sched_reset_on_fork when nothing else changes
Date: Sat, 22 Dec 2012 10:49:23 -0500
Message-ID: <20121222154947.071059966@goodmis.org>
References: <20121222154922.724242376@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable@vger.kernel.org>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-sched-Adjust-sched_reset_on_fork-when-nothing-else-c.patch
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If the policy and priority remain unchanged a possible modification of
sched_reset_on_fork gets lost in the early exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
---
 kernel/sched.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index cdf9484..9af4bbe 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5719,11 +5719,13 @@ recheck:
 	}
 
 	/*
-	 * If not changing anything there's no need to proceed further:
+	 * If not changing anything there's no need to proceed
+	 * further, but store a possible modification of
+	 * reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy && (!rt_policy(policy) ||
 			param->sched_priority == p->rt_priority))) {
-
+		p->sched_reset_on_fork = reset_on_fork;
 		__task_rq_unlock(rq);
 		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 		return 0;
-- 
1.7.10.4

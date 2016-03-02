From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/22] kernel/softirq: use cond_resched_rcu_qs() on -RT as well
 (run_ksoftirqd())
Date: Wed, 02 Mar 2016 10:09:03 -0500
Message-ID: <20160302151110.893912638@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-kernel-softirq-use-cond_resched_rcu_qs-on-RT-as-well.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.15-rt18-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The upstream changes were:
6047967 ksoftirqd: Use new cond_resched_rcu_qs() function
28423ad ksoftirqd: Enable IRQs and call cond_resched() before poking RCU

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0fd93311536f..f4c2e679a7d7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -599,8 +599,8 @@ static void run_ksoftirqd(unsigned int cpu)
 
 	do_current_softirqs();
 	current->softirq_nestcnt--;
-	rcu_note_context_switch();
 	local_irq_enable();
+	cond_resched_rcu_qs();
 }
 
 /*
-- 
2.7.0

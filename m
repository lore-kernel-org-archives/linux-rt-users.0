From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/10] kernel: softirq: unlock with irqs on
Date: Wed, 02 Mar 2016 10:51:05 -0500
Message-ID: <20160302155111.192159170@goodmis.org>
References: <20160302155100.873557484@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-kernel-softirq-unlock-with-irqs-on.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.97-rt107-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

We unlock the lock while the interrupts are off. This isn't a problem
now but will get because the migrate_disable() + enable are not
symmetrical in regard to the status of interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ce2cfd3910d4..463523131bfa 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -580,8 +580,10 @@ static void do_current_softirqs(int need_rcu_bh_qs)
 			do_single_softirq(i, need_rcu_bh_qs);
 		}
 		softirq_clr_runner(i);
-		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
+		local_irq_enable();
+		unlock_softirq(i);
+		local_irq_disable();
 	}
 }
 
-- 
2.7.0

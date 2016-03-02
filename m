From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/13] kernel: softirq: unlock with irqs on
Date: Wed, 02 Mar 2016 10:48:54 -0500
Message-ID: <20160302154905.018001213@goodmis.org>
References: <20160302154847.937325532@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60541 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810AbcCBPtJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:49:09 -0500
Content-Disposition: inline; filename=0007-kernel-softirq-unlock-with-irqs-on.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.54-rt74-rc1 stable review patch.
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
index cce9723c5a18..7c8e36bf9e2a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -578,8 +578,10 @@ static void do_current_softirqs(int need_rcu_bh_qs)
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



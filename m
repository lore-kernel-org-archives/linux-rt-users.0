From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/22] kernel: softirq: unlock with irqs on
Date: Wed, 02 Mar 2016 10:09:11 -0500
Message-ID: <20160302151112.167131599@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:55160 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605AbcCBPLR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:11:17 -0500
Content-Disposition: inline; filename=0012-kernel-softirq-unlock-with-irqs-on.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.15-rt18-rc1 stable review patch.
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
index d1e999e74d23..2ca63cc1469e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -563,8 +563,10 @@ static void do_current_softirqs(void)
 			do_single_softirq(i);
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



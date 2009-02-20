From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH-rt26] irq handle: use cached status instead of dereference NULL action
Date: Fri, 20 Feb 2009 15:17:55 -0500
Message-ID: <1235161075-11358-1-git-send-email-paul.gortmaker@windriver.com>
Cc: tglx@linutronix.de
To: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47079 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZBTUS1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2009 15:18:27 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Patch "irq-tracer-fix.patch" from the additions at rt13 of the
26 preempt_rt patch set introduced a test on action->flags, but it
comes at the end of a loop where we will have run all the
chained handlers until action==NULL.  Since we have stored the
action->flags (or'd) in status while walking the action chain,
use status in the check instead.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/irq/handle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index ed6deaa..314c9d7 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -164,7 +164,7 @@ irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
 	} while (action);
 
 	if (status & IRQF_SAMPLE_RANDOM) {
-		if (hardirq_count() && (action->flags & IRQF_DISABLED))
+		if (hardirq_count() && (status & IRQF_DISABLED))
 			local_irq_enable();
 		add_interrupt_randomness(irq);
 	}
-- 
1.6.0.4


From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] irq_work: Hide access to hirq_work_list in
 PREEMPT_RT_FULL
Date: Thu, 12 Mar 2015 18:08:57 -0400
Message-ID: <20150312180857.31a0f7d1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:59556 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752179AbbCLWJA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 18:09:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The hirq_work_list is only defined when PREEMPT_RT_FULL is configured.
Most access to it is within an #ifdef CONFIG_PREEMPT_RT_FULL, except
for one. Encapsulate that location too.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 0c6491228b17..4b53470bf97b 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -147,7 +147,9 @@ bool irq_work_needs_cpu(void)
 
 	if (llist_empty(raised))
 		if (llist_empty(lazy))
+#ifdef CONFIG_PREEMPT_RT_FULL
 			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
+#endif
 				return false;
 
 	/* All work should have been flushed before going offline */

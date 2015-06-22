From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT] irq_work: Use proper BUG_ON_NONRT()
Date: Mon, 22 Jun 2015 15:43:58 -0400
Message-ID: <20150622154358.279eb0d9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:55726 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751105AbbFVToA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 15:44:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We added BUG_ON_NONRT() to handle those cases that don't apply when
PREEMPT_RT is enabled. No need to open code the check using
IS_ENABLED().

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9678fd1382a7..5a0f4525139c 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -144,7 +144,7 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work;
 	struct llist_node *llnode;
 
-	BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled());
+	BUG_ON_NONRT(!irqs_disabled());
 
 	if (llist_empty(list))
 		return;
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in

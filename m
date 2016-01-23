From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch-rt] sched: fix ->nr_cpus_allowed = 1 transcription error
 during migrate_disable() cleanup
Date: Sat, 23 Jan 2016 08:11:53 +0100
Message-ID: <1453533113.3798.3.camel@gmail.com>
References: <20160122230859.GC3883@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34027 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbcAWHL5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jan 2016 02:11:57 -0500
In-Reply-To: <20160122230859.GC3883@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Setting p->nr_cpus_allowed accidentally wandered into migrate_disable()
during the cleanup - kill it. 

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3180,7 +3180,6 @@ void migrate_disable(void)
 	preempt_lazy_disable();
 	pin_current_cpu();
 	p->migrate_disable = 1;
-	p->nr_cpus_allowed = 1;
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_disable);

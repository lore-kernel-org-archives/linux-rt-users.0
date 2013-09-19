From: Thomas Pfaff <tpfaff@pcs.com>
Subject: [PATCH 3.4.62-rt77] fix irq thread scheduling
Date: Thu, 19 Sep 2013 11:02:57 +0200
Message-ID: <alpine.LNX.2.00.1309191038050.7134@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
	<rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pcs.de ([145.253.69.50]:19875 "EHLO exchange5.pcs.ditec.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753156Ab3ISJIr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Sep 2013 05:08:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If an irq is requested during device open, for example by opening a serial 
device, then request_irq is called in the context of the opening process.
If the process lacks off CAP_SYS_NICE the irq thread is running with SCHED_OTHER 
priority.

The problem exists in other real time patches as well, 3.10 seems to be ok.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff -urp linux-3.4.62-rt.old/kernel/irq/manage.c linux-3.4.62-rt/kernel/irq/manage.c
--- linux-3.4.62-rt.old/kernel/irq/manage.c	2013-09-16 10:13:15.365559288 +0200
+++ linux-3.4.62-rt/kernel/irq/manage.c	2013-09-19 10:22:40.092831656 +0200
@@ -1024,7 +1024,7 @@ __setup_irq(unsigned int irq, struct irq
 			goto out_mput;
 		}
 
-		sched_setscheduler(t, SCHED_FIFO, &param);
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
 
 		/*
 		 * We keep the reference to the task struct even if

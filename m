From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt 4/9] ifdef raise_softirq_irqoff wakeup
Date: Sun, 29 Jul 2007 19:45:38 -0700
Message-ID: <20070730024719.782847315@mvista.com>
References: <20070730024534.369897977@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41611 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936593AbXG3CrW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jul 2007 22:47:22 -0400
Content-Disposition: inline; filename=softirq-raise-wakeup-fix.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

raise_softirq is called every timer interrupt in run_local_timers(),
which causes a thread wakeup to happen every timer interrupt. This
happens in !CONFIG_PREEMPT_SOFTIRQS, which means the wakeup is most
likely not needed. In addition it also fouls calc_load() since it's,
agian, observing at least one thread running on every invocation.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
 
---
 kernel/softirq.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.22/kernel/softirq.c
===================================================================
--- linux-2.6.22.orig/kernel/softirq.c
+++ linux-2.6.22/kernel/softirq.c
@@ -508,7 +508,9 @@ inline fastcall void raise_softirq_irqof
 {
 	__do_raise_softirq_irqoff(nr);
 
+#ifdef CONFIG_PREEMPT_SOFTIRQS
 	wakeup_softirqd(nr);
+#endif
 }
 
 EXPORT_SYMBOL(raise_softirq_irqoff);

-- 

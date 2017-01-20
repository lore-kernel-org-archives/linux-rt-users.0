From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] x86/mm/cpa: avoid wbinvd() for PREEMPT_RT_FULL
Date: Fri, 20 Jan 2017 23:42:57 +0100
Message-ID: <87o9z1ic9a.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbdATWnb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2017 17:43:31 -0500
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Although wbinvd() is faster than flushing many individual pages, it
blocks the memory bus for "long" periods of time (>100us), thus
directly causing unusually large latencies for PREEMPT_RT_FULL. For
1024 pages, flushing those pages individually can take up to 2200us,
but the task remains fully preemptible during that time.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/x86/mm/pageattr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e3353c9..a182477 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -214,7 +214,12 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/* wbinvd() causes ugly latencies, avoid it */
+	unsigned long do_wbinvd = 0;
+#else
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
+#endif
 
 	BUG_ON(irqs_disabled());
 
-- 
2.9.3

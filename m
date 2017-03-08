From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/8] x86/mm/cpa: avoid wbinvd() for PREEMPT
Date: Wed, 08 Mar 2017 15:20:58 -0500
Message-ID: <20170308202117.460904513@goodmis.org>
References: <20170308202055.192561119@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>, stable-rt@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753711AbdCHUZc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Mar 2017 15:25:32 -0500
Content-Disposition: inline; filename=0003-x86-mm-cpa-avoid-wbinvd-for-PREEMPT.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.48-rt54-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: John Ogness <john.ogness@linutronix.de>

Although wbinvd() is faster than flushing many individual pages, it
blocks the memory bus for "long" periods of time (>100us), thus
directly causing unusually large latencies on all CPUs, regardless
of any CPU isolation features that may be active.

For 1024 pages, flushing those pages individually can take up to
2200us, but the task remains fully preemptible during that time.

Cc: stable-rt@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/mm/pageattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e5545f2105f6..3c4b0318a363 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -211,7 +211,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Avoid wbinvd() because it causes latencies on all CPUs,
+	 * regardless of any CPU isolation that may be in effect.
+	 */
+	unsigned long do_wbinvd = 0;
+#else
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
+#endif
 
 	BUG_ON(irqs_disabled());
 
-- 
2.10.2



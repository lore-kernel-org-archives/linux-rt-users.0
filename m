From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCHv2] x86/mm/cpa: avoid wbinvd() for PREEMPT
Date: Mon, 30 Jan 2017 09:41:21 +0100
Message-ID: <87o9ypvt1q.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: fenghua.yu@intel.com
Cc: h.peter.anvin@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: tony.luck@intel.com
Cc: davidcc@google.com
Cc: dave.hansen@intel.com
Cc: eranian@google.com
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Although wbinvd() is faster than flushing many individual pages, it
blocks the memory bus for "long" periods of time (>100us), thus
directly causing unusually large latencies on all CPUs, regardless
of any CPU isolation features that may be active.

For 1024 pages, flushing those pages individually can take up to
2200us, but the task remains fully preemptible during that time.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 v1-v2: changed CONFIG_PREEMPT_RT_FULL to CONFIG_PREEMPT

 It was suggested that wbinvd() is removed altogether, but any
 kernel configured without CONFIG_PREEMPT probably doesn't care
 about latencies.

 arch/x86/mm/pageattr.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 5a287e5..ba1393d 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -214,7 +214,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
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
1.7.10.4

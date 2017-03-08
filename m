From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/7] x86/mm/cpa: avoid wbinvd() for PREEMPT
Date: Wed, 08 Mar 2017 15:30:09 -0500
Message-ID: <20170308203022.136182205@goodmis.org>
References: <20170308203007.731237400@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-x86-mm-cpa-avoid-wbinvd-for-PREEMPT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.105-rt120-rc1 stable review patch.
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
index aabdf762f592..ca212268cedd 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -210,7 +210,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
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

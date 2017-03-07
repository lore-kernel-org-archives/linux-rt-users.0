From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 4/9] x86/mm/cpa: avoid wbinvd() for PREEMPT
Date: Tue, 7 Mar 2017 16:32:54 -0600
Message-ID: <20dc04833e45cf6a3b5fcee0f357e4e829a78b8a.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        <stable-rt@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
(cherry picked from commit 9e539d7327b265c639c859ab1fb7d3699ba0cb19)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 arch/x86/mm/pageattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 2dd9b3ad3bb5..4314b9103ff0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -209,7 +209,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
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
2.11.1

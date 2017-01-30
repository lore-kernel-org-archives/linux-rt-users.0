From: tip-bot for John Ogness <tipbot@zytor.com>
Subject: [tip:x86/mm] x86/mm/cpa: Avoid wbinvd() for PREEMPT
Date: Mon, 30 Jan 2017 06:36:51 -0800
Message-ID: <tip-459fbe00693449fade2d1bc802791b081c94edcf@git.kernel.org>
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, linux-rt-users@vger.kernel.org,
          john.ogness@linutronix.de, peterz@infradead.org,
          bigeasy@linutronix.de, hpa@zytor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: peterz@infradead.org, tglx@linutronix.de,
        john.ogness@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, hpa@zytor.com,
        bigeasy@linutronix.de
To: linux-tip-commits@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:54450 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdA3OhZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jan 2017 09:37:25 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit-ID:  459fbe00693449fade2d1bc802791b081c94edcf
Gitweb:     http://git.kernel.org/tip/459fbe00693449fade2d1bc802791b081c94edcf
Author:     John Ogness <john.ogness@linutronix.de>
AuthorDate: Mon, 30 Jan 2017 09:41:21 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jan 2017 15:33:52 +0100

x86/mm/cpa: Avoid wbinvd() for PREEMPT

Although wbinvd() is faster than flushing many individual pages, it blocks
the memory bus for "long" periods of time (>100us), thus directly causing
unusually large latencies on all CPUs, regardless of any CPU isolation
features that may be active. This is an unpriviledged operatation as it is
exposed to user space via the graphics subsystem.

For 1024 pages, flushing those pages individually can take up to 2200us,
but the task remains fully preemptible during that time.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/mm/pageattr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 5a287e5..28d4213 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -214,7 +214,20 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Avoid wbinvd() because it causes latencies on all CPUs,
+	 * regardless of any CPU isolation that may be in effect.
+	 *
+	 * This should be extended for CAT enabled systems independent of
+	 * PREEMPT because wbinvd() does not respect the CAT partitions and
+	 * this is exposed to unpriviledged users through the graphics
+	 * subsystem.
+	 */
+	unsigned long do_wbinvd = 0;
+#else
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
+#endif
 
 	BUG_ON(irqs_disabled());
 

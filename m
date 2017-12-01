From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/15] PM / CPU: replace raw_notifier with atomic_notifier (fixup)
Date: Fri, 01 Dec 2017 10:48:43 -0500
Message-ID: <20171201154912.315922141@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdLAPtN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 10:49:13 -0500
Content-Disposition: inline; filename=0006-PM-CPU-replace-raw_notifier-with-atomic_notifier-fix.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.9.65-rt57-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The original patch changed betwen its posting and what finally went into
Rafael's tree so here is the delta.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cpu_pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 10f4640f991e..67b02e138a47 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -28,8 +28,15 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
 {
 	int ret;
 
+	/*
+	 * __atomic_notifier_call_chain has a RCU read critical section, which
+	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
+	 * RCU know this.
+	 */
+	rcu_irq_enter_irqson();
 	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
+	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
-- 
2.13.2



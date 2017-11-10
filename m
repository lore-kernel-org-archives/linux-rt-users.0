From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 1/4] PM / CPU: replace raw_notifier with atomic_notifier
Date: Fri, 10 Nov 2017 10:33:23 -0600
Message-ID: <c50243950f97e51100f5f9ab7d9f4fd59326bf81.1510269414.git.julia@ni.com>
References: <cover.1510269414.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510269414.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.46-rt52-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The original patch changed betwen its posting and what finally went into
Rafael's tree so here is the delta.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit f648e23dac72deef07f25e05fc09dbbc209dbd33)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/cpu_pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 9da42f83ee03..d1d1c3961553 100644
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
2.14.2

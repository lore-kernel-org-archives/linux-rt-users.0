From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] kernel/irq_work: fix non RT case
Date: Tue, 04 Aug 2015 21:18:32 -0400
Message-ID: <20150805011853.189005577@goodmis.org>
References: <20150805011826.881627614@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40693 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbbHEBS5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 21:18:57 -0400
Content-Disposition: inline; filename=0006-kernel-irq_work-fix-non-RT-case.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.18-rt16-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

After the deadlock fixed, the checked got somehow away and broke the non-RT
case which could invoke IRQ-work from softirq context.

Cc: stable-rt@vger.kernel.org
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/time/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a29ab1a17023..3a978d000fce 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1452,7 +1452,8 @@ void update_process_times(int user_tick)
 	rcu_check_callbacks(cpu, user_tick);
 
 #if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
+	if (in_irq())
+		irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }
-- 
2.1.4



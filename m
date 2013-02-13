From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/16] softirq: Fix nohz pending issue for real
Date: Wed, 13 Feb 2013 17:12:02 +0100
Message-ID: <1360771932-27150-8-git-send-email-bigeasy@linutronix.de>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59729 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934364Ab3BMQNQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 11:13:16 -0500
In-Reply-To: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

We really need to iterate through all softirqs to find a potentially
blocked runner.

T1 runs softirq X (that cleared pending bit for X)

Interrupt raises softirq Y

T1 gets blocked on a lock and lock owner is not runnable

T1 schedules out

CPU goes idle and complains about pending softirq Y.

Now iterating over all softirqs lets us find the runner for X and
eliminate Y from the to warn about list as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 385fcea..1a0145a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -100,20 +100,15 @@ void softirq_check_pending_idle(void)
 {
 	static int rate_limit;
 	struct softirq_runner *sr = &__get_cpu_var(softirq_runners);
-	u32 warnpending, pending = local_softirq_pending();
+	u32 warnpending = local_softirq_pending();
+	int i;
 
 	if (rate_limit >= 10)
 		return;
 
-	warnpending = pending;
-
-	while (pending) {
-		struct task_struct *tsk;
-		int i = __ffs(pending);

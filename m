From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/7] sched: remove useless nointeractive state
Date: Fri, 19 Dec 2008 16:02:47 -0000
Message-ID: <20081219155555.980925587@linutronix.de>
References: <20081219155504.735865178@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48480 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbYLSQSi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Dec 2008 11:18:38 -0500
Content-Disposition: inline;
	filename=sched-remove-useless-nointeractive-state.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

gone task state reintroduced by rtmutex patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.24/include/linux/sched.h
===================================================================
--- linux-2.6.24.orig/include/linux/sched.h
+++ linux-2.6.24/include/linux/sched.h
@@ -202,8 +202,7 @@ extern struct semaphore kernel_sem;
 #define EXIT_ZOMBIE		32
 #define EXIT_DEAD		64
 /* in tsk->state again */
-#define TASK_NONINTERACTIVE	128
-#define TASK_DEAD		256
+#define TASK_DEAD		128
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)

-- 


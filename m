From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 1/4] RT: Wrap the RQ notion of priority to make it conditional
Date: Tue, 16 Oct 2007 12:08:58 -0400
Message-ID: <20071016160858.5202.51932.stgit@novell1.haskins.net>
References: <20071016160226.5202.53965.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:43761
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751091AbXJPQWq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2007 12:22:46 -0400
In-Reply-To: <20071016160226.5202.53965.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A little cleanup to avoid #ifdef proliferation later in the series

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 0a1ad0e..1866a6e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -365,6 +365,16 @@ struct rq {
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 static DEFINE_MUTEX(sched_hotcpu_mutex);
 
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+static inline void set_rq_prio(struct rq *rq, int prio)
+{
+	rq->curr_prio = prio;
+}
+
+#else
+#define set_rq_prio(rq, prio) do { } while(0)
+#endif
+
 static inline void check_preempt_curr(struct rq *rq, struct task_struct *p)
 {
 	rq->curr->sched_class->check_preempt_curr(rq, p);
@@ -2331,9 +2341,9 @@ static inline void finish_task_switch(struct rq *rq, struct task_struct *prev)
 	 */
 	prev_state = prev->state;
 	_finish_arch_switch(prev);
-#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
-	rq->curr_prio = current->prio;
-#endif
+
+	set_rq_prio(rq, current->prio);
+
 	finish_lock_switch(rq, prev);
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
 	/*

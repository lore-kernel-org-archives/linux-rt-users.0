From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 8/9] RT: Fixes for push-rt patch
Date: Wed, 17 Oct 2007 14:51:08 -0400
Message-ID: <20071017185108.11272.42107.stgit@novell1.haskins.net>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53182
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757657AbXJQTFD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 15:05:03 -0400
In-Reply-To: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Steve found these errors in the original patch

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c    |    2 +-
 kernel/sched_rt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 0ee1e21..8c916de 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1536,7 +1536,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task,
 		for_each_cpu_mask(cpu, cpu_mask) {
 			struct rq *rq = &per_cpu(runqueues, cpu);
 
-			if (cpu == smp_processor_id())
+			if (cpu == this_rq->cpu)
 				continue;
 
 			/* We look for lowest RT prio or non-rt CPU */
diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 8d59e62..04959fe 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -115,7 +115,7 @@ static struct task_struct *rt_next_highest_task(struct rq *rq)
 
 	queue = array->queue + idx;
 	next = list_entry(queue->next, struct task_struct, run_list);
-	if (unlikely(next != current))
+	if (unlikely(next != rq->curr))
 		return next;
 
 	if (queue->next->next != queue) {

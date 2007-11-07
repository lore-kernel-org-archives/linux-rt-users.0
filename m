From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: fix uniprocessor build issue with new scheduler
	enhancements
Date: Wed, 07 Nov 2007 07:20:14 -0700
Message-ID: <20071107142014.22153.93619.stgit@lsg>
References: <1194413959.8827.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Gregory Haskins <ghaskins@novell.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:5361 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756745AbXKGOUP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 09:20:15 -0500
In-Reply-To: <1194413959.8827.66.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Primary issue is cpupri_init() is not defined, but also clean up
some warnings related to uniproc builds.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
CC: Dragan Noveski <perodog@gmx.net>
---

 kernel/sched.c        |    2 ++
 kernel/sched_cpupri.h |    5 +++++
 kernel/sched_rt.c     |    2 +-
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 6f24aa0..365c987 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -863,9 +863,11 @@ static int balance_tasks(struct rq *this_rq, int this_cpu, struct rq *busiest,
 		      int *all_pinned, unsigned long *load_moved,
 		      int *this_best_prio, struct rq_iterator *iterator);
 
+#ifdef CONFIG_SMP
 static unsigned long source_load(int cpu, int type);
 static unsigned long target_load(int cpu, int type);
 static unsigned long cpu_avg_load_per_task(int cpu);
+#endif /* CONFIG_SMP */
 
 #include "sched_stats.h"
 #include "sched_rt.c"
diff --git a/kernel/sched_cpupri.h b/kernel/sched_cpupri.h
index 8cdd15d..2119495 100644
--- a/kernel/sched_cpupri.h
+++ b/kernel/sched_cpupri.h
@@ -5,6 +5,11 @@
 
 int  cpupri_find(struct task_struct *p, cpumask_t *lowest_mask);
 void cpupri_set(int cpu, int pri);
+
+#ifdef CONFIG_SMP
 void cpupri_init(void);
+#else
+#define cpupri_init() do { } while(0)
+#endif
 
 #endif /* _LINUX_CPUPRI_H */
diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 71ae9e6..0213aa2 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -207,9 +207,9 @@ yield_task_rt(struct rq *rq, struct task_struct *p)
 	requeue_task_rt(rq, p);
 }
 
+#ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
-#ifdef CONFIG_SMP
 static int select_task_rq_rt(struct task_struct *p, int sync)
 {
 	struct rq *rq = task_rq(p);

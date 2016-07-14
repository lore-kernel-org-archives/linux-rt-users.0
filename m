From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Thu, 14 Jul 2016 19:24:29 +0200
Message-ID: <20160714172429.GH30935@twins.programming.kicks-ass.net>
References: <1464995924-16367-1-git-send-email-brian@peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	bigeasy@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37742 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbcGNRYb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 13:24:31 -0400
Content-Disposition: inline
In-Reply-To: <1464995924-16367-1-git-send-email-brian@peloton-tech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 03, 2016 at 04:18:44PM -0700, Brian Silverman wrote:
> Without this, a realtime process which has called mlockall exiting
> causes large latencies for other realtime processes at the same or
> lower priorities. This seems like a fairly common use case too, because
> realtime processes generally want their memory locked into RAM.

So I'm not too sure..  SCHED_FIFO/RR are a complete trainwreck and
provide absolutely no isolation from badly behaving tasks what so ever,
so I'm not too inclined to protect them from exit either, its just one
more way in which they can cause pain.

But aside from the, the patch has issues..

> +++ b/kernel/exit.c
> @@ -730,6 +730,12 @@ void do_exit(long code)
>  	tsk->exit_code = code;
>  	taskstats_exit(tsk, group_dead);
>  
> +	if (tsk->policy == SCHED_FIFO || tsk->policy == SCHED_RR) {
> +		struct sched_param param = { .sched_priority = 0 };
> +
> +		sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +	}
> +
>  	exit_mm(tsk);

That only does half a job. You forget about SCHED_DEADLINE and negative
nice tasks.

Something like the below perhaps... But yeah, unconvinced.


diff --git a/kernel/exit.c b/kernel/exit.c
index 84ae830234f8..25da16bcfb9b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -812,6 +812,13 @@ void do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	/*
+	 * Drop all scheduler priority before exit_mm() as that
+	 * can involve a lot of work and we don't want a dying
+	 * task to interfere with healthy/running tasks.
+	 */
+	sched_normalize_task(tsk);
+
 	exit_mm(tsk);
 
 	if (group_dead)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7f5376cfaac..14e1945c62e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7585,14 +7585,29 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL(___might_sleep);
 #endif
 
-#ifdef CONFIG_MAGIC_SYSRQ
-void normalize_rt_tasks(void)
+void sched_normalize_task(struct task_struct *p)
 {
-	struct task_struct *g, *p;
 	struct sched_attr attr = {
 		.sched_policy = SCHED_NORMAL,
 	};
 
+	if (!dl_task(p) && !rt_task(p)) {
+		/*
+		 * Renice negative nice level tasks.
+		 */
+		if (task_nice(p) < 0)
+			set_user_nice(p, 0);
+		return;
+	}
+
+	__sched_setscheduler(p, &attr, false, false);
+}
+
+#ifdef CONFIG_MAGIC_SYSRQ
+void normalize_rt_tasks(void)
+{
+	struct task_struct *g, *p;
+
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
 		/*
@@ -7608,21 +7623,10 @@ void normalize_rt_tasks(void)
 		p->se.statistics.block_start	= 0;
 #endif
 
-		if (!dl_task(p) && !rt_task(p)) {
-			/*
-			 * Renice negative nice level userspace
-			 * tasks back to 0:
-			 */
-			if (task_nice(p) < 0)
-				set_user_nice(p, 0);
-			continue;
-		}
-
-		__sched_setscheduler(p, &attr, false, false);
+		sched_normalize_task(p);
 	}
 	read_unlock(&tasklist_lock);
 }
-
 #endif /* CONFIG_MAGIC_SYSRQ */
 
 #if defined(CONFIG_IA64) || defined(CONFIG_KGDB_KDB)

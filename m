From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 6/9] tracing: remove on the fly allocator from function
	profiler
Date: Tue, 19 May 2009 11:58:26 -0300
Message-ID: <20090519145826.GN27687@unix.sh>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:64658 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZESO63 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 10:58:29 -0400
Received: by pxi29 with SMTP id 29so2459538pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 07:58:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

tracing: remove on the fly allocator from function profiler

Impact: safer code

| From: Steven Rostedt <srostedt@redhat.com>
| 
| Impact: safer code
| 
| The on the fly allocator for the function profiler was to save
| memory. But at the expense of stability. Although it survived several
| tests, allocating from the function tracer is just too risky, just
| to save space.
| 
| This patch removes the allocator and simply allocates enough entries
| at start up.
| 
| Each function gets a profiling structure of 40 bytes. With an average
| of 20K functions, and this is for each CPU, we have 800K per online
| CPU. This is not too bad, at least for non-embedded.
| 
| Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/trace/ftrace.c |   76 +++++++++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a141d84..4d90c91 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -399,6 +399,8 @@ static void ftrace_profile_reset(struct ftrace_profile_stat *stat)
 int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
 {
 	struct ftrace_profile_page *pg;
+	int functions;
+	int pages;
 	int i;
 
 	/* If we already allocated, do nothing */
@@ -409,22 +411,46 @@ int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
 	if (!stat->pages)
 		return -ENOMEM;
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+	functions = ftrace_update_tot_cnt;
+#else
+	/*
+	 * We do not know the number of functions that exist because
+	 * dynamic tracing is what counts them. With past experience
+	 * we have around 20K functions. That should be more than enough.
+	 * It is highly unlikely we will execute every function in
+	 * the kernel.
+	 */
+	functions = 20000;
+#endif
+
 	pg = stat->start = stat->pages;
 
-	/* allocate 10 more pages to start */
-	for (i = 0; i < 10; i++) {
+	pages = DIV_ROUND_UP(functions, PROFILES_PER_PAGE);
+
+	for (i = 0; i < pages; i++) {
 		pg->next = (void *)get_zeroed_page(GFP_KERNEL);
-		/*
-		 * We only care about allocating profile_pages, if
-		 * we failed to allocate here, hopefully we will allocate
-		 * later.
-		 */
 		if (!pg->next)
-			break;
+			goto out_free;
 		pg = pg->next;
 	}
 
 	return 0;
+
+ out_free:
+	pg = stat->start;
+	while (pg) {
+		unsigned long tmp = (unsigned long)pg;
+
+		pg = pg->next;
+		free_page(tmp);
+	}
+
+	free_page((unsigned long)stat->pages);
+	stat->pages = NULL;
+	stat->start = NULL;
+
+	return -ENOMEM;
 }
 
 static int ftrace_profile_init_cpu(int cpu)
@@ -458,7 +484,7 @@ static int ftrace_profile_init_cpu(int cpu)
 			ftrace_profile_bits++;
 	}
 
-	/* Preallocate a few pages */
+	/* Preallocate the function profiling pages */
 	if (ftrace_profile_pages_init(stat) < 0) {
 		kfree(stat->hash);
 		stat->hash = NULL;
@@ -514,24 +540,21 @@ static void ftrace_add_profile(struct ftrace_profile_stat *stat,
 	hlist_add_head_rcu(&rec->node, &stat->hash[key]);
 }
 
-/* Interrupts must be disabled calling this */
+/*
+ * The memory is already allocated, this simply finds a new record to use.
+ */
 static struct ftrace_profile *
-ftrace_profile_alloc(struct ftrace_profile_stat *stat,
-		     unsigned long ip, bool alloc_safe)
+ftrace_profile_alloc(struct ftrace_profile_stat *stat, unsigned long ip)
 {
 	struct ftrace_profile *rec = NULL;
 
-	/* prevent recursion */
+	/* prevent recursion (from NMIs) */
 	if (atomic_inc_return(&stat->disabled) != 1)
 		goto out;
 
-	/* Try to always keep another page available */
-	if (!stat->pages->next && alloc_safe)
-		stat->pages->next = (void *)get_zeroed_page(GFP_ATOMIC);
-
 	/*
-	 * Try to find the function again since another
-	 * task on another CPU could have added it
+	 * Try to find the function again since an NMI
+	 * could have added it
 	 */
 	rec = ftrace_find_profiled_func(stat, ip);
 	if (rec)
@@ -553,29 +576,16 @@ ftrace_profile_alloc(struct ftrace_profile_stat *stat,
 	return rec;
 }
 
-/*
- * If we are not in an interrupt, or softirq and
- * and interrupts are disabled and preemption is not enabled
- * (not in a spinlock) then it should be safe to allocate memory.
- */
-static bool ftrace_safe_to_allocate(void)
-{
-	return !in_interrupt() && irqs_disabled() && !preempt_count();
-}
-
 static void
 function_profile_call(unsigned long ip, unsigned long parent_ip)
 {
 	struct ftrace_profile_stat *stat;
 	struct ftrace_profile *rec;
 	unsigned long flags;
-	bool alloc_safe;
 
 	if (!ftrace_profile_enabled)
 		return;
 
-	alloc_safe = ftrace_safe_to_allocate();
-
 	local_irq_save(flags);
 
 	stat = &__get_cpu_var(ftrace_profile_stats);
@@ -584,7 +594,7 @@ function_profile_call(unsigned long ip, unsigned long parent_ip)
 
 	rec = ftrace_find_profiled_func(stat, ip);
 	if (!rec) {
-		rec = ftrace_profile_alloc(stat, ip, alloc_safe);
+		rec = ftrace_profile_alloc(stat, ip);
 		if (!rec)
 			goto out;
 	}
-- 
1.6.2

-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]


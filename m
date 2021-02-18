Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE2C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010164EB8
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBRUN3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:13:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhBRUL1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 15:11:27 -0500
Date:   Thu, 18 Feb 2021 21:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613679042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bvvjBVd6kMksuRExd1897cU/wp+0u44ymsx1YD8T0Fw=;
        b=Yf/edwy60ldzRjRPKTN1bqSbH3Tg2IAnJ339KM2qCHJsWVTt4tDQTqnm3Ayzlll3AJITDD
        3riQzSnH9/Bl5GLWC4bOt35ZF7bRXxC15UM44ebbIOQxz6XSOVqpwZ/h4vXuAelLWPttbu
        JmwexeeWSdGlbeuZgLOKbOBPuuXKgt3PYFVQ7iom4PkM6BHxDtw+EtVhgJ195Yp5Y1OKDj
        cLWSXlUQN6D7154DKXDc8RdquVnv+OY/YTp7kIFVdYbojAmkQsyKgu8cOng4pAN1k8z1p/
        9R14cYYER9w2Yrk4tcWb0wV2Fw5qBbR0oTK8yPkw+8aeLUZOMJ+hoP4lfmQXCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613679042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bvvjBVd6kMksuRExd1897cU/wp+0u44ymsx1YD8T0Fw=;
        b=a3lizvqBb3rA1PE59qo4IhFERm62QgQ+btFtJJ0CoCi64Kb+FIVOT1AuPc5ipi+mUTJF0h
        oQwxfHB6IxpSRaBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.11-rt6
Message-ID: <20210218201041.65fknr7bdplwqbez@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.11-rt6 patch set. 

Changes since v5.11-rt5:

  - Updated the "tracing: Merge irqflags + preempt counter." patch to
    the version Steven posted for upstream inclusion.

  - Due to tracing rework, the 'L' marker (for need resched lazy) got
    lost and is now back.

  - The patch for the zsmalloc/zswap regression in v5.11 got updated to
    v2 as posted by Barry Song.

  - A kcov enabled kernel did not compile with PREEMPT_RT enabled.

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.11-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/incr/patch-5.11-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.11-rt6

The RT patch against v5.11 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patch-5.11-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patches-5.11-rt6.tar.xz

Sebastian

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 4e3037dc12048..55dc338f6bcdd 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KCOV_H
 #define _LINUX_KCOV_H
 
+#include <linux/sched.h>
 #include <uapi/linux/kcov.h>
 
 struct task_struct;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7337630326751..183e9d90841cb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -14,7 +14,6 @@
 #include <linux/pid.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
-#include <linux/kcov.h>
 #include <linux/mutex.h>
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5d08fb467f69a..89c3f7162267b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -162,9 +162,58 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 	entry->flags			= trace_ctx >> 24;
 }
 
-unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
-unsigned int tracing_gen_ctx_flags(void);
-unsigned int tracing_gen_ctx_flags_dect(void);
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
+
+enum trace_flag_type {
+	TRACE_FLAG_IRQS_OFF		= 0x01,
+	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED		= 0x04,
+	TRACE_FLAG_HARDIRQ		= 0x08,
+	TRACE_FLAG_SOFTIRQ		= 0x10,
+	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
+	TRACE_FLAG_NMI			= 0x40,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x80,
+};
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
+		TRACE_FLAG_IRQS_OFF : 0;
+	return tracing_gen_ctx_irq_test(irq_status);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	unsigned long irqflags;
+
+	local_save_flags(irqflags);
+	return tracing_gen_ctx_flags(irqflags);
+}
+#else
+
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+#endif
+
+static inline unsigned int tracing_gen_ctx_dec(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx = tracing_gen_ctx();
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
+}
 
 struct trace_event_file;
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f5c4f1d72a885..c54eae2ab208c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -79,7 +79,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
-		trace_ctx = _tracing_gen_ctx_flags(0);
+		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + len + cgid_len,
 						  trace_ctx);
@@ -253,7 +253,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		tracing_record_cmdline(current);
 
 		buffer = blk_tr->array_buffer.buffer;
-		trace_ctx = _tracing_gen_ctx_flags(0);
+		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + pdu_len + cgid_len,
 						  trace_ctx);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ed515daacd568..e33e7bad3fac1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1018,7 +1018,7 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 
 	alloc = sizeof(*entry) + size + 2; /* possible \n added */
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	buffer = global_trace.array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
@@ -1068,7 +1068,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	buffer = global_trace.array_buffer.buffer;
 
 	ring_buffer_nest_start(buffer);
@@ -2587,20 +2587,13 @@ static unsigned short migration_disable_value(void)
 #endif
 }
 
-unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
-	unsigned int trace_flags = 0;
+	unsigned int trace_flags = irqs_status;
 	unsigned int pc;
 
 	pc = preempt_count();
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	if (irqs_disabled_flags(irqflags))
-		trace_flags |= TRACE_FLAG_IRQS_OFF;
-#else
-	trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
-#endif
-
 	if (pc & NMI_MASK)
 		trace_flags |= TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
@@ -2613,39 +2606,17 @@ unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
 
+#ifdef CONFIG_PREEMPT_LAZY
+	if (need_resched_lazy())
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
+#endif
+
 	return (pc & 0xff) |
 		(migration_disable_value() & 0xff) << 8 |
 		(preempt_lazy_count() & 0xff) << 16 |
 		(trace_flags << 24);
 }
 
-unsigned int tracing_gen_ctx_flags(void)
-{
-	unsigned long irqflags;
-
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	local_save_flags(irqflags);
-#else
-	irqflags = 0;
-#endif
-	return _tracing_gen_ctx_flags(irqflags);
-}
-
-unsigned int tracing_gen_ctx_flags_dect(void)
-{
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx_flags();
-
-	/*
-	 * Subtract one from the preeption counter if preemption is enabled,
-	 * see trace_event_buffer_reserve()for details.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		trace_ctx--;
-	return trace_ctx;
-}
-
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
@@ -3090,7 +3061,7 @@ void trace_dump_stack(int skip)
 	skip++;
 #endif
 	__ftrace_trace_stack(global_trace.array_buffer.buffer,
-			     tracing_gen_ctx_flags(), skip, NULL);
+			     tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
@@ -3286,7 +3257,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	tbuffer = get_trace_buf();
@@ -3348,7 +3319,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 
@@ -6718,7 +6689,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    tracing_gen_ctx_flags());
+					    tracing_gen_ctx());
 	if (unlikely(!event))
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
@@ -6797,7 +6768,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    tracing_gen_ctx_flags());
+					    tracing_gen_ctx());
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b687e98fcbe10..93fb08ab8bb6b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,27 +136,6 @@ struct kretprobe_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
-/*
- * trace_flag_type is an enumeration that holds different
- * states when a trace occurs. These are:
- *  IRQS_OFF		- interrupts were disabled
- *  IRQS_NOSUPPORT	- arch does not support irqs_disabled_flags
- *  NEED_RESCHED	- reschedule is requested
- *  HARDIRQ		- inside an interrupt handler
- *  SOFTIRQ		- inside a softirq handler
- *  NEED_RESCHED_LAZY	- lazy reschedule is requested
- */
-enum trace_flag_type {
-	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
-	TRACE_FLAG_NEED_RESCHED		= 0x04,
-	TRACE_FLAG_HARDIRQ		= 0x08,
-	TRACE_FLAG_SOFTIRQ		= 0x10,
-	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
-	TRACE_FLAG_NMI			= 0x40,
-	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x80,
-};
-
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index a95b7f1fa351c..e47fdb4c92fbc 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -59,7 +59,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	if (atomic_read(&data->disabled))
 		goto out;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_BRANCH,
 					  sizeof(*entry), trace_ctx);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 5e64b06ab5189..288ad2c274fba 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -422,7 +422,7 @@ void perf_trace_buf_update(void *record, u16 type)
 {
 	struct trace_entry *entry = record;
 
-	tracing_generic_entry_update(entry, type, tracing_gen_ctx_flags());
+	tracing_generic_entry_update(entry, type, tracing_gen_ctx());
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 95a544899ddd0..a7c176251c637 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -266,7 +266,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	 * interested in the preempt_count at the time the tracepoint was
 	 * hit, we need to subtract one to offset the increment.
 	 */
-	fbuffer->trace_ctx = tracing_gen_ctx_flags_dect();
+	fbuffer->trace_ctx = tracing_gen_ctx_dec();
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
@@ -3682,7 +3682,7 @@ function_test_events_call(unsigned long ip, unsigned long parent_ip,
 	long disabled;
 	int cpu;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	disabled = atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu));
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 65150c0a5e7af..c188045c5f976 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -203,7 +203,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 		return -ENOMEM;
 
 	tracing_generic_entry_update(entry, call->event.type,
-				     tracing_gen_ctx_flags());
+				     tracing_gen_ctx());
 
 	while ((len = parse_field(str, call, &field, &val)) > 0) {
 		if (is_function_field(field))
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 31183dc3ba973..9bb03ab44fffc 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -143,7 +143,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	cpu = smp_processor_id();
@@ -197,7 +197,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	disabled = atomic_inc_return(&data->disabled);
 
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		trace_function(tr, ip, parent_ip, trace_ctx);
 		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
@@ -404,7 +404,7 @@ static __always_inline void trace_stack(struct trace_array *tr)
 {
 	unsigned int trace_ctx;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 83d6be491d468..0aa6e6faa9439 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -173,7 +173,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		ret = __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret = 0;
@@ -253,7 +253,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		__trace_graph_return(tr, trace, trace_ctx);
 	}
 	atomic_dec(&data->disabled);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 375e7635baf67..34dc1a712dcbb 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -110,7 +110,7 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 	struct hwlat_entry *entry;
 
 	event = trace_buffer_lock_reserve(buffer, TRACE_HWLAT, sizeof(*entry),
-					  tracing_gen_ctx_flags());
+					  tracing_gen_ctx());
 	if (!event)
 		return;
 	entry	= ring_buffer_event_data(event);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 56e5ad7240333..590b3d51afae9 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -148,7 +148,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
 
@@ -198,7 +198,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return 0;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	ret = __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 
@@ -217,7 +217,7 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 }
@@ -331,7 +331,7 @@ check_critical_timing(struct trace_array *tr,
 	T1 = ftrace_now(cpu);
 	delta = T1-T0;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	if (!report_latency(tr, delta))
 		goto out;
@@ -393,7 +393,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 	data->preempt_timestamp = ftrace_now(cpu);
 	data->critical_start = parent_ip ? : ip;
 
-	__trace_function(tr, ip, parent_ip, tracing_gen_ctx_flags());
+	__trace_function(tr, ip, parent_ip, tracing_gen_ctx());
 
 	per_cpu(tracing_cpu, cpu) = 1;
 
@@ -426,7 +426,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 
 	atomic_inc(&data->disabled);
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	__trace_function(tr, ip, parent_ip, trace_ctx);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start = 0;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 86dda18fa09b2..f6c459aba8a61 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1386,7 +1386,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx_flags();
+	fbuffer.trace_ctx = tracing_gen_ctx();
 	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
@@ -1433,7 +1433,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx_flags();
+	fbuffer.trace_ctx = tracing_gen_ctx();
 	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 5a7d37bf6888c..7221ae0b4c477 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -302,7 +302,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 	struct trace_mmiotrace_rw *entry;
 	unsigned int trace_ctx;
 
-	trace_ctx = _tracing_gen_ctx_flags(0);
+	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
 					  sizeof(*entry), trace_ctx);
 	if (!event) {
@@ -333,7 +333,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 	struct trace_mmiotrace_map *entry;
 	unsigned int trace_ctx;
 
-	trace_ctx = _tracing_gen_ctx_flags(0);
+	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
 					  sizeof(*entry), trace_ctx);
 	if (!event) {
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 8c7d0650a9ba9..e5778d1d7a5b6 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -75,7 +75,7 @@ func_prolog_preempt_disable(struct trace_array *tr,
 	if (likely(!wakeup_task))
 		return 0;
 
-	*trace_ctx = tracing_gen_ctx_flags();
+	*trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	cpu = raw_smp_processor_id();
@@ -459,7 +459,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 		goto out;
 
 	local_irq_save(flags);
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 
 	arch_spin_lock(&wakeup_lock);
 
@@ -550,7 +550,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	if (unlikely(disabled != 1))
 		goto out;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	/* interrupts should be off from try_to_wake_up */
 	arch_spin_lock(&wakeup_lock);
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 71a2e705970f0..8bfcd3b094226 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -321,7 +321,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer,
@@ -365,7 +365,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer,
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/mm/zswap.c b/mm/zswap.c
index 67d4555491b03..1566cc3ab7f46 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -935,7 +935,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 
-	u8 *src, *tmp;
+	u8 *src, *tmp = NULL;
 	unsigned int dlen;
 	int ret;
 	struct writeback_control wbc = {
@@ -943,8 +943,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	};
 
 	if (!zpool_can_sleep_mapped(pool)) {
-
-		tmp = kmalloc(entry->length, GFP_ATOMIC);
+		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
 		if (!tmp)
 			return -ENOMEM;
 	}
@@ -962,6 +961,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		/* entry was invalidated */
 		spin_unlock(&tree->lock);
 		zpool_unmap_handle(pool, handle);
+		kfree(tmp);
 		return 0;
 	}
 	spin_unlock(&tree->lock);
@@ -1272,6 +1272,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		dst = kmap_atomic(page);
 		zswap_fill_page(dst, entry->value);
 		kunmap_atomic(dst);
+		ret = 0;
 		goto freeentry;
 	}
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 785daff48030d..e64d0a2e21c31 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -60,6 +60,7 @@
 #include <linux/prefetch.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
+#include <linux/kcov.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b31417f40bd56..39943c33abbfa 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -15,6 +15,7 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/kcov.h>
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include "ieee80211_i.h"
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 972895e9f22dc..3527b17f235a8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
+#include <linux/kcov.h>
 #include <linux/bitops.h>
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>

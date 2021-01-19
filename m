Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9EEC47434
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E769022DD3
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392554AbhASSMu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:12:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389833AbhASSMi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jan 2021 13:12:38 -0500
Date:   Tue, 19 Jan 2021 19:11:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611079913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=25Fn7FcUuTGCUmy2t3FQrxcXJTuctqBxaXUt5HwOxm4=;
        b=aDaHC661KtsYC3fxiUf1CLePT9v8jvicdeQVKxCPQkzG2KyFkjNpi5+h4LllG7K6OvvdGE
        /JHiuhLwCGwbPavB2c6fVC1yY96yjMIevIPgVjU1QzQxVc1JKBnMXzwvN31es4Fc1HZ/gH
        E0JBpW64rItVKTjYPystqZ0yfjhdhYG0pohXO55qr4MajC3puX37MdRUcWaVtSAtmr6FT1
        klTdgT6z7GY5towMZAPNvs362i+m+VN1tJ0xYvlZnsaJLlztzxDu25b0lCRtnz+vU05i3s
        UGfZhiZZozDHLekvkuM4fF6nlEbxAcBZxLWDgRFpKOpPbGJKjhZXotbZ7clD0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611079913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=25Fn7FcUuTGCUmy2t3FQrxcXJTuctqBxaXUt5HwOxm4=;
        b=hITE7nq40rJpOvtWQZi8OUfyt6P1FW7i0XI91xAhx4H1hizhRZtTH6aBqOfBZFAW7rI3sH
        Sg3iVFIHa+AyE0CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.8-rt24
Message-ID: <20210119181153.i7j2hzdtiqdaa7nv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.8-rt24 patch set. 

Changes since v5.10.8-rt23:

  - Added RT's version of __down_read_interruptible() which is used by
    stable tree since v5.10.6.

  - Updated the "tracing: Merge irqflags + preempt counter." patch to
    the latest version posted for upstream.

[ The issues listed below were accidentally lost in the last announcement. ]

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.10.8-rt23 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.8-rt23-rt24.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.8-rt24

The RT patch against v5.10.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.8-rt24.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.8-rt24.tar.xz

Sebastian

diff --git a/include/linux/rwsem-rt.h b/include/linux/rwsem-rt.h
index 7f7e748ef5222..0ba8aae9a1983 100644
--- a/include/linux/rwsem-rt.h
+++ b/include/linux/rwsem-rt.h
@@ -57,6 +57,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 }
 
 extern void __down_read(struct rw_semaphore *sem);
+extern int __down_read_interruptible(struct rw_semaphore *sem);
 extern int __down_read_killable(struct rw_semaphore *sem);
 extern int __down_read_trylock(struct rw_semaphore *sem);
 extern void __down_write(struct rw_semaphore *sem);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 79b680067e646..5d08fb467f69a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -154,14 +154,12 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 						unsigned short type,
 						unsigned int trace_ctx)
 {
-	struct task_struct *tsk = current;
-
 	entry->preempt_count		= trace_ctx & 0xff;
 	entry->migrate_disable		= (trace_ctx >> 8) & 0xff;
 	entry->preempt_lazy_count	= (trace_ctx >> 16) & 0xff;
-	entry->pid			= (tsk) ? tsk->pid : 0;
+	entry->pid			= current->pid;
 	entry->type			= type;
-	entry->flags =			trace_ctx >> 24;
+	entry->flags			= trace_ctx >> 24;
 }
 
 unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
@@ -256,7 +254,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 				  struct trace_event_file *trace_file,
 				  unsigned long len);
 
-void trace_event_buffer_commit__(struct trace_event_buffer *fbuffer);
+void trace_event_buffer_commit(struct trace_event_buffer *fbuffer);
 
 enum {
 	TRACE_EVENT_FL_FILTERED_BIT,
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index ec5a7ff786717..7785961d82bae 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -694,7 +694,7 @@ trace_event_raw_event_##call(void *__data, proto)			\
 									\
 	{ assign; }							\
 									\
-	trace_event_buffer_commit__(&fbuffer);				\
+	trace_event_buffer_commit(&fbuffer);				\
 }
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index ab05ce0903537..274172d5bb3a5 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -164,6 +164,17 @@ void __down_read(struct rw_semaphore *sem)
 	WARN_ON_ONCE(ret);
 }
 
+int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	int ret;
+
+	ret = __down_read_common(sem, TASK_INTERRUPTIBLE);
+	if (likely(!ret))
+		return ret;
+	WARN_ONCE(ret != -EINTR, "Unexpected state: %d\n", ret);
+	return -EINTR;
+}
+
 int __down_read_killable(struct rw_semaphore *sem)
 {
 	int ret;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2ed294e2c8863..0f9162f0c02a3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2587,7 +2587,7 @@ static unsigned short migration_disable_value(void)
 #endif
 }
 
-static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
+unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
 {
 	unsigned int trace_flags = 0;
 	unsigned int pc;
@@ -2598,21 +2598,16 @@ static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
 	if (irqs_disabled_flags(irqflags))
 		trace_flags |= TRACE_FLAG_IRQS_OFF;
 #else
-		trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
+	trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
 #endif
 
 	if (pc & NMI_MASK)
 		trace_flags |= TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
 		trace_flags |= TRACE_FLAG_HARDIRQ;
+	if (in_serving_softirq())
+		trace_flags |= TRACE_FLAG_SOFTIRQ;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if (in_serving_softirq())
-			trace_flags |= TRACE_FLAG_SOFTIRQ;
-	} else {
-		if (pc & SOFTIRQ_OFFSET)
-			trace_flags |= TRACE_FLAG_SOFTIRQ;
-	}
 	if (tif_need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
@@ -2624,11 +2619,6 @@ static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
 		(trace_flags << 24);
 }
 
-unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
-{
-	return __tracing_gen_ctx_flags(irqflags);
-}
-
 unsigned int tracing_gen_ctx_flags(void)
 {
 	unsigned long irqflags;
@@ -2890,7 +2880,7 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
-void trace_event_buffer_commit__(struct trace_event_buffer *fbuffer)
+void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 {
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
@@ -2901,7 +2891,7 @@ void trace_event_buffer_commit__(struct trace_event_buffer *fbuffer)
 				    fbuffer->event, fbuffer->entry,
 				    fbuffer->trace_ctx, fbuffer->regs);
 }
-EXPORT_SYMBOL_GPL(trace_event_buffer_commit__);
+EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
 /*
  * Skip 3:
@@ -3092,13 +3082,9 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
  */
 void trace_dump_stack(int skip)
 {
-	unsigned long flags;
-
 	if (tracing_disabled || tracing_selftest_running)
 		return;
 
-	local_save_flags(flags);
-
 #ifndef CONFIG_UNWINDER_ORC
 	/* Skip 1 to skip this function. */
 	skip++;
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 0de1e9c4d381b..a95b7f1fa351c 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -37,7 +37,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	struct ring_buffer_event *event;
 	struct trace_branch *entry;
 	unsigned long flags;
-	unsigned int pc;
+	unsigned int trace_ctx;
 	const char *p;
 
 	if (current->trace_recursion & TRACE_BRANCH_BIT)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 257c11f98b786..a38d7edb2fe03 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3677,7 +3677,6 @@ function_test_events_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct ftrace_entry *entry;
-	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
 	int cpu;
@@ -3690,8 +3689,6 @@ function_test_events_call(unsigned long ip, unsigned long parent_ip,
 	if (disabled != 1)
 		goto out;
 
-	local_save_flags(flags);
-
 	event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
 						TRACE_FN, sizeof(*entry),
 						trace_ctx);
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index a5465a93fc149..65150c0a5e7af 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -25,7 +25,7 @@ trace_inject_entry(struct trace_event_file *file, void *rec, int len)
 	if (entry) {
 		memcpy(entry, rec, len);
 		written = len;
-		trace_event_buffer_commit__(&fbuffer);
+		trace_event_buffer_commit(&fbuffer);
 	}
 	rcu_read_unlock_sched();
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2fc59be73a288..881df991742ab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -504,7 +504,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		}
 	}
 
-	trace_event_buffer_commit__(&fbuffer);
+	trace_event_buffer_commit(&fbuffer);
 out:
 	ring_buffer_nest_end(buffer);
 }
@@ -1494,7 +1494,7 @@ __synth_event_trace_start(struct trace_event_file *file,
 static inline void
 __synth_event_trace_end(struct synth_event_trace_state *trace_state)
 {
-	trace_event_buffer_commit__(&trace_state->fbuffer);
+	trace_event_buffer_commit(&trace_state->fbuffer);
 
 	ring_buffer_nest_end(trace_state->buffer);
 }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 7066faab29e7a..52ab6cf49d767 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -185,7 +185,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	unsigned long flags;
 	long disabled;
 	int cpu;
-	int trace_ctx;
+	unsigned int trace_ctx;
 
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -200,7 +200,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	disabled = atomic_inc_return(&data->disabled);
 
 	if (likely(disabled == 1)) {
-		trace_ctx = tracing_gen_ctx_flags();
+		trace_ctx = _tracing_gen_ctx_flags(flags);
 		trace_function(tr, ip, parent_ip, trace_ctx);
 		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
@@ -405,10 +405,8 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned long flags;
 	unsigned int trace_ctx;
 
-	local_save_flags(flags);
 	trace_ctx = tracing_gen_ctx_flags();
 
 	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 966b1a16fe6ae..7bf4d63c02206 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1402,7 +1402,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	trace_event_buffer_commit__(&fbuffer);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
@@ -1449,7 +1449,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	entry->ret_ip = (unsigned long)ri->ret_addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	trace_event_buffer_commit__(&fbuffer);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 795935a669f97..e8bb2d8149e63 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -116,7 +116,6 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
 	unsigned int trace_ctx;
 	int ret = 0;
 
@@ -135,7 +134,6 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return 0;
 
-	local_save_flags(flags);
 	ret = __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 	preempt_enable_notrace();
@@ -147,7 +145,6 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
 	unsigned int trace_ctx;
 
 	ftrace_graph_addr_finish(trace);
@@ -155,7 +152,6 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
 
-	local_save_flags(flags);
 	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 
@@ -456,8 +452,6 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	if (next != wakeup_task)
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
-
 	/* disable local data, not wakeup_cpu data */
 	cpu = raw_smp_processor_id();
 	disabled = atomic_inc_return(&per_cpu_ptr(wakeup_trace->array_buffer.data, cpu)->disabled);
@@ -465,6 +459,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 		goto out;
 
 	local_irq_save(flags);
+	trace_ctx = _tracing_gen_ctx_flags(flags);
+
 	arch_spin_lock(&wakeup_lock);
 
 	/* We could race with grabbing wakeup_lock */
@@ -528,7 +524,6 @@ probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu = smp_processor_id();
-	unsigned long flags;
 	long disabled;
 	unsigned int trace_ctx;
 
@@ -551,11 +546,12 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
 	disabled = atomic_inc_return(&per_cpu_ptr(wakeup_trace->array_buffer.data, cpu)->disabled);
 	if (unlikely(disabled != 1))
 		goto out;
 
+	trace_ctx = tracing_gen_ctx_flags();
+
 	/* interrupts should be off from try_to_wake_up */
 	arch_spin_lock(&wakeup_lock);
 
@@ -582,8 +578,6 @@ probe_wakeup(void *ignore, struct task_struct *p)
 
 	wakeup_task = get_task_struct(p);
 
-	local_save_flags(flags);
-
 	data = per_cpu_ptr(wakeup_trace->array_buffer.data, wakeup_cpu);
 	data->preempt_timestamp = ftrace_now(cpu);
 	tracing_sched_wakeup_trace(wakeup_trace, p, current, trace_ctx);
diff --git a/localversion-rt b/localversion-rt
index 9a218ca230534..b2111a212663a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt23
+-rt24

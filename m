Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD01C4A11;
	Fri, 25 Oct 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851018; cv=none; b=Q/DqjPIy8AIL8pHSU8ITLG9c8T8Ql5rdR7ai+iSfriqRG1Lz4tjzOLkFPEtbsNm0f181gLffv+DLI9PG+cA37HZ7ErvYa+bWNt/m8u1Fk5T49i+8X2+3cB/LTsTF2NuN6gbok2dXXfNRqyny4ysZ32J742b3eoi9CAlCyJsLxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851018; c=relaxed/simple;
	bh=zlfs+ZZk5vXPdLiiTq+TCpORCFa82NvX3YMz7liO9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tGKEfVVFWFt8Fi5kGV/YwUWD1WwCIngbGksXVVpy944xo90+ReSL+kW74ufbuPrn4s5D1I1OTSbud4/x5fj6Q0KevA12z35omObV0/bVTv/IBiqP/I8rDhm0wKmJBAd4DzB9/f/kgg69iWlTRe2/85wqQhCKA7hISuynZ9ajVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ciYQO0De; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDGAEUBW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ciYQO0De";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDGAEUBW"
Date: Fri, 25 Oct 2024 12:10:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729851013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DBqdUHyYF1H23UokcRjiCaNoCcBrGrr+YiZ2cu0o2J0=;
	b=ciYQO0DeqXfhV06AaUOg1mtsptkOC4RfGjMtgLyEoIAS2y5pmUyuGGoo4Po8rJWiUPUUkL
	JqooLN0tIjtgwRqxeO/rDqCP4/diR/wmcNgIWEjeN27lBUlYR8XBak3aKpmPoHdh3O0AAO
	r8BezumwxoeEkRFjRC1CRglXBQTy4GxT0bFTYRO3X+Nfaom12+wLm8jhpCCguOhxARIwtF
	+6RTivbxNpb4bwoqGafjulAHWVeZD01QK2Bz/3uA7inwI1UPhoIdD3WHTPaWSZ4yQW1uye
	m1O8Su5Luzd6ORkbDoKQvO17WSKEpxCBEQ1LfsPLuNC8Ekc74Zmna/iF/S0RgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729851013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DBqdUHyYF1H23UokcRjiCaNoCcBrGrr+YiZ2cu0o2J0=;
	b=dDGAEUBWu8kDSUQqQLqJM9kDrIjuqWM4AMoioWKVvvBxriRQfKIyNAk8Z5Z+078Qq/rHf9
	ulbpiE0hM+i76PBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.12-rc4-rt6
Message-ID: <20241025101011.NrYoNbkE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.12-rc4-rt6 patch set. 

Changes since v6.12-rc4-rt5:

  - Updated the lazy preempt series
    - Added a bit of documentation for the new flags in tracing and
      corrected the IS_ENABLED checks. Reported by Shrikanth Hegde.

    - Added a check to not record the LAZY bit in tracing if the LAZY
      model is not supported by the architecture. Reported by Ankur
      Arora.

    - Keeping the TRACE_FLAG_NEED_RESCHED where it was as this is ABI
      and might confuse userland. Reported by Steven Rostedt.

  - Updated the ktimersd patch based on upstream's review.

Known issues
    None.

The delta patch against v6.12-rc4-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/incr/patch-6.12-rc4-rt5-rt6.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.12-rc4-rt6

The RT patch against v6.12-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12-rc4-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patches-6.12-rc4-rt6.tar.xz

Sebastian

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4073ca48af4ad..16892b844108c 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1031,14 +1031,15 @@ explains which is which.
   CPU#: The CPU which the process was running on.
 
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
-	.. caution:: If the architecture does not support a way to
-		read the irq flags variable, an 'X' will always
-		be printed here.
 
   need-resched:
+	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
 	- 'n' only TIF_NEED_RESCHED is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
+	- 'L' borg PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'b' borg TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'l' only TIF_RESCHED_LAZY is set
 	- '.' otherwise.
 
   hardirq/softirq:
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4a4f367cd6864..9637af78087f3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,14 +616,27 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
+/*
+ * Handle timers in a dedicated thread at a low SCHED_FIFO priority instead in
+ * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
+ */
 #ifdef CONFIG_PREEMPT_RT
 DECLARE_PER_CPU(struct task_struct *, timersd);
 DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
 
-extern void raise_timer_softirq(void);
-extern void raise_hrtimer_softirq(void);
+void raise_ktimers_thread(unsigned int nr);
 
-static inline unsigned int local_pending_timers(void)
+static inline void raise_timer_softirq(void)
+{
+	raise_ktimers_thread(TIMER_SOFTIRQ);
+}
+
+static inline void raise_hrtimer_softirq(void)
+{
+	raise_ktimers_thread(HRTIMER_SOFTIRQ);
+}
+
+static inline unsigned int local_timers_pending(void)
 {
 	return __this_cpu_read(pending_timer_softirq);
 }
@@ -631,15 +644,17 @@ static inline unsigned int local_pending_timers(void)
 #else
 static inline void raise_timer_softirq(void)
 {
-	raise_softirq(TIMER_SOFTIRQ);
+	lockdep_assert_in_irq();
+	__raise_softirq_irqoff(TIMER_SOFTIRQ);
 }
 
 static inline void raise_hrtimer_softirq(void)
 {
-	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	lockdep_assert_in_irq();
+	__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
-static inline unsigned int local_pending_timers(void)
+static inline unsigned int local_timers_pending(void)
 {
 	return local_softirq_pending();
 }
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4cae6f2581379..0b9144b08e1f7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,8 +184,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_NEED_RESCHED		= 0x02,
-	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x02,
+	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
@@ -193,7 +193,6 @@ enum trace_flag_type {
 	TRACE_FLAG_BH_OFF		= 0x80,
 };
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
 	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
@@ -207,17 +206,6 @@ static inline unsigned int tracing_gen_ctx(void)
 	local_save_flags(irqflags);
 	return tracing_gen_ctx_flags(irqflags);
 }
-#else
-
-static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
-{
-	return tracing_gen_ctx_irq_test(0);
-}
-static inline unsigned int tracing_gen_ctx(void)
-{
-	return tracing_gen_ctx_irq_test(0);
-}
-#endif
 
 static inline unsigned int tracing_gen_ctx_dec(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 46972fe661f81..e66d883ed0b9b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1125,11 +1125,11 @@ static __always_inline bool dynamic_preempt_promote(void)
 #else
 static __always_inline bool dynamic_preempt_lazy(void)
 {
-	return IS_ENABLED(PREEMPT_LAZY) | IS_ENABLED(PREEMPT_LAZIEST);
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY) | IS_ENABLED(CONFIG_PREEMPT_LAZIEST);
 }
 static __always_inline bool dynamic_preempt_promote(void)
 {
-	return IS_ENABLED(PREEMPT_LAZY);
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
 }
 #endif
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2d847405e5a7f..b452206cf93b2 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -654,7 +654,7 @@ static inline void __irq_exit_rcu(void)
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers() &&
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_timers_pending() &&
 	    !(in_nmi() | in_hardirq()))
 		wake_timersd();
 
@@ -996,12 +996,20 @@ static struct smp_hotplug_thread softirq_threads = {
 #ifdef CONFIG_PREEMPT_RT
 static void timersd_setup(unsigned int cpu)
 {
+	/* Above SCHED_NORMAL to handle timers before regular tasks. */
 	sched_set_fifo_low(current);
 }
 
 static int timersd_should_run(unsigned int cpu)
 {
-	return local_pending_timers();
+	return local_timers_pending();
+}
+
+void raise_ktimers_thread(unsigned int nr)
+{
+	lockdep_assert_in_irq();
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, 1 << nr);
 }
 
 static void run_timersd(unsigned int cpu)
@@ -1010,7 +1018,7 @@ static void run_timersd(unsigned int cpu)
 
 	ksoftirqd_run_begin();
 
-	timer_si = local_pending_timers();
+	timer_si = local_timers_pending();
 	__this_cpu_write(pending_timer_softirq, 0);
 	or_softirq_pending(timer_si);
 
@@ -1019,27 +1027,6 @@ static void run_timersd(unsigned int cpu)
 	ksoftirqd_run_end();
 }
 
-static void raise_ktimers_thread(unsigned int nr)
-{
-	trace_softirq_raise(nr);
-	__this_cpu_or(pending_timer_softirq, 1 << nr);
-}
-
-void raise_hrtimer_softirq(void)
-{
-	raise_ktimers_thread(HRTIMER_SOFTIRQ);
-}
-
-void raise_timer_softirq(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	raise_ktimers_thread(TIMER_SOFTIRQ);
-	wake_timersd();
-	local_irq_restore(flags);
-}
-
 static struct smp_hotplug_thread timer_threads = {
 	.store			= &timersd,
 	.setup			= timersd_setup,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a7c0b2156de3f..e0c47259e91a7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -865,7 +865,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_pending_timers() & BIT(TIMER_SOFTIRQ);
+	return local_timers_pending() & BIT(TIMER_SOFTIRQ);
 }
 
 /*
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 23ca2155306b1..77b7f9d244240 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,7 +460,6 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD975C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Dec 2020 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3E22AAB
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Dec 2020 17:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgLDRfT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgLDRfS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Dec 2020 12:35:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632CC061A4F;
        Fri,  4 Dec 2020 09:34:38 -0800 (PST)
Date:   Fri, 4 Dec 2020 18:34:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607103276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CUnqXEGkkwJsGoCnqeRdfMLJTaCNVbs18/tEvIBYgT4=;
        b=stgGHWoFqVyvZ1JIGUk4at+x22qB4MGZzC32811mySJoMsqz1rAs23HgRHL0LeJz7cwd3i
        PKTUrK5SzbqujrwuyQiNVRk/A+VKJ6rQWbqUxDhFSWankZbS5OOIpUJR8l0S0kSYHNqtA5
        MDprcGK3gIPp6lscWsW2qyXYLkU7EmxomRxKo3B143zCTVR41ca+s9T/94IlhzZxE9o7E6
        xT0G8pfHAkLOObv7kGhMVfzU0MSpkB/F1IhzSzveN+8FGwiD99d1gekvqWc+qt/w2I0F+3
        ImgUoZPjCmjpi+pnyJSFoVHDqSNt8mDa/5t7vgQPMvU3PyUwbGtgI93iMZbshA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607103276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CUnqXEGkkwJsGoCnqeRdfMLJTaCNVbs18/tEvIBYgT4=;
        b=Dv3S4s13YRTUHOpmtBnqZl53AJnevPjenLzXm7oYeWY+gEmIOhClj9if8L4OYWYPGDKsYP
        yHehJR40q0mzokAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc6-rt14
Message-ID: <20201204173435.pj7e4kvely3nc2mg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc6-rt14 patch set. 

Changes since v5.10-rc6-rt13:

  - Update Thomas Gleixner's softirq patches. This updated version has
    been posted as v2.
    This update also includes a handful patches by Frederic Weisbecker
    which were required as a prerequisite.

Known issues
     - None.

The delta patch against v5.10-rc6-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc6-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc6-rt14

The RT patch against v5.10-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc6-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc6-rt14.tar.xz

Sebastian

diff --git a/arch/Kconfig b/arch/Kconfig
index baf1c2b12a5b9..f349962465cd8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -628,6 +628,12 @@ config HAVE_TIF_NOHZ
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
 
+config HAVE_VIRT_CPU_ACCOUNTING_IDLE
+	bool
+	help
+	  Architecture has its own way to account idle CPU time and therefore
+	  doesn't implement vtime_account_idle().
+
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
@@ -642,7 +648,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_GEN
 	  some 32-bit arches may require multiple accesses, so proper
 	  locking is needed to protect against concurrent accesses.
 
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf9..733e0e3324b80 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -138,12 +138,8 @@ void vtime_account_kernel(struct task_struct *tsk)
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count())
+	if (tsk->flags & PF_VCPU)
 		ti->gtime += stime;
-	else if (hardirq_count())
-		ti->hardirq_time += stime;
-	else if (in_serving_softirq())
-		ti->softirq_time += stime;
 	else
 		ti->stime += stime;
 }
@@ -156,6 +152,20 @@ void vtime_account_idle(struct task_struct *tsk)
 	ti->idle_time += vtime_delta(tsk);
 }
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->softirq_time += vtime_delta(tsk);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->hardirq_time += vtime_delta(tsk);
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 static irqreturn_t
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 74efe46f55327..cf3f8db7e0e3f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -311,12 +311,11 @@ static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 	return stime_scaled;
 }
 
-static unsigned long vtime_delta(struct task_struct *tsk,
+static unsigned long vtime_delta(struct cpu_accounting_data *acct,
 				 unsigned long *stime_scaled,
 				 unsigned long *steal_time)
 {
 	unsigned long now, stime;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
 
 	WARN_ON_ONCE(!irqs_disabled());
 
@@ -331,29 +330,30 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
+static void vtime_delta_kernel(struct cpu_accounting_data *acct,
+			       unsigned long *stime, unsigned long *stime_scaled)
+{
+	unsigned long steal_time;
+
+	*stime = vtime_delta(acct, stime_scaled, &steal_time);
+	*stime -= min(*stime, steal_time);
+	acct->steal_time += steal_time;
+}
+
 void vtime_account_kernel(struct task_struct *tsk)
 {
-	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long stime, stime_scaled;
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
 
-	stime -= min(stime, steal_time);
-	acct->steal_time += steal_time;
-
-	if ((tsk->flags & PF_VCPU) && !irq_count()) {
+	if (tsk->flags & PF_VCPU) {
 		acct->gtime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
 #endif
 	} else {
-		if (hardirq_count())
-			acct->hardirq_time += stime;
-		else if (in_serving_softirq())
-			acct->softirq_time += stime;
-		else
-			acct->stime += stime;
-
+		acct->stime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
 #endif
@@ -366,10 +366,34 @@ void vtime_account_idle(struct task_struct *tsk)
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	stime = vtime_delta(acct, &stime_scaled, &steal_time);
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_account_irq_field(struct cpu_accounting_data *acct,
+				    unsigned long *field)
+{
+	unsigned long stime, stime_scaled;
+
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
+	*field += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->stime_scaled += stime_scaled;
+#endif
+}
+
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->softirq_time);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->hardirq_time);
+}
+
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4a2a12be04c96..6f1fdcd3b5db7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -181,6 +181,7 @@ config S390
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
 	select MODULES_USE_ELF_RELA
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index 3622d4ebc73aa..fac6a67988eb5 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,7 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_ACCOUNT
 #define __ARCH_HAS_VTIME_TASK_SWITCH
 
 #endif /* _S390_VTIME_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3c8f6cf..5aaa2ca6a9286 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -222,35 +222,50 @@ void vtime_flush(struct task_struct *tsk)
 	S390_lowcore.avg_steal_timer = avg_steal;
 }
 
+static u64 vtime_delta(void)
+{
+	u64 timer = S390_lowcore.last_update_timer;
+
+	S390_lowcore.last_update_timer = get_vtimer();
+
+	return timer - S390_lowcore.last_update_timer;
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void vtime_account_irq_enter(struct task_struct *tsk)
-{
-	u64 timer;
-
-	timer = S390_lowcore.last_update_timer;
-	S390_lowcore.last_update_timer = get_vtimer();
-	timer -= S390_lowcore.last_update_timer;
-
-	if ((tsk->flags & PF_VCPU) && (irq_count() == 0))
-		S390_lowcore.guest_timer += timer;
-	else if (hardirq_count())
-		S390_lowcore.hardirq_timer += timer;
-	else if (in_serving_softirq())
-		S390_lowcore.softirq_timer += timer;
-	else
-		S390_lowcore.system_timer += timer;
-
-	virt_timer_forward(timer);
-}
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-
 void vtime_account_kernel(struct task_struct *tsk)
-__attribute__((alias("vtime_account_irq_enter")));
+{
+	u64 delta = vtime_delta();
+
+	if (tsk->flags & PF_VCPU)
+		S390_lowcore.guest_timer += delta;
+	else
+		S390_lowcore.system_timer += delta;
+
+	virt_timer_forward(delta);
+}
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.softirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.hardirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 9d2e4026be961..5db7af565decc 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index b14fb2a2a9c56..76878b357ffa9 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -33,9 +33,9 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
 		lockdep_hardirq_enter();		\
+		account_hardirq_enter(current);		\
 	} while (0)
 
 /*
@@ -63,8 +63,8 @@ void irq_enter_rcu(void);
  */
 #define __irq_exit()					\
 	do {						\
+		account_hardirq_exit(current);		\
 		lockdep_hardirq_exit();			\
-		account_irq_exit_time(current);		\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca062db32..041d6524d144a 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,36 +83,46 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq_enter(struct task_struct *tsk);
-static inline void vtime_account_irq_exit(struct task_struct *tsk)
-{
-	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_kernel(tsk);
-}
+extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq_enter(struct task_struct *tsk) { }
-static inline void vtime_account_irq_exit(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
+static inline void vtime_account_softirq(struct task_struct *tsk) { }
+static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 #endif
 
-static inline void account_irq_enter_time(struct task_struct *tsk)
+static inline void account_softirq_enter(struct task_struct *tsk)
 {
-	vtime_account_irq_enter(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_irq(tsk, SOFTIRQ_OFFSET);
+	irqtime_account_irq(tsk, SOFTIRQ_OFFSET);
 }
 
-static inline void account_irq_exit_time(struct task_struct *tsk)
+static inline void account_softirq_exit(struct task_struct *tsk)
 {
-	vtime_account_irq_exit(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_softirq(tsk);
+	irqtime_account_irq(tsk, 0);
+}
+
+static inline void account_hardirq_enter(struct task_struct *tsk)
+{
+	vtime_account_irq(tsk, HARDIRQ_OFFSET);
+	irqtime_account_irq(tsk, HARDIRQ_OFFSET);
+}
+
+static inline void account_hardirq_exit(struct task_struct *tsk)
+{
+	vtime_account_hardirq(tsk);
+	irqtime_account_irq(tsk, 0);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d23004524..2c36a5fad5891 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -44,12 +44,13 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 }
 
 /*
- * Called before incrementing preempt_count on {soft,}irq_enter
+ * Called after incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
  */
-void irqtime_account_irq(struct task_struct *curr)
+void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	unsigned int pc;
 	s64 delta;
 	int cpu;
 
@@ -59,6 +60,7 @@ void irqtime_account_irq(struct task_struct *curr)
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
+	pc = irq_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -66,12 +68,11 @@ void irqtime_account_irq(struct task_struct *curr)
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count())
+	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
-EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
@@ -418,24 +419,21 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-/*
- * Archs that account the whole time spent in the idle task
- * (outside irq) as idle time can rely on this and just implement
- * vtime_account_kernel() and vtime_account_idle(). Archs that
- * have other meaning of the idle time (s390 only includes the
- * time spent by the CPU when it's in low power mode) must override
- * vtime_account().
- */
-#ifndef __ARCH_HAS_VTIME_ACCOUNT
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	if (!in_interrupt() && is_idle_task(tsk))
+	unsigned int pc = irq_count() - offset;
+
+	if (pc & HARDIRQ_OFFSET) {
+		vtime_account_hardirq(tsk);
+	} else if (pc & SOFTIRQ_OFFSET) {
+		vtime_account_softirq(tsk);
+	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+		   is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
-	else
+	} else {
 		vtime_account_kernel(tsk);
+	}
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-#endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4406cdaa84670..08a30f7f04b55 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -164,18 +164,18 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
 			local_lock(&softirq_ctrl.lock);
+			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
 			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
 		}
 	}
 
-	preempt_disable();
 	/*
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
 	/*
 	 * Reflect the result in the task state to prevent recursion on the
 	 * local lock and to make softirq_count() & al work.
@@ -187,7 +187,6 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 		lockdep_softirqs_off(ip);
 		raw_local_irq_restore(flags);
 	}
-	preempt_enable();
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
@@ -199,16 +198,14 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
 	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
 			    this_cpu_read(softirq_ctrl.cnt));
 
-	preempt_disable();
 	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
 
-	newcnt = this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
 	current->softirq_disable_cnt = newcnt;
-	preempt_enable();
 
 	if (!newcnt && unlock) {
 		rcu_read_unlock();
@@ -263,22 +260,6 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-/*
- * Invoked from irq_enter_rcu() to prevent that tick_irq_enter()
- * pointlessly wakes the softirq daemon. That's handled in __irq_exit_rcu().
- * None of the above logic in the regular bh_disable/enable functions is
- * required here.
- */
-static inline void local_bh_disable_irq_enter(void)
-{
-	this_cpu_add(softirq_ctrl.cnt, SOFTIRQ_DISABLE_OFFSET);
-}
-
-static inline void local_bh_enable_irq_enter(void)
-{
-	this_cpu_sub(softirq_ctrl.cnt, SOFTIRQ_DISABLE_OFFSET);
-}
-
 /*
  * Invoked from ksoftirqd_run() outside of the interrupt disabled section
  * to acquire the per CPU local lock for reentrancy protection.
@@ -300,17 +281,17 @@ static inline void ksoftirqd_run_end(void)
 static inline void softirq_handle_begin(void) { }
 static inline void softirq_handle_end(void) { }
 
-static inline void invoke_softirq(void)
-{
-	if (!this_cpu_read(softirq_ctrl.cnt))
-		wakeup_softirqd();
-}
-
 static inline bool should_wake_ksoftirqd(void)
 {
 	return !this_cpu_read(softirq_ctrl.cnt);
 }
 
+static inline void invoke_softirq(void)
+{
+	if (should_wake_ksoftirqd())
+		wakeup_softirqd();
+}
+
 #else /* CONFIG_PREEMPT_RT */
 
 /*
@@ -408,16 +389,6 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-static inline void local_bh_disable_irq_enter(void)
-{
-	local_bh_disable();
-}
-
-static inline void local_bh_enable_irq_enter(void)
-{
-	_local_bh_enable();
-}
-
 static inline void softirq_handle_begin(void)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
@@ -557,10 +528,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
 
 	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
+	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -609,8 +580,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		wakeup_softirqd();
 	}
 
+	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	account_irq_exit_time(current);
 	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
@@ -620,16 +591,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
  */
 void irq_enter_rcu(void)
 {
-	if (is_idle_task(current) && !in_interrupt()) {
-		/*
-		 * Prevent raise_softirq from needlessly waking up ksoftirqd
-		 * here, as softirq will be serviced on return from interrupt.
-		 */
-		local_bh_disable_irq_enter();
+	__irq_enter_raw();
+
+	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
 		tick_irq_enter();
-		local_bh_enable_irq_enter();
-	}
-	__irq_enter();
+
+	account_hardirq_enter(current);
 }
 
 /**
@@ -661,7 +628,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14

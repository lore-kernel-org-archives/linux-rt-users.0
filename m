Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D5C48BD6
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB382086D
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 07:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfFYH5l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:57:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFYH5k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 03:57:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hfgKY-0007v5-Ox; Tue, 25 Jun 2019 09:57:30 +0200
Date:   Tue, 25 Jun 2019 09:57:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.21-rt13
Message-ID: <20190625075730.7twx4i6aamoqh6nz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.21-rt13 patch set. 

Changes since v5.0.21-rt12:

  - A patch by Kirill Smelkov to avoid deadlock in the switchtec driver.

  - Rework of the hrtimer, timer and posix-timer cancelation interface
    on -RT. Instead of the swait/schedule interface we now have locks
    which are taken while timer is active. During the cancellation of an
    active timer the lock is acquired. The lock will then either
    PI-boost the timer or block and wait until the timer completed.
    The new code looks simpler and does not trigger a warning from
    rcu_note_context_switch() anymore like reported by Grygorii Strashko
    and Daniel Wagner.
    The patches were contributed by Anna-Maria Gleixner.

  - Drop a preempt_disable_rt() statement in get_nohz_timer_target().
    The caller holds a lock which already disables preemption.

  - tasklet_kill() could deadlock since the softirq rework if the task
    invoking tasklet_kill() preempted the active tasklet.

  - in_softirq() (and related functions) did not work as expected since
    the softirq rework.

  - RCU_FAST_NO_HZ was disabled on RT because a timer was used in a bad
    context. After double checking this is no longer the case and the
    option can be enabled (but it depends on RCU_EXPERT so be careful).

  - The option "rcu.rcu_normal_after_boot=1" is set by default on RT.
    Now it is not possible to disable it on command line. Suggested by
    Paul E. McKenney.

  - Backport a patch from upstream to introduce
    user_access_{save,restore}() which is needed due to a backport made
    by stable.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.21-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.21-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.21-rt13

The RT patch against v5.0.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.21-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.21-rt13.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index db333300bd4be..6cfe431710203 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -58,6 +58,23 @@ static __always_inline void stac(void)
 	alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
 }
 
+static __always_inline unsigned long smap_save(void)
+{
+	unsigned long flags;
+
+	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __stringify(__ASM_CLAC),
+				  X86_FEATURE_SMAP)
+		      : "=rm" (flags) : : "memory", "cc");
+
+	return flags;
+}
+
+static __always_inline void smap_restore(unsigned long flags)
+{
+	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+		      : : "g" (flags) : "memory", "cc");
+}
+
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
 	ALTERNATIVE("", __stringify(__ASM_CLAC), X86_FEATURE_SMAP)
@@ -69,6 +86,9 @@ static __always_inline void stac(void)
 static inline void clac(void) { }
 static inline void stac(void) { }
 
+static inline unsigned long smap_save(void) { return 0; }
+static inline void smap_restore(unsigned long flags) { }
+
 #define ASM_CLAC
 #define ASM_STAC
 
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 2b0dd1b9c2087..743e1a96cd6ea 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -720,6 +720,9 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	__uaccess_end()
 
+#define user_access_save()	smap_save()
+#define user_access_restore(x)	smap_restore(x)
+
 #define unsafe_put_user(x, ptr, label)	\
 	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
 
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 80823ad221ba5..ba17eaa410f96 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -392,7 +392,7 @@ static int switchtec_dev_open(struct inode *inode, struct file *filp)
 		return PTR_ERR(stuser);
 
 	filp->private_data = stuser;
-	nonseekable_open(inode, filp);
+	stream_open(inode, filp);
 
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
 
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 190cb85044112..86ce98700f323 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,10 +471,11 @@ static int do_timerfd_settime(int ufd, int flags,
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
+
 		if (isalarm(ctx))
-			hrtimer_wait_for_timer(&ctx->t.alarm.timer);
+			hrtimer_grab_expiry_lock(&ctx->t.alarm.timer);
 		else
-			hrtimer_wait_for_timer(&ctx->t.tmr);
+			hrtimer_grab_expiry_lock(&ctx->t.tmr);
 	}
 
 	/*
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 34e9c6b74ae0a..c737e15ea6536 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -19,7 +19,6 @@
 #include <linux/percpu.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
-#include <linux/wait.h>
 
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
@@ -190,6 +189,8 @@ enum  hrtimer_base_type {
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
  * @expires_next:	absolute time of the next event, is required for remote
  *			hrtimer enqueue; it is the total first expiry time (hard
  *			and soft hrtimer are taken into account)
@@ -217,12 +218,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
 #endif
+	spinlock_t			softirq_expiry_lock;
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	wait_queue_head_t		wait;
-#endif
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
 } ____cacheline_aligned;
@@ -423,6 +422,7 @@ static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
 
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
+extern void hrtimer_grab_expiry_lock(const struct hrtimer *timer);
 
 static inline void hrtimer_start_expires(struct hrtimer *timer,
 					 enum hrtimer_mode mode)
@@ -440,13 +440,6 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/* Softirq preemption could deadlock timer removal */
-#ifdef CONFIG_PREEMPT_RT_BASE
-  extern void hrtimer_wait_for_timer(const struct hrtimer *timer);
-#else
-# define hrtimer_wait_for_timer(timer)	do { cpu_relax(); } while (0)
-#endif
-
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
@@ -472,7 +465,7 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  * Helper function to check, whether the timer is running the callback
  * function
  */
-static inline int hrtimer_callback_running(const struct hrtimer *timer)
+static inline int hrtimer_callback_running(struct hrtimer *timer)
 {
 	return timer->base->running == timer;
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9329de0d8bfdd..64762225e1756 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -596,7 +596,10 @@ static inline void tasklet_unlock(struct tasklet_struct *t)
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		local_bh_disable();
+		local_bh_enable();
+	}
 }
 #else
 #define tasklet_trylock(t) 1
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 05cd7466d10a8..d3552a5bcc8b2 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -15,6 +15,7 @@ struct cpu_timer_list {
 	u64 expires, incr;
 	struct task_struct *task;
 	int firing;
+	int firing_cpu;
 };
 
 /*
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 6a4884268f4c9..d559e3a0379c2 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -80,14 +80,6 @@
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
 				 | NMI_MASK))
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-long softirq_count(void);
-
-#else
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#endif
-
 /*
  * Are we doing bottom half or hardware interrupt processing?
  *
@@ -102,12 +94,23 @@ long softirq_count(void);
  *       should not be used in new code.
  */
 #define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
 #define in_nmi()		(preempt_count() & NMI_MASK)
 #define in_task()		(!(preempt_count() & \
 				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+#ifdef CONFIG_PREEMPT_RT_FULL
+
+#define softirq_count()		((long)get_current()->softirq_count)
+#define in_softirq()		(softirq_count())
+#define in_serving_softirq()	(get_current()->softirq_count & SOFTIRQ_OFFSET)
+
+#else
+
+#define softirq_count()		(preempt_count() & SOFTIRQ_MASK)
+#define in_softirq()		(softirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+
+#endif
 
 /*
  * The preempt_count offset after preempt_disable();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e1ea2ea52feb0..8c5bc47f934c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -961,6 +961,9 @@ struct task_struct {
 	int				softirqs_enabled;
 	int				softirq_context;
 #endif
+#ifdef CONFIG_PREEMPT_RT_FULL
+	int				softirq_count;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index d3afc0f018147..7f7356e151ce3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -270,6 +270,8 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
+static inline unsigned long user_access_save(void) { return 0UL; }
+static inline void user_access_restore(unsigned long flags) { }
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7e36ea9b7b720..5f5a54714a7a3 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -172,7 +172,7 @@ config RCU_FANOUT_LEAF
 
 config RCU_FAST_NO_HZ
 	bool "Accelerate last non-dyntick-idle CPU's grace periods"
-	depends on NO_HZ_COMMON && SMP && RCU_EXPERT && !PREEMPT_RT_FULL
+	depends on NO_HZ_COMMON && SMP && RCU_EXPERT
 	default n
 	help
 	  This option permits CPUs to enter dynticks-idle state even if
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 3700b730ea55d..aae5968ec9ebb 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -69,7 +69,9 @@ module_param(rcu_expedited, int, 0);
 extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+#ifndef CONFIG_PREEMPT_RT_FULL
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a8493ff60b673..2bd114e788a10 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -570,14 +570,11 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu;
+	int i, cpu = smp_processor_id();
 	struct sched_domain *sd;
 
-	preempt_disable_rt();
-	cpu = smp_processor_id();
-
 	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		goto preempt_en_rt;
+		return cpu;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -596,8 +593,6 @@ int get_nohz_timer_target(void)
 		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
 unlock:
 	rcu_read_unlock();
-preempt_en_rt:
-	preempt_enable_rt();
 	return cpu;
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 473369122ddd0..c4fae96f23c54 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -109,12 +109,6 @@ static bool ksoftirqd_running(unsigned long pending)
 static DEFINE_LOCAL_IRQ_LOCK(bh_lock);
 static DEFINE_PER_CPU(long, softirq_counter);
 
-long softirq_count(void)
-{
-	return raw_cpu_read(softirq_counter);
-}
-EXPORT_SYMBOL(softirq_count);
-
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long __maybe_unused flags;
@@ -125,6 +119,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 		local_lock(bh_lock);
 	soft_cnt = this_cpu_inc_return(softirq_counter);
 	WARN_ON_ONCE(soft_cnt == 0);
+	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_save(flags);
@@ -155,6 +150,7 @@ void _local_bh_enable(void)
 	local_irq_restore(flags);
 #endif
 
+	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
 	if (!in_atomic())
 		local_unlock(bh_lock);
 }
@@ -192,6 +188,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	if (!in_atomic())
 		local_unlock(bh_lock);
 
+	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
@@ -365,7 +362,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
-#ifndef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
+	current->softirq_count |= SOFTIRQ_OFFSET;
+#else
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
 #endif
 	in_hardirq = lockdep_softirq_start();
@@ -418,7 +417,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-#ifndef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
+	current->softirq_count &= ~SOFTIRQ_OFFSET;
+#else
 	__local_bh_enable(SOFTIRQ_OFFSET);
 #endif
 	WARN_ON_ONCE(in_interrupt());
@@ -468,7 +469,7 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-	if (softirq_count() == 0)
+	if (this_cpu_read(softirq_counter) == 0)
 		wakeup_softirqd();
 }
 
@@ -552,7 +553,7 @@ void raise_softirq_irqoff(unsigned int nr)
 	 * If were are not in BH-disabled section then we have to wake
 	 * ksoftirqd.
 	 */
-	if (softirq_count() == 0)
+	if (this_cpu_read(softirq_counter) == 0)
 		wakeup_softirqd();
 }
 
@@ -704,7 +705,8 @@ void tasklet_kill(struct tasklet_struct *t)
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		do {
-			yield();
+			local_bh_disable();
+			local_bh_enable();
 		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
 	}
 	tasklet_unlock_wait(t);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f6cd4bed61846..9f17e011087eb 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -433,7 +433,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(&alarm->timer);
+		hrtimer_grab_expiry_lock(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6e5d62bdebf22..2067f461b12a3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -930,33 +930,16 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 }
 EXPORT_SYMBOL_GPL(hrtimer_forward);
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-# define wake_up_timer_waiters(b)	wake_up(&(b)->wait)
-
-/**
- * hrtimer_wait_for_timer - Wait for a running timer
- *
- * @timer:	timer to wait for
- *
- * The function waits in case the timers callback function is
- * currently executed on the waitqueue of the timer base. The
- * waitqueue is woken up after the timer callback function has
- * finished execution.
- */
-void hrtimer_wait_for_timer(const struct hrtimer *timer)
+void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = timer->base;
 
-	if (base && base->cpu_base &&
-	    base->index >= HRTIMER_BASE_MONOTONIC_SOFT)
-		wait_event(base->cpu_base->wait,
-				!(hrtimer_callback_running(timer)));
+	if (base && base->cpu_base) {
+		spin_lock(&base->cpu_base->softirq_expiry_lock);
+		spin_unlock(&base->cpu_base->softirq_expiry_lock);
+	}
 }
 
-#else
-# define wake_up_timer_waiters(b)	do { } while (0)
-#endif
-
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
  *
@@ -1191,7 +1174,7 @@ int hrtimer_cancel(struct hrtimer *timer)
 
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(timer);
+		hrtimer_grab_expiry_lock(timer);
 	}
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
@@ -1495,6 +1478,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	unsigned long flags;
 	ktime_t now;
 
+	spin_lock(&cpu_base->softirq_expiry_lock);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1504,7 +1488,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-	wake_up_timer_waiters(cpu_base);
+	spin_unlock(&cpu_base->softirq_expiry_lock);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1914,9 +1898,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
-#ifdef CONFIG_PREEMPT_RT_BASE
-	init_waitqueue_head(&cpu_base->wait);
-#endif
+	spin_lock_init(&cpu_base->softirq_expiry_lock);
 	return 0;
 }
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index cb2b301d05490..d999294adeefd 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -213,7 +213,7 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
-			hrtimer_wait_for_timer(&tsk->signal->real_timer);
+			hrtimer_grab_expiry_lock(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a436ee592737a..5bb1edffe0d05 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -789,6 +789,7 @@ check_timers_list(struct list_head *timers,
 			return t->expires;
 
 		t->firing = 1;
+		t->firing_cpu = smp_processor_id();
 		list_move_tail(&t->entry, firing);
 	}
 
@@ -1131,6 +1132,20 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
 	return 0;
 }
 
+static DEFINE_PER_CPU(spinlock_t, cpu_timer_expiry_lock) = __SPIN_LOCK_UNLOCKED(cpu_timer_expiry_lock);
+
+void cpu_timers_grab_expiry_lock(struct k_itimer *timer)
+{
+	int cpu = timer->it.cpu.firing_cpu;
+
+	if (cpu >= 0) {
+		spinlock_t *expiry_lock = per_cpu_ptr(&cpu_timer_expiry_lock, cpu);
+
+		spin_lock_irq(expiry_lock);
+		spin_unlock_irq(expiry_lock);
+	}
+}
+
 /*
  * This is called from the timer interrupt handler.  The irq handler has
  * already updated our counts.  We need to check if any timers fire now.
@@ -1141,6 +1156,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	LIST_HEAD(firing);
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	spinlock_t *expiry_lock;
 
 	/*
 	 * The fast path checks that there are no expired thread or thread
@@ -1149,6 +1165,9 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	if (!fastpath_timer_check(tsk))
 		return;
 
+	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
+	spin_lock(expiry_lock);
+
 	if (!lock_task_sighand(tsk, &flags))
 		return;
 	/*
@@ -1183,6 +1202,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 		list_del_init(&timer->it.cpu.entry);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
+		timer->it.cpu.firing_cpu = -1;
 		/*
 		 * The firing flag is -1 if we collided with a reset
 		 * of the timer, which already reported this
@@ -1192,6 +1212,7 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+	spin_unlock(expiry_lock);
 }
 
 #ifdef CONFIG_PREEMPT_RT_BASE
@@ -1457,6 +1478,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		spin_unlock_irq(&timer.it_lock);
 
 		while (error == TIMER_RETRY) {
+
+			cpu_timers_grab_expiry_lock(&timer);
 			/*
 			 * We need to handle case when timer was or is in the
 			 * middle of firing. In other cases we already freed
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a4f57a1ea0df2..2c1ca3cc391b2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -800,27 +800,22 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
-/*
- * Protected by RCU!
- */
-static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_arm == common_hrtimer_arm)
-		hrtimer_wait_for_timer(&timr->it.real.timer);
-	else if (kc == &alarm_clock)
-		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
-	else
-		/* FIXME: Whacky hack for posix-cpu-timers */
-		schedule_timeout(1);
-#endif
-}
-
 static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 {
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timer)
+{
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_grab_expiry_lock(&timer->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_grab_expiry_lock(&timer->it.alarm.alarmtimer.timer);
+	else
+		/* posix-cpu-timers */
+		cpu_timers_grab_expiry_lock(timer);
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -880,21 +875,21 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
-	rcu_read_lock();
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
 		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
+		rcu_read_lock();
+		unlock_timer(timr, flag);
 		timer_wait_for_callback(kc, timr);
-		old_spec64 = NULL;	// We already got the old time...
 		rcu_read_unlock();
+		old_spec64 = NULL;	// We already got the old time...
 		goto retry;
 	}
-	rcu_read_unlock();
+	unlock_timer(timr, flag);
 
 	return error;
 }
@@ -956,13 +951,21 @@ int common_timer_del(struct k_itimer *timer)
 	return 0;
 }
 
-static inline int timer_delete_hook(struct k_itimer *timer)
+static int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
+	int ret;
 
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
-	return kc->timer_del(timer);
+	ret = kc->timer_del(timer);
+	if (ret == TIMER_RETRY) {
+		rcu_read_lock();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_for_callback(kc, timer);
+		rcu_read_unlock();
+	}
+	return ret;
 }
 
 /* Delete a POSIX.1b interval timer. */
@@ -976,15 +979,8 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	if (!timer)
 		return -EINVAL;
 
-	rcu_read_lock();
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
-	rcu_read_unlock();
 
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1010,20 +1006,9 @@ static void itimer_delete(struct k_itimer *timer)
 retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-	/* On RT we can race with a deletion */
-	if (!timer->it_signal) {
-		unlock_timer(timer, flags);
-		return;
-	}
-
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		rcu_read_lock();
-		unlock_timer(timer, flags);
-		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
-					timer);
-		rcu_read_unlock();
+	if (timer_delete_hook(timer) == TIMER_RETRY)
 		goto retry_delete;
-	}
+
 	list_del(&timer->list);
 	/*
 	 * This keeps any tasks waiting on the spin lock from thinking
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a0..725bd230a8db4 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -32,6 +32,8 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
+extern void cpu_timers_grab_expiry_lock(struct k_itimer *timer);
+
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 227dba00dd0ef..0b5f07c2fa834 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -43,7 +43,6 @@
 #include <linux/sched/debug.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
-#include <linux/swait.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -197,9 +196,7 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct swait_queue_head	wait_for_running_timer;
-#endif
+	spinlock_t		expiry_lock;
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1181,33 +1178,6 @@ void add_timer_on(struct timer_list *timer, int cpu)
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-/*
- * Wait for a running timer
- */
-static void wait_for_running_timer(struct timer_list *timer)
-{
-	struct timer_base *base;
-	u32 tf = timer->flags;
-
-	if (tf & TIMER_MIGRATING)
-		return;
-
-	base = get_timer_base(tf);
-	swait_event_exclusive(base->wait_for_running_timer,
-			      base->running_timer != timer);
-}
-
-# define wakeup_timer_waiters(b)	swake_up_all(&(b)->wait_for_running_timer)
-#else
-static inline void wait_for_running_timer(struct timer_list *timer)
-{
-	cpu_relax();
-}
-
-# define wakeup_timer_waiters(b)	do { } while (0)
-#endif
-
 /**
  * del_timer - deactivate a timer.
  * @timer: the timer to be deactivated
@@ -1237,6 +1207,25 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
+static int __try_to_del_timer_sync(struct timer_list *timer,
+				   struct timer_base **basep)
+{
+	struct timer_base *base;
+	unsigned long flags;
+	int ret = -1;
+
+	debug_assert_init(timer);
+
+	*basep = base = lock_timer_base(timer, &flags);
+
+	if (base->running_timer != timer)
+		ret = detach_if_pending(timer, base, true);
+
+	raw_spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
+}
+
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
  * @timer: timer to delete
@@ -1247,23 +1236,31 @@ EXPORT_SYMBOL(del_timer);
 int try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
-	unsigned long flags;
-	int ret = -1;
 
-	debug_assert_init(timer);
-
-	base = lock_timer_base(timer, &flags);
-
-	if (base->running_timer != timer)
-		ret = detach_if_pending(timer, base, true);
-
-	raw_spin_unlock_irqrestore(&base->lock, flags);
-
-	return ret;
+	return __try_to_del_timer_sync(timer, &base);
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
+static int __del_timer_sync(struct timer_list *timer)
+{
+	struct timer_base *base;
+	int ret;
+
+	for (;;) {
+		ret = __try_to_del_timer_sync(timer, &base);
+		if (ret >= 0)
+			return ret;
+
+		/*
+		 * When accessing the lock, timers of base are no longer expired
+		 * and so timer is no longer running.
+		 */
+		spin_lock(&base->expiry_lock);
+		spin_unlock(&base->expiry_lock);
+	}
+}
+
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1319,12 +1316,8 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		wait_for_running_timer(timer);
-	}
+
+	return __del_timer_sync(timer);
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1389,11 +1382,15 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
+			spin_unlock(&base->expiry_lock);
+			spin_lock(&base->expiry_lock);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1688,6 +1685,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	spin_lock(&base->expiry_lock);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1715,7 +1713,7 @@ static inline void __run_timers(struct timer_base *base)
 			expire_timers(base, heads + levels);
 	}
 	raw_spin_unlock_irq(&base->lock);
-	wakeup_timer_waiters(base);
+	spin_unlock(&base->expiry_lock);
 }
 
 /*
@@ -1962,9 +1960,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-#ifdef CONFIG_PREEMPT_RT_FULL
-		init_swait_queue_head(&base->wait_for_running_timer);
-#endif
+		spin_lock_init(&base->expiry_lock);
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13

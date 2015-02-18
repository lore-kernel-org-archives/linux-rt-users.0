From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY
 explosions
Date: Wed, 18 Feb 2015 12:21:54 +0100
Message-ID: <1424258514.3819.39.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216111822.GA21649@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:

> Known issues:
>
>       - lazy preempt on x86_64 leads to a crash with some load.

The below still works for me.  (it doesn't make nohz_full actually work
in rt, but at least folks who want to tinker with it can do so)


If context tracking is enabled, we can recurse, and explode violently.
Add missing checks to preempt_schedule_context().

Fix other inconsistencies spotted while searching for the little SOB.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 arch/x86/Kconfig                   |    2 +-
 arch/x86/include/asm/thread_info.h |    1 +
 include/linux/preempt.h            |    2 +-
 include/linux/preempt_mask.h       |   10 ++++++++--
 kernel/fork.c                      |    1 +
 kernel/sched/core.c                |   18 ++++++------------
 kernel/sched/fair.c                |    2 +-
 7 files changed, 19 insertions(+), 17 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -21,7 +21,7 @@ config X86_64
 ### Arch settings
 config X86
 	def_bool y
-	select HAVE_PREEMPT_LAZY if X86_32
+	select HAVE_PREEMPT_LAZY
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_FAST_MULTIPLIER
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -46,6 +46,7 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.saved_preempt_count = INIT_PREEMPT_COUNT,	\
+	.preempt_lazy_count = 0,		\
 	.addr_limit	= KERNEL_DS,		\
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -91,8 +91,8 @@ do { \
 
 #define preempt_lazy_enable() \
 do { \
-	dec_preempt_lazy_count(); \
 	barrier(); \
+	dec_preempt_lazy_count(); \
 	preempt_check_resched(); \
 } while (0)
 
--- a/include/linux/preempt_mask.h
+++ b/include/linux/preempt_mask.h
@@ -118,9 +118,15 @@ extern int in_serving_softirq(void);
 		((preempt_count() & ~PREEMPT_ACTIVE) != PREEMPT_CHECK_OFFSET)
 
 #ifdef CONFIG_PREEMPT_COUNT
-# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
+# define preemptible()		(preempt_count() == 0 && !irqs_disabled())
+#ifdef CONFIG_PREEMPT_LAZY
+# define preemptible_lazy()	(preempt_lazy_count() == 0 || need_resched_now())
 #else
-# define preemptible()	0
+# define preemptible_lazy()	1
+#endif
+#else
+# define preemptible()		0
+# define preemptible_lazy()	0
 #endif
 
 #endif /* LINUX_PREEMPT_MASK_H */
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -348,6 +348,7 @@ static struct task_struct *dup_task_stru
 	setup_thread_stack(tsk, orig);
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
+	clear_tsk_need_resched_lazy(tsk);
 	set_task_stack_end_magic(tsk);
 
 #ifdef CONFIG_CC_STACKPROTECTOR
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2861,8 +2861,8 @@ void migrate_enable(void)
 		p->migrate_disable = 0;
 
 	unpin_current_cpu();
-	preempt_enable();
 	preempt_lazy_enable();
+	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
 #else
@@ -3099,19 +3099,13 @@ asmlinkage __visible void __sched notrac
 {
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
-	 * we do not want to preempt the current task. Just return..
+	 * we do not want to preempt the current task. Just return.  For
+	 * lazy preemption we also check for non-zero preempt_count_lazy,
+	 * and bail if no immediate preemption is required.
 	 */
-	if (likely(!preemptible()))
+	if (likely(!preemptible() || !preemptible_lazy()))
 		return;
 
-#ifdef CONFIG_PREEMPT_LAZY
-	/*
-	 * Check for lazy preemption
-	 */
-	if (current_thread_info()->preempt_lazy_count &&
-			!test_thread_flag(TIF_NEED_RESCHED))
-		return;
-#endif
 	do {
 		__preempt_count_add(PREEMPT_ACTIVE);
 		/*
@@ -3155,7 +3149,7 @@ asmlinkage __visible void __sched notrac
 {
 	enum ctx_state prev_ctx;
 
-	if (likely(!preemptible()))
+	if (likely(!preemptible() || !preemptible_lazy()))
 		return;
 
 	do {
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4761,7 +4761,7 @@ static void check_preempt_wakeup(struct
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(curr) || test_tsk_need_resched_lazy(curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */

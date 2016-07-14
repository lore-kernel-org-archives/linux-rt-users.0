From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.102-rt113
Date: Thu, 14 Jul 2016 10:59:16 -0400
Message-ID: <20160714105916.1228c64d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.10.102-rt113 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: 1df43a742d5375abf819762126f484afe674dbda


Or to build 3.10.102-rt113 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.102.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.102-rt113.patch.xz



You can also build from 3.10.102-rt112 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.102-rt112-rt113.patch.xz



Enjoy,

-- Steve


Changes from v3.10.102-rt112:

---

Corey Minyard (1):
      x86: Fix an RT MCE crash

Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (4):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 3.10.102-rt113

----
 arch/arm/kernel/entry-armv.S     |  6 +++++-
 arch/x86/kernel/cpu/mcheck/mce.c |  3 ++-
 arch/x86/kernel/kvm.c            | 37 +++++++++++++++++++------------------
 include/linux/list_bl.h          | 12 +++++++-----
 include/trace/ftrace.h           |  3 +++
 kernel/printk.c                  | 10 ++++++++++
 localversion-rt                  |  2 +-
 net/core/dev.c                   |  4 ++++
 8 files changed, 51 insertions(+), 26 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9b51e3faff52..06be94212de9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -234,7 +234,11 @@ svc_preempt:
 	bne	1b
 	tst	r0, #_TIF_NEED_RESCHED_LAZY
 	moveq	pc, r8				@ go again
-	b	1b
+	ldr	r0, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
+	teq	r0, #0				@ if preempt lazy count != 0
+	beq	1b
+	mov	pc, r8				@ go again
+
 #endif
 
 __und_fault:
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index aaf4b9b94f38..cc70d98a30f6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (mce_notify_helper)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c4ff2a916139..2434b60a39de 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -34,6 +34,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kprobes.h>
+#include <linux/wait-simple.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -89,14 +90,14 @@ static void kvm_io_delay(void)
 
 struct kvm_task_sleep_node {
 	struct hlist_node link;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u32 token;
 	int cpu;
 	bool halted;
 };
 
 static struct kvm_task_sleep_head {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct hlist_head list;
 } async_pf_sleepers[KVM_TASK_SLEEP_HASHSIZE];
 
@@ -120,17 +121,17 @@ void kvm_async_pf_task_wait(u32 token)
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
 	struct kvm_task_sleep_node n, *e;
-	DEFINE_WAIT(wait);
+	DEFINE_SWAITER(wait);
 
 	rcu_irq_enter();
 
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	e = _find_apf_task(b, token);
 	if (e) {
 		/* dummy entry exist -> wake up was delivered ahead of PF */
 		hlist_del(&e->link);
 		kfree(e);
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 
 		rcu_irq_exit();
 		return;
@@ -139,13 +140,13 @@ void kvm_async_pf_task_wait(u32 token)
 	n.token = token;
 	n.cpu = smp_processor_id();
 	n.halted = is_idle_task(current) || preempt_count() > 1;
-	init_waitqueue_head(&n.wq);
+	init_swait_head(&n.wq);
 	hlist_add_head(&n.link, &b->list);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 
 	for (;;) {
 		if (!n.halted)
-			prepare_to_wait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
+			swait_prepare(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
@@ -164,7 +165,7 @@ void kvm_async_pf_task_wait(u32 token)
 		}
 	}
 	if (!n.halted)
-		finish_wait(&n.wq, &wait);
+		swait_finish(&n.wq, &wait);
 
 	rcu_irq_exit();
 	return;
@@ -176,8 +177,8 @@ static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 	hlist_del_init(&n->link);
 	if (n->halted)
 		smp_send_reschedule(n->cpu);
-	else if (waitqueue_active(&n->wq))
-		wake_up(&n->wq);
+	else if (swaitqueue_active(&n->wq))
+		swait_wake(&n->wq);
 }
 
 static void apf_task_wake_all(void)
@@ -187,14 +188,14 @@ static void apf_task_wake_all(void)
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++) {
 		struct hlist_node *p, *next;
 		struct kvm_task_sleep_head *b = &async_pf_sleepers[i];
-		spin_lock(&b->lock);
+		raw_spin_lock(&b->lock);
 		hlist_for_each_safe(p, next, &b->list) {
 			struct kvm_task_sleep_node *n =
 				hlist_entry(p, typeof(*n), link);
 			if (n->cpu == smp_processor_id())
 				apf_task_wake_one(n);
 		}
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 	}
 }
 
@@ -210,7 +211,7 @@ void kvm_async_pf_task_wake(u32 token)
 	}
 
 again:
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	n = _find_apf_task(b, token);
 	if (!n) {
 		/*
@@ -223,17 +224,17 @@ again:
 			 * Allocation failed! Busy wait while other cpu
 			 * handles async PF.
 			 */
-			spin_unlock(&b->lock);
+			raw_spin_unlock(&b->lock);
 			cpu_relax();
 			goto again;
 		}
 		n->token = token;
 		n->cpu = smp_processor_id();
-		init_waitqueue_head(&n->wq);
+		init_swait_head(&n->wq);
 		hlist_add_head(&n->link, &b->list);
 	} else
 		apf_task_wake_one(n);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 	return;
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wake);
@@ -482,7 +483,7 @@ void __init kvm_guest_init(void)
 	paravirt_ops_setup();
 	register_reboot_notifier(&kvm_pv_reboot_nb);
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++)
-		spin_lock_init(&async_pf_sleepers[i].lock);
+		raw_spin_lock_init(&async_pf_sleepers[i].lock);
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF))
 		x86_init.irqs.trap_init = kvm_apf_trap_init;
 
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index d8876a0cf036..017d0f1c1eb4 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -42,13 +42,15 @@ struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
 
-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
-{
-	h->first = NULL;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	raw_spin_lock_init(&h->lock);
+#define INIT_HLIST_BL_HEAD(h)		\
+do {					\
+	(h)->first = NULL;		\
+	raw_spin_lock_init(&(h)->lock);	\
+} while (0)
+#else
+#define INIT_HLIST_BL_HEAD(h) (h)->first = NULL
 #endif
-}
 
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index dbb47418df81..f30e85b675e8 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -526,6 +526,9 @@ ftrace_raw_event_##call(void *__data, proto)				\
 									\
 	local_save_flags(irq_flags);					\
 	pc = preempt_count();						\
+	/* Account for tracepoint preempt disable */			\
+	if (IS_ENABLED(CONFIG_PREEMPT))					\
+		pc--;							\
 									\
 	__data_size = ftrace_get_offsets_##call(&__data_offsets, args); \
 									\
diff --git a/kernel/printk.c b/kernel/printk.c
index 1b7fbc73c125..55b6871f21e2 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -1302,6 +1302,11 @@ static void call_console_drivers(int level, const char *text, size_t len)
 	if (!console_drivers)
 		return;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	migrate_disable();
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
@@ -2236,6 +2241,11 @@ void console_unblank(void)
 {
 	struct console *c;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	/*
 	 * console_unblank can no longer be called in interrupt context unless
 	 * oops_in_progress is set to 1..
diff --git a/localversion-rt b/localversion-rt
index 0c40e2660574..fdcd9167ca0b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt112
+-rt113
diff --git a/net/core/dev.c b/net/core/dev.c
index 1857dde698ca..28e1c539099f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2680,7 +2680,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	 * This permits __QDISC_STATE_RUNNING owner to get the lock more often
 	 * and dequeue packets faster.
 	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	contended = true;
+#else
 	contended = qdisc_is_running(q);
+#endif
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 

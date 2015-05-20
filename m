From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.75-rt81
Date: Wed, 20 May 2015 10:56:49 -0400
Message-ID: <20150520105649.19821d23@gandalf.local.home>
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

I'm pleased to announce the 3.10.75-rt81 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: da82a06c28aba98d042119da61af5636d32b4977


Or to build 3.10.75-rt81 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.75.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.75-rt81.patch.xz



You can also build from 3.10.75-rt80 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.75-rt80-rt81.patch.xz



Enjoy,

-- Steve


Changes from v3.10.75-rt80:

---

Marcelo Tosatti (2):
      KVM: lapic: mark LAPIC timer handler as irqsafe
      KVM: use simple waitqueue for vcpu->wq

Mike Galbraith (2):
      hotplug: Use set_cpus_allowed_ptr() in sync_unplug_thread()
      rt, nohz_full: fix nohz_full for PREEMPT_RT_FULL

Sebastian Andrzej Siewior (1):
      kernel/irq_work: fix no_hz deadlock

Steven Rostedt (Red Hat) (1):
      Linux 3.10.75-rt81

----
 arch/arm/kvm/arm.c                  |  4 ++--
 arch/arm/kvm/psci.c                 |  4 ++--
 arch/powerpc/include/asm/kvm_host.h |  4 ++--
 arch/powerpc/kernel/time.c          |  2 +-
 arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++--------
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/sparc/kernel/pcr.c             |  2 --
 arch/x86/kernel/irq_work.c          |  2 --
 arch/x86/kvm/lapic.c                | 48 ++++++++++++++++++++++++++++++++-----
 include/linux/kvm_host.h            |  4 ++--
 kernel/cpu.c                        |  2 +-
 kernel/irq_work.c                   |  5 +---
 kernel/sched/core.c                 | 29 +++++++++++++++++-----
 kernel/time/tick-sched.c            | 10 ++++++++
 kernel/timer.c                      |  2 +-
 localversion-rt                     |  2 +-
 virt/kvm/async_pf.c                 |  4 ++--
 virt/kvm/kvm_main.c                 | 16 ++++++-------
 18 files changed, 109 insertions(+), 53 deletions(-)
---------------------------
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index ef1703b9587b..6837ef09934c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -487,9 +487,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	swait_event_interruptible(*wq, !vcpu->arch.pause);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 7ee5bb7a3667..6da25764094f 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -35,7 +35,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu;
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	unsigned long cpu_id;
 	phys_addr_t target_pc;
 
@@ -66,7 +66,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	vcpu->arch.pause = false;
 	smp_mb();		/* Make sure the above is visible */
 
-	wake_up_interruptible(wq);
+	swait_wake_interruptible(wq);
 
 	return KVM_PSCI_RET_SUCCESS;
 }
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index af326cde7cb6..286e65ad2fa1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -294,7 +294,7 @@ struct kvmppc_vcore {
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u64 stolen_tb;
 	u64 preempt_tb;
 	struct kvm_vcpu *runner;
@@ -566,7 +566,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe66ccabb744..03c314694e58 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -423,7 +423,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 
 /*
  * 64-bit uses a byte in the PACA, 32-bit uses a per-cpu variable...
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 102ad8a255f3..47193e4ae46f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -70,11 +70,11 @@ void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swaitqueue_active(wqp)) {
+		swait_wake_interruptible(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -534,8 +534,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		tvcpu->arch.prodded = 1;
 		smp_mb();
 		if (vcpu->arch.ceded) {
-			if (waitqueue_active(&vcpu->wq)) {
-				wake_up_interruptible(&vcpu->wq);
+			if (swaitqueue_active(&vcpu->wq)) {
+				swait_wake_interruptible(&vcpu->wq);
 				vcpu->stat.halt_wakeup++;
 			}
 		}
@@ -942,7 +942,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 		if (vcore) {
 			INIT_LIST_HEAD(&vcore->runnable_threads);
 			spin_lock_init(&vcore->lock);
-			init_waitqueue_head(&vcore->wq);
+			init_swait_head(&vcore->wq);
 			vcore->preempt_tb = TB_NIL;
 		}
 		kvm->arch.vcores[core] = vcore;
@@ -1315,13 +1315,13 @@ static void kvmppc_wait_for_exec(struct kvm_vcpu *vcpu, int wait_state)
  */
 static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_SWAITER(wait);
 
-	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	swait_prepare(&vc->wq, &wait, TASK_INTERRUPTIBLE);
 	vc->vcore_state = VCORE_SLEEPING;
 	spin_unlock(&vc->lock);
 	schedule();
-	finish_wait(&vc->wq, &wait);
+	swait_finish(&vc->wq, &wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 }
@@ -1363,7 +1363,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_create_dtl_entry(vcpu, vc);
 			kvmppc_start_thread(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swait_wake(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 16bd5d169cdb..1a492e2f1075 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -219,7 +219,7 @@ struct kvm_s390_local_interrupt {
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
 	int timer_due; /* event indicator for waitqueue below */
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
 };
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index dbb51a6441a6..269af58497aa 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -43,12 +43,10 @@ void __irq_entry deferred_pcr_work_irq(int irq, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	set_softint(1 << PIL_DEFERRED_PCR_WORK);
 }
-#endif
 
 const struct pcr_ops *pcr_ops;
 EXPORT_SYMBOL_GPL(pcr_ops);
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 129b8bb73de2..ca8f703a1e70 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -18,7 +18,6 @@ void smp_irq_work_interrupt(struct pt_regs *regs)
 	irq_exit();
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -29,4 +28,3 @@ void arch_irq_work_raise(void)
 	apic_wait_icr_idle();
 #endif
 }
-#endif
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 681e4e251f00..dce9273a3361 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1045,8 +1045,38 @@ static void update_divide_count(struct kvm_lapic *apic)
 				   apic->divide_count);
 }
 
+
+static enum hrtimer_restart apic_timer_fn(struct hrtimer *data);
+
+static void apic_timer_expired(struct hrtimer *data)
+{
+	int ret, i = 0;
+	enum hrtimer_restart r;
+	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
+
+	r = apic_timer_fn(data);
+
+	if (r == HRTIMER_RESTART) {
+		do {
+			ret = hrtimer_start_expires(data, HRTIMER_MODE_ABS);
+			if (ret == -ETIME)
+				hrtimer_add_expires_ns(&ktimer->timer,
+							ktimer->period);
+			i++;
+		} while (ret == -ETIME && i < 10);
+
+		if (ret == -ETIME) {
+			printk_once(KERN_ERR "%s: failed to reprogram timer\n",
+			       __func__);
+			WARN_ON_ONCE(1);
+		}
+	}
+}
+
+
 static void start_apic_timer(struct kvm_lapic *apic)
 {
+	int ret;
 	ktime_t now;
 	atomic_set(&apic->lapic_timer.pending, 0);
 
@@ -1076,9 +1106,11 @@ static void start_apic_timer(struct kvm_lapic *apic)
 			}
 		}
 
-		hrtimer_start(&apic->lapic_timer.timer,
+		ret = hrtimer_start(&apic->lapic_timer.timer,
 			      ktime_add_ns(now, apic->lapic_timer.period),
 			      HRTIMER_MODE_ABS);
+		if (ret == -ETIME)
+			apic_timer_expired(&apic->lapic_timer.timer);
 
 		apic_debug("%s: bus cycle is %" PRId64 "ns, now 0x%016"
 			   PRIx64 ", "
@@ -1108,8 +1140,10 @@ static void start_apic_timer(struct kvm_lapic *apic)
 			ns = (tscdeadline - guest_tsc) * 1000000ULL;
 			do_div(ns, this_tsc_khz);
 		}
-		hrtimer_start(&apic->lapic_timer.timer,
+		ret = hrtimer_start(&apic->lapic_timer.timer,
 			ktime_add_ns(now, ns), HRTIMER_MODE_ABS);
+		if (ret == -ETIME)
+			apic_timer_expired(&apic->lapic_timer.timer);
 
 		local_irq_restore(flags);
 	}
@@ -1547,7 +1581,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
 	struct kvm_lapic *apic = container_of(ktimer, struct kvm_lapic, lapic_timer);
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_head *q = &vcpu->wq;
 
 	/*
 	 * There is a race window between reading and incrementing, but we do
@@ -1561,8 +1595,8 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
 	}
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swaitqueue_active(q))
+		swait_wake_interruptible(q);
 
 	if (lapic_is_periodic(apic)) {
 		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
@@ -1595,6 +1629,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS);
 	apic->lapic_timer.timer.function = apic_timer_fn;
+	apic->lapic_timer.timer.irqsafe = 1;
 
 	/*
 	 * APIC is created enabled. This will prevent kvm_lapic_set_base from
@@ -1713,7 +1748,8 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &vcpu->arch.apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) == -ETIME)
+			apic_timer_expired(timer);
 }
 
 /*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8db53cfaccdb..be9bcd06c571 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -220,7 +220,7 @@ struct kvm_vcpu {
 
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -655,7 +655,7 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b460d99bc761..50ae129671f0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -234,7 +234,7 @@ static int sync_unplug_thread(void *data)
 	 * we don't want any more work on this CPU.
 	 */
 	current->flags &= ~PF_NO_SETAFFINITY;
-	do_set_cpus_allowed(current, cpu_present_mask);
+	set_cpus_allowed_ptr(current, cpu_present_mask);
 	migrate_me();
 	return 0;
 }
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 35d21f93bbe8..5f7d93d89c7f 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -16,6 +16,7 @@
 #include <linux/tick.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
+#include <linux/interrupt.h>
 #include <asm/processor.h>
 
 
@@ -51,11 +52,7 @@ static bool irq_work_claim(struct irq_work *work)
 	return true;
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-void arch_irq_work_raise(void)
-#else
 void __weak arch_irq_work_raise(void)
-#endif
 {
 	/*
 	 * Lame architectures will get the timer tick callback
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6d5587cc529..23e289ae4270 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -694,17 +694,34 @@ static inline bool got_nohz_idle_kick(void)
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
+
+static int ksoftirqd_running(void)
+{
+	struct task_struct *softirqd;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		return 0;
+	softirqd = this_cpu_ksoftirqd();
+	if (softirqd && softirqd->on_rq)
+		return 1;
+	return 0;
+}
+
 bool sched_can_stop_tick(void)
 {
-       struct rq *rq;
+	struct rq *rq;
 
-       rq = this_rq();
+	rq = this_rq();
 
-       /* Make sure rq->nr_running update is visible after the IPI */
-       smp_rmb();
+	/* Make sure rq->nr_running update is visible after the IPI */
+	smp_rmb();
 
-       /* More than one running task need preemption */
-       if (rq->nr_running > 1)
+	/*
+	 * More than one running task need preemption
+	 *
+	 * NOTE, RT: if ksoftirqd is awake, subtract it.
+	 */
+	if (rq->nr_running - ksoftirqd_running() > 1)
                return false;
 
        return true;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index aedf4c21e2c1..d2e137953d44 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -174,6 +174,11 @@ static bool can_stop_full_tick(void)
 		return false;
 	}
 
+	if (!arch_irq_work_has_interrupt()) {
+		trace_tick_stop(0, "missing irq work interrupt\n");
+		return false;
+	}
+
 	/* sched_clock_tick() needs us? */
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 	/*
@@ -209,7 +214,12 @@ void tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+	unsigned long flags;
+
+	/* ksoftirqd processes sirqs with interrupts enabled */
+	local_irq_save(flags);
 	tick_nohz_full_check();
+	local_irq_restore(flags);
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
diff --git a/kernel/timer.c b/kernel/timer.c
index a2bfef4a8f23..4254253f2267 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1450,7 +1450,7 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
-#if defined(CONFIG_IRQ_WORK)
+#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
 	if (in_irq())
 		irq_work_run();
 #endif
diff --git a/localversion-rt b/localversion-rt
index 5ba2c2091cf9..8269ec129c0c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt80
+-rt81
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index ea475cd03511..59a9f1eada67 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -85,8 +85,8 @@ static void async_pf_execute(struct work_struct *work)
 
 	trace_kvm_async_pf_completed(addr, page, gva);
 
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swaitqueue_active(&vcpu->wq))
+		swait_wake_interruptible(&vcpu->wq);
 
 	mmdrop(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a17f190be58e..71a1f09cd94b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -233,7 +233,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	init_waitqueue_head(&vcpu->wq);
+	init_swait_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -1672,10 +1672,10 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
  */
 void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_SWAITER(wait);
 
 	for (;;) {
-		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+		swait_prepare(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_arch_vcpu_runnable(vcpu)) {
 			kvm_make_request(KVM_REQ_UNHALT, vcpu);
@@ -1689,7 +1689,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		schedule();
 	}
 
-	finish_wait(&vcpu->wq, &wait);
+	swait_finish(&vcpu->wq, &wait);
 }
 
 #ifndef CONFIG_S390
@@ -1700,11 +1700,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swaitqueue_active(wqp)) {
+		swait_wake_interruptible(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -1816,7 +1816,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq))
+			if (swaitqueue_active(&vcpu->wq))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;

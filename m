From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.11-rt7
Date: Mon, 13 Apr 2015 15:15:49 +0200
Message-ID: <20150413131549.GA19684@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v3.18.11-rt7 patch set.

Changes since v3.18.11-rt6

- kvm tick optimisation by Marcelo Tosatti.

- the cpufreq driver for "AMD Opteron/Athlon64 PowerNow" is deactivated.
  Ralf Mardorf reported that this responsible for a crash on his
  machine. Since nobody is able to debug this, it remains off on -RT.

- Carsten Emde reported a hrtimer related deadlock in FULL_NOHZ mode.
  The deadlock is workarounded by using the dedicated IRQ vector for
  NOHZ callbacks.

- Mike Galbraith reworked a patch of his to get FULL_NOHZ working on
  -RT (again).

- a hotplug related fix by Mike Galbraith.

Known issues:

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 3.18.11-rt6 is appended below and can be found here: 

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.11-rt6-rt7.patch.xz

The RT patch against 3.18.11 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.11-rt7.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.11-rt7.tar.xz

Sebastian

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fe912bc87c33..a8e32aaf0383 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -506,14 +506,12 @@ void arch_send_call_function_single_ipi(int cpu)
 }
 
 #ifdef CONFIG_IRQ_WORK
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	if (arch_irq_work_has_interrupt())
 		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
-#endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9e193c8a959e..e71a43720a21 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -441,9 +441,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	swait_event_interruptible(*wq, !vcpu->arch.pause);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 09cf37737ee2..b26f4cb51b1e 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -66,7 +66,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL, *tmp;
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
 	unsigned long mpidr;
@@ -123,7 +123,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	wake_up_interruptible(wq);
+	swait_wake_interruptible(wq);
 
 	return PSCI_RET_SUCCESS;
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1828a6421f60..b06d1d90ee8c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -529,14 +529,12 @@ void arch_send_call_function_single_ipi(int cpu)
 }
 
 #ifdef CONFIG_IRQ_WORK
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 	if (__smp_cross_call)
 		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
-#endif
 
 static DEFINE_RAW_SPINLOCK(stop_lock);
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 047855619cc4..addfd9b99cef 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -296,7 +296,7 @@ struct kvmppc_vcore {
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u64 stolen_tb;
 	u64 preempt_tb;
 	struct kvm_vcpu *runner;
@@ -618,7 +618,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 550a14dd313b..f4de021815ae 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -424,7 +424,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 
 /*
  * 64-bit uses a byte in the PACA, 32-bit uses a per-cpu variable...
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e63587d30b70..499bc8303456 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -84,11 +84,11 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
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
 
@@ -639,8 +639,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
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
@@ -1357,7 +1357,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 
 	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
-	init_waitqueue_head(&vcore->wq);
+	init_swait_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
 	vcore->first_vcpuid = core * threads_per_subcore;
@@ -1826,13 +1826,13 @@ static void kvmppc_wait_for_exec(struct kvm_vcpu *vcpu, int wait_state)
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
@@ -1873,7 +1873,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_create_dtl_entry(vcpu, vc);
 			kvmppc_start_thread(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swait_wake(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2175f911a73a..884ec9b27b3c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -311,7 +311,7 @@ struct kvm_s390_local_interrupt {
 	struct list_head list;
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
 };
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 29e2e5aa2111..e6c1cd7043df 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -619,13 +619,13 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
-	if (waitqueue_active(&vcpu->wq)) {
+	if (swaitqueue_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
 		 * yield-candidate.
 		 */
 		vcpu->preempted = true;
-		wake_up_interruptible(&vcpu->wq);
+		swait_wake_interruptible(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
 }
@@ -746,7 +746,7 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swaitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
 }
@@ -771,7 +771,7 @@ int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swaitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
 }
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 927d9c5e50f5..7e967c8018c8 100644
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
index cbfb33df3749..15d741ddfeeb 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -38,7 +38,6 @@ __visible void smp_trace_irq_work_interrupt(struct pt_regs *regs)
 	exiting_irq();
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 void arch_irq_work_raise(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -49,4 +48,3 @@ void arch_irq_work_raise(void)
 	apic_wait_icr_idle();
 #endif
 }
-#endif
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b8345dd41b25..ca7b11e8e2d3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1034,8 +1034,38 @@ static void update_divide_count(struct kvm_lapic *apic)
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
 
@@ -1065,9 +1095,11 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -1097,8 +1129,10 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -1539,7 +1573,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
 	struct kvm_lapic *apic = container_of(ktimer, struct kvm_lapic, lapic_timer);
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_head *q = &vcpu->wq;
 
 	/*
 	 * There is a race window between reading and incrementing, but we do
@@ -1553,8 +1587,8 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
 	}
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swaitqueue_active(q))
+		swait_wake_interruptible(q);
 
 	if (lapic_is_periodic(apic)) {
 		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
@@ -1587,6 +1621,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS);
 	apic->lapic_timer.timer.function = apic_timer_fn;
+	apic->lapic_timer.timer.irqsafe = 1;
 
 	/*
 	 * APIC is created enabled. This will prevent kvm_lapic_set_base from
@@ -1707,7 +1742,8 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &vcpu->arch.apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) == -ETIME)
+			apic_timer_expired(timer);
 }
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec679b2c2229..49909ae53e50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -194,7 +194,7 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->resid_len = 0;
 	rq->sense = NULL;
 
-#if CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
 	INIT_WORK(&rq->work, __blk_mq_complete_request_remote_work);
 #endif
 	INIT_LIST_HEAD(&rq->timeout_list);
@@ -352,7 +352,7 @@ static void blk_mq_ipi_complete_request(struct request *rq)
 		shared = cpus_share_cache(cpu, ctx->cpu);
 
 	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
-#if CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
 		schedule_work_on(ctx->cpu, &rq->work);
 #else
 		rq->csd.func = __blk_mq_complete_request_remote;
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 89ae88f91895..e3108a67e671 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -113,7 +113,7 @@ config X86_POWERNOW_K7_ACPI
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ
+	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ && !PREEMPT_RT_BASE
 	help
 	  This adds the CPUFreq driver for K8/early Opteron/Athlon64 processors.
 	  Support for K10 and newer processors is now in acpi-cpufreq.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a6059bdf7b03..9527595fdb2d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -244,7 +244,7 @@ struct kvm_vcpu {
 
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -687,7 +687,7 @@ static inline bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index af677166c2a8..27f44cd27d9d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -265,7 +265,7 @@ static int sync_unplug_thread(void *data)
 	 * we don't want any more work on this CPU.
 	 */
 	current->flags &= ~PF_NO_SETAFFINITY;
-	do_set_cpus_allowed(current, cpu_present_mask);
+	set_cpus_allowed_ptr(current, cpu_present_mask);
 	migrate_me();
 	return 0;
 }
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 4b53470bf97b..9dda38a377bf 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
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
@@ -118,8 +115,9 @@ bool irq_work_queue(struct irq_work *work)
 		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
 			arch_irq_work_raise();
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
-			arch_irq_work_raise();
+		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+		    tick_nohz_tick_stopped())
+			raise_softirq(TIMER_SOFTIRQ);
 	}
 #else
 	if (work->flags & IRQ_WORK_LAZY) {
@@ -203,30 +201,25 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_irq()) {
-		irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-		return;
-	}
-#endif
+	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
+#else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
+#endif
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
 void irq_work_tick(void)
 {
-	struct llist_head *raised;
-
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_irq()) {
-		irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-		return;
-	}
-#endif
-	raised = &__get_cpu_var(raised_list);
-	if (!llist_empty(raised))
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+#else
+	struct llist_head *raised = &__get_cpu_var(raised_list);
+
+	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
 	irq_work_run_list(&__get_cpu_var(lazy_list));
+#endif
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d2c72bb3376..f093b200d8ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -786,14 +786,29 @@ static inline bool got_nohz_idle_kick(void)
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
 	/*
 	 * More than one running task need preemption.
 	 * nr_running update is assumed to be visible
 	 * after IPI is sent from wakers.
+	 *
+	 * NOTE, RT: if ksoftirqd is awake, subtract it.
 	 */
-	if (this_rq()->nr_running > 1)
+	if (this_rq()->nr_running - ksoftirqd_running() > 1)
 		return false;
 
 	return true;
@@ -3301,6 +3316,8 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.dl_boosted = 0;
+		if (rt_prio(oldprio))
+			p->rt.timeout = 0;
 		p->sched_class = &fair_sched_class;
 	}
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7405d0105892..d7cef36a443c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -181,6 +181,11 @@ static bool can_stop_full_tick(void)
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
@@ -222,7 +227,12 @@ void __tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+	unsigned long flags;
+
+	/* ksoftirqd processes sirqs with interrupts enabled */
+	local_irq_save(flags);
 	__tick_nohz_full_check();
+	local_irq_restore(flags);
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b617b9a9400d..a29ab1a17023 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1450,9 +1450,9 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
-#ifdef CONFIG_IRQ_WORK
-	if (in_irq())
-		irq_work_tick();
+
+#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+	irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }
diff --git a/localversion-rt b/localversion-rt
index 8fc605d80667..045478966e9f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 5ff7f7f2689a..1e545966ddd9 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -94,8 +94,8 @@ static void async_pf_execute(struct work_struct *work)
 
 	trace_kvm_async_pf_completed(addr, gva);
 
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swaitqueue_active(&vcpu->wq))
+		swait_wake_interruptible(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cfbe0e7d1c45..06e4febc51e7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -221,7 +221,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	init_waitqueue_head(&vcpu->wq);
+	init_swait_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -1740,10 +1740,10 @@ EXPORT_SYMBOL_GPL(mark_page_dirty);
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
@@ -1757,7 +1757,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		schedule();
 	}
 
-	finish_wait(&vcpu->wq, &wait);
+	swait_finish(&vcpu->wq, &wait);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
@@ -1769,11 +1769,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
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
 
@@ -1878,7 +1878,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
+			if (swaitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;

From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH 7/7] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 28 Oct 2015 11:05:13 +0100
Message-ID: <1446026713-13154-9-git-send-email-daniel.wagner@bmw-carit.de>
References: <1446026713-13154-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:46118 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755687AbbJ1KFT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Oct 2015 06:05:19 -0400
In-Reply-To: <1446026713-13154-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Marcelo Tosatti <mtosatti@redhat.com>

The problem:

On -rt, an emulated LAPIC timer instances has the following path:

1) hard interrupt
2) ksoftirqd is scheduled
3) ksoftirqd wakes up vcpu thread
4) vcpu thread is scheduled

This extra context switch introduces unnecessary latency in the
LAPIC path for a KVM guest.

The solution:

Allow waking up vcpu thread from hardirq context,
thus avoiding the need for ksoftirqd to be scheduled.

Normal waitqueues make use of spinlocks, which on -RT
are sleepable locks. Therefore, waking up a waitqueue
waiter involves locking a sleeping lock, which
is not allowed from hard interrupt context.

cyclictest command line:

This patch reduces the average latency in my tests from 14us to 11us.

Daniel writes:
Paolo asked for numbers from kvm-unit-tests/tscdeadline_latency
benchmark on mainline. The test was run 382, respectively 300 times:

  ./x86-run x86/tscdeadline_latency.flat -cpu host

with idle=poll.

The test seems not to deliver really stable numbers though most of
them are smaller which I consider a good sign:

Before:

	min              max          mean            std
	count   382.000000       382.000000    382.000000     382.000000
	mean   6068.552356    269502.528796   8056.016198    3912.128273
	std     707.404966    848866.474783   1062.472704    9835.891707
	min    2335.000000     29828.000000   7337.426000     445.738750
	25%    6004.500000     44237.500000   7471.094250    1078.834837
	50%    6372.000000     64175.000000   7663.133700    1783.172446
	75%    6465.500000    150384.500000   8210.771900    2759.734524
	max    6886.000000  10188451.000000  15466.434000  120469.205668

After
	min             max          mean           std
	count   300.000000      300.000000    300.000000    300.000000
	mean   5618.380000   217464.786667   7745.545114   3258.483272
	std     824.719741   516371.888369    847.391685   5632.943904
	min    3494.000000    31410.000000   7083.574800    438.445477
	25%    4937.000000    45446.000000   7214.102850   1045.536261
	50%    6118.000000    67023.000000   7417.330800   1699.574075
	75%    6224.000000   134191.500000   7871.625600   2809.536185
	max    6654.000000  4570896.000000  13528.788600  52206.226799

[Patch was originaly based on the swait implementation found in the -rt
 tree. Daniel ported it to mainline's version and gathered the
  benchmark numbers for tscdeadline_latency test.]

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/kvm/arm.c                  |  4 ++--
 arch/arm/kvm/psci.c                 |  4 ++--
 arch/mips/kvm/mips.c                |  8 ++++----
 arch/powerpc/include/asm/kvm_host.h |  4 ++--
 arch/powerpc/kvm/book3s_hv.c        | 23 +++++++++++------------
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/s390/kvm/interrupt.c           |  8 ++++----
 arch/x86/kvm/lapic.c                |  6 +++---
 include/linux/kvm_host.h            |  5 +++--
 virt/kvm/async_pf.c                 |  4 ++--
 virt/kvm/kvm_main.c                 | 16 ++++++++--------
 11 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d6223cb..39a606a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -474,9 +474,9 @@ bool kvm_arch_intc_initialized(struct kvm *kvm)
 
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	swait_event_interruptible(*wq, !vcpu->arch.pause);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 531e922..98be16b 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -68,7 +68,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	wait_queue_head_t *wq;
+	struct swait_queue_head *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
 	phys_addr_t target_pc;
@@ -117,7 +117,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	wake_up_interruptible(wq);
+	swake_up(wq);
 
 	return PSCI_RET_SUCCESS;
 }
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 52f205a..003a53c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -440,8 +440,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 
 	dvcpu->arch.wait = 0;
 
-	if (waitqueue_active(&dvcpu->wq))
-		wake_up_interruptible(&dvcpu->wq);
+	if (swait_active(&dvcpu->wq))
+		swake_up(&dvcpu->wq);
 
 	return 0;
 }
@@ -1167,8 +1167,8 @@ static void kvm_mips_comparecount_func(unsigned long data)
 	kvm_mips_callbacks->queue_timer_int(vcpu);
 
 	vcpu->arch.wait = 0;
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 }
 
 /* low level hrtimer wake routine */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index a193a13..d361449 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -280,7 +280,7 @@ struct kvmppc_vcore {
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_queue_head wq;
 	spinlock_t stoltb_lock;	/* protects stolen_tb and preempt_tb */
 	u64 stolen_tb;
 	u64 preempt_tb;
@@ -613,7 +613,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index df81caa..d1822f2 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -115,11 +115,11 @@ static bool kvmppc_ipi_thread(int cpu)
 static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 {
 	int cpu = vcpu->cpu;
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -686,8 +686,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		tvcpu->arch.prodded = 1;
 		smp_mb();
 		if (vcpu->arch.ceded) {
-			if (waitqueue_active(&vcpu->wq)) {
-				wake_up_interruptible(&vcpu->wq);
+			if (swait_active(&vcpu->wq)) {
+				swake_up(&vcpu->wq);
 				vcpu->stat.halt_wakeup++;
 			}
 		}
@@ -1426,7 +1426,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
 	spin_lock_init(&vcore->stoltb_lock);
-	init_waitqueue_head(&vcore->wq);
+	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
 	vcore->first_vcpuid = core * threads_per_subcore;
@@ -2073,10 +2073,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
 	struct kvm_vcpu *vcpu;
 	int do_sleep = 1;
+	DECLARE_SWAITQUEUE(wait);
 
-	DEFINE_WAIT(wait);
-
-	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
 
 	/*
 	 * Check one last time for pending exceptions and ceded state after
@@ -2090,7 +2089,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	}
 
 	if (!do_sleep) {
-		finish_wait(&vc->wq, &wait);
+		finish_swait(&vc->wq, &wait);
 		return;
 	}
 
@@ -2098,7 +2097,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	trace_kvmppc_vcore_blocked(vc, 0);
 	spin_unlock(&vc->lock);
 	schedule();
-	finish_wait(&vc->wq, &wait);
+	finish_swait(&vc->wq, &wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
@@ -2142,7 +2141,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_start_thread(vcpu);
 			trace_kvm_guest_enter(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swake_up(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d01fc58..3b60649 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -419,7 +419,7 @@ struct kvm_s390_irq_payload {
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
 	struct kvm_s390_float_interrupt *float_int;
-	wait_queue_head_t *wq;
+	struct swait_queue_head *wq;
 	atomic_t *cpuflags;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index b745a10..4713f49 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -875,13 +875,13 @@ no_timer:
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
-	if (waitqueue_active(&vcpu->wq)) {
+	if (swait_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
 		 * yield-candidate.
 		 */
 		vcpu->preempted = true;
-		wake_up_interruptible(&vcpu->wq);
+		swake_up(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
 }
@@ -987,7 +987,7 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	spin_lock(&li->lock);
 	irq.u.pgm.code = code;
 	__inject_prog(vcpu, &irq);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swait_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
 }
@@ -1006,7 +1006,7 @@ int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 	spin_lock(&li->lock);
 	irq.u.pgm = *pgm_info;
 	rc = __inject_prog(vcpu, &irq);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swait_active(li->wq));
 	spin_unlock(&li->lock);
 	return rc;
 }
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 918f969..e77612b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1104,7 +1104,7 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
 static void apic_timer_expired(struct kvm_lapic *apic)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_queue_head *q = &vcpu->wq;
 	struct kvm_timer *ktimer = &apic->lapic_timer;
 
 	if (atomic_read(&apic->lapic_timer.pending))
@@ -1113,8 +1113,8 @@ static void apic_timer_expired(struct kvm_lapic *apic)
 	atomic_inc(&apic->lapic_timer.pending);
 	kvm_set_pending_timer(vcpu);
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swait_active(q))
+		swake_up(q);
 
 	if (apic_lvtt_tscdeadline(apic))
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ad45054..7b7a70f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
+#include <linux/swait.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -230,7 +231,7 @@ struct kvm_vcpu {
 
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
-	wait_queue_head_t wq;
+	struct swait_queue_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -690,7 +691,7 @@ static inline bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_queue_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 44660ae..ff4891c 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -94,8 +94,8 @@ static void async_pf_execute(struct work_struct *work)
 
 	trace_kvm_async_pf_completed(addr, gva);
 
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9097741..dd90d78 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -218,7 +218,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	init_waitqueue_head(&vcpu->wq);
+	init_swait_queue_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -1779,7 +1779,7 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
 void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	ktime_t start, cur;
-	DEFINE_WAIT(wait);
+	DECLARE_SWAITQUEUE(wait);
 	bool waited = false;
 
 	start = cur = ktime_get();
@@ -1800,7 +1800,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	}
 
 	for (;;) {
-		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_vcpu_check_block(vcpu) < 0)
 			break;
@@ -1809,7 +1809,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		schedule();
 	}
 
-	finish_wait(&vcpu->wq, &wait);
+	finish_swait(&vcpu->wq, &wait);
 	cur = ktime_get();
 
 out:
@@ -1825,11 +1825,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -1930,7 +1930,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
+			if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
-- 
2.4.3


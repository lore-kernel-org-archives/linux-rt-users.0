From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 08 Apr 2015 20:33:24 -0300
Message-ID: <20150408233413.720557390@redhat.com>
References: <20150408233323.842124241@redhat.com>
Cc: Rik van Riel <riel@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org, kvm@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbbDHXfJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Apr 2015 19:35:09 -0400
Content-Disposition: inline; filename=kvm-use-simplewaitqueue-1
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The problem:

On -RT, an emulated LAPIC timer instances has the following path:

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
# cyclictest -m -n -q -p99 -l 1000000 -h60  -D 1m

This patch reduces the average latency in my tests from 14us to 11us.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 arch/arm/kvm/arm.c                  |    4 ++--
 arch/arm/kvm/psci.c                 |    4 ++--
 arch/powerpc/include/asm/kvm_host.h |    4 ++--
 arch/powerpc/kvm/book3s_hv.c        |   20 ++++++++++----------
 arch/s390/include/asm/kvm_host.h    |    2 +-
 arch/s390/kvm/interrupt.c           |    8 ++++----
 arch/x86/kvm/lapic.c                |    6 +++---
 include/linux/kvm_host.h            |    4 ++--
 virt/kvm/async_pf.c                 |    4 ++--
 virt/kvm/kvm_main.c                 |   16 ++++++++--------
 10 files changed, 36 insertions(+), 36 deletions(-)

Index: rt-linux/arch/arm/kvm/arm.c
===================================================================
--- rt-linux.orig/arch/arm/kvm/arm.c	2015-04-08 20:20:39.962649422 -0300
+++ rt-linux/arch/arm/kvm/arm.c	2015-04-08 20:20:41.966654408 -0300
@@ -441,9 +441,9 @@
 
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	swait_event_interruptible(*wq, !vcpu->arch.pause);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
Index: rt-linux/arch/arm/kvm/psci.c
===================================================================
--- rt-linux.orig/arch/arm/kvm/psci.c	2015-04-08 20:20:39.962649422 -0300
+++ rt-linux/arch/arm/kvm/psci.c	2015-04-08 20:20:41.966654408 -0300
@@ -66,7 +66,7 @@
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL, *tmp;
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
 	unsigned long mpidr;
@@ -123,7 +123,7 @@
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	wake_up_interruptible(wq);
+	swait_wake_interruptible(wq);
 
 	return PSCI_RET_SUCCESS;
 }
Index: rt-linux/arch/powerpc/include/asm/kvm_host.h
===================================================================
--- rt-linux.orig/arch/powerpc/include/asm/kvm_host.h	2015-04-08 20:20:39.963649425 -0300
+++ rt-linux/arch/powerpc/include/asm/kvm_host.h	2015-04-08 20:20:41.966654408 -0300
@@ -296,7 +296,7 @@
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u64 stolen_tb;
 	u64 preempt_tb;
 	struct kvm_vcpu *runner;
@@ -618,7 +618,7 @@
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
Index: rt-linux/arch/powerpc/kvm/book3s_hv.c
===================================================================
--- rt-linux.orig/arch/powerpc/kvm/book3s_hv.c	2015-04-08 20:20:39.964649427 -0300
+++ rt-linux/arch/powerpc/kvm/book3s_hv.c	2015-04-08 20:20:41.966654408 -0300
@@ -84,11 +84,11 @@
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
 
@@ -639,8 +639,8 @@
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
@@ -1357,7 +1357,7 @@
 
 	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
-	init_waitqueue_head(&vcore->wq);
+	init_swait_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
 	vcore->first_vcpuid = core * threads_per_subcore;
@@ -1826,13 +1826,13 @@
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
@@ -1873,7 +1873,7 @@
 			kvmppc_create_dtl_entry(vcpu, vc);
 			kvmppc_start_thread(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swait_wake(&vc->wq);
 		}
 
 	}
Index: rt-linux/arch/s390/include/asm/kvm_host.h
===================================================================
--- rt-linux.orig/arch/s390/include/asm/kvm_host.h	2015-04-08 20:20:39.964649427 -0300
+++ rt-linux/arch/s390/include/asm/kvm_host.h	2015-04-08 20:20:41.967654410 -0300
@@ -311,7 +311,7 @@
 	struct list_head list;
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
 };
Index: rt-linux/arch/s390/kvm/interrupt.c
===================================================================
--- rt-linux.orig/arch/s390/kvm/interrupt.c	2015-04-08 20:20:39.965649430 -0300
+++ rt-linux/arch/s390/kvm/interrupt.c	2015-04-08 20:20:41.967654410 -0300
@@ -619,13 +619,13 @@
 
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
@@ -736,7 +736,7 @@
 	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swaitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
 }
@@ -761,7 +761,7 @@
 	spin_lock(&li->lock);
 	list_add(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	BUG_ON(waitqueue_active(li->wq));
+	BUG_ON(swaitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
 }
Index: rt-linux/arch/x86/kvm/lapic.c
===================================================================
--- rt-linux.orig/arch/x86/kvm/lapic.c	2015-04-08 20:20:39.965649430 -0300
+++ rt-linux/arch/x86/kvm/lapic.c	2015-04-08 20:20:41.000000000 -0300
@@ -1539,7 +1539,7 @@
 	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
 	struct kvm_lapic *apic = container_of(ktimer, struct kvm_lapic, lapic_timer);
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_head *q = &vcpu->wq;
 
 	/*
 	 * There is a race window between reading and incrementing, but we do
@@ -1553,8 +1553,8 @@
 		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
 	}
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swaitqueue_active(q))
+		swait_wake_interruptible(q);
 
 	if (lapic_is_periodic(apic)) {
 		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
Index: rt-linux/include/linux/kvm_host.h
===================================================================
--- rt-linux.orig/include/linux/kvm_host.h	2015-04-08 20:20:39.966649432 -0300
+++ rt-linux/include/linux/kvm_host.h	2015-04-08 20:20:41.967654410 -0300
@@ -244,7 +244,7 @@
 
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -687,7 +687,7 @@
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
Index: rt-linux/virt/kvm/async_pf.c
===================================================================
--- rt-linux.orig/virt/kvm/async_pf.c	2015-04-08 20:20:39.966649432 -0300
+++ rt-linux/virt/kvm/async_pf.c	2015-04-08 20:20:41.968654413 -0300
@@ -94,8 +94,8 @@
 
 	trace_kvm_async_pf_completed(addr, gva);
 
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swaitqueue_active(&vcpu->wq))
+		swait_wake_interruptible(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
Index: rt-linux/virt/kvm/kvm_main.c
===================================================================
--- rt-linux.orig/virt/kvm/kvm_main.c	2015-04-08 20:20:39.966649432 -0300
+++ rt-linux/virt/kvm/kvm_main.c	2015-04-08 20:20:41.968654413 -0300
@@ -221,7 +221,7 @@
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	init_waitqueue_head(&vcpu->wq);
+	init_swait_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -1740,10 +1740,10 @@
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
@@ -1757,7 +1757,7 @@
 		schedule();
 	}
 
-	finish_wait(&vcpu->wq, &wait);
+	swait_finish(&vcpu->wq, &wait);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
@@ -1769,11 +1769,11 @@
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
 
@@ -1878,7 +1878,7 @@
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
+			if (swaitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;



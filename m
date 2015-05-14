From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] KVM: use simple waitqueue for vcpu->wq
Date: Thu, 14 May 2015 10:01:40 -0400
Message-ID: <20150514140146.805536967@goodmis.org>
References: <20150514140137.396749660@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-KVM-use-simple-waitqueue-for-vcpu-wq.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.40-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Marcelo Tosatti <mtosatti@redhat.com>

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

This patch reduces the average latency in my tests from 14us to 11us.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/kvm/arm.c                  |  4 ++--
 arch/arm/kvm/psci.c                 |  4 ++--
 arch/powerpc/include/asm/kvm_host.h |  4 ++--
 arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++----------
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/lapic.c                |  6 +++---
 include/linux/kvm_host.h            |  4 ++--
 virt/kvm/async_pf.c                 |  4 ++--
 virt/kvm/kvm_main.c                 | 16 ++++++++--------
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db2787e..5409d4d7c208 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -491,9 +491,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 
 static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	swait_event_interruptible(*wq, !vcpu->arch.pause);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 86a693a02ba3..49aed024ad78 100644
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
index 33283532e9d8..5fa50fc31ab3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -290,7 +290,7 @@ struct kvmppc_vcore {
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u64 stolen_tb;
 	u64 preempt_tb;
 	struct kvm_vcpu *runner;
@@ -562,7 +562,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 211974a386d6..a4e71ea12cf7 100644
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
@@ -941,7 +941,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 		if (vcore) {
 			INIT_LIST_HEAD(&vcore->runnable_threads);
 			spin_lock_init(&vcore->lock);
-			init_waitqueue_head(&vcore->wq);
+			init_swait_head(&vcore->wq);
 			vcore->preempt_tb = TB_NIL;
 		}
 		kvm->arch.vcores[core] = vcore;
@@ -1312,13 +1312,13 @@ static void kvmppc_wait_for_exec(struct kvm_vcpu *vcpu, int wait_state)
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
@@ -1360,7 +1360,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_create_dtl_entry(vcpu, vc);
 			kvmppc_start_thread(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swait_wake(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e87ecaa2c569..295aab26f605 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -228,7 +228,7 @@ struct kvm_s390_local_interrupt {
 	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
 	int timer_due; /* event indicator for waitqueue below */
-	wait_queue_head_t *wq;
+	struct swait_head *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
 };
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0c4ebde0452f..9644aac4334e 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1546,7 +1546,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
 	struct kvm_lapic *apic = container_of(ktimer, struct kvm_lapic, lapic_timer);
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_head *q = &vcpu->wq;
 
 	/*
 	 * There is a race window between reading and incrementing, but we do
@@ -1560,8 +1560,8 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
 	}
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swaitqueue_active(q))
+		swait_wake_interruptible(q);
 
 	if (lapic_is_periodic(apic)) {
 		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e47c7e2f4d04..7bb6c5ac2ad7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -234,7 +234,7 @@ struct kvm_vcpu {
 
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -669,7 +669,7 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 8a39dda7a325..c8b49a1f9278 100644
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
index b9bf29490b12..efcd02d2a5c6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -213,7 +213,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
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
-- 
2.1.4

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.112-rt143
Date: Thu, 14 Jul 2016 10:59:43 -0400
Message-ID: <20160714105943.7164eba9@gandalf.local.home>
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

I'm pleased to announce the 3.4.112-rt143 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.4-rt
  Head SHA1: 7a6baa46e0f5e19beea329413b9832722f86ee5e


Or to build 3.4.112-rt143 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.112.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.112-rt143.patch.xz



You can also build from 3.4.112-rt142 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.112-rt142-rt143.patch.xz



Enjoy,

-- Steve


Changes from v3.4.112-rt142:

---

Corey Minyard (1):
      x86: Fix an RT MCE crash

Sebastian Andrzej Siewior (1):
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (2):
      Revert: KVM: lapic: mark LAPIC timer handler as irqsafe
      Linux 3.4.112-rt143

----
 arch/x86/kernel/cpu/mcheck/mce.c |  3 ++-
 arch/x86/kvm/lapic.c             | 42 +++-------------------------------------
 include/trace/ftrace.h           |  3 +++
 localversion-rt                  |  2 +-
 4 files changed, 9 insertions(+), 41 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 27068f690ede..674872b08ea4 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1344,7 +1344,8 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (mce_notify_helper)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b6dffeacbe92..53454a6775bf 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -683,38 +683,8 @@ static void update_divide_count(struct kvm_lapic *apic)
 				   apic->divide_count);
 }
 
-
-static enum hrtimer_restart apic_timer_fn(struct hrtimer *data);
-
-static void apic_timer_expired(struct hrtimer *data)
-{
-	int ret, i = 0;
-	enum hrtimer_restart r;
-	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
-
-	r = apic_timer_fn(data);
-
-	if (r == HRTIMER_RESTART) {
-		do {
-			ret = hrtimer_start_expires(data, HRTIMER_MODE_ABS);
-			if (ret == -ETIME)
-				hrtimer_add_expires_ns(&ktimer->timer,
-							ktimer->period);
-			i++;
-		} while (ret == -ETIME && i < 10);
-
-		if (ret == -ETIME) {
-			printk_once(KERN_ERR "%s: failed to reprogram timer\n",
-			       __func__);
-			WARN_ON_ONCE(1);
-		}
-	}
-}
-
-
 static void start_apic_timer(struct kvm_lapic *apic)
 {
-	int ret;
 	ktime_t now;
 	atomic_set(&apic->lapic_timer.pending, 0);
 
@@ -744,11 +714,9 @@ static void start_apic_timer(struct kvm_lapic *apic)
 			}
 		}
 
-		ret = hrtimer_start(&apic->lapic_timer.timer,
+		hrtimer_start(&apic->lapic_timer.timer,
 			      ktime_add_ns(now, apic->lapic_timer.period),
 			      HRTIMER_MODE_ABS);
-		if (ret == -ETIME)
-			apic_timer_expired(&apic->lapic_timer.timer);
 
 		apic_debug("%s: bus cycle is %" PRId64 "ns, now 0x%016"
 			   PRIx64 ", "
@@ -778,10 +746,8 @@ static void start_apic_timer(struct kvm_lapic *apic)
 			ns = (tscdeadline - guest_tsc) * 1000000ULL;
 			do_div(ns, this_tsc_khz);
 		}
-		ret = hrtimer_start(&apic->lapic_timer.timer,
+		hrtimer_start(&apic->lapic_timer.timer,
 			ktime_add_ns(now, ns), HRTIMER_MODE_ABS);
-		if (ret == -ETIME)
-			apic_timer_expired(&apic->lapic_timer.timer);
 
 		local_irq_restore(flags);
 	}
@@ -1211,7 +1177,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS);
 	apic->lapic_timer.timer.function = kvm_timer_fn;
-	apic->lapic_timer.timer.irqsafe = 1;
 	apic->lapic_timer.t_ops = &lapic_timer_ops;
 	apic->lapic_timer.kvm = vcpu->kvm;
 	apic->lapic_timer.vcpu = vcpu;
@@ -1309,8 +1274,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) == -ETIME)
-			apic_timer_expired(timer);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
 void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu)
diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 763bf05ccb27..73aab555b42d 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -530,6 +530,9 @@ ftrace_raw_event_##call(void *__data, proto)				\
 									\
 	local_save_flags(irq_flags);					\
 	pc = preempt_count();						\
+	/* Account for tracepoint preempt disable */			\
+	if (IS_ENABLED(CONFIG_PREEMPT))					\
+		pc--;							\
 									\
 	__data_size = ftrace_get_offsets_##call(&__data_offsets, args); \
 									\
diff --git a/localversion-rt b/localversion-rt
index 234720dc343d..a7cc5d609b19 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt142
+-rt143

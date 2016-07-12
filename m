From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] Revert: KVM: lapic: mark LAPIC timer handler as irqsafe
Date: Tue, 12 Jul 2016 16:54:45 -0400
Message-ID: <20160712205458.320076864@goodmis.org>
References: <20160712205444.115211356@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-Revert-KVM-lapic-mark-LAPIC-timer-handler-as-irqsafe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.81-rt117-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The whole patch was not backported correctly and causes allmodconfig to
fail.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kvm/lapic.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7198be07b406..055cc49ffb10 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -679,38 +679,8 @@ static void update_divide_count(struct kvm_lapic *apic)
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
 
@@ -740,11 +710,9 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -774,10 +742,8 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -1207,7 +1173,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS);
 	apic->lapic_timer.timer.function = kvm_timer_fn;
-	apic->lapic_timer.timer.irqsafe = 1;
 	apic->lapic_timer.t_ops = &lapic_timer_ops;
 	apic->lapic_timer.kvm = vcpu->kvm;
 	apic->lapic_timer.vcpu = vcpu;
@@ -1305,8 +1270,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) == -ETIME)
-			apic_timer_expired(timer);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
 void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu)
-- 
2.8.1

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/5] KVM: lapic: mark LAPIC timer handler as irqsafe
Date: Thu, 14 May 2015 10:02:44 -0400
Message-ID: <20150514140250.929809691@goodmis.org>
References: <20150514140242.839416736@goodmis.org>
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
Content-Disposition: inline; filename=0002-KVM-lapic-mark-LAPIC-timer-handler-as-irqsafe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.75-rt81-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Marcelo Tosatti <mtosatti@redhat.com>

Since lapic timer handler only wakes up a simple waitqueue,
it can be executed from hardirq context.

Also handle the case where hrtimer_start_expires fails due to -ETIME,
by injecting the interrupt to the guest immediately.

Reduces average cyclictest latency by 3us.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kvm/lapic.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 681e4e251f00..4500d312f8d9 100644
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
-- 
2.1.4

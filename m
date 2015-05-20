From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.2.68-rt100
Date: Wed, 20 May 2015 10:57:45 -0400
Message-ID: <20150520105745.2fabfb66@gandalf.local.home>
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

I'm pleased to announce the 3.2.68-rt100 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.2-rt
  Head SHA1: 0ebfe81f7a834713ae0b2e0718aa34057fafa106


Or to build 3.2.68-rt100 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.68.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.68-rt100.patch.xz



You can also build from 3.2.68-rt99 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.68-rt99-rt100.patch.xz



Enjoy,

-- Steve


Changes from v3.2.68-rt99:

---

Marcelo Tosatti (1):
      KVM: lapic: mark LAPIC timer handler as irqsafe

Steven Rostedt (Red Hat) (1):
      Linux 3.2.68-rt100

----
 arch/x86/kvm/lapic.c | 42 +++++++++++++++++++++++++++++++++++++++---
 localversion-rt      |  2 +-
 2 files changed, 40 insertions(+), 4 deletions(-)
---------------------------
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 176205ab0ca8..745cbfe4b51c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -679,8 +679,38 @@ static void update_divide_count(struct kvm_lapic *apic)
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
 
@@ -710,9 +740,11 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -742,8 +774,10 @@ static void start_apic_timer(struct kvm_lapic *apic)
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
@@ -1173,6 +1207,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS);
 	apic->lapic_timer.timer.function = kvm_timer_fn;
+	apic->lapic_timer.timer.irqsafe = 1;
 	apic->lapic_timer.t_ops = &lapic_timer_ops;
 	apic->lapic_timer.kvm = vcpu->kvm;
 	apic->lapic_timer.vcpu = vcpu;
@@ -1269,7 +1304,8 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) == -ETIME)
+			apic_timer_expired(timer);
 }
 
 void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu)
diff --git a/localversion-rt b/localversion-rt
index 31145e774bbe..79d3e2b9f550 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt99
+-rt100

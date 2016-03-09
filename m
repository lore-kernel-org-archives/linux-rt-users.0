From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.4.4-rt11
Date: Wed, 9 Mar 2016 14:51:42 +0100
Message-ID: <20160309135142.GF10517@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.4.4-rt11 patch set.
Changes since v4.4.4-rt10:

- A  compile error has been fixed in conjunction with the latency
  tracer.

- AT91 got a little better. A larger patch series by Boris Brezillon has
  been merged. That means SAMA5 boots now. There is one warning left
  about invoking free_irq() twice. I would be glad about some feedback
  from pre-SAMA5 SoC. Those which share UART and timer interrupt. It
  seems that that one I have here does not do this anymore.

- A patch on top the AT91 series to avoid two warning while switching
  from period to oneshow mode.

- Daniel Wagner refurbished the swait patches. This relase contains now
  what is queued for v4.6 in the TIP tree. Only RT uses `completion'
  based on swait. Based on the current implementation you will see a
  warning if complete_all() in invoked on more than two waiters. Please
  report if see this.

Known issues:
  - CPU hotplug got a little better but can deadlock.

The delta patch against 4.4.4-rt10 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.4-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.4-rt11

The RT patch against 4.4.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.4-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.4-rt11.tar.xz

Sebastian

diff --git a/Makefile b/Makefile
index 344bc6f27ea1..5ae061c18c75 100644
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
+# enforce correct pointer usage
+KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2ce9cc2717ac..bb43bc396f06 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -498,16 +498,16 @@ static void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
+		struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
 		vcpu->arch.pause = false;
-		swait_wake_interruptible(wq);
+		swake_up(wq);
 	}
 }
 
 static void vcpu_sleep(struct kvm_vcpu *vcpu)
 {
-	 struct swait_head *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
 	swait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
 				       (!vcpu->arch.pause)));
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 08148c46c8d0..c2b131527a64 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -70,7 +70,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	struct swait_head *wq;
+	struct swait_queue_head *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
 	phys_addr_t target_pc;
@@ -119,7 +119,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	swait_wake_interruptible(wq);
+	swake_up(wq);
 
 	return PSCI_RET_SUCCESS;
 }
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 28656c2b54a0..3f501305ca26 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -99,6 +99,7 @@ config HAVE_AT91_USB_CLK
 config COMMON_CLK_AT91
 	bool
 	select COMMON_CLK
+	select MFD_SYSCON
 
 config HAVE_AT91_SMD
 	bool
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index c1a7c6cc00e1..63b4fa25b48a 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -12,7 +12,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "soc.h"
@@ -33,7 +32,6 @@ static void __init at91rm9200_dt_device_init(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
 
-	arm_pm_idle = at91rm9200_idle;
 	at91rm9200_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 7eb64f763034..cada2a6412b3 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -62,8 +62,6 @@ static void __init at91sam9_common_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-
-	arm_pm_idle = at91sam9_idle;
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index b0fa7dc7286d..28ca57a2060f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -11,27 +11,18 @@
 #ifndef _AT91_GENERIC_H
 #define _AT91_GENERIC_H
 
-#include <linux/of.h>
-#include <linux/reboot.h>
-
- /* Map io */
-extern void __init at91_map_io(void);
-extern void __init at91_alt_map_io(void);
-
-/* idle */
-extern void at91rm9200_idle(void);
-extern void at91sam9_idle(void);
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
 extern void __init at91sam9g45_pm_init(void);
 extern void __init at91sam9x5_pm_init(void);
+extern void __init sama5_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9260_pm_init(void) { }
 static inline void __init at91sam9g45_pm_init(void) { }
 static inline void __init at91sam9x5_pm_init(void) { }
+static inline void __init sama5_pm_init(void) { }
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 23726fb31741..f06270198bf1 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -31,10 +31,13 @@
 #include <asm/mach/irq.h>
 #include <asm/fncpy.h>
 #include <asm/cacheflush.h>
+#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "pm.h"
 
+static void __iomem *pmc;
+
 /*
  * FIXME: this is needed to communicate between the pinctrl driver and
  * the PM implementation in the machine. Possibly part of the PM
@@ -87,7 +90,7 @@ static int at91_pm_verify_clocks(void)
 	unsigned long scsr;
 	int i;
 
-	scsr = at91_pmc_read(AT91_PMC_SCSR);
+	scsr = readl(pmc + AT91_PMC_SCSR);
 
 	/* USB must not be using PLLB */
 	if ((scsr & at91_pm_data.uhp_udp_mask) != 0) {
@@ -101,8 +104,7 @@ static int at91_pm_verify_clocks(void)
 
 		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
 			continue;
-
-		css = at91_pmc_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css = readl(pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
 		if (css != AT91_PMC_CSS_SLOW) {
 			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
 			return 0;
@@ -145,8 +147,8 @@ static void at91_pm_suspend(suspend_state_t state)
 	flush_cache_all();
 	outer_disable();
 
-	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
-				at91_ramc_base[1], pm_data);
+	at91_suspend_sram_fn(pmc, at91_ramc_base[0],
+			     at91_ramc_base[1], pm_data);
 
 	outer_resume();
 }
@@ -353,6 +355,21 @@ static __init void at91_dt_ramc(void)
 	at91_pm_set_standby(standby);
 }
 
+void at91rm9200_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+}
+
+void at91sam9_idle(void)
+{
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
@@ -399,13 +416,36 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
-static void __init at91_pm_init(void)
+static const struct of_device_id atmel_pmc_ids[] __initconst = {
+	{ .compatible = "atmel,at91rm9200-pmc"  },
+	{ .compatible = "atmel,at91sam9260-pmc" },
+	{ .compatible = "atmel,at91sam9g45-pmc" },
+	{ .compatible = "atmel,at91sam9n12-pmc" },
+	{ .compatible = "atmel,at91sam9x5-pmc" },
+	{ .compatible = "atmel,sama5d3-pmc" },
+	{ .compatible = "atmel,sama5d2-pmc" },
+	{ /* sentinel */ },
+};
+
+static void __init at91_pm_init(void (*pm_idle)(void))
 {
-	at91_pm_sram_init();
+	struct device_node *pmc_np;
 
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
+	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
+	pmc = of_iomap(pmc_np, 0);
+	if (!pmc) {
+		pr_err("AT91: PM not supported, PMC not found\n");
+		return;
+	}
+
+	if (pm_idle)
+		arm_pm_idle = pm_idle;
+
+	at91_pm_sram_init();
+
 	if (at91_suspend_sram_fn)
 		suspend_set_ops(&at91_pm_ops);
 	else
@@ -424,7 +464,7 @@ void __init at91rm9200_pm_init(void)
 	at91_pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_MC;
 
-	at91_pm_init();
+	at91_pm_init(at91rm9200_idle);
 }
 
 void __init at91sam9260_pm_init(void)
@@ -432,7 +472,7 @@ void __init at91sam9260_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	return at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9g45_pm_init(void)
@@ -440,7 +480,7 @@ void __init at91sam9g45_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9x5_pm_init(void)
@@ -448,5 +488,13 @@ void __init at91sam9x5_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init(at91sam9_idle);
+}
+
+void __init sama5_pm_init(void)
+{
+	at91_dt_ramc();
+	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
+	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
+	at91_pm_init(NULL);
 }
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index d9cf6799aec0..df8fdf1cf66d 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -51,7 +51,7 @@ static void __init sama5_dt_device_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-	at91sam9x5_pm_init();
+	sama5_pm_init();
 }
 
 static const char *const sama5_dt_board_compat[] __initconst = {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b9b803facdbf..28e9acbde4eb 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -445,8 +445,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 
 	dvcpu->arch.wait = 0;
 
-	if (waitqueue_active(&dvcpu->wq))
-		wake_up_interruptible(&dvcpu->wq);
+	if (swait_active(&dvcpu->wq))
+		swake_up(&dvcpu->wq);
 
 	return 0;
 }
@@ -1174,8 +1174,8 @@ static void kvm_mips_comparecount_func(unsigned long data)
 	kvm_mips_callbacks->queue_timer_int(vcpu);
 
 	vcpu->arch.wait = 0;
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 }
 
 /* low level hrtimer wake routine */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index b439518f0253..f8673ff84b31 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -286,7 +286,7 @@ struct kvmppc_vcore {
 	struct list_head runnable_threads;
 	struct list_head preempt_list;
 	spinlock_t lock;
-	struct swait_head wq;
+	struct swait_queue_head wq;
 	spinlock_t stoltb_lock;	/* protects stolen_tb and preempt_tb */
 	u64 stolen_tb;
 	u64 preempt_tb;
@@ -626,7 +626,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	struct swait_head *wqp;
+	struct swait_queue_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 32be32b61d4c..df34a6432873 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -114,11 +114,11 @@ static bool kvmppc_ipi_thread(int cpu)
 static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 {
 	int cpu;
-	struct swait_head *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (swaitqueue_active(wqp)) {
-		swait_wake_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -707,8 +707,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		tvcpu->arch.prodded = 1;
 		smp_mb();
 		if (vcpu->arch.ceded) {
-			if (swaitqueue_active(&vcpu->wq)) {
-				swait_wake_interruptible(&vcpu->wq);
+			if (swait_active(&vcpu->wq)) {
+				swake_up(&vcpu->wq);
 				vcpu->stat.halt_wakeup++;
 			}
 		}
@@ -1447,7 +1447,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
 	spin_lock_init(&vcore->stoltb_lock);
-	init_swait_head(&vcore->wq);
+	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
 	vcore->first_vcpuid = core * threads_per_subcore;
@@ -2519,9 +2519,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
 	struct kvm_vcpu *vcpu;
 	int do_sleep = 1;
-	DEFINE_SWAITER(wait);
+	DECLARE_SWAITQUEUE(wait);
 
-	swait_prepare(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
 
 	/*
 	 * Check one last time for pending exceptions and ceded state after
@@ -2535,7 +2535,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	}
 
 	if (!do_sleep) {
-		swait_finish(&vc->wq, &wait);
+		finish_swait(&vc->wq, &wait);
 		return;
 	}
 
@@ -2543,7 +2543,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	trace_kvmppc_vcore_blocked(vc, 0);
 	spin_unlock(&vc->lock);
 	schedule();
-	swait_finish(&vc->wq, &wait);
+	finish_swait(&vc->wq, &wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
@@ -2599,7 +2599,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_start_thread(vcpu, vc);
 			trace_kvm_guest_enter(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			swait_wake(&vc->wq);
+			swake_up(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2a84c76265ec..bbdc539fb3c6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -427,7 +427,7 @@ struct kvm_s390_irq_payload {
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
 	struct kvm_s390_float_interrupt *float_int;
-	struct swait_head *wq;
+	struct swait_queue_head *wq;
 	atomic_t *cpuflags;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8b4516b99bcd..cc862c486002 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -868,13 +868,13 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
-	if (swaitqueue_active(&vcpu->wq)) {
+	if (swait_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
 		 * yield-candidate.
 		 */
 		vcpu->preempted = true;
-		swait_wake_interruptible(&vcpu->wq);
+		swake_up(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
 }
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 906a1ecb7606..20d9e9fb3b74 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1195,7 +1195,7 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
 static void apic_timer_expired(struct kvm_lapic *apic)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	struct swait_head *q = &vcpu->wq;
+	struct swait_queue_head *q = &vcpu->wq;
 	struct kvm_timer *ktimer = &apic->lapic_timer;
 
 	if (atomic_read(&apic->lapic_timer.pending))
@@ -1204,8 +1204,8 @@ static void apic_timer_expired(struct kvm_lapic *apic)
 	atomic_inc(&apic->lapic_timer.pending);
 	kvm_set_pending_timer(vcpu);
 
-	if (swaitqueue_active(q))
-		swait_wake_interruptible(q);
+	if (swait_active(q))
+		swake_up(q);
 
 	if (apic_lvtt_tscdeadline(apic))
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
diff --git a/block/blk-core.c b/block/blk-core.c
index 4c8cefd2c019..2f7afb98e8e0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -680,7 +680,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	swait_wake_all(&q->mq_freeze_wq);
+	swake_up_all(&q->mq_freeze_wq);
 }
 
 struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
@@ -742,7 +742,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	q->bypass_depth = 1;
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
-	init_swait_head(&q->mq_freeze_wq);
+	init_swait_queue_head(&q->mq_freeze_wq);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c70813cb6b6..7cdf19e4aaea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -130,7 +130,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
 		percpu_ref_reinit(&q->q_usage_counter);
-		swait_wake_all(&q->mq_freeze_wq);
+		swake_up_all(&q->mq_freeze_wq);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
@@ -149,7 +149,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
 	 * dying, we need to ensure that processes currently waiting on
 	 * the queue are notified as well.
 	 */
-	swait_wake_all(&q->mq_freeze_wq);
+	swake_up_all(&q->mq_freeze_wq);
 }
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index abc80949e1dd..4ad3298eb372 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -15,8 +15,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -28,8 +28,9 @@
 
 struct clk_generated {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 	struct clk_range range;
+	spinlock_t *lock;
 	u32 id;
 	u32 gckdiv;
 	u8 parent_id;
@@ -41,49 +42,52 @@ struct clk_generated {
 static int clk_generated_enable(struct clk_hw *hw)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
-	struct at91_pmc *pmc = gck->pmc;
-	u32 tmp;
+	unsigned long flags;
 
 	pr_debug("GCLK: %s, gckdiv = %d, parent id = %d\n",
 		 __func__, gck->gckdiv, gck->parent_id);
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR) &
-			~(AT91_PMC_PCR_GCKDIV_MASK | AT91_PMC_PCR_GCKCSS_MASK);
-	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_GCKCSS(gck->parent_id)
-					 | AT91_PMC_PCR_CMD
-					 | AT91_PMC_PCR_GCKDIV(gck->gckdiv)
-					 | AT91_PMC_PCR_GCKEN);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(gck->lock, flags);
+	regmap_write(gck->regmap, AT91_PMC_PCR,
+		     (gck->id & AT91_PMC_PCR_PID_MASK));
+	regmap_update_bits(gck->regmap, AT91_PMC_PCR,
+			   AT91_PMC_PCR_GCKDIV_MASK | AT91_PMC_PCR_GCKCSS_MASK |
+			   AT91_PMC_PCR_CMD | AT91_PMC_PCR_GCKEN,
+			   AT91_PMC_PCR_GCKCSS(gck->parent_id) |
+			   AT91_PMC_PCR_CMD |
+			   AT91_PMC_PCR_GCKDIV(gck->gckdiv) |
+			   AT91_PMC_PCR_GCKEN);
+	spin_unlock_irqrestore(gck->lock, flags);
 	return 0;
 }
 
 static void clk_generated_disable(struct clk_hw *hw)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
-	struct at91_pmc *pmc = gck->pmc;
-	u32 tmp;
+	unsigned long flags;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_GCKEN;
-	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_CMD);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(gck->lock, flags);
+	regmap_write(gck->regmap, AT91_PMC_PCR,
+		     (gck->id & AT91_PMC_PCR_PID_MASK));
+	regmap_update_bits(gck->regmap, AT91_PMC_PCR,
+			   AT91_PMC_PCR_CMD | AT91_PMC_PCR_GCKEN,
+			   AT91_PMC_PCR_CMD);
+	spin_unlock_irqrestore(gck->lock, flags);
 }
 
 static int clk_generated_is_enabled(struct clk_hw *hw)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
-	struct at91_pmc *pmc = gck->pmc;
-	int ret;
+	unsigned long flags;
+	unsigned int status;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
-	ret = !!(pmc_read(pmc, AT91_PMC_PCR) & AT91_PMC_PCR_GCKEN);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(gck->lock, flags);
+	regmap_write(gck->regmap, AT91_PMC_PCR,
+		     (gck->id & AT91_PMC_PCR_PID_MASK));
+	regmap_read(gck->regmap, AT91_PMC_PCR, &status);
+	spin_unlock_irqrestore(gck->lock, flags);
 
-	return ret;
+	return status & AT91_PMC_PCR_GCKEN ? 1 : 0;
 }
 
 static unsigned long
@@ -214,13 +218,14 @@ static const struct clk_ops generated_ops = {
  */
 static void clk_generated_startup(struct clk_generated *gck)
 {
-	struct at91_pmc *pmc = gck->pmc;
 	u32 tmp;
+	unsigned long flags;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (gck->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(gck->lock, flags);
+	regmap_write(gck->regmap, AT91_PMC_PCR,
+		     (gck->id & AT91_PMC_PCR_PID_MASK));
+	regmap_read(gck->regmap, AT91_PMC_PCR, &tmp);
+	spin_unlock_irqrestore(gck->lock, flags);
 
 	gck->parent_id = (tmp & AT91_PMC_PCR_GCKCSS_MASK)
 					>> AT91_PMC_PCR_GCKCSS_OFFSET;
@@ -229,8 +234,8 @@ static void clk_generated_startup(struct clk_generated *gck)
 }
 
 static struct clk * __init
-at91_clk_register_generated(struct at91_pmc *pmc, const char *name,
-			    const char **parent_names, u8 num_parents,
+at91_clk_register_generated(struct regmap *regmap,  spinlock_t *lock, const char
+			    *name, const char **parent_names, u8 num_parents,
 			    u8 id, const struct clk_range *range)
 {
 	struct clk_generated *gck;
@@ -249,7 +254,8 @@ at91_clk_register_generated(struct at91_pmc *pmc, const char *name,
 
 	gck->id = id;
 	gck->hw.init = &init;
-	gck->pmc = pmc;
+	gck->regmap = regmap;
+	gck->lock = lock;
 	gck->range = *range;
 
 	clk = clk_register(NULL, &gck->hw);
@@ -261,8 +267,7 @@ at91_clk_register_generated(struct at91_pmc *pmc, const char *name,
 	return clk;
 }
 
-void __init of_sama5d2_clk_generated_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
+void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 {
 	int num;
 	u32 id;
@@ -272,6 +277,7 @@ void __init of_sama5d2_clk_generated_setup(struct device_node *np,
 	const char *parent_names[GENERATED_SOURCE_MAX];
 	struct device_node *gcknp;
 	struct clk_range range = CLK_RANGE(0, 0);
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > GENERATED_SOURCE_MAX)
@@ -283,6 +289,10 @@ void __init of_sama5d2_clk_generated_setup(struct device_node *np,
 	if (!num || num > PERIPHERAL_MAX)
 		return;
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	for_each_child_of_node(np, gcknp) {
 		if (of_property_read_u32(gcknp, "reg", &id))
 			continue;
@@ -296,11 +306,14 @@ void __init of_sama5d2_clk_generated_setup(struct device_node *np,
 		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
 				      &range);
 
-		clk = at91_clk_register_generated(pmc, name, parent_names,
-						  num_parents, id, &range);
+		clk = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
+						  parent_names, num_parents,
+						  id, &range);
 		if (IS_ERR(clk))
 			continue;
 
 		of_clk_add_provider(gcknp, of_clk_src_simple_get, clk);
 	}
 }
+CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
+	       of_sama5d2_clk_generated_setup);
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index 61566bcefa53..819f5842fa66 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -15,15 +15,9 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
-#include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "pmc.h"
 
@@ -31,7 +25,7 @@
 
 struct clk_sama5d4_h32mx {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 #define to_clk_sama5d4_h32mx(hw) container_of(hw, struct clk_sama5d4_h32mx, hw)
@@ -40,8 +34,10 @@ static unsigned long clk_sama5d4_h32mx_recalc_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
 	struct clk_sama5d4_h32mx *h32mxclk = to_clk_sama5d4_h32mx(hw);
+	unsigned int mckr;
 
-	if (pmc_read(h32mxclk->pmc, AT91_PMC_MCKR) & AT91_PMC_H32MXDIV)
+	regmap_read(h32mxclk->regmap, AT91_PMC_MCKR, &mckr);
+	if (mckr & AT91_PMC_H32MXDIV)
 		return parent_rate / 2;
 
 	if (parent_rate > H32MX_MAX_FREQ)
@@ -70,18 +66,16 @@ static int clk_sama5d4_h32mx_set_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate)
 {
 	struct clk_sama5d4_h32mx *h32mxclk = to_clk_sama5d4_h32mx(hw);
-	struct at91_pmc *pmc = h32mxclk->pmc;
-	u32 tmp;
+	u32 mckr = 0;
 
 	if (parent_rate != rate && (parent_rate / 2) != rate)
 		return -EINVAL;
 
-	pmc_lock(pmc);
-	tmp = pmc_read(pmc, AT91_PMC_MCKR) & ~AT91_PMC_H32MXDIV;
 	if ((parent_rate / 2) == rate)
-		tmp |= AT91_PMC_H32MXDIV;
-	pmc_write(pmc, AT91_PMC_MCKR, tmp);
-	pmc_unlock(pmc);
+		mckr = AT91_PMC_H32MXDIV;
+
+	regmap_update_bits(h32mxclk->regmap, AT91_PMC_MCKR,
+			   AT91_PMC_H32MXDIV, mckr);
 
 	return 0;
 }
@@ -92,14 +86,18 @@ static const struct clk_ops h32mx_ops = {
 	.set_rate = clk_sama5d4_h32mx_set_rate,
 };
 
-void __init of_sama5d4_clk_h32mx_setup(struct device_node *np,
-				     struct at91_pmc *pmc)
+static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 {
 	struct clk_sama5d4_h32mx *h32mxclk;
 	struct clk_init_data init;
 	const char *parent_name;
+	struct regmap *regmap;
 	struct clk *clk;
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	h32mxclk = kzalloc(sizeof(*h32mxclk), GFP_KERNEL);
 	if (!h32mxclk)
 		return;
@@ -113,7 +111,7 @@ void __init of_sama5d4_clk_h32mx_setup(struct device_node *np,
 	init.flags = CLK_SET_RATE_GATE;
 
 	h32mxclk->hw.init = &init;
-	h32mxclk->pmc = pmc;
+	h32mxclk->regmap = regmap;
 
 	clk = clk_register(NULL, &h32mxclk->hw);
 	if (!clk) {
@@ -123,3 +121,5 @@ void __init of_sama5d4_clk_h32mx_setup(struct device_node *np,
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
+	       of_sama5d4_clk_h32mx_setup);
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index fd7247deabdc..4bfc94d6c26e 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -13,13 +13,8 @@
 #include <linux/clk/at91_pmc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -34,18 +29,14 @@
 
 struct clk_main_osc {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 };
 
 #define to_clk_main_osc(hw) container_of(hw, struct clk_main_osc, hw)
 
 struct clk_main_rc_osc {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 	unsigned long frequency;
 	unsigned long accuracy;
 };
@@ -54,51 +45,47 @@ struct clk_main_rc_osc {
 
 struct clk_rm9200_main {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 #define to_clk_rm9200_main(hw) container_of(hw, struct clk_rm9200_main, hw)
 
 struct clk_sam9x5_main {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 	u8 parent;
 };
 
 #define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, hw)
 
-static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
+static inline bool clk_main_osc_ready(struct regmap *regmap)
 {
-	struct clk_main_osc *osc = dev_id;
+	unsigned int status;
 
-	wake_up(&osc->wait);
-	disable_irq_nosync(osc->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & AT91_PMC_MOSCS;
 }
 
 static int clk_main_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
+	struct regmap *regmap = osc->regmap;
 	u32 tmp;
 
-	tmp = pmc_read(pmc, AT91_CKGR_MOR) & ~MOR_KEY_MASK;
+	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
+	tmp &= ~MOR_KEY_MASK;
+
 	if (tmp & AT91_PMC_OSCBYPASS)
 		return 0;
 
 	if (!(tmp & AT91_PMC_MOSCEN)) {
 		tmp |= AT91_PMC_MOSCEN | AT91_PMC_KEY;
-		pmc_write(pmc, AT91_CKGR_MOR, tmp);
+		regmap_write(regmap, AT91_CKGR_MOR, tmp);
 	}
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCS)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCS);
-	}
+	while (!clk_main_osc_ready(regmap))
+		cpu_relax();
 
 	return 0;
 }
@@ -106,9 +93,10 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 static void clk_main_osc_unprepare(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
-	u32 tmp = pmc_read(pmc, AT91_CKGR_MOR);
+	struct regmap *regmap = osc->regmap;
+	u32 tmp;
 
+	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
 	if (tmp & AT91_PMC_OSCBYPASS)
 		return;
 
@@ -116,20 +104,22 @@ static void clk_main_osc_unprepare(struct clk_hw *hw)
 		return;
 
 	tmp &= ~(AT91_PMC_KEY | AT91_PMC_MOSCEN);
-	pmc_write(pmc, AT91_CKGR_MOR, tmp | AT91_PMC_KEY);
+	regmap_write(regmap, AT91_CKGR_MOR, tmp | AT91_PMC_KEY);
 }
 
 static int clk_main_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_main_osc *osc = to_clk_main_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
-	u32 tmp = pmc_read(pmc, AT91_CKGR_MOR);
+	struct regmap *regmap = osc->regmap;
+	u32 tmp, status;
 
+	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
 	if (tmp & AT91_PMC_OSCBYPASS)
 		return 1;
 
-	return !!((pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCS) &&
-		  (pmc_read(pmc, AT91_CKGR_MOR) & AT91_PMC_MOSCEN));
+	regmap_read(regmap, AT91_PMC_SR, &status);
+
+	return (status & AT91_PMC_MOSCS) && (tmp & AT91_PMC_MOSCEN);
 }
 
 static const struct clk_ops main_osc_ops = {
@@ -139,18 +129,16 @@ static const struct clk_ops main_osc_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_main_osc(struct at91_pmc *pmc,
-			   unsigned int irq,
+at91_clk_register_main_osc(struct regmap *regmap,
 			   const char *name,
 			   const char *parent_name,
 			   bool bypass)
 {
-	int ret;
 	struct clk_main_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !irq || !name || !parent_name)
+	if (!name || !parent_name)
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -164,85 +152,70 @@ at91_clk_register_main_osc(struct at91_pmc *pmc,
 	init.flags = CLK_IGNORE_UNUSED;
 
 	osc->hw.init = &init;
-	osc->pmc = pmc;
-	osc->irq = irq;
-
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
-	if (ret) {
-		kfree(osc);
-		return ERR_PTR(ret);
-	}
+	osc->regmap = regmap;
 
 	if (bypass)
-		pmc_write(pmc, AT91_CKGR_MOR,
-			  (pmc_read(pmc, AT91_CKGR_MOR) &
-			   ~(MOR_KEY_MASK | AT91_PMC_MOSCEN)) |
-			  AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
+		regmap_update_bits(regmap,
+				   AT91_CKGR_MOR, MOR_KEY_MASK |
+				   AT91_PMC_MOSCEN,
+				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
 
 	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk)) {
-		free_irq(irq, osc);
+	if (IS_ERR(clk))
 		kfree(osc);
-	}
 
 	return clk;
 }
 
-void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np,
-					     struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 {
 	struct clk *clk;
-	unsigned int irq;
 	const char *name = np->name;
 	const char *parent_name;
+	struct regmap *regmap;
 	bool bypass;
 
 	of_property_read_string(np, "clock-output-names", &name);
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 	parent_name = of_clk_get_parent_name(np, 0);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_main_osc(pmc, irq, name, parent_name, bypass);
+	clk = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91rm9200_clk_main_osc, "atmel,at91rm9200-clk-main-osc",
+	       of_at91rm9200_clk_main_osc_setup);
 
-static irqreturn_t clk_main_rc_osc_irq_handler(int irq, void *dev_id)
+static bool clk_main_rc_osc_ready(struct regmap *regmap)
 {
-	struct clk_main_rc_osc *osc = dev_id;
+	unsigned int status;
 
-	wake_up(&osc->wait);
-	disable_irq_nosync(osc->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & AT91_PMC_MOSCRCS;
 }
 
 static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
-	u32 tmp;
+	struct regmap *regmap = osc->regmap;
+	unsigned int mor;
 
-	tmp = pmc_read(pmc, AT91_CKGR_MOR) & ~MOR_KEY_MASK;
+	regmap_read(regmap, AT91_CKGR_MOR, &mor);
 
-	if (!(tmp & AT91_PMC_MOSCRCEN)) {
-		tmp |= AT91_PMC_MOSCRCEN | AT91_PMC_KEY;
-		pmc_write(pmc, AT91_CKGR_MOR, tmp);
-	}
+	if (!(mor & AT91_PMC_MOSCRCEN))
+		regmap_update_bits(regmap, AT91_CKGR_MOR,
+				   MOR_KEY_MASK | AT91_PMC_MOSCRCEN,
+				   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCRCS)) {
-		enable_irq(osc->irq);
-		wait_event(osc->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCRCS);
-	}
+	while (!clk_main_rc_osc_ready(regmap))
+		cpu_relax();
 
 	return 0;
 }
@@ -250,23 +223,28 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 static void clk_main_rc_osc_unprepare(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
-	u32 tmp = pmc_read(pmc, AT91_CKGR_MOR);
+	struct regmap *regmap = osc->regmap;
+	unsigned int mor;
 
-	if (!(tmp & AT91_PMC_MOSCRCEN))
+	regmap_read(regmap, AT91_CKGR_MOR, &mor);
+
+	if (!(mor & AT91_PMC_MOSCRCEN))
 		return;
 
-	tmp &= ~(MOR_KEY_MASK | AT91_PMC_MOSCRCEN);
-	pmc_write(pmc, AT91_CKGR_MOR, tmp | AT91_PMC_KEY);
+	regmap_update_bits(regmap, AT91_CKGR_MOR,
+			   MOR_KEY_MASK | AT91_PMC_MOSCRCEN, AT91_PMC_KEY);
 }
 
 static int clk_main_rc_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
-	struct at91_pmc *pmc = osc->pmc;
+	struct regmap *regmap = osc->regmap;
+	unsigned int mor, status;
 
-	return !!((pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCRCS) &&
-		  (pmc_read(pmc, AT91_CKGR_MOR) & AT91_PMC_MOSCRCEN));
+	regmap_read(regmap, AT91_CKGR_MOR, &mor);
+	regmap_read(regmap, AT91_PMC_SR, &status);
+
+	return (mor & AT91_PMC_MOSCRCEN) && (status & AT91_PMC_MOSCRCS);
 }
 
 static unsigned long clk_main_rc_osc_recalc_rate(struct clk_hw *hw,
@@ -294,17 +272,15 @@ static const struct clk_ops main_rc_osc_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
-			      unsigned int irq,
+at91_clk_register_main_rc_osc(struct regmap *regmap,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
 {
-	int ret;
 	struct clk_main_rc_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !irq || !name || !frequency)
+	if (!name || !frequency)
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -318,63 +294,53 @@ at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 	init.flags = CLK_IS_ROOT | CLK_IGNORE_UNUSED;
 
 	osc->hw.init = &init;
-	osc->pmc = pmc;
-	osc->irq = irq;
+	osc->regmap = regmap;
 	osc->frequency = frequency;
 	osc->accuracy = accuracy;
 
-	init_waitqueue_head(&osc->wait);
-	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
-	ret = request_irq(osc->irq, clk_main_rc_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
-	if (ret)
-		return ERR_PTR(ret);
-
 	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk)) {
-		free_irq(irq, osc);
+	if (IS_ERR(clk))
 		kfree(osc);
-	}
 
 	return clk;
 }
 
-void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np,
-						struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
 {
 	struct clk *clk;
-	unsigned int irq;
 	u32 frequency = 0;
 	u32 accuracy = 0;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	of_property_read_string(np, "clock-output-names", &name);
 	of_property_read_u32(np, "clock-frequency", &frequency);
 	of_property_read_u32(np, "clock-accuracy", &accuracy);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_main_rc_osc(pmc, irq, name, frequency,
-					    accuracy);
+	clk = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_main_rc_osc, "atmel,at91sam9x5-clk-main-rc-osc",
+	       of_at91sam9x5_clk_main_rc_osc_setup);
 
 
-static int clk_main_probe_frequency(struct at91_pmc *pmc)
+static int clk_main_probe_frequency(struct regmap *regmap)
 {
 	unsigned long prep_time, timeout;
-	u32 tmp;
+	unsigned int mcfr;
 
 	timeout = jiffies + usecs_to_jiffies(MAINFRDY_TIMEOUT);
 	do {
 		prep_time = jiffies;
-		tmp = pmc_read(pmc, AT91_CKGR_MCFR);
-		if (tmp & AT91_PMC_MAINRDY)
+		regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
+		if (mcfr & AT91_PMC_MAINRDY)
 			return 0;
 		usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
 	} while (time_before(prep_time, timeout));
@@ -382,34 +348,37 @@ static int clk_main_probe_frequency(struct at91_pmc *pmc)
 	return -ETIMEDOUT;
 }
 
-static unsigned long clk_main_recalc_rate(struct at91_pmc *pmc,
+static unsigned long clk_main_recalc_rate(struct regmap *regmap,
 					  unsigned long parent_rate)
 {
-	u32 tmp;
+	unsigned int mcfr;
 
 	if (parent_rate)
 		return parent_rate;
 
 	pr_warn("Main crystal frequency not set, using approximate value\n");
-	tmp = pmc_read(pmc, AT91_CKGR_MCFR);
-	if (!(tmp & AT91_PMC_MAINRDY))
+	regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
+	if (!(mcfr & AT91_PMC_MAINRDY))
 		return 0;
 
-	return ((tmp & AT91_PMC_MAINF) * SLOW_CLOCK_FREQ) / MAINF_DIV;
+	return ((mcfr & AT91_PMC_MAINF) * SLOW_CLOCK_FREQ) / MAINF_DIV;
 }
 
 static int clk_rm9200_main_prepare(struct clk_hw *hw)
 {
 	struct clk_rm9200_main *clkmain = to_clk_rm9200_main(hw);
 
-	return clk_main_probe_frequency(clkmain->pmc);
+	return clk_main_probe_frequency(clkmain->regmap);
 }
 
 static int clk_rm9200_main_is_prepared(struct clk_hw *hw)
 {
 	struct clk_rm9200_main *clkmain = to_clk_rm9200_main(hw);
+	unsigned int status;
 
-	return !!(pmc_read(clkmain->pmc, AT91_CKGR_MCFR) & AT91_PMC_MAINRDY);
+	regmap_read(clkmain->regmap, AT91_CKGR_MCFR, &status);
+
+	return status & AT91_PMC_MAINRDY ? 1 : 0;
 }
 
 static unsigned long clk_rm9200_main_recalc_rate(struct clk_hw *hw,
@@ -417,7 +386,7 @@ static unsigned long clk_rm9200_main_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_rm9200_main *clkmain = to_clk_rm9200_main(hw);
 
-	return clk_main_recalc_rate(clkmain->pmc, parent_rate);
+	return clk_main_recalc_rate(clkmain->regmap, parent_rate);
 }
 
 static const struct clk_ops rm9200_main_ops = {
@@ -427,7 +396,7 @@ static const struct clk_ops rm9200_main_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_rm9200_main(struct at91_pmc *pmc,
+at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
 			      const char *parent_name)
 {
@@ -435,7 +404,7 @@ at91_clk_register_rm9200_main(struct at91_pmc *pmc,
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !name)
+	if (!name)
 		return ERR_PTR(-EINVAL);
 
 	if (!parent_name)
@@ -452,7 +421,7 @@ at91_clk_register_rm9200_main(struct at91_pmc *pmc,
 	init.flags = 0;
 
 	clkmain->hw.init = &init;
-	clkmain->pmc = pmc;
+	clkmain->regmap = regmap;
 
 	clk = clk_register(NULL, &clkmain->hw);
 	if (IS_ERR(clk))
@@ -461,52 +430,54 @@ at91_clk_register_rm9200_main(struct at91_pmc *pmc,
 	return clk;
 }
 
-void __init of_at91rm9200_clk_main_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_rm9200_main(pmc, name, parent_name);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	clk = at91_clk_register_rm9200_main(regmap, name, parent_name);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
+	       of_at91rm9200_clk_main_setup);
 
-static irqreturn_t clk_sam9x5_main_irq_handler(int irq, void *dev_id)
+static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
 {
-	struct clk_sam9x5_main *clkmain = dev_id;
+	unsigned int status;
 
-	wake_up(&clkmain->wait);
-	disable_irq_nosync(clkmain->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & AT91_PMC_MOSCSELS ? 1 : 0;
 }
 
 static int clk_sam9x5_main_prepare(struct clk_hw *hw)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
-	struct at91_pmc *pmc = clkmain->pmc;
+	struct regmap *regmap = clkmain->regmap;
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS);
-	}
+	while (!clk_sam9x5_main_ready(regmap))
+		cpu_relax();
 
-	return clk_main_probe_frequency(pmc);
+	return clk_main_probe_frequency(regmap);
 }
 
 static int clk_sam9x5_main_is_prepared(struct clk_hw *hw)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
 
-	return !!(pmc_read(clkmain->pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS);
+	return clk_sam9x5_main_ready(clkmain->regmap);
 }
 
 static unsigned long clk_sam9x5_main_recalc_rate(struct clk_hw *hw,
@@ -514,30 +485,28 @@ static unsigned long clk_sam9x5_main_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
 
-	return clk_main_recalc_rate(clkmain->pmc, parent_rate);
+	return clk_main_recalc_rate(clkmain->regmap, parent_rate);
 }
 
 static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
-	struct at91_pmc *pmc = clkmain->pmc;
-	u32 tmp;
+	struct regmap *regmap = clkmain->regmap;
+	unsigned int tmp;
 
 	if (index > 1)
 		return -EINVAL;
 
-	tmp = pmc_read(pmc, AT91_CKGR_MOR) & ~MOR_KEY_MASK;
+	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
+	tmp &= ~MOR_KEY_MASK;
 
 	if (index && !(tmp & AT91_PMC_MOSCSEL))
-		pmc_write(pmc, AT91_CKGR_MOR, tmp | AT91_PMC_MOSCSEL);
+		regmap_write(regmap, AT91_CKGR_MOR, tmp | AT91_PMC_MOSCSEL);
 	else if (!index && (tmp & AT91_PMC_MOSCSEL))
-		pmc_write(pmc, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
+		regmap_write(regmap, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS)) {
-		enable_irq(clkmain->irq);
-		wait_event(clkmain->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS);
-	}
+	while (!clk_sam9x5_main_ready(regmap))
+		cpu_relax();
 
 	return 0;
 }
@@ -545,8 +514,11 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 static u8 clk_sam9x5_main_get_parent(struct clk_hw *hw)
 {
 	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
+	unsigned int status;
 
-	return !!(pmc_read(clkmain->pmc, AT91_CKGR_MOR) & AT91_PMC_MOSCEN);
+	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
+
+	return status & AT91_PMC_MOSCEN ? 1 : 0;
 }
 
 static const struct clk_ops sam9x5_main_ops = {
@@ -558,18 +530,17 @@ static const struct clk_ops sam9x5_main_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
-			      unsigned int irq,
+at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
 			      const char **parent_names,
 			      int num_parents)
 {
-	int ret;
 	struct clk_sam9x5_main *clkmain;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
+	unsigned int status;
 
-	if (!pmc || !irq || !name)
+	if (!name)
 		return ERR_PTR(-EINVAL);
 
 	if (!parent_names || !num_parents)
@@ -586,51 +557,42 @@ at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 	init.flags = CLK_SET_PARENT_GATE;
 
 	clkmain->hw.init = &init;
-	clkmain->pmc = pmc;
-	clkmain->irq = irq;
-	clkmain->parent = !!(pmc_read(clkmain->pmc, AT91_CKGR_MOR) &
-			     AT91_PMC_MOSCEN);
-	init_waitqueue_head(&clkmain->wait);
-	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
-	ret = request_irq(clkmain->irq, clk_sam9x5_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, clkmain);
-	if (ret)
-		return ERR_PTR(ret);
+	clkmain->regmap = regmap;
+	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
+	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
 
 	clk = clk_register(NULL, &clkmain->hw);
-	if (IS_ERR(clk)) {
-		free_irq(clkmain->irq, clkmain);
+	if (IS_ERR(clk))
 		kfree(clkmain);
-	}
 
 	return clk;
 }
 
-void __init of_at91sam9x5_clk_main_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_names[2];
 	int num_parents;
-	unsigned int irq;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > 2)
 		return;
 
 	of_clk_parent_fill(np, parent_names, num_parents);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
-	clk = at91_clk_register_sam9x5_main(pmc, irq, name, parent_names,
+	clk = at91_clk_register_sam9x5_main(regmap, name, parent_names,
 					    num_parents);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
+	       of_at91sam9x5_clk_main_setup);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 620ea323356b..7d4a1864ea7c 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -12,13 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -44,32 +39,26 @@ struct clk_master_layout {
 
 struct clk_master {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 	const struct clk_master_layout *layout;
 	const struct clk_master_characteristics *characteristics;
 };
 
-static irqreturn_t clk_master_irq_handler(int irq, void *dev_id)
+static inline bool clk_master_ready(struct regmap *regmap)
 {
-	struct clk_master *master = (struct clk_master *)dev_id;
+	unsigned int status;
 
-	wake_up(&master->wait);
-	disable_irq_nosync(master->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & AT91_PMC_MCKRDY ? 1 : 0;
 }
+
 static int clk_master_prepare(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
-	struct at91_pmc *pmc = master->pmc;
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY)) {
-		enable_irq(master->irq);
-		wait_event(master->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
-	}
+	while (!clk_master_ready(master->regmap))
+		cpu_relax();
 
 	return 0;
 }
@@ -78,7 +67,7 @@ static int clk_master_is_prepared(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
 
-	return !!(pmc_read(master->pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+	return clk_master_ready(master->regmap);
 }
 
 static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
@@ -88,18 +77,16 @@ static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
 	u8 div;
 	unsigned long rate = parent_rate;
 	struct clk_master *master = to_clk_master(hw);
-	struct at91_pmc *pmc = master->pmc;
 	const struct clk_master_layout *layout = master->layout;
 	const struct clk_master_characteristics *characteristics =
 						master->characteristics;
-	u32 tmp;
+	unsigned int mckr;
 
-	pmc_lock(pmc);
-	tmp = pmc_read(pmc, AT91_PMC_MCKR) & layout->mask;
-	pmc_unlock(pmc);
+	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+	mckr &= layout->mask;
 
-	pres = (tmp >> layout->pres_shift) & MASTER_PRES_MASK;
-	div = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+	pres = (mckr >> layout->pres_shift) & MASTER_PRES_MASK;
+	div = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
 
 	if (characteristics->have_div3_pres && pres == MASTER_PRES_MAX)
 		rate /= 3;
@@ -119,9 +106,11 @@ static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
 static u8 clk_master_get_parent(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
-	struct at91_pmc *pmc = master->pmc;
+	unsigned int mckr;
 
-	return pmc_read(pmc, AT91_PMC_MCKR) & AT91_PMC_CSS;
+	regmap_read(master->regmap, AT91_PMC_MCKR, &mckr);
+
+	return mckr & AT91_PMC_CSS;
 }
 
 static const struct clk_ops master_ops = {
@@ -132,18 +121,17 @@ static const struct clk_ops master_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
+at91_clk_register_master(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics)
 {
-	int ret;
 	struct clk_master *master;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !irq || !name || !num_parents || !parent_names)
+	if (!name || !num_parents || !parent_names)
 		return ERR_PTR(-EINVAL);
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -159,20 +147,10 @@ at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
 	master->hw.init = &init;
 	master->layout = layout;
 	master->characteristics = characteristics;
-	master->pmc = pmc;
-	master->irq = irq;
-	init_waitqueue_head(&master->wait);
-	irq_set_status_flags(master->irq, IRQ_NOAUTOEN);
-	ret = request_irq(master->irq, clk_master_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-master", master);
-	if (ret) {
-		kfree(master);
-		return ERR_PTR(ret);
-	}
+	master->regmap = regmap;
 
 	clk = clk_register(NULL, &master->hw);
 	if (IS_ERR(clk)) {
-		free_irq(master->irq, master);
 		kfree(master);
 	}
 
@@ -217,15 +195,15 @@ of_at91_clk_master_get_characteristics(struct device_node *np)
 }
 
 static void __init
-of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
+of_at91_clk_master_setup(struct device_node *np,
 			 const struct clk_master_layout *layout)
 {
 	struct clk *clk;
 	int num_parents;
-	unsigned int irq;
 	const char *parent_names[MASTER_SOURCE_MAX];
 	const char *name = np->name;
 	struct clk_master_characteristics *characteristics;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > MASTER_SOURCE_MAX)
@@ -239,11 +217,11 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
 	if (!characteristics)
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		goto out_free_characteristics;
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
 
-	clk = at91_clk_register_master(pmc, irq, name, num_parents,
+	clk = at91_clk_register_master(regmap, name, num_parents,
 				       parent_names, layout,
 				       characteristics);
 	if (IS_ERR(clk))
@@ -256,14 +234,16 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
 	kfree(characteristics);
 }
 
-void __init of_at91rm9200_clk_master_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_master_setup(struct device_node *np)
 {
-	of_at91_clk_master_setup(np, pmc, &at91rm9200_master_layout);
+	of_at91_clk_master_setup(np, &at91rm9200_master_layout);
 }
+CLK_OF_DECLARE(at91rm9200_clk_master, "atmel,at91rm9200-clk-master",
+	       of_at91rm9200_clk_master_setup);
 
-void __init of_at91sam9x5_clk_master_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_master_setup(struct device_node *np)
 {
-	of_at91_clk_master_setup(np, pmc, &at91sam9x5_master_layout);
+	of_at91_clk_master_setup(np, &at91sam9x5_master_layout);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_master, "atmel,at91sam9x5-clk-master",
+	       of_at91sam9x5_clk_master_setup);
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 58f3b568e9cb..d69cd2a121b1 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -12,11 +12,13 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
+DEFINE_SPINLOCK(pmc_pcr_lock);
+
 #define PERIPHERAL_MAX		64
 
 #define PERIPHERAL_AT91RM9200	0
@@ -33,7 +35,7 @@
 
 struct clk_peripheral {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 	u32 id;
 };
 
@@ -41,8 +43,9 @@ struct clk_peripheral {
 
 struct clk_sam9x5_peripheral {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 	struct clk_range range;
+	spinlock_t *lock;
 	u32 id;
 	u32 div;
 	bool auto_div;
@@ -54,7 +57,6 @@ struct clk_sam9x5_peripheral {
 static int clk_peripheral_enable(struct clk_hw *hw)
 {
 	struct clk_peripheral *periph = to_clk_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
 	int offset = AT91_PMC_PCER;
 	u32 id = periph->id;
 
@@ -62,14 +64,14 @@ static int clk_peripheral_enable(struct clk_hw *hw)
 		return 0;
 	if (id > PERIPHERAL_ID_MAX)
 		offset = AT91_PMC_PCER1;
-	pmc_write(pmc, offset, PERIPHERAL_MASK(id));
+	regmap_write(periph->regmap, offset, PERIPHERAL_MASK(id));
+
 	return 0;
 }
 
 static void clk_peripheral_disable(struct clk_hw *hw)
 {
 	struct clk_peripheral *periph = to_clk_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
 	int offset = AT91_PMC_PCDR;
 	u32 id = periph->id;
 
@@ -77,21 +79,23 @@ static void clk_peripheral_disable(struct clk_hw *hw)
 		return;
 	if (id > PERIPHERAL_ID_MAX)
 		offset = AT91_PMC_PCDR1;
-	pmc_write(pmc, offset, PERIPHERAL_MASK(id));
+	regmap_write(periph->regmap, offset, PERIPHERAL_MASK(id));
 }
 
 static int clk_peripheral_is_enabled(struct clk_hw *hw)
 {
 	struct clk_peripheral *periph = to_clk_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
 	int offset = AT91_PMC_PCSR;
+	unsigned int status;
 	u32 id = periph->id;
 
 	if (id < PERIPHERAL_ID_MIN)
 		return 1;
 	if (id > PERIPHERAL_ID_MAX)
 		offset = AT91_PMC_PCSR1;
-	return !!(pmc_read(pmc, offset) & PERIPHERAL_MASK(id));
+	regmap_read(periph->regmap, offset, &status);
+
+	return status & PERIPHERAL_MASK(id) ? 1 : 0;
 }
 
 static const struct clk_ops peripheral_ops = {
@@ -101,14 +105,14 @@ static const struct clk_ops peripheral_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_peripheral(struct at91_pmc *pmc, const char *name,
+at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 			     const char *parent_name, u32 id)
 {
 	struct clk_peripheral *periph;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !name || !parent_name || id > PERIPHERAL_ID_MAX)
+	if (!name || !parent_name || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -123,7 +127,7 @@ at91_clk_register_peripheral(struct at91_pmc *pmc, const char *name,
 
 	periph->id = id;
 	periph->hw.init = &init;
-	periph->pmc = pmc;
+	periph->regmap = regmap;
 
 	clk = clk_register(NULL, &periph->hw);
 	if (IS_ERR(clk))
@@ -160,53 +164,58 @@ static void clk_sam9x5_peripheral_autodiv(struct clk_sam9x5_peripheral *periph)
 static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
-	u32 tmp;
+	unsigned long flags;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return 0;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_DIV_MASK;
-	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_DIV(periph->div)
-					 | AT91_PMC_PCR_CMD
-					 | AT91_PMC_PCR_EN);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(periph->lock, flags);
+	regmap_write(periph->regmap, AT91_PMC_PCR,
+		     (periph->id & AT91_PMC_PCR_PID_MASK));
+	regmap_update_bits(periph->regmap, AT91_PMC_PCR,
+			   AT91_PMC_PCR_DIV_MASK | AT91_PMC_PCR_CMD |
+			   AT91_PMC_PCR_EN,
+			   AT91_PMC_PCR_DIV(periph->div) |
+			   AT91_PMC_PCR_CMD |
+			   AT91_PMC_PCR_EN);
+	spin_unlock_irqrestore(periph->lock, flags);
+
 	return 0;
 }
 
 static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
-	u32 tmp;
+	unsigned long flags;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_EN;
-	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_CMD);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(periph->lock, flags);
+	regmap_write(periph->regmap, AT91_PMC_PCR,
+		     (periph->id & AT91_PMC_PCR_PID_MASK));
+	regmap_update_bits(periph->regmap, AT91_PMC_PCR,
+			   AT91_PMC_PCR_EN | AT91_PMC_PCR_CMD,
+			   AT91_PMC_PCR_CMD);
+	spin_unlock_irqrestore(periph->lock, flags);
 }
 
 static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
-	int ret;
+	unsigned long flags;
+	unsigned int status;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return 1;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
-	ret = !!(pmc_read(pmc, AT91_PMC_PCR) & AT91_PMC_PCR_EN);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(periph->lock, flags);
+	regmap_write(periph->regmap, AT91_PMC_PCR,
+		     (periph->id & AT91_PMC_PCR_PID_MASK));
+	regmap_read(periph->regmap, AT91_PMC_PCR, &status);
+	spin_unlock_irqrestore(periph->lock, flags);
 
-	return ret;
+	return status & AT91_PMC_PCR_EN ? 1 : 0;
 }
 
 static unsigned long
@@ -214,19 +223,20 @@ clk_sam9x5_peripheral_recalc_rate(struct clk_hw *hw,
 				  unsigned long parent_rate)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
-	struct at91_pmc *pmc = periph->pmc;
-	u32 tmp;
+	unsigned long flags;
+	unsigned int status;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return parent_rate;
 
-	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
-	tmp = pmc_read(pmc, AT91_PMC_PCR);
-	pmc_unlock(pmc);
+	spin_lock_irqsave(periph->lock, flags);
+	regmap_write(periph->regmap, AT91_PMC_PCR,
+		     (periph->id & AT91_PMC_PCR_PID_MASK));
+	regmap_read(periph->regmap, AT91_PMC_PCR, &status);
+	spin_unlock_irqrestore(periph->lock, flags);
 
-	if (tmp & AT91_PMC_PCR_EN) {
-		periph->div = PERIPHERAL_RSHIFT(tmp);
+	if (status & AT91_PMC_PCR_EN) {
+		periph->div = PERIPHERAL_RSHIFT(status);
 		periph->auto_div = false;
 	} else {
 		clk_sam9x5_peripheral_autodiv(periph);
@@ -318,15 +328,15 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_sam9x5_peripheral(struct at91_pmc *pmc, const char *name,
-				    const char *parent_name, u32 id,
-				    const struct clk_range *range)
+at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
+				    const char *name, const char *parent_name,
+				    u32 id, const struct clk_range *range)
 {
 	struct clk_sam9x5_peripheral *periph;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !name || !parent_name)
+	if (!name || !parent_name)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -342,7 +352,8 @@ at91_clk_register_sam9x5_peripheral(struct at91_pmc *pmc, const char *name,
 	periph->id = id;
 	periph->hw.init = &init;
 	periph->div = 0;
-	periph->pmc = pmc;
+	periph->regmap = regmap;
+	periph->lock = lock;
 	periph->auto_div = true;
 	periph->range = *range;
 
@@ -356,7 +367,7 @@ at91_clk_register_sam9x5_peripheral(struct at91_pmc *pmc, const char *name,
 }
 
 static void __init
-of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
+of_at91_clk_periph_setup(struct device_node *np, u8 type)
 {
 	int num;
 	u32 id;
@@ -364,6 +375,7 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 	const char *parent_name;
 	const char *name;
 	struct device_node *periphclknp;
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -373,6 +385,10 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 	if (!num || num > PERIPHERAL_MAX)
 		return;
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	for_each_child_of_node(np, periphclknp) {
 		if (of_property_read_u32(periphclknp, "reg", &id))
 			continue;
@@ -384,7 +400,7 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 			name = periphclknp->name;
 
 		if (type == PERIPHERAL_AT91RM9200) {
-			clk = at91_clk_register_peripheral(pmc, name,
+			clk = at91_clk_register_peripheral(regmap, name,
 							   parent_name, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
@@ -393,7 +409,9 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 					      "atmel,clk-output-range",
 					      &range);
 
-			clk = at91_clk_register_sam9x5_peripheral(pmc, name,
+			clk = at91_clk_register_sam9x5_peripheral(regmap,
+								  &pmc_pcr_lock,
+								  name,
 								  parent_name,
 								  id, &range);
 		}
@@ -405,14 +423,16 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 	}
 }
 
-void __init of_at91rm9200_clk_periph_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_periph_setup(struct device_node *np)
 {
-	of_at91_clk_periph_setup(np, pmc, PERIPHERAL_AT91RM9200);
+	of_at91_clk_periph_setup(np, PERIPHERAL_AT91RM9200);
 }
+CLK_OF_DECLARE(at91rm9200_clk_periph, "atmel,at91rm9200-clk-peripheral",
+	       of_at91rm9200_clk_periph_setup);
 
-void __init of_at91sam9x5_clk_periph_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_periph_setup(struct device_node *np)
 {
-	of_at91_clk_periph_setup(np, pmc, PERIPHERAL_AT91SAM9X5);
+	of_at91_clk_periph_setup(np, PERIPHERAL_AT91SAM9X5);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_periph, "atmel,at91sam9x5-clk-peripheral",
+	       of_at91sam9x5_clk_periph_setup);
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 18b60f4895a6..fb2e0b56d4b7 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -12,14 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -58,9 +52,7 @@ struct clk_pll_layout {
 
 struct clk_pll {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 	u8 id;
 	u8 div;
 	u8 range;
@@ -69,20 +61,19 @@ struct clk_pll {
 	const struct clk_pll_characteristics *characteristics;
 };
 
-static irqreturn_t clk_pll_irq_handler(int irq, void *dev_id)
+static inline bool clk_pll_ready(struct regmap *regmap, int id)
 {
-	struct clk_pll *pll = (struct clk_pll *)dev_id;
+	unsigned int status;
 
-	wake_up(&pll->wait);
-	disable_irq_nosync(pll->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & PLL_STATUS_MASK(id) ? 1 : 0;
 }
 
 static int clk_pll_prepare(struct clk_hw *hw)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	struct at91_pmc *pmc = pll->pmc;
+	struct regmap *regmap = pll->regmap;
 	const struct clk_pll_layout *layout = pll->layout;
 	const struct clk_pll_characteristics *characteristics =
 							pll->characteristics;
@@ -90,39 +81,34 @@ static int clk_pll_prepare(struct clk_hw *hw)
 	u32 mask = PLL_STATUS_MASK(id);
 	int offset = PLL_REG(id);
 	u8 out = 0;
-	u32 pllr, icpr;
+	unsigned int pllr;
+	unsigned int status;
 	u8 div;
 	u16 mul;
 
-	pllr = pmc_read(pmc, offset);
+	regmap_read(regmap, offset, &pllr);
 	div = PLL_DIV(pllr);
 	mul = PLL_MUL(pllr, layout);
 
-	if ((pmc_read(pmc, AT91_PMC_SR) & mask) &&
+	regmap_read(regmap, AT91_PMC_SR, &status);
+	if ((status & mask) &&
 	    (div == pll->div && mul == pll->mul))
 		return 0;
 
 	if (characteristics->out)
 		out = characteristics->out[pll->range];
-	if (characteristics->icpll) {
-		icpr = pmc_read(pmc, AT91_PMC_PLLICPR) & ~PLL_ICPR_MASK(id);
-		icpr |= (characteristics->icpll[pll->range] <<
-			PLL_ICPR_SHIFT(id));
-		pmc_write(pmc, AT91_PMC_PLLICPR, icpr);
-	}
 
-	pllr &= ~layout->pllr_mask;
-	pllr |= layout->pllr_mask &
-	       (pll->div | (PLL_MAX_COUNT << PLL_COUNT_SHIFT) |
-		(out << PLL_OUT_SHIFT) |
-		((pll->mul & layout->mul_mask) << layout->mul_shift));
-	pmc_write(pmc, offset, pllr);
+	if (characteristics->icpll)
+		regmap_update_bits(regmap, AT91_PMC_PLLICPR, PLL_ICPR_MASK(id),
+			characteristics->icpll[pll->range] << PLL_ICPR_SHIFT(id));
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & mask)) {
-		enable_irq(pll->irq);
-		wait_event(pll->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & mask);
-	}
+	regmap_update_bits(regmap, offset, layout->pllr_mask,
+			pll->div | (PLL_MAX_COUNT << PLL_COUNT_SHIFT) |
+			(out << PLL_OUT_SHIFT) |
+			((pll->mul & layout->mul_mask) << layout->mul_shift));
+
+	while (!clk_pll_ready(regmap, pll->id))
+		cpu_relax();
 
 	return 0;
 }
@@ -130,32 +116,35 @@ static int clk_pll_prepare(struct clk_hw *hw)
 static int clk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	struct at91_pmc *pmc = pll->pmc;
 
-	return !!(pmc_read(pmc, AT91_PMC_SR) &
-		  PLL_STATUS_MASK(pll->id));
+	return clk_pll_ready(pll->regmap, pll->id);
 }
 
 static void clk_pll_unprepare(struct clk_hw *hw)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	struct at91_pmc *pmc = pll->pmc;
-	const struct clk_pll_layout *layout = pll->layout;
-	int offset = PLL_REG(pll->id);
-	u32 tmp = pmc_read(pmc, offset) & ~(layout->pllr_mask);
+	unsigned int mask = pll->layout->pllr_mask;
 
-	pmc_write(pmc, offset, tmp);
+	regmap_update_bits(pll->regmap, PLL_REG(pll->id), mask, ~mask);
 }
 
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
+	unsigned int pllr;
+	u16 mul;
+	u8 div;
 
-	if (!pll->div || !pll->mul)
+	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
+
+	div = PLL_DIV(pllr);
+	mul = PLL_MUL(pllr, pll->layout);
+
+	if (!div || !mul)
 		return 0;
 
-	return (parent_rate / pll->div) * (pll->mul + 1);
+	return (parent_rate / div) * (mul + 1);
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
@@ -308,7 +297,7 @@ static const struct clk_ops pll_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
+at91_clk_register_pll(struct regmap *regmap, const char *name,
 		      const char *parent_name, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics)
@@ -316,9 +305,8 @@ at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
 	struct clk_pll *pll;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
-	int ret;
 	int offset = PLL_REG(id);
-	u32 tmp;
+	unsigned int pllr;
 
 	if (id > PLL_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -337,23 +325,13 @@ at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
 	pll->hw.init = &init;
 	pll->layout = layout;
 	pll->characteristics = characteristics;
-	pll->pmc = pmc;
-	pll->irq = irq;
-	tmp = pmc_read(pmc, offset) & layout->pllr_mask;
-	pll->div = PLL_DIV(tmp);
-	pll->mul = PLL_MUL(tmp, layout);
-	init_waitqueue_head(&pll->wait);
-	irq_set_status_flags(pll->irq, IRQ_NOAUTOEN);
-	ret = request_irq(pll->irq, clk_pll_irq_handler, IRQF_TRIGGER_HIGH,
-			  id ? "clk-pllb" : "clk-plla", pll);
-	if (ret) {
-		kfree(pll);
-		return ERR_PTR(ret);
-	}
+	pll->regmap = regmap;
+	regmap_read(regmap, offset, &pllr);
+	pll->div = PLL_DIV(pllr);
+	pll->mul = PLL_MUL(pllr, layout);
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
-		free_irq(pll->irq, pll);
 		kfree(pll);
 	}
 
@@ -483,12 +461,12 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 }
 
 static void __init
-of_at91_clk_pll_setup(struct device_node *np, struct at91_pmc *pmc,
+of_at91_clk_pll_setup(struct device_node *np,
 		      const struct clk_pll_layout *layout)
 {
 	u32 id;
-	unsigned int irq;
 	struct clk *clk;
+	struct regmap *regmap;
 	const char *parent_name;
 	const char *name = np->name;
 	struct clk_pll_characteristics *characteristics;
@@ -500,15 +478,15 @@ of_at91_clk_pll_setup(struct device_node *np, struct at91_pmc *pmc,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	characteristics = of_at91_clk_pll_get_characteristics(np);
 	if (!characteristics)
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
-		return;
-
-	clk = at91_clk_register_pll(pmc, irq, name, parent_name, id, layout,
+	clk = at91_clk_register_pll(regmap, name, parent_name, id, layout,
 				    characteristics);
 	if (IS_ERR(clk))
 		goto out_free_characteristics;
@@ -520,26 +498,30 @@ of_at91_clk_pll_setup(struct device_node *np, struct at91_pmc *pmc,
 	kfree(characteristics);
 }
 
-void __init of_at91rm9200_clk_pll_setup(struct device_node *np,
-					       struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_pll_setup(struct device_node *np)
 {
-	of_at91_clk_pll_setup(np, pmc, &at91rm9200_pll_layout);
+	of_at91_clk_pll_setup(np, &at91rm9200_pll_layout);
 }
+CLK_OF_DECLARE(at91rm9200_clk_pll, "atmel,at91rm9200-clk-pll",
+	       of_at91rm9200_clk_pll_setup);
 
-void __init of_at91sam9g45_clk_pll_setup(struct device_node *np,
-						struct at91_pmc *pmc)
+static void __init of_at91sam9g45_clk_pll_setup(struct device_node *np)
 {
-	of_at91_clk_pll_setup(np, pmc, &at91sam9g45_pll_layout);
+	of_at91_clk_pll_setup(np, &at91sam9g45_pll_layout);
 }
+CLK_OF_DECLARE(at91sam9g45_clk_pll, "atmel,at91sam9g45-clk-pll",
+	       of_at91sam9g45_clk_pll_setup);
 
-void __init of_at91sam9g20_clk_pllb_setup(struct device_node *np,
-						 struct at91_pmc *pmc)
+static void __init of_at91sam9g20_clk_pllb_setup(struct device_node *np)
 {
-	of_at91_clk_pll_setup(np, pmc, &at91sam9g20_pllb_layout);
+	of_at91_clk_pll_setup(np, &at91sam9g20_pllb_layout);
 }
+CLK_OF_DECLARE(at91sam9g20_clk_pllb, "atmel,at91sam9g20-clk-pllb",
+	       of_at91sam9g20_clk_pllb_setup);
 
-void __init of_sama5d3_clk_pll_setup(struct device_node *np,
-					    struct at91_pmc *pmc)
+static void __init of_sama5d3_clk_pll_setup(struct device_node *np)
 {
-	of_at91_clk_pll_setup(np, pmc, &sama5d3_pll_layout);
+	of_at91_clk_pll_setup(np, &sama5d3_pll_layout);
 }
+CLK_OF_DECLARE(sama5d3_clk_pll, "atmel,sama5d3-clk-pll",
+	       of_sama5d3_clk_pll_setup);
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index ea226562bb40..2bed26481027 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -12,8 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -21,16 +21,18 @@
 
 struct clk_plldiv {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 static unsigned long clk_plldiv_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
 	struct clk_plldiv *plldiv = to_clk_plldiv(hw);
-	struct at91_pmc *pmc = plldiv->pmc;
+	unsigned int mckr;
 
-	if (pmc_read(pmc, AT91_PMC_MCKR) & AT91_PMC_PLLADIV2)
+	regmap_read(plldiv->regmap, AT91_PMC_MCKR, &mckr);
+
+	if (mckr & AT91_PMC_PLLADIV2)
 		return parent_rate / 2;
 
 	return parent_rate;
@@ -57,18 +59,12 @@ static int clk_plldiv_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate)
 {
 	struct clk_plldiv *plldiv = to_clk_plldiv(hw);
-	struct at91_pmc *pmc = plldiv->pmc;
-	u32 tmp;
 
-	if (parent_rate != rate && (parent_rate / 2) != rate)
+	if ((parent_rate != rate) && (parent_rate / 2 != rate))
 		return -EINVAL;
 
-	pmc_lock(pmc);
-	tmp = pmc_read(pmc, AT91_PMC_MCKR) & ~AT91_PMC_PLLADIV2;
-	if ((parent_rate / 2) == rate)
-		tmp |= AT91_PMC_PLLADIV2;
-	pmc_write(pmc, AT91_PMC_MCKR, tmp);
-	pmc_unlock(pmc);
+	regmap_update_bits(plldiv->regmap, AT91_PMC_MCKR, AT91_PMC_PLLADIV2,
+			   parent_rate != rate ? AT91_PMC_PLLADIV2 : 0);
 
 	return 0;
 }
@@ -80,7 +76,7 @@ static const struct clk_ops plldiv_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_plldiv(struct at91_pmc *pmc, const char *name,
+at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name)
 {
 	struct clk_plldiv *plldiv;
@@ -98,7 +94,7 @@ at91_clk_register_plldiv(struct at91_pmc *pmc, const char *name,
 	init.flags = CLK_SET_RATE_GATE;
 
 	plldiv->hw.init = &init;
-	plldiv->pmc = pmc;
+	plldiv->regmap = regmap;
 
 	clk = clk_register(NULL, &plldiv->hw);
 
@@ -109,27 +105,27 @@ at91_clk_register_plldiv(struct at91_pmc *pmc, const char *name,
 }
 
 static void __init
-of_at91_clk_plldiv_setup(struct device_node *np, struct at91_pmc *pmc)
+of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_plldiv(pmc, name, parent_name);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
 
+	clk = at91_clk_register_plldiv(regmap, name, parent_name);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 	return;
 }
-
-void __init of_at91sam9x5_clk_plldiv_setup(struct device_node *np,
-					   struct at91_pmc *pmc)
-{
-	of_at91_clk_plldiv_setup(np, pmc);
-}
+CLK_OF_DECLARE(at91sam9x5_clk_plldiv, "atmel,at91sam9x5-clk-plldiv",
+	       of_at91sam9x5_clk_plldiv_setup);
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 14b270b85fec..bc0be629671b 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -12,10 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -24,6 +22,7 @@
 
 #define PROG_STATUS_MASK(id)	(1 << ((id) + 8))
 #define PROG_PRES_MASK		0x7
+#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & PROG_PRES_MASK)
 #define PROG_MAX_RM9200_CSS	3
 
 struct clk_programmable_layout {
@@ -34,7 +33,7 @@ struct clk_programmable_layout {
 
 struct clk_programmable {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 	u8 id;
 	const struct clk_programmable_layout *layout;
 };
@@ -44,14 +43,12 @@ struct clk_programmable {
 static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
-	u32 pres;
 	struct clk_programmable *prog = to_clk_programmable(hw);
-	struct at91_pmc *pmc = prog->pmc;
-	const struct clk_programmable_layout *layout = prog->layout;
+	unsigned int pckr;
 
-	pres = (pmc_read(pmc, AT91_PMC_PCKR(prog->id)) >> layout->pres_shift) &
-	       PROG_PRES_MASK;
-	return parent_rate >> pres;
+	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
+
+	return parent_rate >> PROG_PRES(prog->layout, pckr);
 }
 
 static int clk_programmable_determine_rate(struct clk_hw *hw,
@@ -101,36 +98,36 @@ static int clk_programmable_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_programmable *prog = to_clk_programmable(hw);
 	const struct clk_programmable_layout *layout = prog->layout;
-	struct at91_pmc *pmc = prog->pmc;
-	u32 tmp = pmc_read(pmc, AT91_PMC_PCKR(prog->id)) & ~layout->css_mask;
+	unsigned int mask = layout->css_mask;
+	unsigned int pckr = 0;
 
 	if (layout->have_slck_mck)
-		tmp &= AT91_PMC_CSSMCK_MCK;
+		mask |= AT91_PMC_CSSMCK_MCK;
 
 	if (index > layout->css_mask) {
-		if (index > PROG_MAX_RM9200_CSS && layout->have_slck_mck) {
-			tmp |= AT91_PMC_CSSMCK_MCK;
-			return 0;
-		} else {
+		if (index > PROG_MAX_RM9200_CSS && !layout->have_slck_mck)
 			return -EINVAL;
-		}
+
+		pckr |= AT91_PMC_CSSMCK_MCK;
 	}
 
-	pmc_write(pmc, AT91_PMC_PCKR(prog->id), tmp | index);
+	regmap_update_bits(prog->regmap, AT91_PMC_PCKR(prog->id), mask, pckr);
+
 	return 0;
 }
 
 static u8 clk_programmable_get_parent(struct clk_hw *hw)
 {
-	u32 tmp;
-	u8 ret;
 	struct clk_programmable *prog = to_clk_programmable(hw);
-	struct at91_pmc *pmc = prog->pmc;
 	const struct clk_programmable_layout *layout = prog->layout;
+	unsigned int pckr;
+	u8 ret;
 
-	tmp = pmc_read(pmc, AT91_PMC_PCKR(prog->id));
-	ret = tmp & layout->css_mask;
-	if (layout->have_slck_mck && (tmp & AT91_PMC_CSSMCK_MCK) && !ret)
+	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
+
+	ret = pckr & layout->css_mask;
+
+	if (layout->have_slck_mck && (pckr & AT91_PMC_CSSMCK_MCK) && !ret)
 		ret = PROG_MAX_RM9200_CSS + 1;
 
 	return ret;
@@ -140,26 +137,27 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct clk_programmable *prog = to_clk_programmable(hw);
-	struct at91_pmc *pmc = prog->pmc;
 	const struct clk_programmable_layout *layout = prog->layout;
 	unsigned long div = parent_rate / rate;
+	unsigned int pckr;
 	int shift = 0;
-	u32 tmp = pmc_read(pmc, AT91_PMC_PCKR(prog->id)) &
-		  ~(PROG_PRES_MASK << layout->pres_shift);
+
+	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
 
 	if (!div)
 		return -EINVAL;
 
 	shift = fls(div) - 1;
 
-	if (div != (1<<shift))
+	if (div != (1 << shift))
 		return -EINVAL;
 
 	if (shift >= PROG_PRES_MASK)
 		return -EINVAL;
 
-	pmc_write(pmc, AT91_PMC_PCKR(prog->id),
-		  tmp | (shift << layout->pres_shift));
+	regmap_update_bits(prog->regmap, AT91_PMC_PCKR(prog->id),
+			   PROG_PRES_MASK << layout->pres_shift,
+			   shift << layout->pres_shift);
 
 	return 0;
 }
@@ -173,7 +171,7 @@ static const struct clk_ops programmable_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_programmable(struct at91_pmc *pmc,
+at91_clk_register_programmable(struct regmap *regmap,
 			       const char *name, const char **parent_names,
 			       u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout)
@@ -198,7 +196,7 @@ at91_clk_register_programmable(struct at91_pmc *pmc,
 	prog->id = id;
 	prog->layout = layout;
 	prog->hw.init = &init;
-	prog->pmc = pmc;
+	prog->regmap = regmap;
 
 	clk = clk_register(NULL, &prog->hw);
 	if (IS_ERR(clk))
@@ -226,7 +224,7 @@ static const struct clk_programmable_layout at91sam9x5_programmable_layout = {
 };
 
 static void __init
-of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
+of_at91_clk_prog_setup(struct device_node *np,
 		       const struct clk_programmable_layout *layout)
 {
 	int num;
@@ -236,6 +234,7 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 	const char *parent_names[PROG_SOURCE_MAX];
 	const char *name;
 	struct device_node *progclknp;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > PROG_SOURCE_MAX)
@@ -247,6 +246,10 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 	if (!num || num > (PROG_ID_MAX + 1))
 		return;
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	for_each_child_of_node(np, progclknp) {
 		if (of_property_read_u32(progclknp, "reg", &id))
 			continue;
@@ -254,7 +257,7 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 		if (of_property_read_string(np, "clock-output-names", &name))
 			name = progclknp->name;
 
-		clk = at91_clk_register_programmable(pmc, name,
+		clk = at91_clk_register_programmable(regmap, name,
 						     parent_names, num_parents,
 						     id, layout);
 		if (IS_ERR(clk))
@@ -265,20 +268,23 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 }
 
 
-void __init of_at91rm9200_clk_prog_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, pmc, &at91rm9200_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91rm9200_programmable_layout);
 }
+CLK_OF_DECLARE(at91rm9200_clk_prog, "atmel,at91rm9200-clk-programmable",
+	       of_at91rm9200_clk_prog_setup);
 
-void __init of_at91sam9g45_clk_prog_setup(struct device_node *np,
-					  struct at91_pmc *pmc)
+static void __init of_at91sam9g45_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, pmc, &at91sam9g45_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91sam9g45_programmable_layout);
 }
+CLK_OF_DECLARE(at91sam9g45_clk_prog, "atmel,at91sam9g45-clk-programmable",
+	       of_at91sam9g45_clk_prog_setup);
 
-void __init of_at91sam9x5_clk_prog_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, pmc, &at91sam9x5_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91sam9x5_programmable_layout);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_prog, "atmel,at91sam9x5-clk-programmable",
+	       of_at91sam9x5_clk_prog_setup);
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index d0d5076a9b94..221c09684ba3 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -13,17 +13,11 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
-#include <linux/slab.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 #include "sckc.h"
@@ -59,7 +53,7 @@ struct clk_slow_rc_osc {
 
 struct clk_sam9260_slow {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 #define to_clk_sam9260_slow(hw) container_of(hw, struct clk_sam9260_slow, hw)
@@ -393,8 +387,11 @@ void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
 static u8 clk_sam9260_slow_get_parent(struct clk_hw *hw)
 {
 	struct clk_sam9260_slow *slowck = to_clk_sam9260_slow(hw);
+	unsigned int status;
 
-	return !!(pmc_read(slowck->pmc, AT91_PMC_SR) & AT91_PMC_OSCSEL);
+	regmap_read(slowck->regmap, AT91_PMC_SR, &status);
+
+	return status & AT91_PMC_OSCSEL ? 1 : 0;
 }
 
 static const struct clk_ops sam9260_slow_ops = {
@@ -402,7 +399,7 @@ static const struct clk_ops sam9260_slow_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
+at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
 			       int num_parents)
@@ -411,7 +408,7 @@ at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 
-	if (!pmc || !name)
+	if (!name)
 		return ERR_PTR(-EINVAL);
 
 	if (!parent_names || !num_parents)
@@ -428,7 +425,7 @@ at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 	init.flags = 0;
 
 	slowck->hw.init = &init;
-	slowck->pmc = pmc;
+	slowck->regmap = regmap;
 
 	clk = clk_register(NULL, &slowck->hw);
 	if (IS_ERR(clk))
@@ -439,29 +436,34 @@ at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 	return clk;
 }
 
-void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
-					  struct at91_pmc *pmc)
+static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_names[2];
 	int num_parents;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents != 2)
 		return;
 
 	of_clk_parent_fill(np, parent_names, num_parents);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_sam9260_slow(pmc, name, parent_names,
+	clk = at91_clk_register_sam9260_slow(regmap, name, parent_names,
 					     num_parents);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9260_clk_slow, "atmel,at91sam9260-clk-slow",
+	       of_at91sam9260_clk_slow_setup);
 
 /*
  * FIXME: All slow clk users are not properly claiming it (get + prepare +
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index a7f8501cfa05..e6948a52005a 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -12,8 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -24,7 +24,7 @@
 
 struct at91sam9x5_clk_smd {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 #define to_at91sam9x5_clk_smd(hw) \
@@ -33,13 +33,13 @@ struct at91sam9x5_clk_smd {
 static unsigned long at91sam9x5_clk_smd_recalc_rate(struct clk_hw *hw,
 						    unsigned long parent_rate)
 {
-	u32 tmp;
-	u8 smddiv;
 	struct at91sam9x5_clk_smd *smd = to_at91sam9x5_clk_smd(hw);
-	struct at91_pmc *pmc = smd->pmc;
+	unsigned int smdr;
+	u8 smddiv;
+
+	regmap_read(smd->regmap, AT91_PMC_SMD, &smdr);
+	smddiv = (smdr & AT91_PMC_SMD_DIV) >> SMD_DIV_SHIFT;
 
-	tmp = pmc_read(pmc, AT91_PMC_SMD);
-	smddiv = (tmp & AT91_PMC_SMD_DIV) >> SMD_DIV_SHIFT;
 	return parent_rate / (smddiv + 1);
 }
 
@@ -67,40 +67,38 @@ static long at91sam9x5_clk_smd_round_rate(struct clk_hw *hw, unsigned long rate,
 
 static int at91sam9x5_clk_smd_set_parent(struct clk_hw *hw, u8 index)
 {
-	u32 tmp;
 	struct at91sam9x5_clk_smd *smd = to_at91sam9x5_clk_smd(hw);
-	struct at91_pmc *pmc = smd->pmc;
 
 	if (index > 1)
 		return -EINVAL;
-	tmp = pmc_read(pmc, AT91_PMC_SMD) & ~AT91_PMC_SMDS;
-	if (index)
-		tmp |= AT91_PMC_SMDS;
-	pmc_write(pmc, AT91_PMC_SMD, tmp);
+
+	regmap_update_bits(smd->regmap, AT91_PMC_SMD, AT91_PMC_SMDS,
+			   index ? AT91_PMC_SMDS : 0);
+
 	return 0;
 }
 
 static u8 at91sam9x5_clk_smd_get_parent(struct clk_hw *hw)
 {
 	struct at91sam9x5_clk_smd *smd = to_at91sam9x5_clk_smd(hw);
-	struct at91_pmc *pmc = smd->pmc;
+	unsigned int smdr;
 
-	return pmc_read(pmc, AT91_PMC_SMD) & AT91_PMC_SMDS;
+	regmap_read(smd->regmap, AT91_PMC_SMD, &smdr);
+
+	return smdr & AT91_PMC_SMDS;
 }
 
 static int at91sam9x5_clk_smd_set_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long parent_rate)
 {
-	u32 tmp;
 	struct at91sam9x5_clk_smd *smd = to_at91sam9x5_clk_smd(hw);
-	struct at91_pmc *pmc = smd->pmc;
 	unsigned long div = parent_rate / rate;
 
 	if (parent_rate % rate || div < 1 || div > (SMD_MAX_DIV + 1))
 		return -EINVAL;
-	tmp = pmc_read(pmc, AT91_PMC_SMD) & ~AT91_PMC_SMD_DIV;
-	tmp |= (div - 1) << SMD_DIV_SHIFT;
-	pmc_write(pmc, AT91_PMC_SMD, tmp);
+
+	regmap_update_bits(smd->regmap, AT91_PMC_SMD, AT91_PMC_SMD_DIV,
+			   (div - 1) << SMD_DIV_SHIFT);
 
 	return 0;
 }
@@ -114,7 +112,7 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 };
 
 static struct clk * __init
-at91sam9x5_clk_register_smd(struct at91_pmc *pmc, const char *name,
+at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_smd *smd;
@@ -132,7 +130,7 @@ at91sam9x5_clk_register_smd(struct at91_pmc *pmc, const char *name,
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 
 	smd->hw.init = &init;
-	smd->pmc = pmc;
+	smd->regmap = regmap;
 
 	clk = clk_register(NULL, &smd->hw);
 	if (IS_ERR(clk))
@@ -141,13 +139,13 @@ at91sam9x5_clk_register_smd(struct at91_pmc *pmc, const char *name,
 	return clk;
 }
 
-void __init of_at91sam9x5_clk_smd_setup(struct device_node *np,
-					struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 {
 	struct clk *clk;
 	int num_parents;
 	const char *parent_names[SMD_SOURCE_MAX];
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > SMD_SOURCE_MAX)
@@ -157,10 +155,16 @@ void __init of_at91sam9x5_clk_smd_setup(struct device_node *np,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91sam9x5_clk_register_smd(pmc, name, parent_names,
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	clk = at91sam9x5_clk_register_smd(regmap, name, parent_names,
 					  num_parents);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_smd, "atmel,at91sam9x5-clk-smd",
+	       of_at91sam9x5_clk_smd_setup);
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 3f5314344286..8f35d8172909 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -12,13 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of_irq.h>
-#include <linux/interrupt.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -29,9 +24,7 @@
 #define to_clk_system(hw) container_of(hw, struct clk_system, hw)
 struct clk_system {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 	u8 id;
 };
 
@@ -39,58 +32,54 @@ static inline int is_pck(int id)
 {
 	return (id >= 8) && (id <= 15);
 }
-static irqreturn_t clk_system_irq_handler(int irq, void *dev_id)
+
+static inline bool clk_system_ready(struct regmap *regmap, int id)
 {
-	struct clk_system *sys = (struct clk_system *)dev_id;
+	unsigned int status;
 
-	wake_up(&sys->wait);
-	disable_irq_nosync(sys->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & (1 << id) ? 1 : 0;
 }
 
 static int clk_system_prepare(struct clk_hw *hw)
 {
 	struct clk_system *sys = to_clk_system(hw);
-	struct at91_pmc *pmc = sys->pmc;
-	u32 mask = 1 << sys->id;
 
-	pmc_write(pmc, AT91_PMC_SCER, mask);
+	regmap_write(sys->regmap, AT91_PMC_SCER, 1 << sys->id);
 
 	if (!is_pck(sys->id))
 		return 0;
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & mask)) {
-		if (sys->irq) {
-			enable_irq(sys->irq);
-			wait_event(sys->wait,
-				   pmc_read(pmc, AT91_PMC_SR) & mask);
-		} else
-			cpu_relax();
-	}
+	while (!clk_system_ready(sys->regmap, sys->id))
+		cpu_relax();
+
 	return 0;
 }
 
 static void clk_system_unprepare(struct clk_hw *hw)
 {
 	struct clk_system *sys = to_clk_system(hw);
-	struct at91_pmc *pmc = sys->pmc;
 
-	pmc_write(pmc, AT91_PMC_SCDR, 1 << sys->id);
+	regmap_write(sys->regmap, AT91_PMC_SCDR, 1 << sys->id);
 }
 
 static int clk_system_is_prepared(struct clk_hw *hw)
 {
 	struct clk_system *sys = to_clk_system(hw);
-	struct at91_pmc *pmc = sys->pmc;
+	unsigned int status;
 
-	if (!(pmc_read(pmc, AT91_PMC_SCSR) & (1 << sys->id)))
+	regmap_read(sys->regmap, AT91_PMC_SCSR, &status);
+
+	if (!(status & (1 << sys->id)))
 		return 0;
 
 	if (!is_pck(sys->id))
 		return 1;
 
-	return !!(pmc_read(pmc, AT91_PMC_SR) & (1 << sys->id));
+	regmap_read(sys->regmap, AT91_PMC_SR, &status);
+
+	return status & (1 << sys->id) ? 1 : 0;
 }
 
 static const struct clk_ops system_ops = {
@@ -100,13 +89,12 @@ static const struct clk_ops system_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_system(struct at91_pmc *pmc, const char *name,
-			 const char *parent_name, u8 id, int irq)
+at91_clk_register_system(struct regmap *regmap, const char *name,
+			 const char *parent_name, u8 id)
 {
 	struct clk_system *sys;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
-	int ret;
 
 	if (!parent_name || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -123,44 +111,33 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
 
 	sys->id = id;
 	sys->hw.init = &init;
-	sys->pmc = pmc;
-	sys->irq = irq;
-	if (irq) {
-		init_waitqueue_head(&sys->wait);
-		irq_set_status_flags(sys->irq, IRQ_NOAUTOEN);
-		ret = request_irq(sys->irq, clk_system_irq_handler,
-				IRQF_TRIGGER_HIGH, name, sys);
-		if (ret) {
-			kfree(sys);
-			return ERR_PTR(ret);
-		}
-	}
+	sys->regmap = regmap;
 
 	clk = clk_register(NULL, &sys->hw);
-	if (IS_ERR(clk)) {
-		if (irq)
-			free_irq(sys->irq, sys);
+	if (IS_ERR(clk))
 		kfree(sys);
-	}
 
 	return clk;
 }
 
-static void __init
-of_at91_clk_sys_setup(struct device_node *np, struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 {
 	int num;
-	int irq = 0;
 	u32 id;
 	struct clk *clk;
 	const char *name;
 	struct device_node *sysclknp;
 	const char *parent_name;
+	struct regmap *regmap;
 
 	num = of_get_child_count(np);
 	if (num > (SYSTEM_MAX_ID + 1))
 		return;
 
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
 	for_each_child_of_node(np, sysclknp) {
 		if (of_property_read_u32(sysclknp, "reg", &id))
 			continue;
@@ -168,21 +145,14 @@ of_at91_clk_sys_setup(struct device_node *np, struct at91_pmc *pmc)
 		if (of_property_read_string(np, "clock-output-names", &name))
 			name = sysclknp->name;
 
-		if (is_pck(id))
-			irq = irq_of_parse_and_map(sysclknp, 0);
-
 		parent_name = of_clk_get_parent_name(sysclknp, 0);
 
-		clk = at91_clk_register_system(pmc, name, parent_name, id, irq);
+		clk = at91_clk_register_system(regmap, name, parent_name, id);
 		if (IS_ERR(clk))
 			continue;
 
 		of_clk_add_provider(sysclknp, of_clk_src_simple_get, clk);
 	}
 }
-
-void __init of_at91rm9200_clk_sys_setup(struct device_node *np,
-					struct at91_pmc *pmc)
-{
-	of_at91_clk_sys_setup(np, pmc);
-}
+CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
+	       of_at91rm9200_clk_sys_setup);
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 8ab8502778a2..650ca45892c0 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -12,8 +12,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -27,7 +27,7 @@
 
 struct at91sam9x5_clk_usb {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 };
 
 #define to_at91sam9x5_clk_usb(hw) \
@@ -35,7 +35,7 @@ struct at91sam9x5_clk_usb {
 
 struct at91rm9200_clk_usb {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
+	struct regmap *regmap;
 	u32 divisors[4];
 };
 
@@ -45,13 +45,12 @@ struct at91rm9200_clk_usb {
 static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 						    unsigned long parent_rate)
 {
-	u32 tmp;
-	u8 usbdiv;
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
+	unsigned int usbr;
+	u8 usbdiv;
 
-	tmp = pmc_read(pmc, AT91_PMC_USB);
-	usbdiv = (tmp & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
+	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
+	usbdiv = (usbr & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
 
 	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
 }
@@ -109,33 +108,31 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 
 static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
 {
-	u32 tmp;
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
 
 	if (index > 1)
 		return -EINVAL;
-	tmp = pmc_read(pmc, AT91_PMC_USB) & ~AT91_PMC_USBS;
-	if (index)
-		tmp |= AT91_PMC_USBS;
-	pmc_write(pmc, AT91_PMC_USB, tmp);
+
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_USBS,
+			   index ? AT91_PMC_USBS : 0);
+
 	return 0;
 }
 
 static u8 at91sam9x5_clk_usb_get_parent(struct clk_hw *hw)
 {
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
+	unsigned int usbr;
 
-	return pmc_read(pmc, AT91_PMC_USB) & AT91_PMC_USBS;
+	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
+
+	return usbr & AT91_PMC_USBS;
 }
 
 static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long parent_rate)
 {
-	u32 tmp;
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
 	unsigned long div;
 
 	if (!rate)
@@ -145,9 +142,8 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (div > SAM9X5_USB_MAX_DIV + 1 || !div)
 		return -EINVAL;
 
-	tmp = pmc_read(pmc, AT91_PMC_USB) & ~AT91_PMC_OHCIUSBDIV;
-	tmp |= (div - 1) << SAM9X5_USB_DIV_SHIFT;
-	pmc_write(pmc, AT91_PMC_USB, tmp);
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_OHCIUSBDIV,
+			   (div - 1) << SAM9X5_USB_DIV_SHIFT);
 
 	return 0;
 }
@@ -163,28 +159,28 @@ static const struct clk_ops at91sam9x5_usb_ops = {
 static int at91sam9n12_clk_usb_enable(struct clk_hw *hw)
 {
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
 
-	pmc_write(pmc, AT91_PMC_USB,
-		  pmc_read(pmc, AT91_PMC_USB) | AT91_PMC_USBS);
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_USBS,
+			   AT91_PMC_USBS);
+
 	return 0;
 }
 
 static void at91sam9n12_clk_usb_disable(struct clk_hw *hw)
 {
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
 
-	pmc_write(pmc, AT91_PMC_USB,
-		  pmc_read(pmc, AT91_PMC_USB) & ~AT91_PMC_USBS);
+	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_USBS, 0);
 }
 
 static int at91sam9n12_clk_usb_is_enabled(struct clk_hw *hw)
 {
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
+	unsigned int usbr;
 
-	return !!(pmc_read(pmc, AT91_PMC_USB) & AT91_PMC_USBS);
+	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
+
+	return usbr & AT91_PMC_USBS;
 }
 
 static const struct clk_ops at91sam9n12_usb_ops = {
@@ -197,7 +193,7 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 };
 
 static struct clk * __init
-at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
+at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_usb *usb;
@@ -216,7 +212,7 @@ at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
 		     CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
-	usb->pmc = pmc;
+	usb->regmap = regmap;
 
 	clk = clk_register(NULL, &usb->hw);
 	if (IS_ERR(clk))
@@ -226,7 +222,7 @@ at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
 }
 
 static struct clk * __init
-at91sam9n12_clk_register_usb(struct at91_pmc *pmc, const char *name,
+at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
 {
 	struct at91sam9x5_clk_usb *usb;
@@ -244,7 +240,7 @@ at91sam9n12_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
-	usb->pmc = pmc;
+	usb->regmap = regmap;
 
 	clk = clk_register(NULL, &usb->hw);
 	if (IS_ERR(clk))
@@ -257,12 +253,12 @@ static unsigned long at91rm9200_clk_usb_recalc_rate(struct clk_hw *hw,
 						    unsigned long parent_rate)
 {
 	struct at91rm9200_clk_usb *usb = to_at91rm9200_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
-	u32 tmp;
+	unsigned int pllbr;
 	u8 usbdiv;
 
-	tmp = pmc_read(pmc, AT91_CKGR_PLLBR);
-	usbdiv = (tmp & AT91_PMC_USBDIV) >> RM9200_USB_DIV_SHIFT;
+	regmap_read(usb->regmap, AT91_CKGR_PLLBR, &pllbr);
+
+	usbdiv = (pllbr & AT91_PMC_USBDIV) >> RM9200_USB_DIV_SHIFT;
 	if (usb->divisors[usbdiv])
 		return parent_rate / usb->divisors[usbdiv];
 
@@ -310,10 +306,8 @@ static long at91rm9200_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
 static int at91rm9200_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long parent_rate)
 {
-	u32 tmp;
 	int i;
 	struct at91rm9200_clk_usb *usb = to_at91rm9200_clk_usb(hw);
-	struct at91_pmc *pmc = usb->pmc;
 	unsigned long div;
 
 	if (!rate)
@@ -323,10 +317,10 @@ static int at91rm9200_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	for (i = 0; i < RM9200_USB_DIV_TAB_SIZE; i++) {
 		if (usb->divisors[i] == div) {
-			tmp = pmc_read(pmc, AT91_CKGR_PLLBR) &
-			      ~AT91_PMC_USBDIV;
-			tmp |= i << RM9200_USB_DIV_SHIFT;
-			pmc_write(pmc, AT91_CKGR_PLLBR, tmp);
+			regmap_update_bits(usb->regmap, AT91_CKGR_PLLBR,
+					   AT91_PMC_USBDIV,
+					   i << RM9200_USB_DIV_SHIFT);
+
 			return 0;
 		}
 	}
@@ -341,7 +335,7 @@ static const struct clk_ops at91rm9200_usb_ops = {
 };
 
 static struct clk * __init
-at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
+at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
@@ -359,7 +353,7 @@ at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	init.flags = CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
-	usb->pmc = pmc;
+	usb->regmap = regmap;
 	memcpy(usb->divisors, divisors, sizeof(usb->divisors));
 
 	clk = clk_register(NULL, &usb->hw);
@@ -369,13 +363,13 @@ at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	return clk;
 }
 
-void __init of_at91sam9x5_clk_usb_setup(struct device_node *np,
-					struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 {
 	struct clk *clk;
 	int num_parents;
 	const char *parent_names[USB_SOURCE_MAX];
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > USB_SOURCE_MAX)
@@ -385,19 +379,26 @@ void __init of_at91sam9x5_clk_usb_setup(struct device_node *np,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91sam9x5_clk_register_usb(pmc, name, parent_names, num_parents);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	clk = at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					  num_parents);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9x5_clk_usb, "atmel,at91sam9x5-clk-usb",
+	       of_at91sam9x5_clk_usb_setup);
 
-void __init of_at91sam9n12_clk_usb_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
+static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -405,20 +406,26 @@ void __init of_at91sam9n12_clk_usb_setup(struct device_node *np,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91sam9n12_clk_register_usb(pmc, name, parent_name);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	clk = at91sam9n12_clk_register_usb(regmap, name, parent_name);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91sam9n12_clk_usb, "atmel,at91sam9n12-clk-usb",
+	       of_at91sam9n12_clk_usb_setup);
 
-void __init of_at91rm9200_clk_usb_setup(struct device_node *np,
-					struct at91_pmc *pmc)
+static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 {
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
 	u32 divisors[4] = {0, 0, 0, 0};
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -430,9 +437,15 @@ void __init of_at91rm9200_clk_usb_setup(struct device_node *np,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91rm9200_clk_register_usb(pmc, name, parent_name, divisors);
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	clk = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(at91rm9200_clk_usb, "atmel,at91rm9200-clk-usb",
+	       of_at91rm9200_clk_usb_setup);
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index ca561e90a60f..61fcf399e58c 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -11,14 +11,9 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pmc.h"
 
@@ -26,37 +21,30 @@
 
 struct clk_utmi {
 	struct clk_hw hw;
-	struct at91_pmc *pmc;
-	unsigned int irq;
-	wait_queue_head_t wait;
+	struct regmap *regmap;
 };
 
 #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
 
-static irqreturn_t clk_utmi_irq_handler(int irq, void *dev_id)
+static inline bool clk_utmi_ready(struct regmap *regmap)
 {
-	struct clk_utmi *utmi = (struct clk_utmi *)dev_id;
+	unsigned int status;
 
-	wake_up(&utmi->wait);
-	disable_irq_nosync(utmi->irq);
+	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return IRQ_HANDLED;
+	return status & AT91_PMC_LOCKU;
 }
 
 static int clk_utmi_prepare(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
-	struct at91_pmc *pmc = utmi->pmc;
-	u32 tmp = pmc_read(pmc, AT91_CKGR_UCKR) | AT91_PMC_UPLLEN |
-		  AT91_PMC_UPLLCOUNT | AT91_PMC_BIASEN;
+	unsigned int uckr = AT91_PMC_UPLLEN | AT91_PMC_UPLLCOUNT |
+			    AT91_PMC_BIASEN;
 
-	pmc_write(pmc, AT91_CKGR_UCKR, tmp);
+	regmap_update_bits(utmi->regmap, AT91_CKGR_UCKR, uckr, uckr);
 
-	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_LOCKU)) {
-		enable_irq(utmi->irq);
-		wait_event(utmi->wait,
-			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_LOCKU);
-	}
+	while (!clk_utmi_ready(utmi->regmap))
+		cpu_relax();
 
 	return 0;
 }
@@ -64,18 +52,15 @@ static int clk_utmi_prepare(struct clk_hw *hw)
 static int clk_utmi_is_prepared(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
-	struct at91_pmc *pmc = utmi->pmc;
 
-	return !!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_LOCKU);
+	return clk_utmi_ready(utmi->regmap);
 }
 
 static void clk_utmi_unprepare(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
-	struct at91_pmc *pmc = utmi->pmc;
-	u32 tmp = pmc_read(pmc, AT91_CKGR_UCKR) & ~AT91_PMC_UPLLEN;
 
-	pmc_write(pmc, AT91_CKGR_UCKR, tmp);
+	regmap_update_bits(utmi->regmap, AT91_CKGR_UCKR, AT91_PMC_UPLLEN, 0);
 }
 
 static unsigned long clk_utmi_recalc_rate(struct clk_hw *hw,
@@ -93,10 +78,9 @@ static const struct clk_ops utmi_ops = {
 };
 
 static struct clk * __init
-at91_clk_register_utmi(struct at91_pmc *pmc, unsigned int irq,
+at91_clk_register_utmi(struct regmap *regmap,
 		       const char *name, const char *parent_name)
 {
-	int ret;
 	struct clk_utmi *utmi;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -112,52 +96,36 @@ at91_clk_register_utmi(struct at91_pmc *pmc, unsigned int irq,
 	init.flags = CLK_SET_RATE_GATE;
 
 	utmi->hw.init = &init;
-	utmi->pmc = pmc;
-	utmi->irq = irq;
-	init_waitqueue_head(&utmi->wait);
-	irq_set_status_flags(utmi->irq, IRQ_NOAUTOEN);
-	ret = request_irq(utmi->irq, clk_utmi_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-utmi", utmi);
-	if (ret) {
-		kfree(utmi);
-		return ERR_PTR(ret);
-	}
+	utmi->regmap = regmap;
 
 	clk = clk_register(NULL, &utmi->hw);
-	if (IS_ERR(clk)) {
-		free_irq(utmi->irq, utmi);
+	if (IS_ERR(clk))
 		kfree(utmi);
-	}
 
 	return clk;
 }
 
-static void __init
-of_at91_clk_utmi_setup(struct device_node *np, struct at91_pmc *pmc)
+static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 {
-	unsigned int irq;
 	struct clk *clk;
 	const char *parent_name;
 	const char *name = np->name;
+	struct regmap *regmap;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_utmi(pmc, irq, name, parent_name);
+	clk = at91_clk_register_utmi(regmap, name, parent_name);
 	if (IS_ERR(clk))
 		return;
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 	return;
 }
-
-void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np,
-					 struct at91_pmc *pmc)
-{
-	of_at91_clk_utmi_setup(np, pmc);
-}
+CLK_OF_DECLARE(at91sam9x5_clk_utmi, "atmel,at91sam9x5-clk-utmi",
+	       of_at91sam9x5_clk_utmi_setup);
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 8476b570779b..526df5ba042d 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -12,36 +12,13 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <asm/proc-fns.h>
 
 #include "pmc.h"
 
-void __iomem *at91_pmc_base;
-EXPORT_SYMBOL_GPL(at91_pmc_base);
-
-void at91rm9200_idle(void)
-{
-	/*
-	 * Disable the processor clock.  The processor will be automatically
-	 * re-enabled by an interrupt or by a reset.
-	 */
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-}
-
-void at91sam9_idle(void)
-{
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
 {
@@ -64,402 +41,3 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
-
-static void pmc_irq_mask(struct irq_data *d)
-{
-	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
-
-	pmc_write(pmc, AT91_PMC_IDR, 1 << d->hwirq);
-}
-
-static void pmc_irq_unmask(struct irq_data *d)
-{
-	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
-
-	pmc_write(pmc, AT91_PMC_IER, 1 << d->hwirq);
-}
-
-static int pmc_irq_set_type(struct irq_data *d, unsigned type)
-{
-	if (type != IRQ_TYPE_LEVEL_HIGH) {
-		pr_warn("PMC: type not supported (support only IRQ_TYPE_LEVEL_HIGH type)\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void pmc_irq_suspend(struct irq_data *d)
-{
-	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
-
-	pmc->imr = pmc_read(pmc, AT91_PMC_IMR);
-	pmc_write(pmc, AT91_PMC_IDR, pmc->imr);
-}
-
-static void pmc_irq_resume(struct irq_data *d)
-{
-	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
-
-	pmc_write(pmc, AT91_PMC_IER, pmc->imr);
-}
-
-static struct irq_chip pmc_irq = {
-	.name = "PMC",
-	.irq_disable = pmc_irq_mask,
-	.irq_mask = pmc_irq_mask,
-	.irq_unmask = pmc_irq_unmask,
-	.irq_set_type = pmc_irq_set_type,
-	.irq_suspend = pmc_irq_suspend,
-	.irq_resume = pmc_irq_resume,
-};
-
-static struct lock_class_key pmc_lock_class;
-
-static int pmc_irq_map(struct irq_domain *h, unsigned int virq,
-		       irq_hw_number_t hw)
-{
-	struct at91_pmc	*pmc = h->host_data;
-
-	irq_set_lockdep_class(virq, &pmc_lock_class);
-
-	irq_set_chip_and_handler(virq, &pmc_irq,
-				 handle_level_irq);
-	irq_set_chip_data(virq, pmc);
-
-	return 0;
-}
-
-static int pmc_irq_domain_xlate(struct irq_domain *d,
-				struct device_node *ctrlr,
-				const u32 *intspec, unsigned int intsize,
-				irq_hw_number_t *out_hwirq,
-				unsigned int *out_type)
-{
-	struct at91_pmc *pmc = d->host_data;
-	const struct at91_pmc_caps *caps = pmc->caps;
-
-	if (WARN_ON(intsize < 1))
-		return -EINVAL;
-
-	*out_hwirq = intspec[0];
-
-	if (!(caps->available_irqs & (1 << *out_hwirq)))
-		return -EINVAL;
-
-	*out_type = IRQ_TYPE_LEVEL_HIGH;
-
-	return 0;
-}
-
-static const struct irq_domain_ops pmc_irq_ops = {
-	.map	= pmc_irq_map,
-	.xlate	= pmc_irq_domain_xlate,
-};
-
-static irqreturn_t pmc_irq_handler(int irq, void *data)
-{
-	struct at91_pmc *pmc = (struct at91_pmc *)data;
-	unsigned long sr;
-	int n;
-
-	sr = pmc_read(pmc, AT91_PMC_SR) & pmc_read(pmc, AT91_PMC_IMR);
-	if (!sr)
-		return IRQ_NONE;
-
-	for_each_set_bit(n, &sr, BITS_PER_LONG)
-		generic_handle_irq(irq_find_mapping(pmc->irqdomain, n));
-
-	return IRQ_HANDLED;
-}
-
-static const struct at91_pmc_caps at91rm9200_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_LOCKB |
-			  AT91_PMC_MCKRDY | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY | AT91_PMC_PCK2RDY |
-			  AT91_PMC_PCK3RDY,
-};
-
-static const struct at91_pmc_caps at91sam9260_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_LOCKB |
-			  AT91_PMC_MCKRDY | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY,
-};
-
-static const struct at91_pmc_caps at91sam9g45_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
-			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY,
-};
-
-static const struct at91_pmc_caps at91sam9n12_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_LOCKB |
-			  AT91_PMC_MCKRDY | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY | AT91_PMC_MOSCSELS |
-			  AT91_PMC_MOSCRCS | AT91_PMC_CFDEV,
-};
-
-static const struct at91_pmc_caps at91sam9x5_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
-			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY | AT91_PMC_MOSCSELS |
-			  AT91_PMC_MOSCRCS | AT91_PMC_CFDEV,
-};
-
-static const struct at91_pmc_caps sama5d2_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
-			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY | AT91_PMC_PCK2RDY |
-			  AT91_PMC_MOSCSELS | AT91_PMC_MOSCRCS |
-			  AT91_PMC_CFDEV | AT91_PMC_GCKRDY,
-};
-
-static const struct at91_pmc_caps sama5d3_caps = {
-	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
-			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
-			  AT91_PMC_PCK1RDY | AT91_PMC_PCK2RDY |
-			  AT91_PMC_MOSCSELS | AT91_PMC_MOSCRCS |
-			  AT91_PMC_CFDEV,
-};
-
-static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
-					     void __iomem *regbase, int virq,
-					     const struct at91_pmc_caps *caps)
-{
-	struct at91_pmc *pmc;
-
-	if (!regbase || !virq ||  !caps)
-		return NULL;
-
-	at91_pmc_base = regbase;
-
-	pmc = kzalloc(sizeof(*pmc), GFP_KERNEL);
-	if (!pmc)
-		return NULL;
-
-	spin_lock_init(&pmc->lock);
-	pmc->regbase = regbase;
-	pmc->virq = virq;
-	pmc->caps = caps;
-
-	pmc->irqdomain = irq_domain_add_linear(np, 32, &pmc_irq_ops, pmc);
-
-	if (!pmc->irqdomain)
-		goto out_free_pmc;
-
-	pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
-	if (request_irq(pmc->virq, pmc_irq_handler,
-			IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
-		goto out_remove_irqdomain;
-
-	return pmc;
-
-out_remove_irqdomain:
-	irq_domain_remove(pmc->irqdomain);
-out_free_pmc:
-	kfree(pmc);
-
-	return NULL;
-}
-
-static const struct of_device_id pmc_clk_ids[] __initconst = {
-	/* Slow oscillator */
-	{
-		.compatible = "atmel,at91sam9260-clk-slow",
-		.data = of_at91sam9260_clk_slow_setup,
-	},
-	/* Main clock */
-	{
-		.compatible = "atmel,at91rm9200-clk-main-osc",
-		.data = of_at91rm9200_clk_main_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-main-rc-osc",
-		.data = of_at91sam9x5_clk_main_rc_osc_setup,
-	},
-	{
-		.compatible = "atmel,at91rm9200-clk-main",
-		.data = of_at91rm9200_clk_main_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-main",
-		.data = of_at91sam9x5_clk_main_setup,
-	},
-	/* PLL clocks */
-	{
-		.compatible = "atmel,at91rm9200-clk-pll",
-		.data = of_at91rm9200_clk_pll_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9g45-clk-pll",
-		.data = of_at91sam9g45_clk_pll_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9g20-clk-pllb",
-		.data = of_at91sam9g20_clk_pllb_setup,
-	},
-	{
-		.compatible = "atmel,sama5d3-clk-pll",
-		.data = of_sama5d3_clk_pll_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-plldiv",
-		.data = of_at91sam9x5_clk_plldiv_setup,
-	},
-	/* Master clock */
-	{
-		.compatible = "atmel,at91rm9200-clk-master",
-		.data = of_at91rm9200_clk_master_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-master",
-		.data = of_at91sam9x5_clk_master_setup,
-	},
-	/* System clocks */
-	{
-		.compatible = "atmel,at91rm9200-clk-system",
-		.data = of_at91rm9200_clk_sys_setup,
-	},
-	/* Peripheral clocks */
-	{
-		.compatible = "atmel,at91rm9200-clk-peripheral",
-		.data = of_at91rm9200_clk_periph_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-peripheral",
-		.data = of_at91sam9x5_clk_periph_setup,
-	},
-	/* Programmable clocks */
-	{
-		.compatible = "atmel,at91rm9200-clk-programmable",
-		.data = of_at91rm9200_clk_prog_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9g45-clk-programmable",
-		.data = of_at91sam9g45_clk_prog_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-programmable",
-		.data = of_at91sam9x5_clk_prog_setup,
-	},
-	/* UTMI clock */
-#if defined(CONFIG_HAVE_AT91_UTMI)
-	{
-		.compatible = "atmel,at91sam9x5-clk-utmi",
-		.data = of_at91sam9x5_clk_utmi_setup,
-	},
-#endif
-	/* USB clock */
-#if defined(CONFIG_HAVE_AT91_USB_CLK)
-	{
-		.compatible = "atmel,at91rm9200-clk-usb",
-		.data = of_at91rm9200_clk_usb_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9x5-clk-usb",
-		.data = of_at91sam9x5_clk_usb_setup,
-	},
-	{
-		.compatible = "atmel,at91sam9n12-clk-usb",
-		.data = of_at91sam9n12_clk_usb_setup,
-	},
-#endif
-	/* SMD clock */
-#if defined(CONFIG_HAVE_AT91_SMD)
-	{
-		.compatible = "atmel,at91sam9x5-clk-smd",
-		.data = of_at91sam9x5_clk_smd_setup,
-	},
-#endif
-#if defined(CONFIG_HAVE_AT91_H32MX)
-	{
-		.compatible = "atmel,sama5d4-clk-h32mx",
-		.data = of_sama5d4_clk_h32mx_setup,
-	},
-#endif
-#if defined(CONFIG_HAVE_AT91_GENERATED_CLK)
-	{
-		.compatible = "atmel,sama5d2-clk-generated",
-		.data = of_sama5d2_clk_generated_setup,
-	},
-#endif
-	{ /*sentinel*/ }
-};
-
-static void __init of_at91_pmc_setup(struct device_node *np,
-				     const struct at91_pmc_caps *caps)
-{
-	struct at91_pmc *pmc;
-	struct device_node *childnp;
-	void (*clk_setup)(struct device_node *, struct at91_pmc *);
-	const struct of_device_id *clk_id;
-	void __iomem *regbase = of_iomap(np, 0);
-	int virq;
-
-	if (!regbase)
-		return;
-
-	virq = irq_of_parse_and_map(np, 0);
-	if (!virq)
-		return;
-
-	pmc = at91_pmc_init(np, regbase, virq, caps);
-	if (!pmc)
-		return;
-	for_each_child_of_node(np, childnp) {
-		clk_id = of_match_node(pmc_clk_ids, childnp);
-		if (!clk_id)
-			continue;
-		clk_setup = clk_id->data;
-		clk_setup(childnp, pmc);
-	}
-}
-
-static void __init of_at91rm9200_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91rm9200_caps);
-}
-CLK_OF_DECLARE(at91rm9200_clk_pmc, "atmel,at91rm9200-pmc",
-	       of_at91rm9200_pmc_setup);
-
-static void __init of_at91sam9260_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9260_caps);
-}
-CLK_OF_DECLARE(at91sam9260_clk_pmc, "atmel,at91sam9260-pmc",
-	       of_at91sam9260_pmc_setup);
-
-static void __init of_at91sam9g45_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9g45_caps);
-}
-CLK_OF_DECLARE(at91sam9g45_clk_pmc, "atmel,at91sam9g45-pmc",
-	       of_at91sam9g45_pmc_setup);
-
-static void __init of_at91sam9n12_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9n12_caps);
-}
-CLK_OF_DECLARE(at91sam9n12_clk_pmc, "atmel,at91sam9n12-pmc",
-	       of_at91sam9n12_pmc_setup);
-
-static void __init of_at91sam9x5_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &at91sam9x5_caps);
-}
-CLK_OF_DECLARE(at91sam9x5_clk_pmc, "atmel,at91sam9x5-pmc",
-	       of_at91sam9x5_pmc_setup);
-
-static void __init of_sama5d2_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &sama5d2_caps);
-}
-CLK_OF_DECLARE(sama5d2_clk_pmc, "atmel,sama5d2-pmc",
-	       of_sama5d2_pmc_setup);
-
-static void __init of_sama5d3_pmc_setup(struct device_node *np)
-{
-	of_at91_pmc_setup(np, &sama5d3_caps);
-}
-CLK_OF_DECLARE(sama5d3_clk_pmc, "atmel,sama5d3-pmc",
-	       of_sama5d3_pmc_setup);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index f65739272779..5771fff0ee3f 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -14,8 +14,11 @@
 
 #include <linux/io.h>
 #include <linux/irqdomain.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 
+extern spinlock_t pmc_pcr_lock;
+
 struct clk_range {
 	unsigned long min;
 	unsigned long max;
@@ -23,102 +26,7 @@ struct clk_range {
 
 #define CLK_RANGE(MIN, MAX) {.min = MIN, .max = MAX,}
 
-struct at91_pmc_caps {
-	u32 available_irqs;
-};
-
-struct at91_pmc {
-	void __iomem *regbase;
-	int virq;
-	spinlock_t lock;
-	const struct at91_pmc_caps *caps;
-	struct irq_domain *irqdomain;
-	u32 imr;
-};
-
-static inline void pmc_lock(struct at91_pmc *pmc)
-{
-	spin_lock(&pmc->lock);
-}
-
-static inline void pmc_unlock(struct at91_pmc *pmc)
-{
-	spin_unlock(&pmc->lock);
-}
-
-static inline u32 pmc_read(struct at91_pmc *pmc, int offset)
-{
-	return readl(pmc->regbase + offset);
-}
-
-static inline void pmc_write(struct at91_pmc *pmc, int offset, u32 value)
-{
-	writel(value, pmc->regbase + offset);
-}
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
-void of_at91sam9260_clk_slow_setup(struct device_node *np,
-				   struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_main_osc_setup(struct device_node *np,
-				      struct at91_pmc *pmc);
-void of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np,
-					 struct at91_pmc *pmc);
-void of_at91rm9200_clk_main_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-void of_at91sam9x5_clk_main_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_pll_setup(struct device_node *np,
-				 struct at91_pmc *pmc);
-void of_at91sam9g45_clk_pll_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-void of_at91sam9g20_clk_pllb_setup(struct device_node *np,
-				   struct at91_pmc *pmc);
-void of_sama5d3_clk_pll_setup(struct device_node *np,
-			      struct at91_pmc *pmc);
-void of_at91sam9x5_clk_plldiv_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_master_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-void of_at91sam9x5_clk_master_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_sys_setup(struct device_node *np,
-				 struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_periph_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-void of_at91sam9x5_clk_periph_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_prog_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-void of_at91sam9g45_clk_prog_setup(struct device_node *np,
-				   struct at91_pmc *pmc);
-void of_at91sam9x5_clk_prog_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-
-void of_at91sam9x5_clk_utmi_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-
-void of_at91rm9200_clk_usb_setup(struct device_node *np,
-				 struct at91_pmc *pmc);
-void of_at91sam9x5_clk_usb_setup(struct device_node *np,
-				 struct at91_pmc *pmc);
-void of_at91sam9n12_clk_usb_setup(struct device_node *np,
-				  struct at91_pmc *pmc);
-
-void of_at91sam9x5_clk_smd_setup(struct device_node *np,
-				 struct at91_pmc *pmc);
-
-void of_sama5d4_clk_h32mx_setup(struct device_node *np,
-				struct at91_pmc *pmc);
-
-void of_sama5d2_clk_generated_setup(struct device_node *np,
-				    struct at91_pmc *pmc);
-
 #endif /* __PMC_H_ */
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 75249416185b..5b6f57f500b8 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -73,6 +73,7 @@ static struct clocksource clksrc = {
 struct tc_clkevt_device {
 	struct clock_event_device	clkevt;
 	struct clk			*clk;
+	bool				clk_enabled;
 	u32				freq;
 	void __iomem			*regs;
 };
@@ -84,6 +85,24 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
 
 static u32 timer_clock;
 
+static void tc_clk_disable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	clk_disable(tcd->clk);
+	tcd->clk_enabled = false;
+}
+
+static void tc_clk_enable(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	if (tcd->clk_enabled)
+		return;
+	clk_enable(tcd->clk);
+	tcd->clk_enabled = true;
+}
+
 static int tc_shutdown(struct clock_event_device *d)
 {
 	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
@@ -91,8 +110,14 @@ static int tc_shutdown(struct clock_event_device *d)
 
 	__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
 	__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+	return 0;
+}
+
+static int tc_shutdown_clk_off(struct clock_event_device *d)
+{
+	tc_shutdown(d);
 	if (!clockevent_state_detached(d))
-		clk_disable(tcd->clk);
+		tc_clk_disable(d);
 
 	return 0;
 }
@@ -105,7 +130,7 @@ static int tc_set_oneshot(struct clock_event_device *d)
 	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
 		tc_shutdown(d);
 
-	clk_enable(tcd->clk);
+	tc_clk_enable(d);
 
 	/* count up to RC, then irq and stop */
 	__raw_writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
@@ -127,7 +152,7 @@ static int tc_set_periodic(struct clock_event_device *d)
 	/* By not making the gentime core emulate periodic mode on top
 	 * of oneshot, we get lower overhead and improved accuracy.
 	 */
-	clk_enable(tcd->clk);
+	tc_clk_enable(d);
 
 	/* count up to RC, then irq and restart */
 	__raw_writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
@@ -165,7 +190,7 @@ static struct tc_clkevt_device clkevt = {
 		.rating			= 200,
 #endif
 		.set_next_event		= tc_next_event,
-		.set_state_shutdown	= tc_shutdown,
+		.set_state_shutdown	= tc_shutdown_clk_off,
 		.set_state_periodic	= tc_set_periodic,
 		.set_state_oneshot	= tc_set_oneshot,
 	},
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3ba63db4dce7..4d475284a20c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1405,7 +1405,7 @@ static void ffs_data_put(struct ffs_data *ffs)
 		pr_info("%s(): freeing\n", __func__);
 		ffs_data_clear(ffs);
 		BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
-		       swaitqueue_active(&ffs->ep0req_completion.wait));
+		       swait_active(&ffs->ep0req_completion.wait));
 		kfree(ffs->dev_name);
 		kfree(ffs);
 	}
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index f92f5aff0dd5..f9bba26e3655 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -17,7 +17,9 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
@@ -1888,20 +1890,15 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 #ifdef CONFIG_OF
 static void at91sam9rl_toggle_bias(struct usba_udc *udc, int is_on)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	if (is_on)
-		at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
-	else
-		at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   is_on ? AT91_PMC_BIASEN : 0);
 }
 
 static void at91sam9g45_pulse_bias(struct usba_udc *udc)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
-	at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN, 0);
+	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
+			   AT91_PMC_BIASEN);
 }
 
 static const struct usba_udc_errata at91sam9rl_errata = {
@@ -1938,6 +1935,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 
 	udc->errata = match->data;
+	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (udc->errata && IS_ERR(udc->pmc))
+		return ERR_CAST(udc->pmc);
 
 	udc->num_ep = 0;
 
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index ea448a344767..3e1c9d589dfa 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -354,6 +354,8 @@ struct usba_udc {
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_regs;
 #endif
+
+	struct regmap *pmc;
 };
 
 static inline struct usba_ep *to_usba_ep(struct usb_ep *ep)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2366b9cec665..77fed1b9afcd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -456,7 +456,7 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
-	struct swait_head	mq_freeze_wq;
+	struct swait_queue_head	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 1e6932222e11..17f413bbbedf 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -16,18 +16,6 @@
 #ifndef AT91_PMC_H
 #define AT91_PMC_H
 
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_pmc_base;
-
-#define at91_pmc_read(field) \
-	readl_relaxed(at91_pmc_base + field)
-
-#define at91_pmc_write(field, value) \
-	writel_relaxed(value, at91_pmc_base + field)
-#else
-.extern at91_pmc_base
-#endif
-
 #define	AT91_PMC_SCER		0x00			/* System Clock Enable Register */
 #define	AT91_PMC_SCDR		0x04			/* System Clock Disable Register */
 
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 3fe8d14c98c0..3bca1590e29f 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -7,7 +7,7 @@
  * Atomic wait-for-completion handler data structures.
  * See kernel/sched/completion.c for details.
  */
-#include <linux/wait-simple.h>
+#include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -23,11 +23,11 @@
  */
 struct completion {
 	unsigned int done;
-	struct swait_head wait;
+	struct swait_queue_head wait;
 };
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, SWAIT_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	({ init_completion(&work); work; })
@@ -72,7 +72,7 @@ struct completion {
 static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
-	init_swait_head(&x->wait);
+	init_swait_queue_head(&x->wait);
 }
 
 /**
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d856ccde77b4..c690acc6900e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -25,6 +25,7 @@
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
 #include <linux/irqbypass.h>
+#include <linux/swait.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -243,7 +244,7 @@ struct kvm_vcpu {
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
 	unsigned char fpu_counter;
-	struct swait_head wq;
+	struct swait_queue_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -794,7 +795,7 @@ static inline bool kvm_arch_has_assigned_device(struct kvm *kvm)
 }
 #endif
 
-static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_queue_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/include/linux/swait.h b/include/linux/swait.h
new file mode 100644
index 000000000000..83f004a72320
--- /dev/null
+++ b/include/linux/swait.h
@@ -0,0 +1,173 @@
+#ifndef _LINUX_SWAIT_H
+#define _LINUX_SWAIT_H
+
+#include <linux/list.h>
+#include <linux/stddef.h>
+#include <linux/spinlock.h>
+#include <asm/current.h>
+
+/*
+ * Simple wait queues
+ *
+ * While these are very similar to the other/complex wait queues (wait.h) the
+ * most important difference is that the simple waitqueue allows for
+ * deterministic behaviour -- IOW it has strictly bounded IRQ and lock hold
+ * times.
+ *
+ * In order to make this so, we had to drop a fair number of features of the
+ * other waitqueue code; notably:
+ *
+ *  - mixing INTERRUPTIBLE and UNINTERRUPTIBLE sleeps on the same waitqueue;
+ *    all wakeups are TASK_NORMAL in order to avoid O(n) lookups for the right
+ *    sleeper state.
+ *
+ *  - the exclusive mode; because this requires preserving the list order
+ *    and this is hard.
+ *
+ *  - custom wake functions; because you cannot give any guarantees about
+ *    random code.
+ *
+ * As a side effect of this; the data structures are slimmer.
+ *
+ * One would recommend using this wait queue where possible.
+ */
+
+struct task_struct;
+
+struct swait_queue_head {
+	raw_spinlock_t		lock;
+	struct list_head	task_list;
+};
+
+struct swait_queue {
+	struct task_struct	*task;
+	struct list_head	task_list;
+};
+
+#define __SWAITQUEUE_INITIALIZER(name) {				\
+	.task		= current,					\
+	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAITQUEUE(name)					\
+	struct swait_queue name = __SWAITQUEUE_INITIALIZER(name)
+
+#define __SWAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),		\
+	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAIT_QUEUE_HEAD(name)					\
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
+
+extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+				    struct lock_class_key *key);
+
+#define init_swait_queue_head(q)				\
+	do {							\
+		static struct lock_class_key __key;		\
+		__init_swait_queue_head((q), #q, &__key);	\
+	} while (0)
+
+#ifdef CONFIG_LOCKDEP
+# define __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)			\
+	({ init_swait_queue_head(&name); name; })
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)
+#else
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	DECLARE_SWAIT_QUEUE_HEAD(name)
+#endif
+
+static inline int swait_active(struct swait_queue_head *q)
+{
+	return !list_empty(&q->task_list);
+}
+
+extern void swake_up(struct swait_queue_head *q);
+extern void swake_up_all(struct swait_queue_head *q);
+extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_all_locked(struct swait_queue_head *q);
+
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
+extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
+
+extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+/* as per ___wait_event() but for swait, therefore "exclusive == 0" */
+#define ___swait_event(wq, condition, state, ret, cmd)			\
+({									\
+	struct swait_queue __wait;					\
+	long __ret = ret;						\
+									\
+	INIT_LIST_HEAD(&__wait.task_list);				\
+	for (;;) {							\
+		long __int = prepare_to_swait_event(&wq, &__wait, state);\
+									\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret = __int;					\
+			break;						\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_swait(&wq, &__wait);					\
+	__ret;								\
+})
+
+#define __swait_event(wq, condition)					\
+	(void)___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,	\
+			    schedule())
+
+#define swait_event(wq, condition)					\
+do {									\
+	if (condition)							\
+		break;							\
+	__swait_event(wq, condition);					\
+} while (0)
+
+#define __swait_event_timeout(wq, condition, timeout)			\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_UNINTERRUPTIBLE, timeout,			\
+		      __ret = schedule_timeout(__ret))
+
+#define swait_event_timeout(wq, condition, timeout)			\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __swait_event_timeout(wq, condition, timeout);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible(wq, condition)			\
+	___swait_event(wq, condition, TASK_INTERRUPTIBLE, 0,		\
+		      schedule())
+
+#define swait_event_interruptible(wq, condition)			\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__ret = __swait_event_interruptible(wq, condition);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible_timeout(wq, condition, timeout)	\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_INTERRUPTIBLE, timeout,			\
+		      __ret = schedule_timeout(__ret))
+
+#define swait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __swait_event_interruptible_timeout(wq,		\
+						condition, timeout);	\
+	__ret;								\
+})
+
+#endif /* _LINUX_SWAIT_H */
diff --git a/include/linux/wait-simple.h b/include/linux/wait-simple.h
deleted file mode 100644
index f86bca2c41d5..000000000000
--- a/include/linux/wait-simple.h
+++ /dev/null
@@ -1,207 +0,0 @@
-#ifndef _LINUX_WAIT_SIMPLE_H
-#define _LINUX_WAIT_SIMPLE_H
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-
-#include <asm/current.h>
-
-struct swaiter {
-	struct task_struct	*task;
-	struct list_head	node;
-};
-
-#define DEFINE_SWAITER(name)					\
-	struct swaiter name = {					\
-		.task	= current,				\
-		.node	= LIST_HEAD_INIT((name).node),		\
-	}
-
-struct swait_head {
-	raw_spinlock_t		lock;
-	struct list_head	list;
-};
-
-#define SWAIT_HEAD_INITIALIZER(name) {				\
-		.lock	= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
-		.list	= LIST_HEAD_INIT((name).list),		\
-	}
-
-#define DEFINE_SWAIT_HEAD(name)					\
-	struct swait_head name = SWAIT_HEAD_INITIALIZER(name)
-
-extern void __init_swait_head(struct swait_head *h, struct lock_class_key *key);
-
-#define init_swait_head(swh)					\
-	do {							\
-		static struct lock_class_key __key;		\
-								\
-		__init_swait_head((swh), &__key);		\
-	} while (0)
-
-/*
- * Waiter functions
- */
-extern void swait_prepare_locked(struct swait_head *head, struct swaiter *w);
-extern void swait_prepare(struct swait_head *head, struct swaiter *w, int state);
-extern void swait_finish_locked(struct swait_head *head, struct swaiter *w);
-extern void swait_finish(struct swait_head *head, struct swaiter *w);
-
-/* Check whether a head has waiters enqueued */
-static inline bool swaitqueue_active(struct swait_head *h)
-{
-	/* Make sure the condition is visible before checking list_empty() */
-	smp_mb();
-	return !list_empty(&h->list);
-}
-
-/*
- * Wakeup functions
- */
-extern unsigned int __swait_wake(struct swait_head *head, unsigned int state, unsigned int num);
-extern unsigned int __swait_wake_locked(struct swait_head *head, unsigned int state, unsigned int num);
-
-#define swait_wake(head)			__swait_wake(head, TASK_NORMAL, 1)
-#define swait_wake_interruptible(head)		__swait_wake(head, TASK_INTERRUPTIBLE, 1)
-#define swait_wake_all(head)			__swait_wake(head, TASK_NORMAL, 0)
-#define swait_wake_all_interruptible(head)	__swait_wake(head, TASK_INTERRUPTIBLE, 0)
-
-/*
- * Event API
- */
-#define __swait_event(wq, condition)					\
-do {									\
-	DEFINE_SWAITER(__wait);						\
-									\
-	for (;;) {							\
-		swait_prepare(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
-		if (condition)						\
-			break;						\
-		schedule();						\
-	}								\
-	swait_finish(&wq, &__wait);					\
-} while (0)
-
-/**
- * swait_event - sleep until a condition gets true
- * @wq: the waitqueue to wait on
- * @condition: a C expression for the event to wait for
- *
- * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
- * @condition evaluates to true. The @condition is checked each time
- * the waitqueue @wq is woken up.
- *
- * wake_up() has to be called after changing any variable that could
- * change the result of the wait condition.
- */
-#define swait_event(wq, condition)					\
-do {									\
-	if (condition)							\
-		break;							\
-	__swait_event(wq, condition);					\
-} while (0)
-
-#define __swait_event_interruptible(wq, condition, ret)			\
-do {									\
-	DEFINE_SWAITER(__wait);						\
-									\
-	for (;;) {							\
-		swait_prepare(&wq, &__wait, TASK_INTERRUPTIBLE);	\
-		if (condition)						\
-			break;						\
-		if (signal_pending(current)) {				\
-			ret = -ERESTARTSYS;				\
-			break;						\
-		}							\
-		schedule();						\
-	}								\
-	swait_finish(&wq, &__wait);					\
-} while (0)
-
-#define __swait_event_interruptible_timeout(wq, condition, ret)		\
-do {									\
-	DEFINE_SWAITER(__wait);						\
-									\
-	for (;;) {							\
-		swait_prepare(&wq, &__wait, TASK_INTERRUPTIBLE);	\
-		if (condition)						\
-			break;						\
-		if (signal_pending(current)) {				\
-			ret = -ERESTARTSYS;				\
-			break;						\
-		}							\
-		ret = schedule_timeout(ret);				\
-		if (!ret)						\
-			break;						\
-	}								\
-	swait_finish(&wq, &__wait);					\
-} while (0)
-
-/**
- * swait_event_interruptible - sleep until a condition gets true
- * @wq: the waitqueue to wait on
- * @condition: a C expression for the event to wait for
- *
- * The process is put to sleep (TASK_INTERRUPTIBLE) until the
- * @condition evaluates to true. The @condition is checked each time
- * the waitqueue @wq is woken up.
- *
- * wake_up() has to be called after changing any variable that could
- * change the result of the wait condition.
- */
-#define swait_event_interruptible(wq, condition)			\
-({									\
-	int __ret = 0;							\
-	if (!(condition))						\
-		__swait_event_interruptible(wq, condition, __ret);	\
-	__ret;								\
-})
-
-#define swait_event_interruptible_timeout(wq, condition, timeout)	\
-({									\
-	int __ret = timeout;						\
-	if (!(condition))						\
-		__swait_event_interruptible_timeout(wq, condition, __ret);	\
-	__ret;								\
-})
-
-#define __swait_event_timeout(wq, condition, ret)			\
-do {									\
-	DEFINE_SWAITER(__wait);						\
-									\
-	for (;;) {							\
-		swait_prepare(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
-		if (condition)						\
-			break;						\
-		ret = schedule_timeout(ret);				\
-		if (!ret)						\
-			break;						\
-	}								\
-	swait_finish(&wq, &__wait);					\
-} while (0)
-
-/**
- * swait_event_timeout - sleep until a condition gets true or a timeout elapses
- * @wq: the waitqueue to wait on
- * @condition: a C expression for the event to wait for
- * @timeout: timeout, in jiffies
- *
- * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
- * @condition evaluates to true. The @condition is checked each time
- * the waitqueue @wq is woken up.
- *
- * wake_up() has to be called after changing any variable that could
- * change the result of the wait condition.
- *
- * The function returns 0 if the @timeout elapsed, and the remaining
- * jiffies if the condition evaluated to true before the timeout elapsed.
- */
-#define swait_event_timeout(wq, condition, timeout)			\
-({									\
-	long __ret = timeout;						\
-	if (!(condition))						\
-		__swait_event_timeout(wq, condition, __ret);		\
-	__ret;								\
-})
-
-#endif
diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
index 6122e4286177..f7710de1b1f3 100644
--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 64098d35de19..d862a203fce0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1621,7 +1621,6 @@ static int rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 	int needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
-	rcu_nocb_gp_cleanup(rsp, rnp);
 	rnp->need_future_gp[c & 0x1] = 0;
 	needmore = rnp->need_future_gp[(c + 1) & 0x1];
 	trace_rcu_future_gp(rnp, rdp, c,
@@ -1642,7 +1641,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;
-	swait_wake(&rsp->gp_wq);
+	swake_up(&rsp->gp_wq);
 }
 
 /*
@@ -2022,6 +2021,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	int nocb = 0;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct swait_queue_head *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq(&rnp->lock);
@@ -2060,7 +2060,9 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
 		nocb += rcu_future_gp_cleanup(rsp, rnp);
+		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq(&rnp->lock);
+		rcu_nocb_gp_cleanup(sq);
 		cond_resched_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
@@ -2261,7 +2263,7 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
-	rcu_gp_kthread_wake(rsp);
+	swake_up(&rsp->gp_wq);  /* Memory barrier implied by swake_up() path. */
 }
 
 /*
@@ -2922,7 +2924,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore(&rnp_old->lock, flags);
-	rcu_gp_kthread_wake(rsp);
+	swake_up(&rsp->gp_wq); /* Memory barrier implied by swake_up() path. */
 }
 
 /*
@@ -3645,7 +3647,7 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore(&rnp->lock, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				swait_wake(&rsp->expedited_wq);
+				swake_up(&rsp->expedited_wq);
 			}
 			break;
 		}
@@ -3902,7 +3904,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	jiffies_start = jiffies;
 
 	for (;;) {
-		ret = swait_event_interruptible_timeout(
+		ret = swait_event_timeout(
 				rsp->expedited_wq,
 				sync_rcu_preempt_exp_done(rnp_root),
 				jiffies_stall);
@@ -4578,8 +4580,8 @@ static void __init rcu_init_one(struct rcu_state *rsp,
 		}
 	}
 
-	init_swait_head(&rsp->gp_wq);
-	init_swait_head(&rsp->expedited_wq);
+	init_swait_queue_head(&rsp->gp_wq);
+	init_swait_queue_head(&rsp->expedited_wq);
 	rnp = rsp->level[rcu_num_lvls - 1];
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2ba8f6c2e81e..c75834d8de24 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -27,8 +27,8 @@
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/swait.h>
 #include <linux/stop_machine.h>
-#include <linux/wait-simple.h>
 
 /*
  * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
@@ -242,7 +242,7 @@ struct rcu_node {
 				/* Refused to boost: not sure why, though. */
 				/*  This can happen due to race conditions. */
 #ifdef CONFIG_RCU_NOCB_CPU
-	struct swait_head nocb_gp_wq[2];
+	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 	int need_future_gp[2];
@@ -394,7 +394,7 @@ struct rcu_data {
 	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
 	struct rcu_head *nocb_follower_head; /* CBs ready to invoke. */
 	struct rcu_head **nocb_follower_tail;
-	struct swait_head nocb_wq;	/* For nocb kthreads to sleep on. */
+	struct swait_queue_head nocb_wq; /* For nocb kthreads to sleep on. */
 	struct task_struct *nocb_kthread;
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 
@@ -473,7 +473,7 @@ struct rcu_state {
 	unsigned long gpnum;			/* Current gp number. */
 	unsigned long completed;		/* # of last completed gp. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
-	struct swait_head gp_wq;		/* Where GP task waits. */
+	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
 	short gp_state;				/* GP kthread sleep state. */
 
@@ -505,7 +505,7 @@ struct rcu_state {
 	atomic_long_t expedited_workdone3;	/* # done by others #3. */
 	atomic_long_t expedited_normal;		/* # fallbacks to normal. */
 	atomic_t expedited_need_qs;		/* # CPUs left to check in. */
-	struct swait_head expedited_wq;		/* Wait for check-ins. */
+	struct swait_queue_head expedited_wq;	/* Wait for check-ins. */
 	int ncpus_snap;				/* # CPUs seen last time. */
 
 	unsigned long jiffies_force_qs;		/* Time at which to invoke */
@@ -607,7 +607,8 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
 static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
 static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq);
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp);
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 			    bool lazy, unsigned long flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d2f27f2f38d..8e119cf647ba 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1717,9 +1717,9 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
  */
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
-	swait_wake_all(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
+	swake_up_all(sq);
 }
 
 /*
@@ -1735,10 +1735,15 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 	rnp->need_future_gp[(rnp->completed + 1) & 0x1] += nrq;
 }
 
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
+{
+	return &rnp->nocb_gp_wq[rnp->completed & 0x1];
+}
+
 static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
-	init_swait_head(&rnp->nocb_gp_wq[0]);
-	init_swait_head(&rnp->nocb_gp_wq[1]);
+	init_swait_queue_head(&rnp->nocb_gp_wq[0]);
+	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
 #ifndef CONFIG_RCU_NOCB_CPU_ALL
@@ -1763,7 +1768,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, bool force)
 	if (READ_ONCE(rdp_leader->nocb_leader_sleep) || force) {
 		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
 		WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
-		swait_wake(&rdp_leader->nocb_wq);
+		swake_up(&rdp_leader->nocb_wq);
 	}
 }
 
@@ -2079,7 +2084,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 			 * List was empty, wake up the follower.
 			 * Memory barriers supplied by atomic_long_add().
 			 */
-			swait_wake(&rdp->nocb_wq);
+			swake_up(&rdp->nocb_wq);
 		}
 	}
 
@@ -2259,7 +2264,7 @@ void __init rcu_init_nohz(void)
 static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	rdp->nocb_tail = &rdp->nocb_head;
-	init_swait_head(&rdp->nocb_wq);
+	init_swait_queue_head(&rdp->nocb_wq);
 	rdp->nocb_follower_tail = &rdp->nocb_follower_head;
 }
 
@@ -2409,7 +2414,7 @@ static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
 	return false;
 }
 
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
 }
 
@@ -2417,6 +2422,11 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 {
 }
 
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
+{
+	return NULL;
+}
+
 static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index a22fdb617462..debedbee5692 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -13,7 +13,7 @@ endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle_task.o fair.o rt.o deadline.o stop_task.o
-obj-y += wait.o wait-simple.o work-simple.o completion.o idle.o
+obj-y += wait.o swait.o work-simple.o completion.o idle.o
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 45ebcffd9feb..b62cf6400fe0 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -32,7 +32,7 @@ void complete(struct completion *x)
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__swait_wake_locked(&x->wait, TASK_NORMAL, 1);
+	swake_up_locked(&x->wait);
 	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
@@ -52,7 +52,7 @@ void complete_all(struct completion *x)
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__swait_wake_locked(&x->wait, TASK_NORMAL, 0);
+	swake_up_all_locked(&x->wait);
 	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
@@ -62,9 +62,9 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DEFINE_SWAITER(wait);
+		DECLARE_SWAITQUEUE(wait);
 
-		swait_prepare_locked(&x->wait, &wait);
+		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
@@ -75,7 +75,7 @@ do_wait_for_common(struct completion *x,
 			timeout = action(timeout);
 			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		swait_finish_locked(&x->wait, &wait);
+		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
new file mode 100644
index 000000000000..8459561f0379
--- /dev/null
+++ b/kernel/sched/swait.c
@@ -0,0 +1,140 @@
+#include <linux/sched.h>
+#include <linux/swait.h>
+
+void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+			     struct lock_class_key *key)
+{
+	raw_spin_lock_init(&q->lock);
+	lockdep_set_class_and_name(&q->lock, key, name);
+	INIT_LIST_HEAD(&q->task_list);
+}
+EXPORT_SYMBOL(__init_swait_queue_head);
+
+/*
+ * The thing about the wake_up_state() return value; I think we can ignore it.
+ *
+ * If for some reason it would return 0, that means the previously waiting
+ * task is already running, so it will observe condition true (or has already).
+ */
+void swake_up_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	if (list_empty(&q->task_list))
+		return;
+
+	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	wake_up_process(curr->task);
+	list_del_init(&curr->task_list);
+}
+EXPORT_SYMBOL(swake_up_locked);
+
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	int wakes = 0;
+
+	while (!list_empty(&q->task_list)) {
+
+		curr = list_first_entry(&q->task_list, typeof(*curr),
+					task_list);
+		wake_up_process(curr->task);
+		list_del_init(&curr->task_list);
+		wakes++;
+	}
+	WARN_ON(wakes > 2);
+}
+EXPORT_SYMBOL(swake_up_all_locked);
+
+void swake_up(struct swait_queue_head *q)
+{
+	unsigned long flags;
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	swake_up_locked(q);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(swake_up);
+
+/*
+ * Does not allow usage from IRQ disabled, since we must be able to
+ * release IRQs to guarantee bounded hold time.
+ */
+void swake_up_all(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	LIST_HEAD(tmp);
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irq(&q->lock);
+	list_splice_init(&q->task_list, &tmp);
+	while (!list_empty(&tmp)) {
+		curr = list_first_entry(&tmp, typeof(*curr), task_list);
+
+		wake_up_state(curr->task, TASK_NORMAL);
+		list_del_init(&curr->task_list);
+
+		if (list_empty(&tmp))
+			break;
+
+		raw_spin_unlock_irq(&q->lock);
+		raw_spin_lock_irq(&q->lock);
+	}
+	raw_spin_unlock_irq(&q->lock);
+}
+EXPORT_SYMBOL(swake_up_all);
+
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	wait->task = current;
+	if (list_empty(&wait->task_list))
+		list_add(&wait->task_list, &q->task_list);
+}
+
+void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	__prepare_to_swait(q, wait);
+	set_current_state(state);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(prepare_to_swait);
+
+long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
+{
+	if (signal_pending_state(state, current))
+		return -ERESTARTSYS;
+
+	prepare_to_swait(q, wait, state);
+
+	return 0;
+}
+EXPORT_SYMBOL(prepare_to_swait_event);
+
+void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	__set_current_state(TASK_RUNNING);
+	if (!list_empty(&wait->task_list))
+		list_del_init(&wait->task_list);
+}
+
+void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+
+	if (!list_empty_careful(&wait->task_list)) {
+		raw_spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		raw_spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+EXPORT_SYMBOL(finish_swait);
diff --git a/kernel/sched/wait-simple.c b/kernel/sched/wait-simple.c
deleted file mode 100644
index 7dfa86d1f654..000000000000
--- a/kernel/sched/wait-simple.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Simple waitqueues without fancy flags and callbacks
- *
- * (C) 2011 Thomas Gleixner <tglx@linutronix.de>
- *
- * Based on kernel/wait.c
- *
- * For licencing details see kernel-base/COPYING
- */
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/wait-simple.h>
-
-/* Adds w to head->list. Must be called with head->lock locked. */
-static inline void __swait_enqueue(struct swait_head *head, struct swaiter *w)
-{
-	list_add(&w->node, &head->list);
-	/* We can't let the condition leak before the setting of head */
-	smp_mb();
-}
-
-/* Removes w from head->list. Must be called with head->lock locked. */
-static inline void __swait_dequeue(struct swaiter *w)
-{
-	list_del_init(&w->node);
-}
-
-void __init_swait_head(struct swait_head *head, struct lock_class_key *key)
-{
-	raw_spin_lock_init(&head->lock);
-	lockdep_set_class(&head->lock, key);
-	INIT_LIST_HEAD(&head->list);
-}
-EXPORT_SYMBOL(__init_swait_head);
-
-void swait_prepare_locked(struct swait_head *head, struct swaiter *w)
-{
-	w->task = current;
-	if (list_empty(&w->node))
-		__swait_enqueue(head, w);
-}
-
-void swait_prepare(struct swait_head *head, struct swaiter *w, int state)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&head->lock, flags);
-	swait_prepare_locked(head, w);
-	__set_current_state(state);
-	raw_spin_unlock_irqrestore(&head->lock, flags);
-}
-EXPORT_SYMBOL(swait_prepare);
-
-void swait_finish_locked(struct swait_head *head, struct swaiter *w)
-{
-	__set_current_state(TASK_RUNNING);
-	if (w->task)
-		__swait_dequeue(w);
-}
-
-void swait_finish(struct swait_head *head, struct swaiter *w)
-{
-	unsigned long flags;
-
-	__set_current_state(TASK_RUNNING);
-	if (w->task) {
-		raw_spin_lock_irqsave(&head->lock, flags);
-		__swait_dequeue(w);
-		raw_spin_unlock_irqrestore(&head->lock, flags);
-	}
-}
-EXPORT_SYMBOL(swait_finish);
-
-unsigned int
-__swait_wake_locked(struct swait_head *head, unsigned int state, unsigned int num)
-{
-	struct swaiter *curr, *next;
-	int woken = 0;
-
-	list_for_each_entry_safe(curr, next, &head->list, node) {
-		if (wake_up_state(curr->task, state)) {
-			__swait_dequeue(curr);
-			/*
-			 * The waiting task can free the waiter as
-			 * soon as curr->task = NULL is written,
-			 * without taking any locks. A memory barrier
-			 * is required here to prevent the following
-			 * store to curr->task from getting ahead of
-			 * the dequeue operation.
-			 */
-			smp_wmb();
-			curr->task = NULL;
-			if (++woken == num)
-				break;
-		}
-	}
-	return woken;
-}
-
-unsigned int
-__swait_wake(struct swait_head *head, unsigned int state, unsigned int num)
-{
-	unsigned long flags;
-	int woken;
-
-	if (!swaitqueue_active(head))
-		return 0;
-
-	raw_spin_lock_irqsave(&head->lock, flags);
-	woken = __swait_wake_locked(head, state, num);
-	raw_spin_unlock_irqrestore(&head->lock, flags);
-	return woken;
-}
-EXPORT_SYMBOL(__swait_wake);
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index e57a0522573f..9ffe40543c81 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -5,7 +5,7 @@
  * PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.
  */
 
-#include <linux/wait-simple.h>
+#include <linux/swait.h>
 #include <linux/work-simple.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
@@ -19,7 +19,7 @@ static struct sworker *glob_worker;
 
 struct sworker {
 	struct list_head events;
-	struct swait_head wq;
+	struct swait_queue_head wq;
 
 	raw_spinlock_t lock;
 
@@ -80,7 +80,7 @@ static struct sworker *swork_create(void)
 
 	INIT_LIST_HEAD(&worker->events);
 	raw_spin_lock_init(&worker->lock);
-	init_swait_head(&worker->wq);
+	init_swait_queue_head(&worker->wq);
 
 	worker->task = kthread_run(swork_kthread, worker, "kswork");
 	if (IS_ERR(worker->task)) {
@@ -117,7 +117,7 @@ bool swork_queue(struct swork_event *sev)
 	list_add_tail(&sev->item, &glob_worker->events);
 	raw_spin_unlock_irqrestore(&glob_worker->lock, flags);
 
-	swait_wake(&glob_worker->wq);
+	swake_up(&glob_worker->wq);
 	return true;
 }
 EXPORT_SYMBOL_GPL(swork_queue);
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaa..05c35cb58077 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 57d9436f7a9c..9378d0919ed8 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -98,8 +98,8 @@ static void async_pf_execute(struct work_struct *work)
 	 * This memory barrier pairs with prepare_to_wait's set_current_state()
 	 */
 	smp_mb();
-	if (swaitqueue_active(&vcpu->wq))
-		swait_wake_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 018ed3eb7e79..43fad2eed608 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -226,8 +226,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	vcpu->halt_poll_ns = 0;
-	init_swait_head(&vcpu->wq);
+	init_swait_queue_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	vcpu->pre_pcpu = -1;
@@ -1999,7 +1998,7 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
 void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	ktime_t start, cur;
-	DEFINE_SWAITER(wait);
+	DECLARE_SWAITQUEUE(wait);
 	bool waited = false;
 	u64 block_ns;
 
@@ -2024,7 +2023,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_blocking(vcpu);
 
 	for (;;) {
-		swait_prepare(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_vcpu_check_block(vcpu) < 0)
 			break;
@@ -2033,7 +2032,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		schedule();
 	}
 
-	swait_finish(&vcpu->wq, &wait);
+	finish_swait(&vcpu->wq, &wait);
 	cur = ktime_get();
 
 	kvm_arch_vcpu_unblocking(vcpu);
@@ -2065,11 +2064,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
-	struct swait_head *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (swaitqueue_active(wqp)) {
-		swait_wake_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -2170,7 +2169,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (swaitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
+			if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;

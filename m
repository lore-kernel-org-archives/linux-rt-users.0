Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284CC43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2A620866
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEARcT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 13:32:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARcT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 13:32:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLt5a-0004N1-NT; Wed, 01 May 2019 19:32:15 +0200
Date:   Wed, 1 May 2019 19:32:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.10-rt7
Message-ID: <20190501173214.emniok77pg5hsav5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.10-rt7 patch set. 

Changes since v5.0.10-rt6:

  - Two FPU related patches for x86 which were merged upstream (after
    the "x86: load FPU registers on return to userland" series has been
    applied).
  
  - Rename rwsem_rt.h -> rwsem-rt.h for consistency reasons with
    rwsem-rt.c.

  - Remove the kmsg_dump_lock mutex which could be acquired in atomic
    context. Reported by Scott Wood, patch by John Ogness.

  - Update "clocksource: improve Atmel TCB timer driver" by Alexandre
    Belloni from v0 to v3.

  - Check if EFI services are disabled at runtime before using them in
    secureboot. Patch by Scott Wood.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.10-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.10-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.10-rt7

The RT patch against v5.0.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.10-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.10-rt7.tar.xz

Sebastian

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index c8876d0ca41a8..e4b1be66b3f56 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -19,7 +19,6 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
-# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 10ebc9481f72c..b0026f73083d7 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
-# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 16f700d5b3a47..5d37ea10eaa26 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -157,11 +157,9 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
-	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
-	int ret = -EFAULT;
+	int ret;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -174,12 +172,13 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
+retry:
 	fpregs_lock();
 	/*
 	 * Load the FPU register if they are not valid for the current task.
 	 * With a valid FPU state we can attempt to save the state directly to
-	 * userland's stack frame which will likely succeed. If it does not, do
-	 * the slowpath.
+	 * userland's stack frame which will likely succeed. If it does not,
+	 * resolve the fault in the user memory and try again.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		__fpregs_load_activate();
@@ -187,20 +186,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);
 	pagefault_enable();
-	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
-		copy_fpregs_to_fpstate(fpu);
-	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
 	if (ret) {
-		if (using_compacted_format()) {
-			if (copy_xstate_to_user(buf_fx, xsave, 0, size))
-				return -1;
-		} else {
-			fpstate_sanitize_xstate(fpu);
-			if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-				return -1;
-		}
+		int aligned_size;
+		int nr_pages;
+
+		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
+		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
+
+		ret = get_user_pages((unsigned long)buf_fx, nr_pages,
+				     FOLL_WRITE, NULL, NULL);
+		if (ret == nr_pages)
+			goto retry;
+		return -EFAULT;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index e47cd9390ab4e..2a2e87717bad1 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -17,6 +17,11 @@ static enum efi_secureboot_mode get_sb_mode(void)
 
 	size = sizeof(secboot);
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("ima: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
 	/* Get variable contents into buffer */
 	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
 				  NULL, &size, &secboot);
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index cfcc18902651a..05b5272f5d7e9 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -65,7 +65,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -80,7 +80,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
@@ -360,16 +360,24 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
+static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+
+static const struct of_device_id atmel_tcb_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
+	{ /* sentinel */ }
+};
+
 static int __init tcb_clksrc_init(struct device_node *node)
 {
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
 	u64 (*tc_sched_clock)(void);
-	int irq;
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
 	int clk32k_divisor_idx = -1;
+	int bits;
 	int i;
 	int ret;
 
@@ -389,10 +397,6 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (IS_ERR(tc.slow_clk))
 		return PTR_ERR(tc.slow_clk);
 
-	irq = of_irq_get(node->parent, 0);
-	if (irq <= 0)
-		return -EINVAL;
-
 	tc.clk[0] = t0_clk;
 	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
 	if (IS_ERR(tc.clk[1]))
@@ -401,16 +405,15 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (IS_ERR(tc.clk[2]))
 		tc.clk[2] = t0_clk;
 
-	tc.irq[0] = irq;
-	tc.irq[1] = of_irq_get(node->parent, 1);
-	if (tc.irq[1] <= 0)
-		tc.irq[1] = irq;
 	tc.irq[2] = of_irq_get(node->parent, 2);
-	if (tc.irq[2] <= 0)
-		tc.irq[2] = irq;
+	if (tc.irq[2] <= 0) {
+		tc.irq[2] = of_irq_get(node->parent, 0);
+		if (tc.irq[2] <= 0)
+			return -EINVAL;
+	}
 
-	match = of_match_node(atmel_tcb_dt_ids, node->parent);
-	tc.tcb_config = match->data;
+	match = of_match_node(atmel_tcb_of_match, node->parent);
+	bits = (uintptr_t)match->data;
 
 	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
 		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
@@ -423,8 +426,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < ARRAY_SIZE(atmel_tc_divisors); i++) {
-		unsigned divisor = atmel_tc_divisors[i];
+	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
 		/* remember 32 KiHz clock for later */
@@ -450,7 +453,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	tcaddr = tc.regs;
 
-	if (tc.tcb_config->counter_width == 32) {
+	if (bits == 32) {
 		/* use apropriate function to read 32 bit counter */
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
@@ -492,7 +495,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	clocksource_unregister(&clksrc);
 
 err_disable_t1:
-	if (tc.tcb_config->counter_width != 32)
+	if (bits != 32)
 		clk_disable_unprepare(tc.clk[1]);
 
 err_disable_t0:
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index b610cc894cd82..2c6850ef0e9c8 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -17,6 +17,18 @@
  * share individual timers between different drivers.
  */
 
+#if defined(CONFIG_AVR32)
+/* AVR32 has these divide PBB */
+const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
+EXPORT_SYMBOL(atmel_tc_divisors);
+
+#elif defined(CONFIG_ARCH_AT91)
+/* AT91 has these divide MCK */
+const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
+EXPORT_SYMBOL(atmel_tc_divisors);
+
+#endif
+
 static DEFINE_SPINLOCK(tc_list_lock);
 static LIST_HEAD(tc_list);
 
@@ -68,6 +80,26 @@ void atmel_tc_free(struct atmel_tc *tc)
 EXPORT_SYMBOL_GPL(atmel_tc_free);
 
 #if defined(CONFIG_OF)
+static struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
+static const struct of_device_id atmel_tcb_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-tcb",
+		.data = &tcb_rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9x5-tcb",
+		.data = &tcb_sam9x5_config,
+	}, {
+		/* sentinel */
+	}
+};
+
 MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
 #endif
 
@@ -80,7 +112,7 @@ static int __init tc_probe(struct platform_device *pdev)
 	unsigned int	i;
 
 	if (of_get_child_count(pdev->dev.of_node))
-		return 0;
+		return -EBUSY;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index d7e92fd552e40..7da1fdb4d269c 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,10 +17,10 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <soc/at91/atmel_tcb.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <soc/at91/atmel_tcb.h>
 
 #define NPWM	6
 
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem-rt.h
similarity index 100%
rename from include/linux/rwsem_rt.h
rename to include/linux/rwsem-rt.h
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c4adabc5a049a..47b2e5d12fde9 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -21,7 +21,7 @@
 #endif
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-#include <linux/rwsem_rt.h>
+#include <linux/rwsem-rt.h>
 #else /* PREEMPT_RT_FULL */
 
 struct rw_semaphore;
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index cb0c5f53cd46c..c3c7200ce1512 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -76,27 +76,8 @@ extern struct atmel_tc *atmel_tc_alloc(unsigned block);
 extern void atmel_tc_free(struct atmel_tc *tc);
 
 /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
-static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
+extern const u8 atmel_tc_divisors[5];
 
-static const struct atmel_tcb_config tcb_rm9200_config = {
-	.counter_width = 16,
-};
-
-static const struct atmel_tcb_config tcb_sam9x5_config = {
-	.counter_width = 32,
-};
-
-static const struct of_device_id atmel_tcb_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-tcb",
-		.data = &tcb_rm9200_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &tcb_sam9x5_config,
-	}, {
-		/* sentinel */
-	}
-};
 
 /*
  * Two registers have block-wide controls.  These are: configuring the three
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 997d07b6bf975..7d3522e0bcecb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -359,8 +359,6 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-static DEFINE_MUTEX(kmsg_dump_lock);
-
 /* the last printk record at the last 'clear' command */
 static u64 clear_seq;
 
@@ -2820,6 +2818,7 @@ module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
  */
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
+	struct kmsg_dumper dumper_local;
 	struct kmsg_dumper *dumper;
 
 	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
@@ -2830,16 +2829,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		if (dumper->max_reason && reason > dumper->max_reason)
 			continue;
 
-		/* initialize iterator with data about the stored records */
-		dumper->active = true;
+		/*
+		 * use a local copy to avoid modifying the
+		 * iterator used by any other cpus/contexts
+		 */
+		memcpy(&dumper_local, dumper, sizeof(dumper_local));
 
-		kmsg_dump_rewind(dumper);
+		/* initialize iterator with data about the stored records */
+		dumper_local.active = true;
+		kmsg_dump_rewind(&dumper_local);
 
 		/* invoke dumper which will iterate over records */
-		dumper->dump(dumper, reason);
-
-		/* reset iterator */
-		dumper->active = false;
+		dumper_local.dump(&dumper_local, reason);
 	}
 	rcu_read_unlock();
 }
@@ -2951,9 +2952,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
 {
 	bool ret;
 
-	mutex_lock(&kmsg_dump_lock);
 	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
-	mutex_unlock(&kmsg_dump_lock);
 
 	return ret;
 }
@@ -3105,9 +3104,7 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
  */
 void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 {
-	mutex_lock(&kmsg_dump_lock);
 	kmsg_dump_rewind_nolock(dumper);
-	mutex_unlock(&kmsg_dump_lock);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7

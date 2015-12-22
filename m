From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.1.15-rt17
Date: Tue, 22 Dec 2015 17:56:01 +0100
Message-ID: <20151222165601.GG27274@linutronix.de>
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

I'm pleased to announce the v4.1.15-rt17 patch set.
Changes since v4.1.15-rt16:

Axel Lin (1):
      gpio: omap: Fix missing raw locks conversion

Grygorii Strashko (15):
      gpio: omap: fix omap_gpio_free to not clean up irq configuration
      gpio: omap: fix error handling in omap_gpio_irq_type
      gpio: omap: rework omap_x_irq_shutdown to touch only irqs specific registers
      gpio: omap: rework omap_gpio_request to touch only gpio specific registers
      gpio: omap: rework omap_gpio_irq_startup to handle current pin state properly
      gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type
      gpio: omap: prevent module from being unloaded while in use
      gpio: omap: remove wrong irq_domain_remove usage in probe
      gpio: omap: switch to use platform_get_irq
      gpio: omap: fix omap2_set_gpio_debounce
      gpio: omap: protect regs access in omap_gpio_irq_handler
      gpio: omap: fix clk_prepare/unprepare usage
      gpio: omap: fix static checker warning
      gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
      gpio: omap: convert to use generic irq handler

Russ Dill (1):
      ARM: OMAP2: Drop the concept of certain power domains not being able to lose context.

Sebastian Andrzej Siewior (4):
      Revert "x86: Do not disable preemption in int3 on 32bit"
      Revert "gpio: omap: use raw locks for locking"
      gpio: omap: use raw locks for locking
      v4.1.15-rt17

Tony Lindgren (3):
      gpio: omap: Allow building as a loadable module
      gpio: omap: Fix gpiochip_add() handling for deferred probe
      gpio: omap: Fix GPIO numbering for deferred probe

Yang Shi (1):
      x86/signal: delay calling signals on 32bit

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

Known issues:
  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

  - Christoph Mathys reported a stall in cgroup locking code while using
    Linux containers.

The delta patch against 4.1.15-rt17 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.15-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.15-rt17

The RT patch against 4.1.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.15-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.15-rt17.tar.xz

Sebastian

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 7a577145b68b..689a1af47c80 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -130,7 +130,6 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	}
 
 	pwrdm = omap_hwmod_get_pwrdm(oh);
-	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 
 	pdev = omap_device_build(name, id - 1, oh, pdata, sizeof(*pdata));
 	kfree(pdata);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 78af6d8cf2e2..ef4227ffa3b6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1166,43 +1166,3 @@ int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 	return count;
 }
 
-/**
- * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
- * @pwrdm: struct powerdomain *
- *
- * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
- * can lose either memory or logic context or if @pwrdm is invalid, or
- * returns 0 otherwise.  This function is not concerned with how the
- * powerdomain registers are programmed (i.e., to go off or not); it's
- * concerned with whether it's ever possible for this powerdomain to
- * go off while some other part of the chip is active.  This function
- * assumes that every powerdomain can go to either ON or INACTIVE.
- */
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
-{
-	int i;
-
-	if (!pwrdm) {
-		pr_debug("powerdomain: %s: invalid powerdomain pointer\n",
-			 __func__);
-		return 1;
-	}
-
-	if (pwrdm->pwrsts & PWRSTS_OFF)
-		return 1;
-
-	if (pwrdm->pwrsts & PWRSTS_RET) {
-		if (pwrdm->pwrsts_logic_ret & PWRSTS_OFF)
-			return 1;
-
-		for (i = 0; i < pwrdm->banks; i++)
-			if (pwrdm->pwrsts_mem_ret[i] & PWRSTS_OFF)
-				return 1;
-	}
-
-	for (i = 0; i < pwrdm->banks; i++)
-		if (pwrdm->pwrsts_mem_on[i] & PWRSTS_OFF)
-			return 1;
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 28a796ce07d7..5e0c033a21db 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -244,7 +244,6 @@ int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
 
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index b1b08a28c72a..0e7bfe98e1d1 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -32,7 +32,7 @@ typedef struct {
  * TIF_NOTIFY_RESUME and set up the signal to be sent on exit of the
  * trap.
  */
-#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_X86_64)
+#if defined(CONFIG_PREEMPT_RT_FULL)
 #define ARCH_RT_DELAYS_SIGNAL_SEND
 #endif
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ebae118938ef..324ab5247687 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -88,21 +88,9 @@ static inline void conditional_sti(struct pt_regs *regs)
 		local_irq_enable();
 }
 
-static inline void conditional_sti_ist(struct pt_regs *regs)
+static inline void preempt_conditional_sti(struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_64
-	/*
-	 * X86_64 uses a per CPU stack on the IST for certain traps
-	 * like int3. The task can not be preempted when using one
-	 * of these stacks, thus preemption must be disabled, otherwise
-	 * the stack can be corrupted if the task is scheduled out,
-	 * and another task comes in and uses this stack.
-	 *
-	 * On x86_32 the task keeps its own stack and it is OK if the
-	 * task schedules out.
-	 */
 	preempt_count_inc();
-#endif
 	if (regs->flags & X86_EFLAGS_IF)
 		local_irq_enable();
 }
@@ -113,13 +101,11 @@ static inline void conditional_cli(struct pt_regs *regs)
 		local_irq_disable();
 }
 
-static inline void conditional_cli_ist(struct pt_regs *regs)
+static inline void preempt_conditional_cli(struct pt_regs *regs)
 {
 	if (regs->flags & X86_EFLAGS_IF)
 		local_irq_disable();
-#ifdef CONFIG_X86_64
 	preempt_count_dec();
-#endif
 }
 
 enum ctx_state ist_enter(struct pt_regs *regs)
@@ -550,9 +536,9 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	 * as we may switch to the interrupt stack.
 	 */
 	debug_stack_usage_inc();
-	conditional_sti_ist(regs);
+	preempt_conditional_sti(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
-	conditional_cli_ist(regs);
+	preempt_conditional_cli(regs);
 	debug_stack_usage_dec();
 exit:
 	ist_exit(regs, prev_state);
@@ -682,12 +668,12 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	debug_stack_usage_inc();
 
 	/* It's safe to allow irq's after DR6 has been saved */
-	conditional_sti_ist(regs);
+	preempt_conditional_sti(regs);
 
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
 					X86_TRAP_DB);
-		conditional_cli_ist(regs);
+		preempt_conditional_cli(regs);
 		debug_stack_usage_dec();
 		goto exit;
 	}
@@ -707,7 +693,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(tsk, regs, error_code, si_code);
-	conditional_cli_ist(regs);
+	preempt_conditional_cli(regs);
 	debug_stack_usage_dec();
 
 exit:
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index caefe806db5e..ff7df95de3bf 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -308,7 +308,7 @@ config GPIO_OCTEON
 	  family of SOCs.
 
 config GPIO_OMAP
-	bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
+	tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_TEST
 	default y if ARCH_OMAP
 	depends on ARM
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a0ace2758e2e..4916fd726dce 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #define OFF_MODE	1
+#define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
 static LIST_HEAD(omap_gpio_list);
 
@@ -50,7 +51,7 @@ struct gpio_regs {
 struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
-	u16 irq;
+	int irq;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -58,6 +59,7 @@ struct gpio_bank {
 	u32 level_mask;
 	u32 toggle_mask;
 	raw_spinlock_t lock;
+	raw_spinlock_t wa_lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 mod_usage;
@@ -67,7 +69,7 @@ struct gpio_bank {
 	struct device *dev;
 	bool is_mpuio;
 	bool dbck_flag;
-	bool loses_context;
+
 	bool context_valid;
 	int stride;
 	u32 width;
@@ -175,7 +177,7 @@ static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set
 static inline void omap_gpio_dbck_enable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
-		clk_prepare_enable(bank->dbck);
+		clk_enable(bank->dbck);
 		bank->dbck_enabled = true;
 
 		writel_relaxed(bank->dbck_enable_mask,
@@ -193,7 +195,7 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
 		 */
 		writel_relaxed(0, bank->base + bank->regs->debounce_en);
 
-		clk_disable_unprepare(bank->dbck);
+		clk_disable(bank->dbck);
 		bank->dbck_enabled = false;
 	}
 }
@@ -204,8 +206,9 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
  * @offset: the gpio number on this @bank
  * @debounce: debounce time to use
  *
- * OMAP's debounce time is in 31us steps so we need
- * to convert and round up to the closest unit.
+ * OMAP's debounce time is in 31us steps
+ *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
+ * so we need to convert and round up to the closest unit.
  */
 static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 				    unsigned debounce)
@@ -213,34 +216,33 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 	void __iomem		*reg;
 	u32			val;
 	u32			l;
+	bool			enable = !!debounce;
 
 	if (!bank->dbck_flag)
 		return;
 
-	if (debounce < 32)
-		debounce = 0x01;
-	else if (debounce > 7936)
-		debounce = 0xff;
-	else
-		debounce = (debounce / 0x1f) - 1;
+	if (enable) {
+		debounce = DIV_ROUND_UP(debounce, 31) - 1;
+		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
+	}
 
 	l = BIT(offset);
 
-	clk_prepare_enable(bank->dbck);
+	clk_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
 	writel_relaxed(debounce, reg);
 
 	reg = bank->base + bank->regs->debounce_en;
 	val = readl_relaxed(reg);
 
-	if (debounce)
+	if (enable)
 		val |= l;
 	else
 		val &= ~l;
 	bank->dbck_enable_mask = val;
 
 	writel_relaxed(val, reg);
-	clk_disable_unprepare(bank->dbck);
+	clk_disable(bank->dbck);
 	/*
 	 * Enable debounce clock per module.
 	 * This call is mandatory because in omap_gpio_request() when
@@ -285,7 +287,7 @@ static void omap_clear_gpio_debounce(struct gpio_bank *bank, unsigned offset)
 		bank->context.debounce = 0;
 		writel_relaxed(bank->context.debounce, bank->base +
 			     bank->regs->debounce);
-		clk_disable_unprepare(bank->dbck);
+		clk_disable(bank->dbck);
 		bank->dbck_enabled = false;
 	}
 }
@@ -488,9 +490,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -500,10 +499,15 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
+	if (retval) {
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
+		goto error;
+	}
 	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
 		raw_spin_unlock_irqrestore(&bank->lock, flags);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto error;
 	}
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -512,6 +516,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
+	return 0;
+
+error:
 	return retval;
 }
 
@@ -638,22 +645,18 @@ static int omap_set_gpio_wakeup(struct gpio_bank *bank, unsigned offset,
 	return 0;
 }
 
-static void omap_reset_gpio(struct gpio_bank *bank, unsigned offset)
-{
-	omap_set_gpio_direction(bank, offset, 1);
-	omap_set_gpio_irqenable(bank, offset, 0);
-	omap_clear_gpio_irqstatus(bank, offset);
-	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-	omap_clear_gpio_debounce(bank, offset);
-}
-
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
 	unsigned offset = d->hwirq;
+	int ret;
 
-	return omap_set_gpio_wakeup(bank, offset, enable);
+	ret = omap_set_gpio_wakeup(bank, offset, enable);
+	if (!ret)
+		ret = irq_set_irq_wake(bank->irq, enable);
+
+	return ret;
 }
 
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -669,14 +672,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		pm_runtime_get_sync(bank->dev);
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	/* Set trigger to none. You need to enable the desired trigger with
-	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
-	 * not already been requested.
-	 */
-	if (!LINE_USED(bank->irq_usage, offset)) {
-		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-		omap_enable_gpio_module(bank, offset);
-	}
+	omap_enable_gpio_module(bank, offset);
 	bank->mod_usage |= BIT(offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -690,8 +686,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(BIT(offset));
+	if (!LINE_USED(bank->irq_usage, offset)) {
+		omap_set_gpio_direction(bank, offset, 1);
+		omap_clear_gpio_debounce(bank, offset);
+	}
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
@@ -711,29 +710,27 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
  * line's interrupt handler has been run, we may miss some nested
  * interrupts.
  */
-static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
 	unsigned int bit;
-	struct gpio_bank *bank;
-	int unmasked = 0;
-	struct irq_chip *irqchip = irq_desc_get_chip(desc);
-	struct gpio_chip *chip = irq_get_handler_data(irq);
+	struct gpio_bank *bank = gpiobank;
+	unsigned long wa_lock_flags;
+	unsigned long lock_flags;
 
-	chained_irq_enter(irqchip, desc);
-
-	bank = container_of(chip, struct gpio_bank, chip);
 	isr_reg = bank->base + bank->regs->irqstatus;
-	pm_runtime_get_sync(bank->dev);
-
 	if (WARN_ON(!isr_reg))
 		goto exit;
 
+	pm_runtime_get_sync(bank->dev);
+
 	while (1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
+		raw_spin_lock_irqsave(&bank->lock, lock_flags);
+
 		enabled = omap_get_gpio_irqbank_mask(bank);
 		isr_saved = isr = readl_relaxed(isr_reg) & enabled;
 
@@ -747,12 +744,7 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
 		omap_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
 
-		/* if there is only edge sensitive GPIO pin interrupts
-		configured, we could unmask GPIO bank interrupt immediately */
-		if (!level_mask && !unmasked) {
-			unmasked = 1;
-			chained_irq_exit(irqchip, desc);
-		}
+		raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
 
 		if (!isr)
 			break;
@@ -761,6 +753,7 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			bit = __ffs(isr);
 			isr &= ~(BIT(bit));
 
+			raw_spin_lock_irqsave(&bank->lock, lock_flags);
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -771,18 +764,20 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			if (bank->toggle_mask & (BIT(bit)))
 				omap_toggle_gpio_edge_triggering(bank, bit);
 
+			raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
+
+			raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
+
 			generic_handle_irq(irq_find_mapping(bank->chip.irqdomain,
 							    bit));
+
+			raw_spin_unlock_irqrestore(&bank->wa_lock,
+						   wa_lock_flags);
 		}
 	}
-	/* if bank has any level sensitive GPIO pin interrupt
-	configured, we must unmask the bank interrupt only after
-	handler(s) are executed in order to avoid spurious bank
-	interrupt */
 exit:
-	if (!unmasked)
-		chained_irq_exit(irqchip, desc);
 	pm_runtime_put(bank->dev);
+	return IRQ_HANDLED;
 }
 
 static unsigned int omap_gpio_irq_startup(struct irq_data *d)
@@ -791,15 +786,22 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	omap_gpio_init_irq(bank, offset);
+
+	if (!LINE_USED(bank->mod_usage, offset))
+		omap_set_gpio_direction(bank, offset, 1);
+	else if (!omap_gpio_is_input(bank, offset))
+		goto err;
+	omap_enable_gpio_module(bank, offset);
+	bank->irq_usage |= BIT(offset);
+
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	omap_gpio_unmask_irq(d);
 
 	return 0;
+err:
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+	return -EINVAL;
 }
 
 static void omap_gpio_irq_shutdown(struct irq_data *d)
@@ -810,9 +812,26 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->irq_usage &= ~(BIT(offset));
+	omap_set_gpio_irqenable(bank, offset, 0);
+	omap_clear_gpio_irqstatus(bank, offset);
+	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+	if (!LINE_USED(bank->mod_usage, offset))
+		omap_clear_gpio_debounce(bank, offset);
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+static void omap_gpio_irq_bus_lock(struct irq_data *data)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(data);
+
+	if (!BANK_USED(bank))
+		pm_runtime_get_sync(bank->dev);
+}
+
+static void gpio_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
 	/*
 	 * If this is the last IRQ to be freed in the bank,
@@ -1048,10 +1067,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 	 /* Initialize interface clk ungated, module enabled */
 	if (bank->regs->ctrl)
 		writel_relaxed(0, base + bank->regs->ctrl);
-
-	bank->dbck = clk_get(bank->dev, "dbclk");
-	if (IS_ERR(bank->dbck))
-		dev_err(bank->dev, "Could not get gpio dbck\n");
 }
 
 static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
@@ -1080,7 +1095,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	} else {
 		bank->chip.label = "gpio";
 		bank->chip.base = gpio;
-		gpio += bank->width;
 	}
 	bank->chip.ngpio = bank->width;
 
@@ -1090,6 +1104,9 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 		return ret;
 	}
 
+	if (!bank->is_mpuio)
+		gpio += bank->width;
+
 #ifdef CONFIG_ARCH_OMAP1
 	/*
 	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
@@ -1112,7 +1129,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	}
 
 	ret = gpiochip_irqchip_add(&bank->chip, irqc,
-				   irq_base, omap_gpio_irq_handler,
+				   irq_base, handle_bad_irq,
 				   IRQ_TYPE_NONE);
 
 	if (ret) {
@@ -1121,10 +1138,14 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 		return -ENODEV;
 	}
 
-	gpiochip_set_chained_irqchip(&bank->chip, irqc,
-				     bank->irq, omap_gpio_irq_handler);
+	gpiochip_set_chained_irqchip(&bank->chip, irqc, bank->irq, NULL);
 
-	return 0;
+	ret = devm_request_irq(bank->dev, bank->irq, omap_gpio_irq_handler,
+			       0, dev_name(bank->dev), bank);
+	if (ret)
+		gpiochip_remove(&bank->chip);
+
+	return ret;
 }
 
 static const struct of_device_id omap_gpio_match[];
@@ -1163,17 +1184,23 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_unmask = omap_gpio_unmask_irq,
 	irqc->irq_set_type = omap_gpio_irq_type,
 	irqc->irq_set_wake = omap_gpio_wake_enable,
+	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
+	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		dev_err(dev, "Invalid IRQ resource\n");
-		return -ENODEV;
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq <= 0) {
+		if (!bank->irq)
+			bank->irq = -ENXIO;
+		if (bank->irq != -EPROBE_DEFER)
+			dev_err(dev,
+				"can't get irq resource ret=%d\n", bank->irq);
+		return bank->irq;
 	}
 
-	bank->irq = res->start;
 	bank->dev = dev;
 	bank->chip.dev = dev;
+	bank->chip.owner = THIS_MODULE;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
@@ -1183,15 +1210,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF_GPIO
 	bank->chip.of_node = of_node_get(node);
 #endif
-	if (node) {
-		if (!of_property_read_bool(node, "ti,gpio-always-on"))
-			bank->loses_context = true;
-	} else {
-		bank->loses_context = pdata->loses_context;
-
-		if (bank->loses_context)
-			bank->get_context_loss_count =
-				pdata->get_context_loss_count;
+	if (!node) {
+		bank->get_context_loss_count =
+			pdata->get_context_loss_count;
 	}
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
@@ -1200,15 +1221,26 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		bank->set_dataout = omap_set_gpio_dataout_mask;
 
 	raw_spin_lock_init(&bank->lock);
+	raw_spin_lock_init(&bank->wa_lock);
 
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	bank->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(bank->base)) {
-		irq_domain_remove(bank->chip.irqdomain);
 		return PTR_ERR(bank->base);
 	}
 
+	if (bank->dbck_flag) {
+		bank->dbck = devm_clk_get(bank->dev, "dbclk");
+		if (IS_ERR(bank->dbck)) {
+			dev_err(bank->dev,
+				"Could not get gpio dbck. Disable debounce\n");
+			bank->dbck_flag = false;
+		} else {
+			clk_prepare(bank->dbck);
+		}
+	}
+
 	platform_set_drvdata(pdev, bank);
 
 	pm_runtime_enable(bank->dev);
@@ -1221,8 +1253,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_mod_init(bank);
 
 	ret = omap_gpio_chip_init(bank, irqc);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(bank->dev);
+		pm_runtime_disable(bank->dev);
 		return ret;
+	}
 
 	omap_gpio_show_rev(bank);
 
@@ -1233,6 +1268,19 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int omap_gpio_remove(struct platform_device *pdev)
+{
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+
+	list_del(&bank->node);
+	gpiochip_remove(&bank->chip);
+	pm_runtime_disable(bank->dev);
+	if (bank->dbck_flag)
+		clk_unprepare(bank->dbck);
+
+	return 0;
+}
+
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
 #if defined(CONFIG_PM)
@@ -1321,7 +1369,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	 * been initialised and so initialise it now. Also initialise
 	 * the context loss count.
 	 */
-	if (bank->loses_context && !bank->context_valid) {
+	if (!bank->context_valid) {
 		omap_gpio_init_context(bank);
 
 		if (bank->get_context_loss_count)
@@ -1342,17 +1390,15 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	writel_relaxed(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (bank->loses_context) {
-		if (!bank->get_context_loss_count) {
+	if (!bank->get_context_loss_count) {
+		omap_gpio_restore_context(bank);
+	} else {
+		c = bank->get_context_loss_count(bank->dev);
+		if (c != bank->context_loss_count) {
 			omap_gpio_restore_context(bank);
 		} else {
-			c = bank->get_context_loss_count(bank->dev);
-			if (c != bank->context_loss_count) {
-				omap_gpio_restore_context(bank);
-			} else {
-				raw_spin_unlock_irqrestore(&bank->lock, flags);
-				return 0;
-			}
+			raw_spin_unlock_irqrestore(&bank->lock, flags);
+			return 0;
 		}
 	}
 
@@ -1418,12 +1464,13 @@ static int omap_gpio_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+#if IS_BUILTIN(CONFIG_GPIO_OMAP)
 void omap2_gpio_prepare_for_idle(int pwr_mode)
 {
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!BANK_USED(bank))
 			continue;
 
 		bank->power_mode = pwr_mode;
@@ -1437,12 +1484,13 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!BANK_USED(bank))
 			continue;
 
 		pm_runtime_get_sync(bank->dev);
 	}
 }
+#endif
 
 #if defined(CONFIG_PM)
 static void omap_gpio_init_context(struct gpio_bank *p)
@@ -1598,6 +1646,7 @@ MODULE_DEVICE_TABLE(of, omap_gpio_match);
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
+	.remove		= omap_gpio_remove,
 	.driver		= {
 		.name	= "omap_gpio",
 		.pm	= &gpio_pm_ops,
@@ -1615,3 +1664,13 @@ static int __init omap_gpio_drv_reg(void)
 	return platform_driver_register(&omap_gpio_driver);
 }
 postcore_initcall(omap_gpio_drv_reg);
+
+static void __exit omap_gpio_exit(void)
+{
+	platform_driver_unregister(&omap_gpio_driver);
+}
+module_exit(omap_gpio_exit);
+
+MODULE_DESCRIPTION("omap gpio driver");
+MODULE_ALIAS("platform:gpio-omap");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index 5d50b25a73d7..ff43e01b8ca9 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -198,7 +198,6 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
-	bool loses_context;	/* whether the bank would ever lose context */
 	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
@@ -208,9 +207,17 @@ struct omap_gpio_platform_data {
 	int (*get_context_loss_count)(struct device *dev);
 };
 
+#if IS_BUILTIN(CONFIG_GPIO_OMAP)
 extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
-extern void omap_set_gpio_debounce(int gpio, int enable);
-extern void omap_set_gpio_debounce_time(int gpio, int enable);
+#else
+static inline void omap2_gpio_prepare_for_idle(int off_mode)
+{
+}
+
+static inline void omap2_gpio_resume_after_idle(void)
+{
+}
+#endif
 
 #endif
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 20267595df07..e0b0d9b419b5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1008,7 +1008,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	pi_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
 	BUG_ON(ret);
 
 	for (;;) {
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b..1e584b47c987 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17

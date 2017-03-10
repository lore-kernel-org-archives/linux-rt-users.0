From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.48-rt54
Date: Fri, 10 Mar 2017 10:25:13 -0500
Message-ID: <20170310102513.05a37787@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.18.48-rt54 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 7da5438755e5c4ac20b7b6a3e689f5c6ecc18c49


Or to build 3.18.48-rt54 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.48.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.48-rt54.patch.xz



You can also build from 3.18.48-rt53 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.48-rt53-rt54.patch.xz



Enjoy,

-- Steve


Changes from v3.18.48-rt53:

---

Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Julia Cartwright (1):
      pinctrl: qcom: Use raw spinlock variants

Sebastian Andrzej Siewior (3):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Steven Rostedt (VMware) (1):
      Linux 3.18.48-rt54

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper

----
 arch/x86/mm/pageattr.c             |  8 +++++++
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++-------------------
 include/linux/module.h             |  6 +++++
 include/linux/mutex_rt.h           |  5 ++++
 include/linux/percpu.h             |  1 +
 include/linux/radix-tree.h         | 12 ++--------
 kernel/locking/lockdep.c           | 32 ++++++++++++++++++-------
 kernel/module.c                    | 36 ++++++++++++++++++----------
 lib/radix-tree.c                   | 23 +++++++++++-------
 localversion-rt                    |  2 +-
 mm/percpu.c                        | 37 ++++++++++++++++++-----------
 11 files changed, 131 insertions(+), 79 deletions(-)
---------------------------
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e5545f2105f6..3c4b0318a363 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -211,7 +211,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Avoid wbinvd() because it causes latencies on all CPUs,
+	 * regardless of any CPU isolation that may be in effect.
+	 */
+	unsigned long do_wbinvd = 0;
+#else
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
+#endif
 
 	BUG_ON(irqs_disabled());
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ed7017df065d..94f1a4fd7681 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -59,7 +59,7 @@ struct msm_pinctrl {
 	struct notifier_block restart_nb;
 	int irq;
 
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
@@ -155,14 +155,14 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->ctl_reg);
 	val &= ~(0x7 << g->mux_bit);
 	val |= i << g->mux_bit;
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -336,14 +336,14 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			break;
 		case PIN_CONFIG_OUTPUT:
 			/* set output value */
-			spin_lock_irqsave(&pctrl->lock, flags);
+			raw_spin_lock_irqsave(&pctrl->lock, flags);
 			val = readl(pctrl->regs + g->io_reg);
 			if (arg)
 				val |= BIT(g->out_bit);
 			else
 				val &= ~BIT(g->out_bit);
 			writel(val, pctrl->regs + g->io_reg);
-			spin_unlock_irqrestore(&pctrl->lock, flags);
+			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 			/* enable output */
 			arg = 1;
@@ -360,12 +360,12 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		}
 
-		spin_lock_irqsave(&pctrl->lock, flags);
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
 		val = readl(pctrl->regs + g->ctl_reg);
 		val &= ~(mask << bit);
 		val |= arg << bit;
 		writel(val, pctrl->regs + g->ctl_reg);
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 
 	return 0;
@@ -394,13 +394,13 @@ static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->ctl_reg);
 	val &= ~BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -414,7 +414,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -427,7 +427,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 	val |= BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -453,7 +453,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -462,7 +462,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		val &= ~BIT(g->out_bit);
 	writel(val, pctrl->regs + g->io_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -593,7 +593,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
 	val &= ~BIT(g->intr_enable_bit);
@@ -601,7 +601,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -614,7 +614,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	val &= ~BIT(g->intr_status_bit);
@@ -626,7 +626,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -639,7 +639,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	if (g->intr_ack_high)
@@ -651,7 +651,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -664,7 +664,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/*
 	 * For hw without possibility of detecting both edges
@@ -738,7 +738,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -754,11 +754,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct msm_pinctrl *pctrl = to_msm_pinctrl(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	irq_set_irq_wake(pctrl->irq, on);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -895,7 +895,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	pctrl->soc = soc_data;
 	pctrl->chip = msm_gpio_template;
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/include/linux/module.h b/include/linux/module.h
index 6fc269ce701c..208518a81281 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -394,6 +394,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
@@ -546,6 +547,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+static inline bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 static inline bool is_module_text_address(unsigned long addr)
 {
 	return false;
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index c38a44b14da5..e0284edec655 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
+
+#ifdef CONFIG_DEBUG_MUTEXES
 #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
+#else
+static inline void mutex_destroy(struct mutex *lock) {}
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 208d86d80cba..a3a446c2901b 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -144,6 +144,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 #endif
 
 extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
 #if !defined(CONFIG_SMP) || !defined(CONFIG_HAVE_SETUP_PER_CPU_AREA)
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 9a80663a1574..e46b414e9e39 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -277,13 +277,10 @@ radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 unsigned int radix_tree_gang_lookup_slot(struct radix_tree_root *root,
 			void ***results, unsigned long *indices,
 			unsigned long first_index, unsigned int max_items);
-#ifndef CONFIG_PREEMPT_RT_FULL
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
-#else
-static inline int radix_tree_preload(gfp_t gm) { return 0; }
-static inline int radix_tree_maybe_preload(gfp_t gfp_mask) { return 0; }
-#endif
+void radix_tree_preload_end(void);
+
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag);
@@ -306,11 +303,6 @@ unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
 int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
 unsigned long radix_tree_locate_item(struct radix_tree_root *root, void *item);
 
-static inline void radix_tree_preload_end(void)
-{
-	preempt_enable_nort();
-}
-
 /**
  * struct radix_tree_iter - radix tree iterator state
  *
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fce6f6f69aad..d4a4d8ea55d6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -654,6 +654,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -681,10 +682,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
 	/*
 	 * Static locks do not have their class-keys yet - for them the key
-	 * is the lock object itself:
+	 * is the lock object itself. If the lock is in the per cpu area,
+	 * the canonical address of the lock (per cpu offset removed) is
+	 * used.
 	 */
-	if (unlikely(!lock->key))
-		lock->key = (void *)lock;
+	if (unlikely(!lock->key)) {
+		unsigned long can_addr, addr = (unsigned long)lock;
+
+		if (__is_kernel_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (__is_module_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (static_obj(lock))
+			lock->key = (void *)lock;
+		else
+			return ERR_PTR(-EINVAL);
+		is_static = true;
+	}
 
 	/*
 	 * NOTE: the class-key must be unique. For dynamic locks, a static
@@ -714,7 +728,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -731,13 +745,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	unsigned long flags;
 
 	class = look_up_lock_class(lock, subclass);
-	if (likely(class))
+	if (likely(!IS_ERR_OR_NULL(class)))
 		goto out_set_class_cache;
 
 	/*
 	 * Debug-check: all keys must be persistent!
- 	 */
-	if (!static_obj(lock->key)) {
+	 */
+	if (IS_ERR(class)) {
 		debug_locks_off();
 		printk("INFO: trying to register non-static key.\n");
 		printk("the code is fine but needs lockdep annotation.\n");
@@ -3276,7 +3290,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -3938,7 +3952,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 737d53099360..ab5169e72289 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -526,16 +526,7 @@ static void percpu_modcopy(struct module *mod,
 		memcpy(per_cpu_ptr(mod->percpu, cpu), from, size);
 }
 
-/**
- * is_module_percpu_address - test whether address is from module static percpu
- * @addr: address to test
- *
- * Test whether @addr belongs to module static percpu area.
- *
- * RETURNS:
- * %true if @addr is from module static percpu area
- */
-bool is_module_percpu_address(unsigned long addr)
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 	struct module *mod;
 	unsigned int cpu;
@@ -549,9 +540,11 @@ bool is_module_percpu_address(unsigned long addr)
 			continue;
 		for_each_possible_cpu(cpu) {
 			void *start = per_cpu_ptr(mod->percpu, cpu);
+			void *va = (void *)addr;
 
-			if ((void *)addr >= start &&
-			    (void *)addr < start + mod->percpu_size) {
+			if (va >= start && va < start + mod->percpu_size) {
+				if (can_addr)
+					*can_addr = (unsigned long) (va - start);
 				preempt_enable();
 				return true;
 			}
@@ -562,6 +555,20 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+/**
+ * is_module_percpu_address - test whether address is from module static percpu
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to module static percpu area.
+ *
+ * RETURNS:
+ * %true if @addr is from module static percpu area
+ */
+bool is_module_percpu_address(unsigned long addr)
+{
+	return __is_module_percpu_address(addr, NULL);
+}
+
 #else /* ... !CONFIG_SMP */
 
 static inline void __percpu *mod_percpu(struct module *mod)
@@ -593,6 +600,11 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #define MODINFO_ATTR(field)	\
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 19713243e698..14192936ee69 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -34,7 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
 #include <linux/preempt_mask.h>		/* in_interrupt() */
-
+#include <linux/locallock.h>
 
 /*
  * The height_to_maxindex array needs to be one deeper than the maximum
@@ -68,6 +68,7 @@ struct radix_tree_preload {
 	struct radix_tree_node *nodes[RADIX_TREE_PRELOAD_SIZE];
 };
 static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+static DEFINE_LOCAL_IRQ_LOCK(radix_tree_preloads_lock);
 
 static inline void *ptr_to_indirect(void *ptr)
 {
@@ -195,13 +196,13 @@ radix_tree_node_alloc(struct radix_tree_root *root)
 		 * succeed in getting a node here (and never reach
 		 * kmem_cache_alloc)
 		 */
-		rtp = &get_cpu_var(radix_tree_preloads);
+		rtp = &get_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
 		if (rtp->nr) {
 			ret = rtp->nodes[rtp->nr - 1];
 			rtp->nodes[rtp->nr - 1] = NULL;
 			rtp->nr--;
 		}
-		put_cpu_var(radix_tree_preloads);
+		put_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
 		/*
 		 * Update the allocation stack trace as this is more useful
 		 * for debugging.
@@ -241,7 +242,6 @@ radix_tree_node_free(struct radix_tree_node *node)
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Load up this CPU's radix_tree_node buffer with sufficient objects to
  * ensure that the addition of a single element in the tree cannot fail.  On
@@ -257,14 +257,14 @@ static int __radix_tree_preload(gfp_t gfp_mask)
 	struct radix_tree_node *node;
 	int ret = -ENOMEM;
 
-	preempt_disable();
+	local_lock(radix_tree_preloads_lock);
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
-		preempt_enable();
+		local_unlock(radix_tree_preloads_lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		preempt_disable();
+		local_lock(radix_tree_preloads_lock);
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < ARRAY_SIZE(rtp->nodes))
 			rtp->nodes[rtp->nr++] = node;
@@ -303,11 +303,16 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 	if (gfp_mask & __GFP_WAIT)
 		return __radix_tree_preload(gfp_mask);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	preempt_disable();
+	local_lock(radix_tree_preloads_lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
-#endif
+
+void radix_tree_preload_end(void)
+{
+	local_unlock(radix_tree_preloads_lock);
+}
+EXPORT_SYMBOL(radix_tree_preload_end);
 
 /*
  *	Return the maximum key which can be store into a
diff --git a/localversion-rt b/localversion-rt
index e6c0dc6a54cd..3165a8781ff5 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt53
+-rt54
diff --git a/mm/percpu.c b/mm/percpu.c
index 5ae6e0284967..d270e8077f52 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1282,18 +1282,7 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
-/**
- * is_kernel_percpu_address - test whether address is from static percpu area
- * @addr: address to test
- *
- * Test whether @addr belongs to in-kernel static percpu area.  Module
- * static percpu areas are not considered.  For those, use
- * is_module_percpu_address().
- *
- * RETURNS:
- * %true if @addr is from in-kernel static percpu area, %false otherwise.
- */
-bool is_kernel_percpu_address(unsigned long addr)
+bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 #ifdef CONFIG_SMP
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
@@ -1302,16 +1291,36 @@ bool is_kernel_percpu_address(unsigned long addr)
 
 	for_each_possible_cpu(cpu) {
 		void *start = per_cpu_ptr(base, cpu);
+		void *va = (void *)addr;
 
-		if ((void *)addr >= start && (void *)addr < start + static_size)
+		if (va >= start && va < start + static_size) {
+			if (can_addr)
+				*can_addr = (unsigned long) (va - start);
 			return true;
-        }
+		}
+	}
 #endif
 	/* on UP, can't distinguish from other static vars, always false */
 	return false;
 }
 
 /**
+ * is_kernel_percpu_address - test whether address is from static percpu area
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to in-kernel static percpu area.  Module
+ * static percpu areas are not considered.  For those, use
+ * is_module_percpu_address().
+ *
+ * RETURNS:
+ * %true if @addr is from in-kernel static percpu area, %false otherwise.
+ */
+bool is_kernel_percpu_address(unsigned long addr)
+{
+	return __is_kernel_percpu_address(addr, NULL);
+}
+
+/**
  * per_cpu_ptr_to_phys - convert translated percpu address to physical address
  * @addr: the address to be converted to physical address
  *

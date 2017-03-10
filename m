From: Julia Cartwright <julia@ni.com>
Subject: [ANNOUNCE] 4.1.38-rt46
Date: Fri, 10 Mar 2017 11:30:07 -0600
Message-ID: <20170310173007.GB32162@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41104 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933173AbdCJRac (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 12:30:32 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hell RT Folks!

I'm pleased to announce the 4.1.38-rt46 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.1-rt
  Head SHA1: d7e24898bcc13308fa03b62c9c8198d86ec2349c


Or to build 4.1.38-rt46 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.38-rt46.patch.xz


You can also build from 4.1.38-rt45 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.38-rt45-rt46.patch.xz


Enjoy!
   Julia

Changes from v4.1.38-rt45:
---
Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Julia Cartwright (2):
      pinctrl: qcom: Use raw spinlock variants
      Linux 4.1.38-rt46

Mike Galbraith (1):
      cpuset: Convert callback_lock to raw_spinlock_t

Sebastian Andrzej Siewior (3):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper
----
 arch/x86/mm/pageattr.c             |  8 +++++
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++--------------
 include/linux/module.h             |  6 ++++
 include/linux/mutex_rt.h           |  5 +++
 include/linux/percpu.h             |  1 +
 include/linux/radix-tree.h         | 12 ++-----
 kernel/cpuset.c                    | 66 +++++++++++++++++++-------------------
 kernel/locking/lockdep.c           | 33 +++++++++++++------
 kernel/module.c                    | 36 ++++++++++++++-------
 lib/radix-tree.c                   | 22 ++++++++-----
 localversion-rt                    |  2 +-
 mm/percpu.c                        | 37 +++++++++++++--------
 12 files changed, 164 insertions(+), 112 deletions(-)
---------------------------
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 2dd9b3ad3bb5..4314b9103ff0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -209,7 +209,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
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
index f3d800f796c2..9c91fe998ad8 100644
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
@@ -325,14 +325,14 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
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
@@ -353,12 +353,12 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
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
@@ -386,13 +386,13 @@ static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
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
@@ -406,7 +406,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -419,7 +419,7 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
 	val |= BIT(g->oe_bit);
 	writel(val, pctrl->regs + g->ctl_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -445,7 +445,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	g = &pctrl->soc->groups[offset];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->io_reg);
 	if (value)
@@ -454,7 +454,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		val &= ~BIT(g->out_bit);
 	writel(val, pctrl->regs + g->io_reg);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -585,7 +585,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
 	val &= ~BIT(g->intr_enable_bit);
@@ -593,7 +593,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -606,7 +606,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	val &= ~BIT(g->intr_status_bit);
@@ -618,7 +618,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -631,7 +631,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_status_reg);
 	if (g->intr_ack_high)
@@ -643,7 +643,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -656,7 +656,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/*
 	 * For hw without possibility of detecting both edges
@@ -730,7 +730,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(pctrl, g, d);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -746,11 +746,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct msm_pinctrl *pctrl = to_msm_pinctrl(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	irq_set_irq_wake(pctrl->irq, on);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -887,7 +887,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	pctrl->soc = soc_data;
 	pctrl->chip = msm_gpio_template;
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pctrl->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/include/linux/module.h b/include/linux/module.h
index b2da02e1591d..2fd71ecdd63a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -386,6 +386,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
@@ -538,6 +539,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
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
index 53a60a51c758..4ecc057b6e27 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -145,6 +145,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
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
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 71403502411b..45da566b9749 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -284,7 +284,7 @@ static struct cpuset top_cpuset = {
  */
 
 static DEFINE_MUTEX(cpuset_mutex);
-static DEFINE_SPINLOCK(callback_lock);
+static DEFINE_RAW_SPINLOCK(callback_lock);
 
 /*
  * CPU / memory hotplug is handled asynchronously.
@@ -903,9 +903,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, new_cpus);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!cgroup_on_dfl(cp->css.cgroup) &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
@@ -970,9 +970,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		return retval;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->cpus_allowed as a temp variable */
 	update_cpumasks_hier(cs, trialcs->cpus_allowed);
@@ -1159,9 +1159,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!cgroup_on_dfl(cp->css.cgroup) &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -1229,9 +1229,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -1322,9 +1322,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
 		rebuild_sched_domains_locked();
@@ -1726,7 +1726,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -1745,7 +1745,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -1962,12 +1962,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
 	cpuset_inc();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (cgroup_on_dfl(cs->css.cgroup)) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
 		goto out_unlock;
@@ -1994,12 +1994,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	}
 	rcu_read_unlock();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return 0;
@@ -2038,7 +2038,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	mutex_lock(&cpuset_mutex);
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	if (cgroup_on_dfl(root_css->cgroup)) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -2049,7 +2049,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -2149,12 +2149,12 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 {
 	bool is_empty;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, new_cpus);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/*
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
@@ -2191,10 +2191,10 @@ hotplug_update_tasks(struct cpuset *cs,
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
 		update_tasks_cpumask(cs);
@@ -2280,21 +2280,21 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 
 	/* synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
 	}
 
 	/* synchronize mems_allowed to N_MEMORY */
 	if (mems_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		update_tasks_nodemask(&top_cpuset);
 	}
 
@@ -2389,11 +2389,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_cpus(task_cs(tsk), pmask);
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
@@ -2441,11 +2441,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -2537,14 +2537,14 @@ int __cpuset_node_allowed(int node, gfp_t gfp_mask)
 		return 1;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 	rcu_read_unlock();
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 577f02617c63..1681f99ed566 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -668,6 +668,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -695,10 +696,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
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
@@ -730,7 +744,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -748,19 +762,18 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
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
 		printk("turning off the locking correctness validator.\n");
 		dump_stack();
-
 		return NULL;
 	}
 
@@ -3297,7 +3310,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -3982,7 +3995,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 6920d1080cdd..a7ac858fd1a1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -525,16 +525,7 @@ static void percpu_modcopy(struct module *mod,
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
@@ -548,9 +539,11 @@ bool is_module_percpu_address(unsigned long addr)
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
@@ -561,6 +554,20 @@ bool is_module_percpu_address(unsigned long addr)
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
@@ -592,6 +599,11 @@ bool is_module_percpu_address(unsigned long addr)
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
index 19713243e698..e91567dc635f 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
 #include <linux/preempt_mask.h>		/* in_interrupt() */
+#include <linux/locallock.h>
 
 
 /*
@@ -68,6 +69,7 @@ struct radix_tree_preload {
 	struct radix_tree_node *nodes[RADIX_TREE_PRELOAD_SIZE];
 };
 static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+static DEFINE_LOCAL_IRQ_LOCK(radix_tree_preloads_lock);
 
 static inline void *ptr_to_indirect(void *ptr)
 {
@@ -195,13 +197,13 @@ radix_tree_node_alloc(struct radix_tree_root *root)
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
@@ -241,7 +243,6 @@ radix_tree_node_free(struct radix_tree_node *node)
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Load up this CPU's radix_tree_node buffer with sufficient objects to
  * ensure that the addition of a single element in the tree cannot fail.  On
@@ -257,14 +258,14 @@ static int __radix_tree_preload(gfp_t gfp_mask)
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
@@ -303,11 +304,16 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
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
index 38c40b21a885..272158183778 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt45
+-rt46
diff --git a/mm/percpu.c b/mm/percpu.c
index b97617587620..3289dbd519a1 100644
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

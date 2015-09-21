From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 4.1.7-rt8
Date: Mon, 21 Sep 2015 18:48:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509211845280.5606@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.1.7-rt8 patch set. v4.1.6-rt6 and
v4.1.7-rt7 are non-announced updates to incorporate the linux-4.1.y
stable tree changes.

Changes since v4.1.5-rt5:

  - Update to 4.1.7

  - Cherry-pick a XFS lockdep annotation fix from mainline

  - Use preempt_xxx_nort in the generic implementation of
    k[un]map_atomic.

  - Revert d04ea10ba1ea mmc: sdhci: don't provide hard irq handler

  - Force thread primary handlers of interrupts which provide both a
    primary and a threaded handler

  - Move clear_tasks_mm_cpumask() call to __cpu_die() on ARM
    (Grygoriii)

  - Fix a RCU splat in the trace histogram (Philipp)

Solved issues:

  - The high CPU usage problem reported by Nicholas turned out to be a
    scalability issue of the gcov instrumentation

Known issues:

  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.1.7-rt7 is appended below and can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.7-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.7-rt8

The RT patch against 4.1.5 can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.7-rt8.patch.xz

The split quilt queue is available at:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.7-rt8.tar.xz

Enjoy!

	tglx
---
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f11d82527076..e561aef093c7 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -213,8 +213,6 @@ int __cpu_disable(void)
 	flush_cache_louis();
 	local_flush_tlb_all();
 
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
@@ -230,6 +228,9 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
+
+	clear_tasks_mm_cpumask(cpu);
+
 	pr_notice("CPU%u: shutdown\n", cpu);
 
 	/*
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index acd8c620ec43..bec8a307f8cd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2691,31 +2691,6 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-static irqreturn_t sdhci_rt_irq(int irq, void *dev_id)
-{
-	irqreturn_t ret;
-
-	local_bh_disable();
-	ret = sdhci_irq(irq, dev_id);
-	local_bh_enable();
-	if (ret == IRQ_WAKE_THREAD)
-		ret = sdhci_thread_irq(irq, dev_id);
-	return ret;
-}
-#endif
-
-static int sdhci_req_irq(struct sdhci_host *host)
-{
-#ifdef CONFIG_PREEMPT_RT_BASE
-	return request_threaded_irq(host->irq, NULL, sdhci_rt_irq,
-				    IRQF_SHARED, mmc_hostname(host->mmc), host);
-#else
-	return request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
-				    IRQF_SHARED, mmc_hostname(host->mmc), host);
-#endif
-}
-
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
@@ -2783,7 +2758,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = sdhci_req_irq(host);
+		ret = request_threaded_irq(host->irq, sdhci_irq,
+					   sdhci_thread_irq, IRQF_SHARED,
+					   mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
 	} else {
@@ -3444,7 +3421,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = sdhci_req_irq(host);
+	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 539a85fddbc2..fec4bfba0839 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -164,7 +164,7 @@ xfs_ilock(
 	       (XFS_MMAPLOCK_SHARED | XFS_MMAPLOCK_EXCL));
 	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
-	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_DEP_MASK)) == 0);
+	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
 
 	if (lock_flags & XFS_IOLOCK_EXCL)
 		mrupdate_nested(&ip->i_iolock, XFS_IOLOCK_DEP(lock_flags));
@@ -212,7 +212,7 @@ xfs_ilock_nowait(
 	       (XFS_MMAPLOCK_SHARED | XFS_MMAPLOCK_EXCL));
 	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
-	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_DEP_MASK)) == 0);
+	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
 
 	if (lock_flags & XFS_IOLOCK_EXCL) {
 		if (!mrtryupdate(&ip->i_iolock))
@@ -281,7 +281,7 @@ xfs_iunlock(
 	       (XFS_MMAPLOCK_SHARED | XFS_MMAPLOCK_EXCL));
 	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
-	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_DEP_MASK)) == 0);
+	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
 	ASSERT(lock_flags != 0);
 
 	if (lock_flags & XFS_IOLOCK_EXCL)
@@ -364,30 +364,38 @@ int xfs_lock_delays;
 
 /*
  * Bump the subclass so xfs_lock_inodes() acquires each lock with a different
- * value. This shouldn't be called for page fault locking, but we also need to
- * ensure we don't overrun the number of lockdep subclasses for the iolock or
- * mmaplock as that is limited to 12 by the mmap lock lockdep annotations.
+ * value. This can be called for any type of inode lock combination, including
+ * parent locking. Care must be taken to ensure we don't overrun the subclass
+ * storage fields in the class mask we build.
  */
 static inline int
 xfs_lock_inumorder(int lock_mode, int subclass)
 {
+	int	class = 0;
+
+	ASSERT(!(lock_mode & (XFS_ILOCK_PARENT | XFS_ILOCK_RTBITMAP |
+			      XFS_ILOCK_RTSUM)));
+
 	if (lock_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)) {
-		ASSERT(subclass + XFS_LOCK_INUMORDER <
-			(1 << (XFS_MMAPLOCK_SHIFT - XFS_IOLOCK_SHIFT)));
-		lock_mode |= (subclass + XFS_LOCK_INUMORDER) << XFS_IOLOCK_SHIFT;
+		ASSERT(subclass <= XFS_IOLOCK_MAX_SUBCLASS);
+		ASSERT(subclass + XFS_IOLOCK_PARENT_VAL <
+						MAX_LOCKDEP_SUBCLASSES);
+		class += subclass << XFS_IOLOCK_SHIFT;
+		if (lock_mode & XFS_IOLOCK_PARENT)
+			class += XFS_IOLOCK_PARENT_VAL << XFS_IOLOCK_SHIFT;
 	}
 
 	if (lock_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) {
-		ASSERT(subclass + XFS_LOCK_INUMORDER <
-			(1 << (XFS_ILOCK_SHIFT - XFS_MMAPLOCK_SHIFT)));
-		lock_mode |= (subclass + XFS_LOCK_INUMORDER) <<
-							XFS_MMAPLOCK_SHIFT;
+		ASSERT(subclass <= XFS_MMAPLOCK_MAX_SUBCLASS);
+		class += subclass << XFS_MMAPLOCK_SHIFT;
 	}
 
-	if (lock_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL))
-		lock_mode |= (subclass + XFS_LOCK_INUMORDER) << XFS_ILOCK_SHIFT;
+	if (lock_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)) {
+		ASSERT(subclass <= XFS_ILOCK_MAX_SUBCLASS);
+		class += subclass << XFS_ILOCK_SHIFT;
+	}
 
-	return lock_mode;
+	return (lock_mode & ~XFS_LOCK_SUBCLASS_MASK) | class;
 }
 
 /*
@@ -399,6 +407,11 @@ xfs_lock_inumorder(int lock_mode, int subclass)
  * transaction (such as truncate). This can result in deadlock since the long
  * running trans might need to wait for the inode we just locked in order to
  * push the tail and free space in the log.
+ *
+ * xfs_lock_inodes() can only be used to lock one type of lock at a time -
+ * the iolock, the mmaplock or the ilock, but not more than one at a time. If we
+ * lock more than one at a time, lockdep will report false positives saying we
+ * have violated locking orders.
  */
 void
 xfs_lock_inodes(
@@ -409,8 +422,29 @@ xfs_lock_inodes(
 	int		attempts = 0, i, j, try_lock;
 	xfs_log_item_t	*lp;
 
-	/* currently supports between 2 and 5 inodes */
+	/*
+	 * Currently supports between 2 and 5 inodes with exclusive locking.  We
+	 * support an arbitrary depth of locking here, but absolute limits on
+	 * inodes depend on the the type of locking and the limits placed by
+	 * lockdep annotations in xfs_lock_inumorder.  These are all checked by
+	 * the asserts.
+	 */
 	ASSERT(ips && inodes >= 2 && inodes <= 5);
+	ASSERT(lock_mode & (XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL |
+			    XFS_ILOCK_EXCL));
+	ASSERT(!(lock_mode & (XFS_IOLOCK_SHARED | XFS_MMAPLOCK_SHARED |
+			      XFS_ILOCK_SHARED)));
+	ASSERT(!(lock_mode & XFS_IOLOCK_EXCL) ||
+		inodes <= XFS_IOLOCK_MAX_SUBCLASS + 1);
+	ASSERT(!(lock_mode & XFS_MMAPLOCK_EXCL) ||
+		inodes <= XFS_MMAPLOCK_MAX_SUBCLASS + 1);
+	ASSERT(!(lock_mode & XFS_ILOCK_EXCL) ||
+		inodes <= XFS_ILOCK_MAX_SUBCLASS + 1);
+
+	if (lock_mode & XFS_IOLOCK_EXCL) {
+		ASSERT(!(lock_mode & (XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL)));
+	} else if (lock_mode & XFS_MMAPLOCK_EXCL)
+		ASSERT(!(lock_mode & XFS_ILOCK_EXCL));
 
 	try_lock = 0;
 	i = 0;
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 8f22d20368d8..ee26a603c131 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -284,9 +284,9 @@ static inline int xfs_isiflocked(struct xfs_inode *ip)
  * Flags for lockdep annotations.
  *
  * XFS_LOCK_PARENT - for directory operations that require locking a
- * parent directory inode and a child entry inode.  The parent gets locked
- * with this flag so it gets a lockdep subclass of 1 and the child entry
- * lock will have a lockdep subclass of 0.
+ * parent directory inode and a child entry inode. IOLOCK requires nesting,
+ * MMAPLOCK does not support this class, ILOCK requires a single subclass
+ * to differentiate parent from child.
  *
  * XFS_LOCK_RTBITMAP/XFS_LOCK_RTSUM - the realtime device bitmap and summary
  * inodes do not participate in the normal lock order, and thus have their
@@ -295,30 +295,63 @@ static inline int xfs_isiflocked(struct xfs_inode *ip)
  * XFS_LOCK_INUMORDER - for locking several inodes at the some time
  * with xfs_lock_inodes().  This flag is used as the starting subclass
  * and each subsequent lock acquired will increment the subclass by one.
- * So the first lock acquired will have a lockdep subclass of 4, the
- * second lock will have a lockdep subclass of 5, and so on. It is
- * the responsibility of the class builder to shift this to the correct
- * portion of the lock_mode lockdep mask.
+ * However, MAX_LOCKDEP_SUBCLASSES == 8, which means we are greatly
+ * limited to the subclasses we can represent via nesting. We need at least
+ * 5 inodes nest depth for the ILOCK through rename, and we also have to support
+ * XFS_ILOCK_PARENT, which gives 6 subclasses. Then we have XFS_ILOCK_RTBITMAP
+ * and XFS_ILOCK_RTSUM, which are another 2 unique subclasses, so that's all
+ * 8 subclasses supported by lockdep.
+ *
+ * This also means we have to number the sub-classes in the lowest bits of
+ * the mask we keep, and we have to ensure we never exceed 3 bits of lockdep
+ * mask and we can't use bit-masking to build the subclasses. What a mess.
+ *
+ * Bit layout:
+ *
+ * Bit		Lock Region
+ * 16-19	XFS_IOLOCK_SHIFT dependencies
+ * 20-23	XFS_MMAPLOCK_SHIFT dependencies
+ * 24-31	XFS_ILOCK_SHIFT dependencies
+ *
+ * IOLOCK values
+ *
+ * 0-3		subclass value
+ * 4-7		PARENT subclass values
+ *
+ * MMAPLOCK values
+ *
+ * 0-3		subclass value
+ * 4-7		unused
+ *
+ * ILOCK values
+ * 0-4		subclass values
+ * 5		PARENT subclass (not nestable)
+ * 6		RTBITMAP subclass (not nestable)
+ * 7		RTSUM subclass (not nestable)
+ *
  */
-#define XFS_LOCK_PARENT		1
-#define XFS_LOCK_RTBITMAP	2
-#define XFS_LOCK_RTSUM		3
-#define XFS_LOCK_INUMORDER	4
-
-#define XFS_IOLOCK_SHIFT	16
-#define	XFS_IOLOCK_PARENT	(XFS_LOCK_PARENT << XFS_IOLOCK_SHIFT)
-
-#define XFS_MMAPLOCK_SHIFT	20
-
-#define XFS_ILOCK_SHIFT		24
-#define	XFS_ILOCK_PARENT	(XFS_LOCK_PARENT << XFS_ILOCK_SHIFT)
-#define	XFS_ILOCK_RTBITMAP	(XFS_LOCK_RTBITMAP << XFS_ILOCK_SHIFT)
-#define	XFS_ILOCK_RTSUM		(XFS_LOCK_RTSUM << XFS_ILOCK_SHIFT)
-
-#define XFS_IOLOCK_DEP_MASK	0x000f0000
-#define XFS_MMAPLOCK_DEP_MASK	0x00f00000
-#define XFS_ILOCK_DEP_MASK	0xff000000
-#define XFS_LOCK_DEP_MASK	(XFS_IOLOCK_DEP_MASK | \
+#define XFS_IOLOCK_SHIFT		16
+#define XFS_IOLOCK_PARENT_VAL		4
+#define XFS_IOLOCK_MAX_SUBCLASS		(XFS_IOLOCK_PARENT_VAL - 1)
+#define XFS_IOLOCK_DEP_MASK		0x000f0000
+#define	XFS_IOLOCK_PARENT		(XFS_IOLOCK_PARENT_VAL << XFS_IOLOCK_SHIFT)
+
+#define XFS_MMAPLOCK_SHIFT		20
+#define XFS_MMAPLOCK_NUMORDER		0
+#define XFS_MMAPLOCK_MAX_SUBCLASS	3
+#define XFS_MMAPLOCK_DEP_MASK		0x00f00000
+
+#define XFS_ILOCK_SHIFT			24
+#define XFS_ILOCK_PARENT_VAL		5
+#define XFS_ILOCK_MAX_SUBCLASS		(XFS_ILOCK_PARENT_VAL - 1)
+#define XFS_ILOCK_RTBITMAP_VAL		6
+#define XFS_ILOCK_RTSUM_VAL		7
+#define XFS_ILOCK_DEP_MASK		0xff000000
+#define	XFS_ILOCK_PARENT		(XFS_ILOCK_PARENT_VAL << XFS_ILOCK_SHIFT)
+#define	XFS_ILOCK_RTBITMAP		(XFS_ILOCK_RTBITMAP_VAL << XFS_ILOCK_SHIFT)
+#define	XFS_ILOCK_RTSUM			(XFS_ILOCK_RTSUM_VAL << XFS_ILOCK_SHIFT)
+
+#define XFS_LOCK_SUBCLASS_MASK	(XFS_IOLOCK_DEP_MASK | \
 				 XFS_MMAPLOCK_DEP_MASK | \
 				 XFS_ILOCK_DEP_MASK)
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d89b5e083c35..06bae5a6761d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -66,7 +66,7 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_atomic(struct page *page)
 {
-	preempt_disable();
+	preempt_disable_nort();
 	pagefault_disable();
 	return page_address(page);
 }
@@ -75,7 +75,7 @@ static inline void *kmap_atomic(struct page *page)
 static inline void __kunmap_atomic(void *addr)
 {
 	pagefault_enable();
-	preempt_enable();
+	preempt_enable_nort();
 }
 
 #define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 67f2af8c0cd5..fe254555cf95 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -104,6 +104,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @flags:	flags (see IRQF_* above)
  * @thread_fn:	interrupt handler function for threaded interrupts
  * @thread:	thread pointer for threaded interrupts
+ * @secondary:	pointer to secondary irqaction (force threading)
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
  * @dir:	pointer to the proc/irq/NN/name entry
@@ -115,6 +116,7 @@ struct irqaction {
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
+	struct irqaction	*secondary;
 	unsigned int		irq;
 	unsigned int		flags;
 	unsigned long		thread_flags;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1b5c50a68e23..79c55c26eaee 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -772,6 +772,12 @@ static irqreturn_t irq_nested_primary_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
+{
+	WARN(1, "Secondary action handler called for irq %d\n", irq);
+	return IRQ_NONE;
+}
+
 static int irq_wait_for_interrupt(struct irqaction *action)
 {
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -798,7 +804,8 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 static void irq_finalize_oneshot(struct irq_desc *desc,
 				 struct irqaction *action)
 {
-	if (!(desc->istate & IRQS_ONESHOT))
+	if (!(desc->istate & IRQS_ONESHOT) ||
+	    action->handler == irq_forced_secondary_handler)
 		return;
 again:
 	chip_bus_lock(desc);
@@ -960,6 +967,18 @@ static void irq_thread_dtor(struct callback_head *unused)
 	irq_finalize_oneshot(desc, action);
 }
 
+static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
+{
+	struct irqaction *secondary = action->secondary;
+
+	if (WARN_ON_ONCE(!secondary))
+		return;
+
+	raw_spin_lock_irq(&desc->lock);
+	__irq_wake_thread(desc, secondary);
+	raw_spin_unlock_irq(&desc->lock);
+}
+
 /*
  * Interrupt handler thread
  */
@@ -990,6 +1009,8 @@ static int irq_thread(void *data)
 		action_ret = handler_fn(desc, action);
 		if (action_ret == IRQ_HANDLED)
 			atomic_inc(&desc->threads_handled);
+		if (action_ret == IRQ_WAKE_THREAD)
+			irq_wake_secondary(desc, action);
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 		migrate_disable();
@@ -1040,20 +1061,36 @@ void irq_wake_thread(unsigned int irq, void *dev_id)
 }
 EXPORT_SYMBOL_GPL(irq_wake_thread);
 
-static void irq_setup_forced_threading(struct irqaction *new)
+static int irq_setup_forced_threading(struct irqaction *new)
 {
 	if (!force_irqthreads)
-		return;
+		return 0;
 	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
-		return;
+		return 0;
 
 	new->flags |= IRQF_ONESHOT;
 
-	if (!new->thread_fn) {
-		set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
-		new->thread_fn = new->handler;
-		new->handler = irq_default_primary_handler;
+	/*
+	 * Handle the case where we have a real primary handler and a
+	 * thread handler. We force thread them as well by creating a
+	 * secondary action.
+	 */
+	if (new->handler != irq_default_primary_handler && new->thread_fn) {
+		/* Allocate the secondary action */
+		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+		if (!new->secondary)
+			return -ENOMEM;
+		new->secondary->handler = irq_forced_secondary_handler;
+		new->secondary->thread_fn = new->thread_fn;
+		new->secondary->dev_id = new->dev_id;
+		new->secondary->irq = new->irq;
+		new->secondary->name = new->name;
 	}
+	/* Deal with the primary handler */
+	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
+	new->thread_fn = new->handler;
+	new->handler = irq_default_primary_handler;
+	return 0;
 }
 
 static int irq_request_resources(struct irq_desc *desc)
@@ -1073,6 +1110,48 @@ static void irq_release_resources(struct irq_desc *desc)
 		c->irq_release_resources(d);
 }
 
+static int
+setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+{
+	struct task_struct *t;
+	struct sched_param param = {
+		.sched_priority = MAX_USER_RT_PRIO/2,
+	};
+
+	if (!secondary) {
+		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
+				   new->name);
+	} else {
+		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
+				   new->name);
+		param.sched_priority += 1;
+	}
+
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
+	sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
+
+	/*
+	 * We keep the reference to the task struct even if
+	 * the thread dies to avoid that the interrupt code
+	 * references an already freed task_struct.
+	 */
+	get_task_struct(t);
+	new->thread = t;
+	/*
+	 * Tell the thread to set its affinity. This is
+	 * important for shared interrupt handlers as we do
+	 * not invoke setup_affinity() for the secondary
+	 * handlers as everything is already set up. Even for
+	 * interrupts marked with IRQF_NO_BALANCE this is
+	 * correct as we want the thread to move to the cpu(s)
+	 * on which the requesting code placed the interrupt.
+	 */
+	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+	return 0;
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1093,6 +1172,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	new->irq = irq;
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1110,8 +1191,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		new->handler = irq_nested_primary_handler;
 	} else {
-		if (irq_settings_can_thread(desc))
-			irq_setup_forced_threading(new);
+		if (irq_settings_can_thread(desc)) {
+			ret = irq_setup_forced_threading(new);
+			if (ret)
+				goto out_mput;
+		}
 	}
 
 	/*
@@ -1120,37 +1204,14 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		struct task_struct *t;
-		static const struct sched_param param = {
-			.sched_priority = MAX_USER_RT_PRIO/2,
-		};
-
-		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
-				   new->name);
-		if (IS_ERR(t)) {
-			ret = PTR_ERR(t);
+		ret = setup_irq_thread(new, irq, false);
+		if (ret)
 			goto out_mput;
+		if (new->secondary) {
+			ret = setup_irq_thread(new->secondary, irq, true);
+			if (ret)
+				goto out_thread;
 		}
-
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
-
-		/*
-		 * We keep the reference to the task struct even if
-		 * the thread dies to avoid that the interrupt code
-		 * references an already freed task_struct.
-		 */
-		get_task_struct(t);
-		new->thread = t;
-		/*
-		 * Tell the thread to set its affinity. This is
-		 * important for shared interrupt handlers as we do
-		 * not invoke setup_affinity() for the secondary
-		 * handlers as everything is already set up. Even for
-		 * interrupts marked with IRQF_NO_BALANCE this is
-		 * correct as we want the thread to move to the cpu(s)
-		 * on which the requesting code placed the interrupt.
-		 */
-		set_bit(IRQTF_AFFINITY, &new->thread_flags);
 	}
 
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -1326,7 +1387,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 				   irq, nmsk, omsk);
 	}
 
-	new->irq = irq;
 	*old_ptr = new;
 
 	irq_pm_install_action(desc, new);
@@ -1352,6 +1412,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (new->thread)
 		wake_up_process(new->thread);
+	if (new->secondary)
+		wake_up_process(new->secondary->thread);
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;
@@ -1382,6 +1444,13 @@ out_thread:
 		kthread_stop(t);
 		put_task_struct(t);
 	}
+	if (new->secondary && new->secondary->thread) {
+		struct task_struct *t = new->secondary->thread;
+
+		new->secondary->thread = NULL;
+		kthread_stop(t);
+		put_task_struct(t);
+	}
 out_mput:
 	module_put(desc->owner);
 	return ret;
@@ -1489,9 +1558,14 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	if (action->thread) {
 		kthread_stop(action->thread);
 		put_task_struct(action->thread);
+		if (action->secondary && action->secondary->thread) {
+			kthread_stop(action->secondary->thread);
+			put_task_struct(action->secondary->thread);
+		}
 	}
 
 	module_put(desc->owner);
+	kfree(action->secondary);
 	return action;
 }
 
@@ -1635,8 +1709,10 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	retval = __setup_irq(irq, desc, action);
 	chip_bus_sync_unlock(desc);
 
-	if (retval)
+	if (retval) {
+		kfree(action->secondary);
 		kfree(action);
+	}
 
 #ifdef CONFIG_DEBUG_SHIRQ_FIXME
 	if (!retval && (irqflags & IRQF_SHARED)) {
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index aaade2efc560..d0e1d0e48640 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -450,7 +450,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -459,7 +459,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
+	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 
 #else /* !CONFIG_PROVE_LOCKING */
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f..700c857efd9b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8

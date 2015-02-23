From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.7-rt2
Date: Mon, 23 Feb 2015 10:06:17 +0100
Message-ID: <20150223090617.GA26453@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v3.18.7-rt2 patch set.
There are still patches to collect but I had this tested for a couple of
days, got big and did not want to sit on it any longer.

Changes since v3.18.7-rt1

- a patch for sched/deadline to get it work in RT (Juri Lelli)
- a patch for proper lockdep annotation for the ww-mutex (Mike Galbraith)
- a patch for AIO to avoid "sleeping while atomic". Reported by Mike
  Galbraith, fix suggested by Benjamin LaHaise
- a patch to use cmpxchg() on armv6+ in the locking path on ARM which
  actually improves performance (from Yong Zhang, resent by Nathan
  Sullivan)
- a patch to avoid "sleeping while atomic" on ARM while accessing kernel
  memory (Yadi Hu)
- a patch to avoid a race in futex code (on ARM) which may results that
  the unlock-er still owns the lock.
- a patch for memcontrol / cgroup to avoid "sleeping while atomic".
  Reported by Nikita Yushchenko, stuffed by Mike Galbraith
- a patch to avoid NULL-pointer dereference if a rtmutex is locked by
  the owner (again)
- a patch to avoid a crashes and get RT working on MIPS platforms with
  dcache aliasing (Yang Shi)
- a patch to properly use the rtmutex deadlock detector in ww-mutex
  which seems to cure a nouveau deadlock (Gustavo Bittencourt)
- a patch to properly check for a waiter in rtmutex instead
  dereferencing an invalid pointer (Brad Mouring)
- a patch to not disable interrupts in the sas_ata on -RT (Paul
  Gortmaker)
- a patch for better support of the UV x86 platform (Mike Galbraith)
- a patch not to wake up the mcework queue if it has not yet been
  initialized (Paul Gortmaker)

Known issues:

      - bcache is disabled.

      - lazy preempt on x86_64 leads to a crash with some load.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        measuring the performance of the individual implementation.

      - cpufreq deadlocks
        the issue has been identified and will be fixed in the next -RT
        release

The delta patch against 3.18.7-rt1 is appended below and can be found here: 

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.7-rt1-rt2.patch.xz

The RT patch against 3.18.7 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.7-rt2.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.7-rt2.tar.xz

Sebastian

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index abb2c3769b01..2386e9745ba4 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -129,6 +129,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 #else	/* min ARCH >= ARMv6 */
 
+#define __HAVE_ARCH_CMPXCHG 1
+
 extern void __bad_cmpxchg(volatile void *ptr, int size);
 
 /*
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 53e69dae796f..9d861f9f215b 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -93,6 +93,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	preempt_disable_rt();
+
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -104,6 +106,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "cc", "memory");
 
 	*uval = val;
+
+	preempt_enable_rt();
 	return ret;
 }
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index b40d4bab8e07..c15d2a0826c6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -431,6 +431,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
 
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	if (user_mode(regs))
 		goto bad_area;
 
@@ -498,6 +501,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index f42e35e42790..e09dae6ce80d 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -90,7 +90,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 
 	BUG_ON(Page_dcache_dirty(page));
 
-	pagefault_disable();
+	raw_pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
@@ -146,7 +146,7 @@ void kunmap_coherent(void)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	local_irq_restore(flags);
-	pagefault_enable();
+	raw_pagefault_enable();
 }
 
 void copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 2d60a7813dfe..ddc4c9e3d09d 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -615,9 +615,9 @@ struct bau_control {
 	cycles_t		send_message;
 	cycles_t		period_end;
 	cycles_t		period_time;
-	spinlock_t		uvhub_lock;
-	spinlock_t		queue_lock;
-	spinlock_t		disable_lock;
+	raw_spinlock_t		uvhub_lock;
+	raw_spinlock_t		queue_lock;
+	raw_spinlock_t		disable_lock;
 	/* tunables */
 	int			max_concurr;
 	int			max_concurr_const;
@@ -776,15 +776,15 @@ static inline int atom_asr(short i, struct atomic_short *v)
  * to be lowered below the current 'v'.  atomic_add_unless can only stop
  * on equal.
  */
-static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int u)
+static inline int atomic_inc_unless_ge(raw_spinlock_t *lock, atomic_t *v, int u)
 {
-	spin_lock(lock);
+	raw_spin_lock(lock);
 	if (atomic_read(v) >= u) {
-		spin_unlock(lock);
+		raw_spin_unlock(lock);
 		return 0;
 	}
 	atomic_inc(v);
-	spin_unlock(lock);
+	raw_spin_unlock(lock);
 	return 1;
 }
 
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index a00ad8f2a657..c2729abe02bc 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -492,7 +492,7 @@ struct uv_blade_info {
 	unsigned short	nr_online_cpus;
 	unsigned short	pnode;
 	short		memory_nid;
-	spinlock_t	nmi_lock;	/* obsolete, see uv_hub_nmi */
+	raw_spinlock_t	nmi_lock;	/* obsolete, see uv_hub_nmi */
 	unsigned long	nmi_count;	/* obsolete, see uv_hub_nmi */
 };
 extern struct uv_blade_info *uv_blade_info;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 8e9dcfd630e4..2cfedcae31b9 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -918,7 +918,7 @@ void __init uv_system_init(void)
 			uv_blade_info[blade].pnode = pnode;
 			uv_blade_info[blade].nr_possible_cpus = 0;
 			uv_blade_info[blade].nr_online_cpus = 0;
-			spin_lock_init(&uv_blade_info[blade].nmi_lock);
+			raw_spin_lock_init(&uv_blade_info[blade].nmi_lock);
 			min_pnode = min(pnode, min_pnode);
 			max_pnode = max(pnode, max_pnode);
 			blade++;
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c23856109466..718fc6cc6c64 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1411,6 +1411,11 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
+	if (WARN_ON_ONCE(!mce_notify_helper)) {
+		pr_info(HW_ERR "Machine check event before MCE init; ignored\n");
+		return;
+	}
+
 	wake_up_process(mce_notify_helper);
 }
 #else
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 3968d67d366b..7d444650bdd4 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -714,9 +714,9 @@ static void destination_plugged(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -736,9 +736,9 @@ static void destination_timeout(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -759,7 +759,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -772,7 +772,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 			}
 		}
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -835,7 +835,7 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	spinlock_t *lock = &hmaster->uvhub_lock;
+	raw_spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -968,7 +968,7 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -980,10 +980,10 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 				tbcp->period_giveups = 0;
 			}
 		}
-		spin_unlock(&hmaster->disable_lock);
+		raw_spin_unlock(&hmaster->disable_lock);
 		return 0;
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 	return -1;
 }
 
@@ -1899,9 +1899,9 @@ static void __init init_per_cpu_tunables(void)
 		bcp->cong_reps			= congested_reps;
 		bcp->disabled_period =		sec_2_cycles(disabled_period);
 		bcp->giveup_limit =		giveup_limit;
-		spin_lock_init(&bcp->queue_lock);
-		spin_lock_init(&bcp->uvhub_lock);
-		spin_lock_init(&bcp->disable_lock);
+		raw_spin_lock_init(&bcp->queue_lock);
+		raw_spin_lock_init(&bcp->uvhub_lock);
+		raw_spin_lock_init(&bcp->disable_lock);
 	}
 }
 
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index a244237f3cfa..a718fe0d2e73 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -58,7 +58,7 @@ static DEFINE_PER_CPU(struct clock_event_device, cpu_ced);
 
 /* There is one of these allocated per node */
 struct uv_rtc_timer_head {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	/* next cpu waiting for timer, local node relative: */
 	int		next_cpu;
 	/* number of cpus on this node: */
@@ -178,7 +178,7 @@ static __init int uv_rtc_allocate_timers(void)
 				uv_rtc_deallocate_timers();
 				return -ENOMEM;
 			}
-			spin_lock_init(&head->lock);
+			raw_spin_lock_init(&head->lock);
 			head->ncpus = uv_blade_nr_possible_cpus(bid);
 			head->next_cpu = -1;
 			blade_info[bid] = head;
@@ -232,7 +232,7 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 	unsigned long flags;
 	int next_cpu;
 
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
 
 	next_cpu = head->next_cpu;
 	*t = expires;
@@ -244,12 +244,12 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 		if (uv_setup_intr(cpu, expires)) {
 			*t = ULLONG_MAX;
 			uv_rtc_find_next_timer(head, pnode);
-			spin_unlock_irqrestore(&head->lock, flags);
+			raw_spin_unlock_irqrestore(&head->lock, flags);
 			return -ETIME;
 		}
 	}
 
-	spin_unlock_irqrestore(&head->lock, flags);
+	raw_spin_unlock_irqrestore(&head->lock, flags);
 	return 0;
 }
 
@@ -268,7 +268,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
 
 	if ((head->next_cpu == bcpu && uv_read_rtc(NULL) >= *t) || force)
 		rc = 1;
@@ -280,7 +280,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 			uv_rtc_find_next_timer(head, pnode);
 	}
 
-	spin_unlock_irqrestore(&head->lock, flags);
+	raw_spin_unlock_irqrestore(&head->lock, flags);
 
 	return rc;
 }
@@ -300,13 +300,18 @@ static int uv_rtc_unset_timer(int cpu, int force)
 static cycle_t uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
+	cycle_t cycles;
 
+	preempt_disable();
 	if (uv_get_min_hub_revision_id() == 1)
 		offset = 0;
 	else
 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
 
-	return (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
+	cycles = (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
+	preempt_enable();
+
+	return cycles;
 }
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index dce02cef145c..ec679b2c2229 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1272,9 +1272,7 @@ static void blk_sq_make_request(struct request_queue *q, struct bio *bio)
 			if (list_empty(&plug->mq_list))
 				trace_block_plug(q);
 			else if (request_count >= BLK_MAX_REQUEST_COUNT) {
-				spin_unlock(&data.ctx->cpu_lock);
 				blk_flush_plug_list(plug, false);
-				spin_lock(&data.ctx->cpu_lock);
 				trace_block_plug(q);
 			}
 			list_add_tail(&rq->queuelist, &plug->mq_list);
@@ -1470,7 +1468,6 @@ static int blk_mq_hctx_cpu_offline(struct blk_mq_hw_ctx *hctx, int cpu)
 		blk_mq_hctx_clear_pending(hctx, ctx);
 	}
 	spin_unlock(&ctx->lock);
-	__blk_mq_put_ctx(ctx);
 
 	if (list_empty(&tmp))
 		return NOTIFY_OK;
@@ -1680,7 +1677,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		memset(__ctx, 0, sizeof(*__ctx));
 		__ctx->cpu = i;
 		spin_lock_init(&__ctx->lock);
-		spin_lock_init(&__ctx->cpu_lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d0d4780ddfb6..d1d78dfe4123 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -9,7 +9,6 @@ struct blk_mq_ctx {
 		struct list_head	rq_list;
 	}  ____cacheline_aligned_in_smp;
 
-	spinlock_t		cpu_lock;
 	unsigned int		cpu;
 	unsigned int		index_hw;
 
@@ -77,7 +76,6 @@ static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 	struct blk_mq_ctx *ctx;
 
 	ctx = per_cpu_ptr(q->queue_ctx, cpu);
-	spin_lock(&ctx->cpu_lock);
 	return ctx;
 }
 
@@ -92,14 +90,8 @@ static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 	return __blk_mq_get_ctx(q, get_cpu_light());
 }
 
-static void __blk_mq_put_ctx(struct blk_mq_ctx *ctx)
-{
-	spin_unlock(&ctx->cpu_lock);
-}
-
 static inline void blk_mq_put_ctx(struct blk_mq_ctx *ctx)
 {
-	__blk_mq_put_ctx(ctx);
 	put_cpu_light();
 }
 
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 766098af4eb7..d79daca3b00b 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -191,7 +191,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	/* TODO: audit callers to ensure they are ready for qc_issue to
 	 * unconditionally re-enable interrupts
 	 */
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	spin_unlock(ap->lock);
 
 	/* If the device fell off, no sense in issuing commands */
@@ -261,7 +261,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 
  out:
 	spin_lock(ap->lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 	return ret;
 }
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5906c14a4e64..e257819480a9 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -360,7 +360,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -1700,7 +1701,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
@@ -2242,7 +2244,8 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,
+				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2260,7 +2263,8 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 	might_sleep();
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL,
+				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd2..c3054d08a112 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 498e8844a142..0c4538811188 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2379,14 +2379,17 @@ static void __init memcg_stock_init(void)
  */
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
+	struct memcg_stock_pcp *stock;
+	int cpu = get_cpu_light();
+
+	stock = &per_cpu(memcg_stock, cpu);
 
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-	put_cpu_var(memcg_stock);
+	put_cpu_light();
 }
 
 /*

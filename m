From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.14.34-rt32
Date: Fri, 20 Mar 2015 11:29:08 -0400
Message-ID: <20150320112908.5a0798b8@gandalf.local.home>
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

I'm pleased to announce the 3.14.34-rt32 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.14-rt
  Head SHA1: 9001336e1e5062158c9feaf69d8429f9de954af6


Or to build 3.14.34-rt32 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.34.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.34-rt32.patch.xz



You can also build from 3.14.34-rt31 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.34-rt31-rt32.patch.xz



Enjoy,

-- Steve


Changes from v3.14.34-rt31:

---

Brad Mouring (1):
      rtmutex.c: Fix incorrect waiter check

Daniel Wagner (2):
      work-simple: Simple work queue implemenation
      thermal: Defer thermal wakups to threads

Gustavo Bittencourt (1):
      rtmutex: enable deadlock detection in ww_mutex_lock functions

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Kevin Hao (1):
      netpoll: guard the access to dev->npinfo with rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y

Mike Galbraith (6):
      rt,locking: fix __ww_mutex_lock_interruptible() lockdep annotation
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()
      locking: ww_mutex: fix ww_mutex vs self-deadlock
      fs,btrfs: fix rt deadlock on extent_buffer->lock

Paul E. McKenney (4):
      timers: Track total number of timers in list
      timers: Reduce __run_timers() latency for empty list
      timers: Reduce future __run_timers() latency for newly emptied list
      timers: Reduce future __run_timers() latency for first add to empty list

Paul Gortmaker (1):
      sas-ata/isci: dont't disable interrupts in qc_issue handler

Sebastian Andrzej Siewior (5):
      gpio: omap: use raw locks for locking
      locking/rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()
      Revert "rwsem-rt: Do not allow readers to nest"
      fs/aio: simple simple work

Steven Rostedt (Red Hat) (3):
      staging: Mark rtl8821ae as broken
      Revert "timers: do not raise softirq unconditionally"
      Linux 3.14.34-rt32

Thomas Gleixner (14):
      rtmutex: Simplify rtmutex_slowtrylock()
      rtmutex: Simplify and document try_to_take_rtmutex()
      rtmutex: No need to keep task ref for lock owner check
      rtmutex: Clarify the boost/deboost part
      rtmutex: Document pi chain walk
      rtmutex: Simplify remove_waiter()
      rtmutex: Confine deadlock logic to futex
      rtmutex: Cleanup deadlock detector debug logic
      rtmutex: Avoid pointless requeueing in the deadlock detection chain walk
      futex: Make unlock_pi more robust
      futex: Use futex_top_waiter() in lookup_pi_state()
      futex: Split out the waiter check from lookup_pi_state()
      futex: Split out the first waiter attachment from lookup_pi_state()
      futex: Simplify futex_lock_pi_atomic() and make it more robust

Yadi.hu (1):
      ARM: enable irq in translation/section permission fault handlers

Yang Shi (1):
      mips: rt: Replace pagefault_* to raw version

Yong Zhang (1):
      ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later

----
 arch/arm/include/asm/cmpxchg.h         |   2 +
 arch/arm/include/asm/futex.h           |   4 +
 arch/arm/mm/fault.c                    |   6 +
 arch/mips/mm/init.c                    |   4 +-
 arch/x86/include/asm/uv/uv_bau.h       |  14 +-
 arch/x86/include/asm/uv/uv_hub.h       |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c     |   2 +-
 arch/x86/platform/uv/tlb_uv.c          |  26 +-
 arch/x86/platform/uv/uv_time.c         |  21 +-
 drivers/gpio/gpio-omap.c               |  72 ++--
 drivers/scsi/libsas/sas_ata.c          |   4 +-
 drivers/staging/rtl8821ae/Kconfig      |   1 +
 drivers/thermal/x86_pkg_temp_thermal.c |  50 ++-
 fs/aio.c                               |  24 +-
 fs/btrfs/ctree.c                       |   4 +-
 fs/btrfs/extent-tree.c                 |   8 -
 include/linux/hrtimer.h                |   3 +-
 include/linux/netpoll.h                |  16 +-
 include/linux/rtmutex.h                |   8 +-
 include/linux/rwsem_rt.h               |   1 +
 include/linux/work-simple.h            |  24 ++
 kernel/futex.c                         | 402 +++++++++++------------
 kernel/hrtimer.c                       |  31 +-
 kernel/locking/rt.c                    |  37 ++-
 kernel/locking/rtmutex-debug.c         |   5 +-
 kernel/locking/rtmutex-debug.h         |   7 +-
 kernel/locking/rtmutex-tester.c        |   4 +-
 kernel/locking/rtmutex.c               | 582 ++++++++++++++++++++++++---------
 kernel/locking/rtmutex.h               |   7 +-
 kernel/locking/rtmutex_common.h        |  22 +-
 kernel/sched/Makefile                  |   2 +-
 kernel/sched/work-simple.c             | 172 ++++++++++
 kernel/timer.c                         |  72 ++--
 lib/locking-selftest.c                 |  27 ++
 localversion-rt                        |   2 +-
 mm/memcontrol.c                        |   7 +-
 net/sunrpc/svc_xprt.c                  |   4 +-
 37 files changed, 1133 insertions(+), 546 deletions(-)
---------------------------
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index df2fbba7efc8..30b1a4010b89 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 #else	/* min ARCH >= ARMv6 */
 
+#define __HAVE_ARCH_CMPXCHG 1
+
 extern void __bad_cmpxchg(volatile void *ptr, int size);
 
 /*
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 2aff798fbef4..54d26a98ff84 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -90,6 +90,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	preempt_disable_rt();
+
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -101,6 +103,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
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
index 6b59617760c1..740219e35d6c 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -124,7 +124,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 
 	BUG_ON(Page_dcache_dirty(page));
 
-	pagefault_disable();
+	raw_pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 #ifdef CONFIG_MIPS_MT_SMTC
 	idx += FIX_N_COLOURS * smp_processor_id() +
@@ -191,7 +191,7 @@ void kunmap_coherent(void)
 	write_c0_entryhi(old_ctx);
 	EXIT_CRITICAL(flags);
 #endif
-	pagefault_enable();
+	raw_pagefault_enable();
 }
 
 void copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 0b46ef261c77..c2c8a7828f04 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -611,9 +611,9 @@ struct bau_control {
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
@@ -773,15 +773,15 @@ static inline int atom_asr(short i, struct atomic_short *v)
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
index a30836c8ac4d..f559a092d8fa 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -502,7 +502,7 @@ struct uv_blade_info {
 	unsigned short	nr_online_cpus;
 	unsigned short	pnode;
 	short		memory_nid;
-	spinlock_t	nmi_lock;	/* obsolete, see uv_hub_nmi */
+	raw_spinlock_t	nmi_lock;	/* obsolete, see uv_hub_nmi */
 	unsigned long	nmi_count;	/* obsolete, see uv_hub_nmi */
 };
 extern struct uv_blade_info *uv_blade_info;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d263b1307de1..1ef690e5459f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -911,7 +911,7 @@ void __init uv_system_init(void)
 			uv_blade_info[blade].pnode = pnode;
 			uv_blade_info[blade].nr_possible_cpus = 0;
 			uv_blade_info[blade].nr_online_cpus = 0;
-			spin_lock_init(&uv_blade_info[blade].nmi_lock);
+			raw_spin_lock_init(&uv_blade_info[blade].nmi_lock);
 			min_pnode = min(pnode, min_pnode);
 			max_pnode = max(pnode, max_pnode);
 			blade++;
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index dfe605ac1bcd..999fd5be9aa1 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -719,9 +719,9 @@ static void destination_plugged(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -741,9 +741,9 @@ static void destination_timeout(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -764,7 +764,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -777,7 +777,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 			}
 		}
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -840,7 +840,7 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	spinlock_t *lock = &hmaster->uvhub_lock;
+	raw_spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -972,7 +972,7 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -984,10 +984,10 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
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
 
@@ -1895,9 +1895,9 @@ static void __init init_per_cpu_tunables(void)
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
index 5c86786bbfd2..c039afa26aa2 100644
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
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 424319061e09..0f057af22fb1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -59,7 +59,7 @@ struct gpio_bank {
 	u32 saved_datain;
 	u32 level_mask;
 	u32 toggle_mask;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 mod_usage;
@@ -503,14 +503,14 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	offset = GPIO_INDEX(bank, gpio);
 	retval = _set_gpio_triggering(bank, offset, type);
 	if (!LINE_USED(bank->mod_usage, offset)) {
 		_enable_gpio_module(bank, offset);
 		_set_gpio_direction(bank, offset, 1);
 	} else if (!gpio_is_input(bank, 1 << offset)) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
 	}
 
@@ -518,12 +518,12 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	if (retval) {
 		dev_err(bank->dev, "unable to lock offset %d for IRQ\n",
 			offset);
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		return retval;
 	}
 
 	bank->irq_usage |= 1 << GPIO_INDEX(bank, gpio);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -640,14 +640,14 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (enable)
 		bank->context.wake_en |= gpio_bit;
 	else
 		bank->context.wake_en &= ~gpio_bit;
 
 	writel_relaxed(bank->context.wake_en, bank->base + bank->regs->wkup_en);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -682,7 +682,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
 	 * not already been requested.
@@ -692,7 +692,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		_enable_gpio_module(bank, offset);
 	}
 	bank->mod_usage |= 1 << offset;
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -702,11 +702,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(1 << offset);
 	_disable_gpio_module(bank, offset);
 	_reset_gpio(bank, bank->chip.base + offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
 	 * If this is the last gpio to be freed in the bank,
@@ -804,12 +804,12 @@ static void gpio_irq_shutdown(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	gpio_unlock_as_irq(&bank->chip, offset);
 	bank->irq_usage &= ~(1 << offset);
 	_disable_gpio_module(bank, offset);
 	_reset_gpio(bank, gpio);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
 	 * If this is the last IRQ to be freed in the bank,
@@ -833,10 +833,10 @@ static void gpio_mask_irq(struct irq_data *d)
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
@@ -847,7 +847,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
 		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
@@ -859,7 +859,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static struct irq_chip gpio_irq_chip = {
@@ -882,9 +882,9 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	writel_relaxed(0xffff & ~bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -897,9 +897,9 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	writel_relaxed(bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -942,9 +942,9 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_direction(bank, offset, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
@@ -968,10 +968,10 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
 	_set_gpio_direction(bank, offset, 0);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
@@ -983,9 +983,9 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 
 	bank = container_of(chip, struct gpio_bank, chip);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_debounce(bank, offset, debounce);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -996,9 +996,9 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 /*---------------------------------------------------------------------*/
@@ -1210,7 +1210,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	else
 		bank->set_dataout = _set_gpio_dataout_mask;
 
-	spin_lock_init(&bank->lock);
+	raw_spin_lock_init(&bank->lock);
 
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1267,7 +1267,7 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	unsigned long flags;
 	u32 wake_low, wake_hi;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	/*
 	 * Only edges can generate a wakeup event to the PRCM.
@@ -1320,7 +1320,7 @@ update_gpio_context_count:
 				bank->get_context_loss_count(bank->dev);
 
 	_gpio_dbck_disable(bank);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -1335,7 +1335,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	unsigned long flags;
 	int c;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	/*
 	 * On the first resume during the probe, the context has not
@@ -1371,14 +1371,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			if (c != bank->context_loss_count) {
 				omap_gpio_restore_context(bank);
 			} else {
-				spin_unlock_irqrestore(&bank->lock, flags);
+				raw_spin_unlock_irqrestore(&bank->lock, flags);
 				return 0;
 			}
 		}
 	}
 
 	if (!bank->workaround_enabled) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	}
 
@@ -1433,7 +1433,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	}
 
 	bank->workaround_enabled = false;
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d2895836f9fa..c85e07ab51e4 100644
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
 
diff --git a/drivers/staging/rtl8821ae/Kconfig b/drivers/staging/rtl8821ae/Kconfig
index abccc9dabd65..50a407f71717 100644
--- a/drivers/staging/rtl8821ae/Kconfig
+++ b/drivers/staging/rtl8821ae/Kconfig
@@ -2,6 +2,7 @@ config R8821AE
 	tristate "RealTek RTL8821AE Wireless LAN NIC driver"
 	depends on PCI && WLAN && MAC80211
 	depends on m
+	depends on BROKEN
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select EEPROM_93CX6
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 081fd7e6a9f0..f297ddd3365c 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
+#include <linux/work-simple.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
@@ -352,7 +353,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 }
 
-static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+static void platform_thermal_notify_work(struct swork_event *event)
 {
 	unsigned long flags;
 	int cpu = smp_processor_id();
@@ -369,7 +370,7 @@ static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
 			pkg_work_scheduled[phy_id]) {
 		disable_pkg_thres_interrupt();
 		spin_unlock_irqrestore(&pkg_work_lock, flags);
-		return -EINVAL;
+		return;
 	}
 	pkg_work_scheduled[phy_id] = 1;
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
@@ -378,9 +379,48 @@ static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
 	schedule_delayed_work_on(cpu,
 				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 				msecs_to_jiffies(notify_delay_ms));
+}
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+static struct swork_event notify_work;
+
+static int thermal_notify_work_init(void)
+{
+	int err;
+
+	err = swork_get();
+	if (err)
+		return err;
+
+	INIT_SWORK(&notify_work, platform_thermal_notify_work);
 	return 0;
 }
 
+static void thermal_notify_work_cleanup(void)
+{
+	swork_put();
+}
+
+static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+{
+	swork_queue(&notify_work);
+	return 0;
+}
+
+#else  /* !CONFIG_PREEMPT_RT_FULL */
+
+static int thermal_notify_work_init(void) { return 0; }
+
+static int thermal_notify_work_cleanup(void) {  }
+
+static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+{
+	platform_thermal_notify_work(NULL);
+
+	return 0;
+}
+#endif /* CONFIG_PREEMPT_RT_FULL */
+
 static int find_siblings_cpu(int cpu)
 {
 	int i;
@@ -584,6 +624,9 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
+	if (!thermal_notify_work_init())
+		return -ENODEV;
+
 	spin_lock_init(&pkg_work_lock);
 	platform_thermal_package_notify =
 			pkg_temp_thermal_platform_thermal_notify;
@@ -608,7 +651,7 @@ err_ret:
 	kfree(pkg_work_scheduled);
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
-
+	thermal_notify_work_cleanup();
 	return -ENODEV;
 }
 
@@ -633,6 +676,7 @@ static void __exit pkg_temp_thermal_exit(void)
 	mutex_unlock(&phy_dev_list_mutex);
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
+	thermal_notify_work_cleanup();
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
diff --git a/fs/aio.c b/fs/aio.c
index 2f7e8c2e3e76..5cddcbfe1b71 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -40,6 +40,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/work-simple.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -110,7 +111,7 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct swork_event	free_work;
 
 	/*
 	 * signals when all in-flight requests are done
@@ -227,6 +228,7 @@ static int __init aio_setup(void)
 		.mount		= aio_mount,
 		.kill_sb	= kill_anon_super,
 	};
+	BUG_ON(swork_get());
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -506,9 +508,9 @@ static int kiocb_cancel(struct kioctx *ctx, struct kiocb *kiocb)
 	return cancel(kiocb);
 }
 
-static void free_ioctx(struct work_struct *work)
+static void free_ioctx(struct swork_event *sev)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
+	struct kioctx *ctx = container_of(sev, struct kioctx, free_work);
 
 	pr_debug("freeing %p\n", ctx);
 
@@ -525,8 +527,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	if (ctx->requests_done)
 		complete(ctx->requests_done);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	INIT_SWORK(&ctx->free_work, free_ioctx);
+	swork_queue(&ctx->free_work);
 }
 
 /*
@@ -534,9 +536,9 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
  * now it's safe to cancel any that need to be.
  */
-static void free_ioctx_users(struct percpu_ref *ref)
+static void free_ioctx_users_work(struct swork_event *sev)
 {
-	struct kioctx *ctx = container_of(ref, struct kioctx, users);
+	struct kioctx *ctx = container_of(sev, struct kioctx, free_work);
 	struct kiocb *req;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -555,6 +557,14 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	percpu_ref_put(&ctx->reqs);
 }
 
+static void free_ioctx_users(struct percpu_ref *ref)
+{
+	struct kioctx *ctx = container_of(ref, struct kioctx, users);
+
+	INIT_SWORK(&ctx->free_work, free_ioctx_users_work);
+	swork_queue(&ctx->free_work);
+}
+
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
 	unsigned i, new_nr;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cbd3a7d6fa68..50c7edc8f4d2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -80,7 +80,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 {
 	int i;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	/* lockdep really cares that we take all of these spinlocks
 	 * in the right order.  If any of the locks in the path are not
 	 * currently blocking, it is going to complain.  So, make really
@@ -107,7 +107,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 		}
 	}
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	if (held)
 		btrfs_clear_lock_blocking_rw(held, held_rw);
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d2f1c011d73a..73035cf6681a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6940,14 +6940,6 @@ again:
 		goto again;
 	}
 
-	if (btrfs_test_opt(root, ENOSPC_DEBUG)) {
-		static DEFINE_RATELIMIT_STATE(_rs,
-				DEFAULT_RATELIMIT_INTERVAL * 10,
-				/*DEFAULT_RATELIMIT_BURST*/ 1);
-		if (__ratelimit(&_rs))
-			WARN(1, KERN_DEBUG
-				"BTRFS: block rsv returned %d\n", ret);
-	}
 try_reserve:
 	ret = reserve_metadata_bytes(root, block_rsv, blocksize,
 				     BTRFS_RESERVE_NO_FLUSH);
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bdbf77db0f4d..79a7a35e1a6e 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -461,8 +461,9 @@ extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 		unsigned long delta, const enum hrtimer_mode mode, int clock);
 extern int schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode);
 
-/* Called from the periodic timer tick */
+/* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
+extern void hrtimer_run_pending(void);
 
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index fbfdb9d8d3a7..039dd5df0ef7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -87,9 +87,21 @@ static inline void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 #ifdef CONFIG_NETPOLL
 static inline bool netpoll_rx_on(struct sk_buff *skb)
 {
-	struct netpoll_info *npinfo = rcu_dereference_bh(skb->dev->npinfo);
+	struct netpoll_info *npinfo;
+	bool ret;
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+	rcu_read_lock_bh();
+#endif
+
+	npinfo = rcu_dereference_bh(skb->dev->npinfo);
+	ret = npinfo && (!list_empty(&npinfo->rx_np) || npinfo->rx_flags);
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+	rcu_read_unlock_bh();
+#endif
 
-	return npinfo && (!list_empty(&npinfo->rx_np) || npinfo->rx_flags);
+	return ret;
 }
 
 static inline bool netpoll_rx(struct sk_buff *skb)
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index edb77fd15803..d5a04ea47a13 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -105,12 +105,10 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
-extern int rt_mutex_lock_interruptible(struct rt_mutex *lock,
-						int detect_deadlock);
-extern int rt_mutex_lock_killable(struct rt_mutex *lock, int detect_deadlock);
+extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
+extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
-					struct hrtimer_sleeper *timeout,
-					int detect_deadlock);
+			       struct hrtimer_sleeper *timeout);
 
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
index 0065b08fbb7a..924c2d274ab5 100644
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -20,6 +20,7 @@
 
 struct rw_semaphore {
 	struct rt_mutex		lock;
+	int			read_depth;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
diff --git a/include/linux/work-simple.h b/include/linux/work-simple.h
new file mode 100644
index 000000000000..f175fa9a6016
--- /dev/null
+++ b/include/linux/work-simple.h
@@ -0,0 +1,24 @@
+#ifndef _LINUX_SWORK_H
+#define _LINUX_SWORK_H
+
+#include <linux/list.h>
+
+struct swork_event {
+	struct list_head item;
+	unsigned long flags;
+	void (*func)(struct swork_event *);
+};
+
+static inline void INIT_SWORK(struct swork_event *event,
+			      void (*func)(struct swork_event *))
+{
+	event->flags = 0;
+	event->func = func;
+}
+
+bool swork_queue(struct swork_event *sev);
+
+int swork_get(void);
+void swork_put(void);
+
+#endif /* _LINUX_SWORK_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index 5ba3c0fc4d19..e7f392e56be4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -782,94 +782,91 @@ void exit_pi_state_list(struct task_struct *curr)
  * [10] There is no transient state which leaves owner and user space
  *	TID out of sync.
  */
-static int
-lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
-		union futex_key *key, struct futex_pi_state **ps)
+
+/*
+ * Validate that the existing waiter has a pi_state and sanity check
+ * the pi_state against the user space value. If correct, attach to
+ * it.
+ */
+static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
+			      struct futex_pi_state **ps)
 {
-	struct futex_pi_state *pi_state = NULL;
-	struct futex_q *this, *next;
-	struct task_struct *p;
 	pid_t pid = uval & FUTEX_TID_MASK;
 
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (match_futex(&this->key, key)) {
-			/*
-			 * Sanity check the waiter before increasing
-			 * the refcount and attaching to it.
-			 */
-			pi_state = this->pi_state;
-			/*
-			 * Userspace might have messed up non-PI and
-			 * PI futexes [3]
-			 */
-			if (unlikely(!pi_state))
-				return -EINVAL;
+	/*
+	 * Userspace might have messed up non-PI and PI futexes [3]
+	 */
+	if (unlikely(!pi_state))
+		return -EINVAL;
 
-			WARN_ON(!atomic_read(&pi_state->refcount));
+	WARN_ON(!atomic_read(&pi_state->refcount));
 
+	/*
+	 * Handle the owner died case:
+	 */
+	if (uval & FUTEX_OWNER_DIED) {
+		/*
+		 * exit_pi_state_list sets owner to NULL and wakes the
+		 * topmost waiter. The task which acquires the
+		 * pi_state->rt_mutex will fixup owner.
+		 */
+		if (!pi_state->owner) {
 			/*
-			 * Handle the owner died case:
+			 * No pi state owner, but the user space TID
+			 * is not 0. Inconsistent state. [5]
 			 */
-			if (uval & FUTEX_OWNER_DIED) {
-				/*
-				 * exit_pi_state_list sets owner to NULL and
-				 * wakes the topmost waiter. The task which
-				 * acquires the pi_state->rt_mutex will fixup
-				 * owner.
-				 */
-				if (!pi_state->owner) {
-					/*
-					 * No pi state owner, but the user
-					 * space TID is not 0. Inconsistent
-					 * state. [5]
-					 */
-					if (pid)
-						return -EINVAL;
-					/*
-					 * Take a ref on the state and
-					 * return. [4]
-					 */
-					goto out_state;
-				}
-
-				/*
-				 * If TID is 0, then either the dying owner
-				 * has not yet executed exit_pi_state_list()
-				 * or some waiter acquired the rtmutex in the
-				 * pi state, but did not yet fixup the TID in
-				 * user space.
-				 *
-				 * Take a ref on the state and return. [6]
-				 */
-				if (!pid)
-					goto out_state;
-			} else {
-				/*
-				 * If the owner died bit is not set,
-				 * then the pi_state must have an
-				 * owner. [7]
-				 */
-				if (!pi_state->owner)
-					return -EINVAL;
-			}
-
+			if (pid)
+				return -EINVAL;
 			/*
-			 * Bail out if user space manipulated the
-			 * futex value. If pi state exists then the
-			 * owner TID must be the same as the user
-			 * space TID. [9/10]
+			 * Take a ref on the state and return success. [4]
 			 */
-			if (pid != task_pid_vnr(pi_state->owner))
-				return -EINVAL;
-
-		out_state:
-			atomic_inc(&pi_state->refcount);
-			*ps = pi_state;
-			return 0;
+			goto out_state;
 		}
+
+		/*
+		 * If TID is 0, then either the dying owner has not
+		 * yet executed exit_pi_state_list() or some waiter
+		 * acquired the rtmutex in the pi state, but did not
+		 * yet fixup the TID in user space.
+		 *
+		 * Take a ref on the state and return success. [6]
+		 */
+		if (!pid)
+			goto out_state;
+	} else {
+		/*
+		 * If the owner died bit is not set, then the pi_state
+		 * must have an owner. [7]
+		 */
+		if (!pi_state->owner)
+			return -EINVAL;
 	}
 
 	/*
+	 * Bail out if user space manipulated the futex value. If pi
+	 * state exists then the owner TID must be the same as the
+	 * user space TID. [9/10]
+	 */
+	if (pid != task_pid_vnr(pi_state->owner))
+		return -EINVAL;
+out_state:
+	atomic_inc(&pi_state->refcount);
+	*ps = pi_state;
+	return 0;
+}
+
+/*
+ * Lookup the task for the TID provided from user space and attach to
+ * it after doing proper sanity checks.
+ */
+static int attach_to_pi_owner(u32 uval, union futex_key *key,
+			      struct futex_pi_state **ps)
+{
+	pid_t pid = uval & FUTEX_TID_MASK;
+	struct futex_pi_state *pi_state;
+	struct task_struct *p;
+
+	/*
 	 * We are the first waiter - try to look up the real owner and attach
 	 * the new pi_state to it, but bail out when TID = 0 [1]
 	 */
@@ -910,7 +907,7 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	pi_state = alloc_pi_state();
 
 	/*
-	 * Initialize the pi_mutex in locked state and make 'p'
+	 * Initialize the pi_mutex in locked state and make @p
 	 * the owner of it:
 	 */
 	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
@@ -930,6 +927,36 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	return 0;
 }
 
+static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
+			   union futex_key *key, struct futex_pi_state **ps)
+{
+	struct futex_q *match = futex_top_waiter(hb, key);
+
+	/*
+	 * If there is a waiter on that futex, validate it and
+	 * attach to the pi_state when the validation succeeds.
+	 */
+	if (match)
+		return attach_to_pi_state(uval, match->pi_state, ps);
+
+	/*
+	 * We are the first waiter - try to look up the owner based on
+	 * @uval and attach to it.
+	 */
+	return attach_to_pi_owner(uval, key, ps);
+}
+
+static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
+{
+	u32 uninitialized_var(curval);
+
+	if (unlikely(cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)))
+		return -EFAULT;
+
+	/*If user space value changed, let the caller retry */
+	return curval != uval ? -EAGAIN : 0;
+}
+
 /**
  * futex_lock_pi_atomic() - Atomic work required to acquire a pi aware futex
  * @uaddr:		the pi futex user address
@@ -953,113 +980,69 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 				struct futex_pi_state **ps,
 				struct task_struct *task, int set_waiters)
 {
-	int lock_taken, ret, force_take = 0;
-	u32 uval, newval, curval, vpid = task_pid_vnr(task);
-
-retry:
-	ret = lock_taken = 0;
+	u32 uval, newval, vpid = task_pid_vnr(task);
+	struct futex_q *match;
+	int ret;
 
 	/*
-	 * To avoid races, we attempt to take the lock here again
-	 * (by doing a 0 -> TID atomic cmpxchg), while holding all
-	 * the locks. It will most likely not succeed.
+	 * Read the user space value first so we can validate a few
+	 * things before proceeding further.
 	 */
-	newval = vpid;
-	if (set_waiters)
-		newval |= FUTEX_WAITERS;
-
-	if (unlikely(cmpxchg_futex_value_locked(&curval, uaddr, 0, newval)))
+	if (get_futex_value_locked(&uval, uaddr))
 		return -EFAULT;
 
 	/*
 	 * Detect deadlocks.
 	 */
-	if ((unlikely((curval & FUTEX_TID_MASK) == vpid)))
+	if ((unlikely((uval & FUTEX_TID_MASK) == vpid)))
 		return -EDEADLK;
 
 	/*
-	 * Surprise - we got the lock, but we do not trust user space at all.
-	 */
-	if (unlikely(!curval)) {
-		/*
-		 * We verify whether there is kernel state for this
-		 * futex. If not, we can safely assume, that the 0 ->
-		 * TID transition is correct. If state exists, we do
-		 * not bother to fixup the user space state as it was
-		 * corrupted already.
-		 */
-		return futex_top_waiter(hb, key) ? -EINVAL : 1;
-	}
-
-	uval = curval;
-
-	/*
-	 * Set the FUTEX_WAITERS flag, so the owner will know it has someone
-	 * to wake at the next unlock.
+	 * Lookup existing state first. If it exists, try to attach to
+	 * its pi_state.
 	 */
-	newval = curval | FUTEX_WAITERS;
+	match = futex_top_waiter(hb, key);
+	if (match)
+		return attach_to_pi_state(uval, match->pi_state, ps);
 
 	/*
-	 * Should we force take the futex? See below.
+	 * No waiter and user TID is 0. We are here because the
+	 * waiters or the owner died bit is set or called from
+	 * requeue_cmp_pi or for whatever reason something took the
+	 * syscall.
 	 */
-	if (unlikely(force_take)) {
+	if (!(uval & FUTEX_TID_MASK)) {
 		/*
-		 * Keep the OWNER_DIED and the WAITERS bit and set the
-		 * new TID value.
+		 * We take over the futex. No other waiters and the user space
+		 * TID is 0. We preserve the owner died bit.
 		 */
-		newval = (curval & ~FUTEX_TID_MASK) | vpid;
-		force_take = 0;
-		lock_taken = 1;
-	}
+		newval = uval & FUTEX_OWNER_DIED;
+		newval |= vpid;
 
-	if (unlikely(cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)))
-		return -EFAULT;
-	if (unlikely(curval != uval))
-		goto retry;
+		/* The futex requeue_pi code can enforce the waiters bit */
+		if (set_waiters)
+			newval |= FUTEX_WAITERS;
+
+		ret = lock_pi_update_atomic(uaddr, uval, newval);
+		/* If the take over worked, return 1 */
+		return ret < 0 ? ret : 1;
+	}
 
 	/*
-	 * We took the lock due to forced take over.
+	 * First waiter. Set the waiters bit before attaching ourself to
+	 * the owner. If owner tries to unlock, it will be forced into
+	 * the kernel and blocked on hb->lock.
 	 */
-	if (unlikely(lock_taken))
-		return 1;
-
+	newval = uval | FUTEX_WAITERS;
+	ret = lock_pi_update_atomic(uaddr, uval, newval);
+	if (ret)
+		return ret;
 	/*
-	 * We dont have the lock. Look up the PI state (or create it if
-	 * we are the first waiter):
+	 * If the update of the user space value succeeded, we try to
+	 * attach to the owner. If that fails, no harm done, we only
+	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	ret = lookup_pi_state(uval, hb, key, ps);
-
-	if (unlikely(ret)) {
-		switch (ret) {
-		case -ESRCH:
-			/*
-			 * We failed to find an owner for this
-			 * futex. So we have no pi_state to block
-			 * on. This can happen in two cases:
-			 *
-			 * 1) The owner died
-			 * 2) A stale FUTEX_WAITERS bit
-			 *
-			 * Re-read the futex value.
-			 */
-			if (get_futex_value_locked(&curval, uaddr))
-				return -EFAULT;
-
-			/*
-			 * If the owner died or we have a stale
-			 * WAITERS bit the owner TID in the user space
-			 * futex is 0.
-			 */
-			if (!(curval & FUTEX_TID_MASK)) {
-				force_take = 1;
-				goto retry;
-			}
-		default:
-			break;
-		}
-	}
-
-	return ret;
+	return attach_to_pi_owner(uval, key, ps);
 }
 
 /**
@@ -1176,22 +1159,6 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this)
 	return 0;
 }
 
-static int unlock_futex_pi(u32 __user *uaddr, u32 uval)
-{
-	u32 uninitialized_var(oldval);
-
-	/*
-	 * There is no waiter, so we unlock the futex. The owner died
-	 * bit has not to be preserved here. We are the owner:
-	 */
-	if (cmpxchg_futex_value_locked(&oldval, uaddr, uval, 0))
-		return -EFAULT;
-	if (oldval != uval)
-		return -EAGAIN;
-
-	return 0;
-}
-
 /*
  * Express the locking dependencies for lockdep:
  */
@@ -1649,7 +1616,12 @@ retry_private:
 				goto retry;
 			goto out;
 		case -EAGAIN:
-			/* The owner was exiting, try again. */
+			/*
+			 * Two reasons for this:
+			 * - Owner is exiting and we just wait for the
+			 *   exit to complete.
+			 * - The user space value changed.
+			 */
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
 			put_futex_key(&key2);
@@ -1708,7 +1680,7 @@ retry_private:
 			this->pi_state = pi_state;
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
-							this->task, 1);
+							this->task);
 			if (ret == 1) {
 				/* We got the lock. */
 				requeue_pi_wake_futex(this, &key2, hb2);
@@ -2316,8 +2288,10 @@ retry_private:
 			goto uaddr_faulted;
 		case -EAGAIN:
 			/*
-			 * Task is exiting and we just wait for the
-			 * exit to complete.
+			 * Two reasons for this:
+			 * - Task is exiting and we just wait for the
+			 *   exit to complete.
+			 * - The user space value changed.
 			 */
 			queue_unlock(hb);
 			put_futex_key(&q.key);
@@ -2337,9 +2311,9 @@ retry_private:
 	/*
 	 * Block on the PI mutex:
 	 */
-	if (!trylock)
-		ret = rt_mutex_timed_lock(&q.pi_state->pi_mutex, to, 1);
-	else {
+	if (!trylock) {
+		ret = rt_mutex_timed_futex_lock(&q.pi_state->pi_mutex, to);
+	} else {
 		ret = rt_mutex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
@@ -2401,10 +2375,10 @@ uaddr_faulted:
  */
 static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
-	struct futex_hash_bucket *hb;
-	struct futex_q *this, *next;
+	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
-	u32 uval, vpid = task_pid_vnr(current);
+	struct futex_hash_bucket *hb;
+	struct futex_q *match;
 	int ret;
 
 retry:
@@ -2417,57 +2391,47 @@ retry:
 		return -EPERM;
 
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, VERIFY_WRITE);
-	if (unlikely(ret != 0))
-		goto out;
+	if (ret)
+		return ret;
 
 	hb = hash_futex(&key);
 	spin_lock(&hb->lock);
 
 	/*
-	 * To avoid races, try to do the TID -> 0 atomic transition
-	 * again. If it succeeds then we can return without waking
-	 * anyone else up. We only try this if neither the waiters nor
-	 * the owner died bit are set.
-	 */
-	if (!(uval & ~FUTEX_TID_MASK) &&
-	    cmpxchg_futex_value_locked(&uval, uaddr, vpid, 0))
-		goto pi_faulted;
-	/*
-	 * Rare case: we managed to release the lock atomically,
-	 * no need to wake anyone else up:
-	 */
-	if (unlikely(uval == vpid))
-		goto out_unlock;
-
-	/*
-	 * Ok, other tasks may need to be woken up - check waiters
-	 * and do the wakeup if necessary:
+	 * Check waiters first. We do not trust user space values at
+	 * all and we at least want to know if user space fiddled
+	 * with the futex value instead of blindly unlocking.
 	 */
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (!match_futex (&this->key, &key))
-			continue;
-		ret = wake_futex_pi(uaddr, uval, this);
+	match = futex_top_waiter(hb, &key);
+	if (match) {
+		ret = wake_futex_pi(uaddr, uval, match);
 		/*
-		 * The atomic access to the futex value
-		 * generated a pagefault, so retry the
-		 * user-access and the wakeup:
+		 * The atomic access to the futex value generated a
+		 * pagefault, so retry the user-access and the wakeup:
 		 */
 		if (ret == -EFAULT)
 			goto pi_faulted;
 		goto out_unlock;
 	}
+
 	/*
-	 * No waiters - kernel unlocks the futex:
+	 * We have no kernel internal state, i.e. no waiters in the
+	 * kernel. Waiters which are about to queue themselves are stuck
+	 * on hb->lock. So we can safely ignore them. We do neither
+	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
+	 * owner.
 	 */
-	ret = unlock_futex_pi(uaddr, uval);
-	if (ret == -EFAULT)
+	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))
 		goto pi_faulted;
 
+	/*
+	 * If uval has changed, let user space handle it.
+	 */
+	ret = (curval == uval) ? 0 : -EAGAIN;
+
 out_unlock:
 	spin_unlock(&hb->lock);
 	put_futex_key(&key);
-
-out:
 	return ret;
 
 pi_faulted:
@@ -2703,7 +2667,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter, 1);
+		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 
 		spin_lock(&hb2->lock);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index f97b9f65c5fa..164201aba52f 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1717,6 +1717,30 @@ static void run_hrtimer_softirq(struct softirq_action *h)
 }
 
 /*
+ * Called from timer softirq every jiffy, expire hrtimers:
+ *
+ * For HRT its the fall back code to run the softirq in the timer
+ * softirq context in case the hrtimer initialization failed or has
+ * not been done yet.
+ */
+void hrtimer_run_pending(void)
+{
+	if (hrtimer_hres_active())
+		return;
+
+	/*
+	 * This _is_ ugly: We have to check in the softirq context,
+	 * whether we can switch to highres and / or nohz mode. The
+	 * clocksource switch happens in the timer interrupt with
+	 * xtime_lock held. Notification from there only sets the
+	 * check bit in the tick_oneshot code, otherwise we might
+	 * deadlock vs. xtime_lock.
+	 */
+	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled()))
+		hrtimer_switch_to_hres();
+}
+
+/*
  * Called from hardirq context every jiffy
  */
 void hrtimer_run_queues(void)
@@ -1729,13 +1753,6 @@ void hrtimer_run_queues(void)
 	if (hrtimer_hres_active())
 		return;
 
-	/*
-	 * Check whether we can switch to highres mode.
-	 */
-	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())
-	    && hrtimer_switch_to_hres())
-		return;
-
 	for (index = 0; index < HRTIMER_MAX_CLOCK_BASES; index++) {
 		base = &cpu_base->clock_base[index];
 		if (!timerqueue_getnext(&base->active))
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index 90b8ba03e2a4..9a972e996185 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -98,7 +98,7 @@ int __lockfunc _mutex_lock_interruptible(struct mutex *lock)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_lock_interruptible(&lock->lock, 0);
+	ret = rt_mutex_lock_interruptible(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -110,7 +110,7 @@ int __lockfunc _mutex_lock_killable(struct mutex *lock)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&lock->lock, 0);
+	ret = rt_mutex_lock_killable(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -137,7 +137,7 @@ int __lockfunc _mutex_lock_interruptible_nested(struct mutex *lock, int subclass
 	int ret;
 
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, NULL, _RET_IP_);
-	ret = rt_mutex_lock_interruptible(&lock->lock, 0);
+	ret = rt_mutex_lock_interruptible(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -149,7 +149,7 @@ int __lockfunc _mutex_lock_killable_nested(struct mutex *lock, int subclass)
 	int ret;
 
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	ret = rt_mutex_lock_killable(&lock->lock, 0);
+	ret = rt_mutex_lock_killable(&lock->lock);
 	if (ret)
 		mutex_release(&lock->dep_map, 1, _RET_IP_);
 	return ret;
@@ -322,7 +322,8 @@ EXPORT_SYMBOL(rt_up_write);
 void  rt_up_read(struct rw_semaphore *rwsem)
 {
 	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	rt_mutex_unlock(&rwsem->lock);
+	if (--rwsem->read_depth == 0)
+		rt_mutex_unlock(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_up_read);
 
@@ -333,6 +334,7 @@ EXPORT_SYMBOL(rt_up_read);
 void  rt_downgrade_write(struct rw_semaphore *rwsem)
 {
 	BUG_ON(rt_mutex_owner(&rwsem->lock) != current);
+	rwsem->read_depth = 1;
 }
 EXPORT_SYMBOL(rt_downgrade_write);
 
@@ -370,12 +372,23 @@ EXPORT_SYMBOL(rt_down_write_nested_lock);
 
 int  rt_down_read_trylock(struct rw_semaphore *rwsem)
 {
-	int ret;
+	struct rt_mutex *lock = &rwsem->lock;
+	int ret = 1;
 
-	ret = rt_mutex_trylock(&rwsem->lock);
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	/*
+	 * recursive read locks succeed when current owns the rwsem,
+	 * but not when read_depth == 0 which means that the rwsem is
+	 * write locked.
+	 */
+	if (rt_mutex_owner(lock) != current)
+		ret = rt_mutex_trylock(&rwsem->lock);
+	else if (!rwsem->read_depth)
+		ret = 0;
 
+	if (ret) {
+		rwsem->read_depth++;
+		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_down_read_trylock);
@@ -383,7 +396,10 @@ EXPORT_SYMBOL(rt_down_read_trylock);
 static void __rt_down_read(struct rw_semaphore *rwsem, int subclass)
 {
 	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+
+	if (rt_mutex_owner(&rwsem->lock) != current)
+		rt_mutex_lock(&rwsem->lock);
+	rwsem->read_depth++;
 }
 
 void  rt_down_read(struct rw_semaphore *rwsem)
@@ -408,6 +424,7 @@ void  __rt_rwsem_init(struct rw_semaphore *rwsem, const char *name,
 	debug_check_no_locks_freed((void *)rwsem, sizeof(*rwsem));
 	lockdep_init_map(&rwsem->dep_map, name, key, 0);
 #endif
+	rwsem->read_depth = 0;
 	rwsem->lock.save_state = 0;
 }
 EXPORT_SYMBOL(__rt_rwsem_init);
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 49b2ed3dced8..62b6cee8ea7f 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -66,12 +66,13 @@ void rt_mutex_debug_task_free(struct task_struct *task)
  * the deadlock. We print when we return. act_waiter can be NULL in
  * case of a remove waiter operation.
  */
-void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *act_waiter,
+void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
+			     struct rt_mutex_waiter *act_waiter,
 			     struct rt_mutex *lock)
 {
 	struct task_struct *task;
 
-	if (!debug_locks || detect || !act_waiter)
+	if (!debug_locks || chwalk == RT_MUTEX_FULL_CHAINWALK || !act_waiter)
 		return;
 
 	task = rt_mutex_owner(act_waiter->lock);
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index ab29b6a22669..d0519c3432b6 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -20,14 +20,15 @@ extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
 				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *waiter,
+extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
+				    struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
 extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
 # define debug_rt_mutex_reset_waiter(w)			\
 	do { (w)->deadlock_lock = NULL; } while (0)
 
-static inline int debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
-						 int detect)
+static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
+						  enum rtmutex_chainwalk walk)
 {
 	return (waiter != NULL);
 }
diff --git a/kernel/locking/rtmutex-tester.c b/kernel/locking/rtmutex-tester.c
index 1d96dd0d93c1..a6b605b51b97 100644
--- a/kernel/locking/rtmutex-tester.c
+++ b/kernel/locking/rtmutex-tester.c
@@ -16,7 +16,7 @@
 #include <linux/freezer.h>
 #include <linux/stat.h>
 
-#include "rtmutex.h"
+#include "rtmutex_common.h"
 
 #define MAX_RT_TEST_THREADS	8
 #define MAX_RT_TEST_MUTEXES	8
@@ -107,7 +107,7 @@ static int handle_op(struct test_thread_data *td, int lockwakeup)
 
 		td->mutexes[id] = 1;
 		td->event = atomic_add_return(1, &rttest_event);
-		ret = rt_mutex_lock_interruptible(&mutexes[id], 0);
+		ret = rt_mutex_lock_interruptible(&mutexes[id]);
 		td->event = atomic_add_return(1, &rttest_event);
 		td->mutexes[id] = ret ? 0 : 4;
 		return ret ? -EINTR : 0;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660d1168..ee4e7e747e06 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -329,13 +329,40 @@ static void rt_mutex_wake_waiter(struct rt_mutex_waiter *waiter)
 }
 
 /*
+ * Deadlock detection is conditional:
+ *
+ * If CONFIG_DEBUG_RT_MUTEXES=n, deadlock detection is only conducted
+ * if the detect argument is == RT_MUTEX_FULL_CHAINWALK.
+ *
+ * If CONFIG_DEBUG_RT_MUTEXES=y, deadlock detection is always
+ * conducted independent of the detect argument.
+ *
+ * If the waiter argument is NULL this indicates the deboost path and
+ * deadlock detection is disabled independent of the detect argument
+ * and the config settings.
+ */
+static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
+					  enum rtmutex_chainwalk chwalk)
+{
+	/*
+	 * This is just a wrapper function for the following call,
+	 * because debug_rt_mutex_detect_deadlock() smells like a magic
+	 * debug feature and I wanted to keep the cond function in the
+	 * main source file along with the comments instead of having
+	 * two of the same in the headers.
+	 */
+	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+}
+
+/*
  * Max number of times we'll walk the boosting chain:
  */
 int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -358,21 +385,65 @@ static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
  * @top_task:	the current top waiter
  *
  * Returns 0 or -EDEADLK.
+ *
+ * Chain walk basics and protection scope
+ *
+ * [R] refcount on task
+ * [P] task->pi_lock held
+ * [L] rtmutex->wait_lock held
+ *
+ * Step	Description				Protected by
+ *	function arguments:
+ *	@task					[R]
+ *	@orig_lock if != NULL			@top_task is blocked on it
+ *	@next_lock				Unprotected. Cannot be
+ *						dereferenced. Only used for
+ *						comparison.
+ *	@orig_waiter if != NULL			@top_task is blocked on it
+ *	@top_task				current, or in case of proxy
+ *						locking protected by calling
+ *						code
+ *	again:
+ *	  loop_sanity_check();
+ *	retry:
+ * [1]	  lock(task->pi_lock);			[R] acquire [P]
+ * [2]	  waiter = task->pi_blocked_on;		[P]
+ * [3]	  check_exit_conditions_1();		[P]
+ * [4]	  lock = waiter->lock;			[P]
+ * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
+ *	    unlock(task->pi_lock);		release [P]
+ *	    goto retry;
+ *	  }
+ * [6]	  check_exit_conditions_2();		[P] + [L]
+ * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
+ * [8]	  unlock(task->pi_lock);		release [P]
+ *	  put_task_struct(task);		release [R]
+ * [9]	  check_exit_conditions_3();		[L]
+ * [10]	  task = owner(lock);			[L]
+ *	  get_task_struct(task);		[L] acquire [R]
+ *	  lock(task->pi_lock);			[L] acquire [P]
+ * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
+ * [12]	  check_exit_conditions_4();		[P] + [L]
+ * [13]	  unlock(task->pi_lock);		release [P]
+ *	  unlock(lock->wait_lock);		release [L]
+ *	  goto again;
  */
 static int rt_mutex_adjust_prio_chain(struct task_struct *task,
-				      int deadlock_detect,
+				      enum rtmutex_chainwalk chwalk,
 				      struct rt_mutex *orig_lock,
 				      struct rt_mutex *next_lock,
 				      struct rt_mutex_waiter *orig_waiter,
 				      struct task_struct *top_task)
 {
-	struct rt_mutex *lock;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
-	int detect_deadlock, ret = 0, depth = 0;
+	struct rt_mutex_waiter *prerequeue_top_waiter;
+	int ret = 0, depth = 0;
+	struct rt_mutex *lock;
+	bool detect_deadlock;
 	unsigned long flags;
+	bool requeue = true;
 
-	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
-							 deadlock_detect);
+	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);
 
 	/*
 	 * The (de)boosting is a step by step approach with a lot of
@@ -381,6 +452,9 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * carefully whether things change under us.
 	 */
  again:
+	/*
+	 * We limit the lock chain length for each invocation.
+	 */
 	if (++depth > max_lock_depth) {
 		static int prev_max;
 
@@ -398,13 +472,28 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 		return -EDEADLK;
 	}
+
+	/*
+	 * We are fully preemptible here and only hold the refcount on
+	 * @task. So everything can have changed under us since the
+	 * caller or our own code below (goto retry/again) dropped all
+	 * locks.
+	 */
  retry:
 	/*
-	 * Task can not go away as we did a get_task() before !
+	 * [1] Task cannot go away as we did a get_task() before !
 	 */
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
+	/*
+	 * [2] Get the waiter on which @task is blocked on.
+	 */
 	waiter = task->pi_blocked_on;
+
+	/*
+	 * [3] check_exit_conditions_1() protected by task->pi_lock.
+	 */
+
 	/*
 	 * Check whether the end of the boosting chain has been
 	 * reached or the state of the chain has changed while we
@@ -442,20 +531,41 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 			goto out_unlock_pi;
 		/*
 		 * If deadlock detection is off, we stop here if we
-		 * are not the top pi waiter of the task.
+		 * are not the top pi waiter of the task. If deadlock
+		 * detection is enabled we continue, but stop the
+		 * requeueing in the chain walk.
 		 */
-		if (!detect_deadlock && top_waiter != task_top_pi_waiter(task))
-			goto out_unlock_pi;
+		if (top_waiter != task_top_pi_waiter(task)) {
+			if (!detect_deadlock)
+				goto out_unlock_pi;
+			else
+				requeue = false;
+		}
 	}
 
 	/*
-	 * When deadlock detection is off then we check, if further
-	 * priority adjustment is necessary.
+	 * If the waiter priority is the same as the task priority
+	 * then there is no further priority adjustment necessary.  If
+	 * deadlock detection is off, we stop the chain walk. If its
+	 * enabled we continue, but stop the requeueing in the chain
+	 * walk.
 	 */
-	if (!detect_deadlock && waiter->prio == task->prio)
-		goto out_unlock_pi;
+	if (waiter->prio == task->prio) {
+		if (!detect_deadlock)
+			goto out_unlock_pi;
+		else
+			requeue = false;
+	}
 
+	/*
+	 * [4] Get the next lock
+	 */
 	lock = waiter->lock;
+	/*
+	 * [5] We need to trylock here as we are holding task->pi_lock,
+	 * which is the reverse lock order versus the other rtmutex
+	 * operations.
+	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		cpu_relax();
@@ -463,81 +573,183 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/*
+	 * [6] check_exit_conditions_2() protected by task->pi_lock and
+	 * lock->wait_lock.
+	 *
 	 * Deadlock detection. If the lock is the same as the original
 	 * lock which caused us to walk the lock chain or if the
 	 * current lock is owned by the task which initiated the chain
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
+		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
 		goto out_unlock_pi;
 	}
 
-	top_waiter = rt_mutex_top_waiter(lock);
+	/*
+	 * If we just follow the lock chain for deadlock detection, no
+	 * need to do all the requeue operations. To avoid a truckload
+	 * of conditionals around the various places below, just do the
+	 * minimum chain walk checks.
+	 */
+	if (!requeue) {
+		/*
+		 * No requeue[7] here. Just release @task [8]
+		 */
+		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		put_task_struct(task);
+
+		/*
+		 * [9] check_exit_conditions_3 protected by lock->wait_lock.
+		 * If there is no owner of the lock, end of chain.
+		 */
+		if (!rt_mutex_owner(lock)) {
+			raw_spin_unlock(&lock->wait_lock);
+			return 0;
+		}
+
+		/* [10] Grab the next task, i.e. owner of @lock */
+		task = rt_mutex_owner(lock);
+		get_task_struct(task);
+		raw_spin_lock_irqsave(&task->pi_lock, flags);
 
-	/* Requeue the waiter */
+		/*
+		 * No requeue [11] here. We just do deadlock detection.
+		 *
+		 * [12] Store whether owner is blocked
+		 * itself. Decision is made after dropping the locks
+		 */
+		next_lock = task_blocked_on_lock(task);
+		/*
+		 * Get the top waiter for the next iteration
+		 */
+		top_waiter = rt_mutex_top_waiter(lock);
+
+		/* [13] Drop locks */
+		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock(&lock->wait_lock);
+
+		/* If owner is not blocked, end of chain. */
+		if (!next_lock)
+			goto out_put_task;
+		goto again;
+	}
+
+	/*
+	 * Store the current top waiter before doing the requeue
+	 * operation on @lock. We need it for the boost/deboost
+	 * decision below.
+	 */
+	prerequeue_top_waiter = rt_mutex_top_waiter(lock);
+
+	/* [7] Requeue the waiter in the lock waiter list. */
 	rt_mutex_dequeue(lock, waiter);
 	waiter->prio = task->prio;
 	rt_mutex_enqueue(lock, waiter);
 
-	/* Release the task */
+	/* [8] Release the task */
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	put_task_struct(task);
+
+	/*
+	 * [9] check_exit_conditions_3 protected by lock->wait_lock.
+	 *
+	 * We must abort the chain walk if there is no lock owner even
+	 * in the dead lock detection case, as we have nothing to
+	 * follow here. This is the end of the chain we are walking.
+	 */
 	if (!rt_mutex_owner(lock)) {
 		struct rt_mutex_waiter *lock_top_waiter;
 
 		/*
-		 * If the requeue above changed the top waiter, then we need
-		 * to wake the new top waiter up to try to get the lock.
+		 * If the requeue [7] above changed the top waiter,
+		 * then we need to wake the new top waiter up to try
+		 * to get the lock.
 		 */
 		lock_top_waiter = rt_mutex_top_waiter(lock);
-		if (top_waiter != lock_top_waiter)
+		if (prerequeue_top_waiter != lock_top_waiter)
 			rt_mutex_wake_waiter(lock_top_waiter);
 		raw_spin_unlock(&lock->wait_lock);
-		goto out_put_task;
+		return 0;
 	}
-	put_task_struct(task);
 
-	/* Grab the next task */
+	/* [10] Grab the next task, i.e. the owner of @lock */
 	task = rt_mutex_owner(lock);
 	get_task_struct(task);
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
+	/* [11] requeue the pi waiters if necessary */
 	if (waiter == rt_mutex_top_waiter(lock)) {
-		/* Boost the owner */
-		rt_mutex_dequeue_pi(task, top_waiter);
+		/*
+		 * The waiter became the new top (highest priority)
+		 * waiter on the lock. Replace the previous top waiter
+		 * in the owner tasks pi waiters list with this waiter
+		 * and adjust the priority of the owner.
+		 */
+		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
 		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
 
-	} else if (top_waiter == waiter) {
-		/* Deboost the owner */
+	} else if (prerequeue_top_waiter == waiter) {
+		/*
+		 * The waiter was the top waiter on the lock, but is
+		 * no longer the top prority waiter. Replace waiter in
+		 * the owner tasks pi waiters list with the new top
+		 * (highest priority) waiter and adjust the priority
+		 * of the owner.
+		 * The new top waiter is stored in @waiter so that
+		 * @waiter == @top_waiter evaluates to true below and
+		 * we continue to deboost the rest of the chain.
+		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
 		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
+	} else {
+		/*
+		 * Nothing changed. No need to do any priority
+		 * adjustment.
+		 */
 	}
 
 	/*
+	 * [12] check_exit_conditions_4() protected by task->pi_lock
+	 * and lock->wait_lock. The actual decisions are made after we
+	 * dropped the locks.
+	 *
 	 * Check whether the task which owns the current lock is pi
 	 * blocked itself. If yes we store a pointer to the lock for
 	 * the lock chain change detection above. After we dropped
 	 * task->pi_lock next_lock cannot be dereferenced anymore.
 	 */
 	next_lock = task_blocked_on_lock(task);
+	/*
+	 * Store the top waiter of @lock for the end of chain walk
+	 * decision below.
+	 */
+	top_waiter = rt_mutex_top_waiter(lock);
 
+	/* [13] Drop the locks */
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-
-	top_waiter = rt_mutex_top_waiter(lock);
 	raw_spin_unlock(&lock->wait_lock);
 
 	/*
+	 * Make the actual exit decisions [12], based on the stored
+	 * values.
+	 *
 	 * We reached the end of the lock chain. Stop right here. No
 	 * point to go back just to figure that out.
 	 */
 	if (!next_lock)
 		goto out_put_task;
 
+	/*
+	 * If the current waiter is not the top waiter on the lock,
+	 * then we can stop the chain walk here if we are not in full
+	 * deadlock detection mode.
+	 */
 	if (!detect_deadlock && waiter != top_waiter)
 		goto out_put_task;
 
@@ -575,78 +787,120 @@ static inline int lock_is_stealable(struct task_struct *task,
  *
  * Must be called with lock->wait_lock held.
  *
- * @lock:   the lock to be acquired.
- * @task:   the task which wants to acquire the lock
- * @waiter: the waiter that is queued to the lock's wait list. (could be NULL)
+ * @lock:   The lock to be acquired.
+ * @task:   The task which wants to acquire the lock
+ * @waiter: The waiter that is queued to the lock's wait list if the
+ *	    callsite called task_blocked_on_lock(), otherwise NULL
  */
 static int
 __try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 		       struct rt_mutex_waiter *waiter, int mode)
 {
+	unsigned long flags;
+
 	/*
-	 * We have to be careful here if the atomic speedups are
-	 * enabled, such that, when
-	 *  - no other waiter is on the lock
-	 *  - the lock has been released since we did the cmpxchg
-	 * the lock can be released or taken while we are doing the
-	 * checks and marking the lock with RT_MUTEX_HAS_WAITERS.
+	 * Before testing whether we can acquire @lock, we set the
+	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
+	 * other tasks which try to modify @lock into the slow path
+	 * and they serialize on @lock->wait_lock.
+	 *
+	 * The RT_MUTEX_HAS_WAITERS bit can have a transitional state
+	 * as explained at the top of this file if and only if:
 	 *
-	 * The atomic acquire/release aware variant of
-	 * mark_rt_mutex_waiters uses a cmpxchg loop. After setting
-	 * the WAITERS bit, the atomic release / acquire can not
-	 * happen anymore and lock->wait_lock protects us from the
-	 * non-atomic case.
+	 * - There is a lock owner. The caller must fixup the
+	 *   transient state if it does a trylock or leaves the lock
+	 *   function due to a signal or timeout.
 	 *
-	 * Note, that this might set lock->owner =
-	 * RT_MUTEX_HAS_WAITERS in the case the lock is not contended
-	 * any more. This is fixed up when we take the ownership.
-	 * This is the transitional state explained at the top of this file.
+	 * - @task acquires the lock and there are no other
+	 *   waiters. This is undone in rt_mutex_set_owner(@task) at
+	 *   the end of this function.
 	 */
 	mark_rt_mutex_waiters(lock);
 
+	/*
+	 * If @lock has an owner, give up.
+	 */
 	if (rt_mutex_owner(lock))
 		return 0;
 
 	/*
-	 * It will get the lock because of one of these conditions:
-	 * 1) there is no waiter
-	 * 2) higher priority than waiters
-	 * 3) it is top waiter
+	 * If @waiter != NULL, @task has already enqueued the waiter
+	 * into @lock waiter list. If @waiter == NULL then this is a
+	 * trylock attempt.
 	 */
-	if (rt_mutex_has_waiters(lock)) {
-		struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
-
-		if (task != pown && !lock_is_stealable(task, pown, mode))
+	if (waiter) {
+		/*
+		 * If waiter is not the highest priority waiter of
+		 * @lock, give up.
+		 */
+		if (waiter != rt_mutex_top_waiter(lock))
 			return 0;
-	}
-
-	/* We got the lock. */
-
-	if (waiter || rt_mutex_has_waiters(lock)) {
-		unsigned long flags;
-		struct rt_mutex_waiter *top;
-
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
 
-		/* remove the queued waiter. */
-		if (waiter) {
-			rt_mutex_dequeue(lock, waiter);
-			task->pi_blocked_on = NULL;
-		}
+		/*
+		 * We can acquire the lock. Remove the waiter from the
+		 * lock waiters list.
+		 */
+		rt_mutex_dequeue(lock, waiter);
 
+	} else {
 		/*
-		 * We have to enqueue the top waiter(if it exists) into
-		 * task->pi_waiters list.
+		 * If the lock has waiters already we check whether @task is
+		 * eligible to take over the lock.
+		 *
+		 * If there are no other waiters, @task can acquire
+		 * the lock.  @task->pi_blocked_on is NULL, so it does
+		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			top = rt_mutex_top_waiter(lock);
-			rt_mutex_enqueue_pi(task, top);
+			/*
+			 * If @task->prio is greater than or equal to
+			 * the top waiter priority (kernel view),
+			 * @task lost.
+			 */
+			if (task->prio >= rt_mutex_top_waiter(lock)->prio)
+				return 0;
+
+			/*
+			 * The current top waiter stays enqueued. We
+			 * don't have to change anything in the lock
+			 * waiters order.
+			 */
+		} else {
+			/*
+			 * No waiters. Take the lock without the
+			 * pi_lock dance.@task->pi_blocked_on is NULL
+			 * and we have no waiters to enqueue in @task
+			 * pi waiters list.
+			 */
+			goto takeit;
 		}
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 	}
 
+	/*
+	 * Clear @task->pi_blocked_on. Requires protection by
+	 * @task->pi_lock. Redundant operation for the @waiter == NULL
+	 * case, but conditionals are more expensive than a redundant
+	 * store.
+	 */
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	task->pi_blocked_on = NULL;
+	/*
+	 * Finish the lock acquisition. @task is the new owner. If
+	 * other waiters exist we have to insert the highest priority
+	 * waiter into @task->pi_waiters list.
+	 */
+	if (rt_mutex_has_waiters(lock))
+		rt_mutex_enqueue_pi(task, rt_mutex_top_waiter(lock));
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+takeit:
+	/* We got the lock. */
 	debug_rt_mutex_lock(lock);
 
+	/*
+	 * This either preserves the RT_MUTEX_HAS_WAITERS bit if there
+	 * are still waiters or clears it.
+	 */
 	rt_mutex_set_owner(lock, task);
 
 	rt_mutex_deadlock_account_lock(lock, task);
@@ -671,7 +925,7 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
 				   struct task_struct *task,
-				   int detect_deadlock)
+				   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
@@ -734,7 +988,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		__rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
-	} else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
+	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
 	}
 
@@ -759,7 +1013,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
+	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
 	raw_spin_lock(&lock->wait_lock);
@@ -821,7 +1075,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	int first = (waiter == rt_mutex_top_waiter(lock));
+	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
@@ -831,30 +1085,32 @@ static void remove_waiter(struct rt_mutex *lock,
 	current->pi_blocked_on = NULL;
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
-	if (!owner)
+	/*
+	 * Only update priority if the waiter was the highest priority
+	 * waiter of the lock and there is an owner to update.
+	 */
+	if (!owner || !is_top_waiter)
 		return;
 
-	if (first) {
-
-		raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 
-		rt_mutex_dequeue_pi(owner, waiter);
+	rt_mutex_dequeue_pi(owner, waiter);
 
-		if (rt_mutex_has_waiters(lock)) {
-			struct rt_mutex_waiter *next;
+	if (rt_mutex_has_waiters(lock))
+		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-			next = rt_mutex_top_waiter(lock);
-			rt_mutex_enqueue_pi(owner, next);
-		}
-		__rt_mutex_adjust_prio(owner);
+	__rt_mutex_adjust_prio(owner);
 
-		/* Store the lock on which owner is blocked or NULL */
-		if (rt_mutex_real_waiter(owner->pi_blocked_on))
-			next_lock = task_blocked_on_lock(owner);
+	/* Store the lock on which owner is blocked or NULL */
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		next_lock = task_blocked_on_lock(owner);
 
-		raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
-	}
+	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
 
+	/*
+	 * Don't walk the chain, if the owner task is not blocked
+	 * itself.
+	 */
 	if (!next_lock)
 		return;
 
@@ -863,7 +1119,8 @@ static void remove_waiter(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	rt_mutex_adjust_prio_chain(owner, 0, lock, next_lock, NULL, current);
+	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
+				   next_lock, NULL, current);
 
 	raw_spin_lock(&lock->wait_lock);
 }
@@ -892,7 +1149,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(task);
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-	rt_mutex_adjust_prio_chain(task, 0, NULL, next_lock, NULL, task);
+	rt_mutex_adjust_prio_chain(task, RT_MUTEX_MIN_CHAINWALK, NULL,
+				   next_lock, NULL, task);
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -1405,7 +1663,8 @@ static void ww_mutex_account_lock(struct rt_mutex *lock,
 static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
-		  int detect_deadlock, struct ww_acquire_ctx *ww_ctx)
+		  enum rtmutex_chainwalk chwalk,
+		  struct ww_acquire_ctx *ww_ctx)
 {
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
@@ -1431,16 +1690,24 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 			timeout->task = NULL;
 	}
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, detect_deadlock);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
 
 	if (likely(!ret))
 		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter, ww_ctx);
+	else if (ww_ctx) {
+		/* ww_mutex received EDEADLK, let it become EALREADY */
+		ret = __mutex_lock_check_stamp(lock, ww_ctx);
+		BUG_ON(!ret);
+	}
 
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, detect_deadlock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -1465,23 +1732,32 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 /*
  * Slow path try-lock function:
  */
-static inline int
-rt_mutex_slowtrylock(struct rt_mutex *lock)
+static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
-	int ret = 0;
+	int ret;
+
+	/*
+	 * If the lock already has an owner we fail to get the lock.
+	 * This can be done without taking the @lock->wait_lock as
+	 * it is only being read, and this is a trylock anyway.
+	 */
+	if (rt_mutex_owner(lock))
+		return 0;
 
+	/*
+	 * The mutex has currently no owner. Lock the wait lock and
+	 * try to acquire the lock.
+	 */
 	if (!raw_spin_trylock(&lock->wait_lock))
-		return ret;
+		return 0;
 
-	if (likely(rt_mutex_owner(lock) != current)) {
+	ret = try_to_take_rt_mutex(lock, current, NULL);
 
-		ret = try_to_take_rt_mutex(lock, current, NULL);
-		/*
-		 * try_to_take_rt_mutex() sets the lock waiters
-		 * bit unconditionally. Clean this up.
-		 */
-		fixup_rt_mutex_waiters(lock);
-	}
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
 
 	raw_spin_unlock(&lock->wait_lock);
 
@@ -1559,33 +1835,35 @@ rt_mutex_slowunlock(struct rt_mutex *lock)
  */
 static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int detect_deadlock, struct ww_acquire_ctx *ww_ctx,
+		  struct ww_acquire_ctx *ww_ctx,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
-				int detect_deadlock,
+				enum rtmutex_chainwalk chwalk,
 				struct ww_acquire_ctx *ww_ctx))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, detect_deadlock, ww_ctx);
+		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
 static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout, int detect_deadlock,
+			struct hrtimer_sleeper *timeout,
+			enum rtmutex_chainwalk chwalk,
 			struct ww_acquire_ctx *ww_ctx,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock,
+				      enum rtmutex_chainwalk chwalk,
 				      struct ww_acquire_ctx *ww_ctx))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
+	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, timeout, detect_deadlock, ww_ctx);
+		return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
 static inline int
@@ -1618,7 +1896,7 @@ void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
 	might_sleep();
 
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, rt_mutex_slowlock);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 
@@ -1626,41 +1904,48 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
  *
  * @lock:		the rt_mutex to be locked
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
- * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock,
-						 int detect_deadlock)
+int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
 	might_sleep();
 
-	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE,
-				 detect_deadlock, NULL, rt_mutex_slowlock);
+	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
+/*
+ * Futex variant with full deadlock detection.
+ */
+int rt_mutex_timed_futex_lock(struct rt_mutex *lock,
+			      struct hrtimer_sleeper *timeout)
+{
+	might_sleep();
+
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
+				       RT_MUTEX_FULL_CHAINWALK, NULL,
+				       rt_mutex_slowlock);
+}
+
 /**
  * rt_mutex_lock_killable - lock a rt_mutex killable
  *
  * @lock:		the rt_mutex to be locked
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
  * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int __sched rt_mutex_lock_killable(struct rt_mutex *lock,
-				   int detect_deadlock)
+int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
 {
 	might_sleep();
 
 	return rt_mutex_fastlock(lock, TASK_KILLABLE,
-				 detect_deadlock, NULL, rt_mutex_slowlock);
+				 NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
 
@@ -1671,22 +1956,20 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
  *
  * @lock:		the rt_mutex to be locked
  * @timeout:		timeout structure or NULL (no timeout)
- * @detect_deadlock:	deadlock detection on/off
  *
  * Returns:
  *  0		on success
  * -EINTR	when interrupted by a signal
  * -ETIMEDOUT	when the timeout expired
- * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
 int
-rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout,
-		    int detect_deadlock)
+rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
 {
 	might_sleep();
 
 	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       detect_deadlock, NULL, rt_mutex_slowlock);
+				       RT_MUTEX_MIN_CHAINWALK,
+				       NULL, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 
@@ -1791,7 +2074,6 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  * @lock:		the rt_mutex to take
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
- * @detect_deadlock:	perform deadlock detection (1) or not (0)
  *
  * Returns:
  *  0 - task blocked on lock
@@ -1802,7 +2084,7 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  */
 int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
-			      struct task_struct *task, int detect_deadlock)
+			      struct task_struct *task)
 {
 	int ret;
 
@@ -1843,7 +2125,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 #endif
 
 	/* We enforce deadlock detection for futexes */
-	ret = task_blocks_on_rt_mutex(lock, waiter, task, 1);
+	ret = task_blocks_on_rt_mutex(lock, waiter, task,
+				      RT_MUTEX_FULL_CHAINWALK);
 
 	if (ret && !rt_mutex_owner(lock)) {
 		/*
@@ -1889,22 +2172,20 @@ struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
  * rt_mutex_finish_proxy_lock() - Complete lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
- * 			been started.
+ *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
- * @detect_deadlock:	perform deadlock detection (1) or not (0)
  *
  * Complete the lock acquisition started our behalf by another thread.
  *
  * Returns:
  *  0 - success
- * <0 - error, one of -EINTR, -ETIMEDOUT, or -EDEADLK
+ * <0 - error, one of -EINTR, -ETIMEDOUT
  *
  * Special API call for PI-futex requeue support
  */
 int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
-			       struct rt_mutex_waiter *waiter,
-			       int detect_deadlock)
+			       struct rt_mutex_waiter *waiter)
 {
 	int ret;
 
@@ -1964,7 +2245,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
 
 	might_sleep();
 
-	mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
 	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
@@ -1982,8 +2263,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 	might_sleep();
 
-	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map,
-			_RET_IP_);
+	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
 	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
@@ -1996,11 +2276,13 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock);
 
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
+	int nest = !!lock->ctx;
+
 	/*
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
 	 */
-	if (lock->ctx) {
+	if (nest) {
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
@@ -2009,7 +2291,7 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 		lock->ctx = NULL;
 	}
 
-	mutex_release(&lock->base.dep_map, 1, _RET_IP_);
+	mutex_release(&lock->base.dep_map, nest, _RET_IP_);
 	rt_mutex_unlock(&lock->base.lock);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index f6a1f3c133b1..c4060584c407 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -22,10 +22,15 @@
 #define debug_rt_mutex_init(m, n)			do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-#define debug_rt_mutex_detect_deadlock(w,d)		(d)
 #define debug_rt_mutex_reset_waiter(w)			do { } while (0)
 
 static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
 {
 	WARN(1, "rtmutex deadlock detected\n");
 }
+
+static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
+						  enum rtmutex_chainwalk walk)
+{
+	return walk == RT_MUTEX_FULL_CHAINWALK;
+}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ac636d37ec32..c6dcda5e53af 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -103,6 +103,21 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 }
 
 /*
+ * Constants for rt mutex functions which have a selectable deadlock
+ * detection.
+ *
+ * RT_MUTEX_MIN_CHAINWALK:	Stops the lock chain walk when there are
+ *				no further PI adjustments to be made.
+ *
+ * RT_MUTEX_FULL_CHAINWALK:	Invoke deadlock detection with a full
+ *				walk of the lock chain.
+ */
+enum rtmutex_chainwalk {
+	RT_MUTEX_MIN_CHAINWALK,
+	RT_MUTEX_FULL_CHAINWALK,
+};
+
+/*
  * PI-futex support (proxy locking functions, etc.):
  */
 #define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
@@ -115,12 +130,11 @@ extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 				  struct task_struct *proxy_owner);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task,
-				     int detect_deadlock);
+				     struct task_struct *task);
 extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 				      struct hrtimer_sleeper *to,
-				      struct rt_mutex_waiter *waiter,
-				      int detect_deadlock);
+				      struct rt_mutex_waiter *waiter);
+extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index b14a512da520..d8374f999e9b 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -13,7 +13,7 @@ endif
 
 obj-y += core.o proc.o clock.o cputime.o
 obj-y += idle_task.o fair.o rt.o deadline.o stop_task.o
-obj-y += wait.o wait-simple.o completion.o
+obj-y += wait.o wait-simple.o work-simple.o completion.o
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
new file mode 100644
index 000000000000..c996f755dba6
--- /dev/null
+++ b/kernel/sched/work-simple.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner daniel.wagner@bmw-carit.de
+ *
+ * Provides a framework for enqueuing callbacks from irq context
+ * PREEMPT_RT_FULL safe. The callbacks are executed in kthread context.
+ */
+
+#include <linux/wait-simple.h>
+#include <linux/work-simple.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define SWORK_EVENT_PENDING     (1 << 0)
+
+static DEFINE_MUTEX(worker_mutex);
+static struct sworker *glob_worker;
+
+struct sworker {
+	struct list_head events;
+	struct swait_head wq;
+
+	raw_spinlock_t lock;
+
+	struct task_struct *task;
+	int refs;
+};
+
+static bool swork_readable(struct sworker *worker)
+{
+	bool r;
+
+	if (kthread_should_stop())
+		return true;
+
+	raw_spin_lock_irq(&worker->lock);
+	r = !list_empty(&worker->events);
+	raw_spin_unlock_irq(&worker->lock);
+
+	return r;
+}
+
+static int swork_kthread(void *arg)
+{
+	struct sworker *worker = arg;
+
+	for (;;) {
+		swait_event_interruptible(worker->wq,
+					swork_readable(worker));
+		if (kthread_should_stop())
+			break;
+
+		raw_spin_lock_irq(&worker->lock);
+		while (!list_empty(&worker->events)) {
+			struct swork_event *sev;
+
+			sev = list_first_entry(&worker->events,
+					struct swork_event, item);
+			list_del(&sev->item);
+			raw_spin_unlock_irq(&worker->lock);
+
+			WARN_ON_ONCE(!test_and_clear_bit(SWORK_EVENT_PENDING,
+							 &sev->flags));
+			sev->func(sev);
+			raw_spin_lock_irq(&worker->lock);
+		}
+		raw_spin_unlock_irq(&worker->lock);
+	}
+	return 0;
+}
+
+static struct sworker *swork_create(void)
+{
+	struct sworker *worker;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
+	if (!worker)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&worker->events);
+	raw_spin_lock_init(&worker->lock);
+	init_swait_head(&worker->wq);
+
+	worker->task = kthread_run(swork_kthread, worker, "kswork");
+	if (IS_ERR(worker->task)) {
+		kfree(worker);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return worker;
+}
+
+static void swork_destroy(struct sworker *worker)
+{
+	kthread_stop(worker->task);
+
+	WARN_ON(!list_empty(&worker->events));
+	kfree(worker);
+}
+
+/**
+ * swork_queue - queue swork
+ *
+ * Returns %false if @work was already on a queue, %true otherwise.
+ *
+ * The work is queued and processed on a random CPU
+ */
+bool swork_queue(struct swork_event *sev)
+{
+	unsigned long flags;
+
+	if (test_and_set_bit(SWORK_EVENT_PENDING, &sev->flags))
+		return false;
+
+	raw_spin_lock_irqsave(&glob_worker->lock, flags);
+	list_add_tail(&sev->item, &glob_worker->events);
+	raw_spin_unlock_irqrestore(&glob_worker->lock, flags);
+
+	swait_wake(&glob_worker->wq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(swork_queue);
+
+/**
+ * swork_get - get an instance of the sworker
+ *
+ * Returns an negative error code if the initialization if the worker did not
+ * work, %0 otherwise.
+ *
+ */
+int swork_get(void)
+{
+	struct sworker *worker;
+
+	mutex_lock(&worker_mutex);
+	if (!glob_worker) {
+		worker = swork_create();
+		if (IS_ERR(worker)) {
+			mutex_unlock(&worker_mutex);
+			return -ENOMEM;
+		}
+
+		glob_worker = worker;
+	}
+
+	glob_worker->refs++;
+	mutex_unlock(&worker_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(swork_get);
+
+/**
+ * swork_put - puts an instance of the sworker
+ *
+ * Will destroy the sworker thread. This function must not be called until all
+ * queued events have been completed.
+ */
+void swork_put(void)
+{
+	mutex_lock(&worker_mutex);
+
+	glob_worker->refs--;
+	if (glob_worker->refs > 0)
+		goto out;
+
+	swork_destroy(glob_worker);
+	glob_worker = NULL;
+out:
+	mutex_unlock(&worker_mutex);
+}
+EXPORT_SYMBOL_GPL(swork_put);
diff --git a/kernel/timer.c b/kernel/timer.c
index 8f1687a4b9c2..34fd2dbba3e3 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -84,6 +84,7 @@ struct tvec_base {
 	unsigned long timer_jiffies;
 	unsigned long next_timer;
 	unsigned long active_timers;
+	unsigned long all_timers;
 	struct tvec_root tv1;
 	struct tvec tv2;
 	struct tvec tv3;
@@ -340,6 +341,20 @@ void set_timer_slack(struct timer_list *timer, int slack_hz)
 }
 EXPORT_SYMBOL_GPL(set_timer_slack);
 
+/*
+ * If the list is empty, catch up ->timer_jiffies to the current time.
+ * The caller must hold the tvec_base lock.  Returns true if the list
+ * was empty and therefore ->timer_jiffies was updated.
+ */
+static bool catchup_timer_jiffies(struct tvec_base *base)
+{
+	if (!base->all_timers) {
+		base->timer_jiffies = jiffies;
+		return true;
+	}
+	return false;
+}
+
 static void
 __internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 {
@@ -386,6 +401,7 @@ __internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 
 static void internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 {
+	(void)catchup_timer_jiffies(base);
 	__internal_add_timer(base, timer);
 	/*
 	 * Update base->active_timers and base->next_timer
@@ -395,6 +411,7 @@ static void internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 			base->next_timer = timer->expires;
 		base->active_timers++;
 	}
+	base->all_timers++;
 }
 
 #ifdef CONFIG_TIMER_STATS
@@ -674,6 +691,8 @@ detach_expired_timer(struct timer_list *timer, struct tvec_base *base)
 	detach_timer(timer, true);
 	if (!tbase_get_deferrable(timer->base))
 		base->active_timers--;
+	base->all_timers--;
+	(void)catchup_timer_jiffies(base);
 }
 
 static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
@@ -688,6 +707,8 @@ static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
 		if (timer->expires == base->next_timer)
 			base->next_timer = base->timer_jiffies;
 	}
+	base->all_timers--;
+	(void)catchup_timer_jiffies(base);
 	return 1;
 }
 
@@ -1199,6 +1220,10 @@ static inline void __run_timers(struct tvec_base *base)
 	struct timer_list *timer;
 
 	spin_lock_irq(&base->lock);
+	if (catchup_timer_jiffies(base)) {
+		spin_unlock_irq(&base->lock);
+		return;
+	}
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list;
 		struct list_head *head = &work_list;
@@ -1439,6 +1464,8 @@ static void run_timer_softirq(struct softirq_action *h)
 {
 	struct tvec_base *base = __this_cpu_read(tvec_bases);
 
+	hrtimer_run_pending();
+
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
 	irq_work_run();
 #endif
@@ -1452,52 +1479,8 @@ static void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
-	struct tvec_base *base = __this_cpu_read(tvec_bases);
-
 	hrtimer_run_queues();
-	/*
-	 * We can access this lockless as we are in the timer
-	 * interrupt. If there are no timers queued, nothing to do in
-	 * the timer softirq.
-	 */
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-#ifndef CONFIG_SMP
-	/*
-	 * The spin_do_trylock() later may fail as the lock may be hold before
-	 * the interrupt arrived. The spin-lock debugging code will raise a
-	 * warning if the try_lock fails on UP. Since this is only an
-	 * optimization for the FULL_NO_HZ case (not to run the timer softirq on
-	 * an nohz_full CPU) we don't really care and shedule the softirq.
-	 */
 	raise_softirq(TIMER_SOFTIRQ);
-	return;
-#endif
-
-	/* On RT, irq work runs from softirq */
-	if (irq_work_needs_cpu()) {
-		raise_softirq(TIMER_SOFTIRQ);
-		return;
-	}
-
-	if (!spin_do_trylock(&base->lock)) {
-		raise_softirq(TIMER_SOFTIRQ);
-		return;
-	}
-#endif
-
-	if (!base->active_timers)
-		goto out;
-
-	/* Check whether the next pending timer has expired */
-	if (time_before_eq(base->next_timer, jiffies))
-		raise_softirq(TIMER_SOFTIRQ);
-out:
-#ifdef CONFIG_PREEMPT_RT_FULL
-	rt_spin_unlock_after_trylock_in_irq(&base->lock);
-#endif
-	/* The ; ensures that gcc won't complain in the !RT case */
-	;
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM
@@ -1677,6 +1660,7 @@ static int init_timers_cpu(int cpu)
 	base->timer_jiffies = jiffies;
 	base->next_timer = base->timer_jiffies;
 	base->active_timers = 0;
+	base->all_timers = 0;
 	return 0;
 }
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 19ae2366a7a9..b93a6103fa4d 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -590,6 +590,8 @@ GENERATE_TESTCASE(init_held_rsem)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 
@@ -605,9 +607,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Enabling hardirqs with a softirq-safe lock held:
  */
@@ -640,6 +645,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
 
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -663,6 +670,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 
@@ -678,6 +687,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
@@ -709,6 +720,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 
@@ -724,6 +737,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
@@ -757,6 +772,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 
@@ -772,10 +789,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock irq inversion.
  *
@@ -838,6 +859,10 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+#endif
+
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -876,6 +901,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 #undef E2
 #undef E3
 
+#endif
+
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
diff --git a/localversion-rt b/localversion-rt
index a68b4337d4ce..ce6a482618d5 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt31
+-rt32
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fa54408b66b2..be24d2d186fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2512,14 +2512,17 @@ static void __init memcg_stock_init(void)
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
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index a4acaf2bcf18..22ca25818120 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -349,9 +349,9 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	if (!svc_xprt_has_something_to_do(xprt))
 		return;
 
-	cpu = get_cpu();
+	cpu = get_cpu_light();
 	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
-	put_cpu();
+	put_cpu_light();
 
 	spin_lock_bh(&pool->sp_lock);
 

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.70-rt75
Date: Fri, 20 Mar 2015 11:30:16 -0400
Message-ID: <20150320113016.2e81c856@gandalf.local.home>
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

I'm pleased to announce the 3.10.70-rt75 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: c7c3ff460dd7e682005d9e7a54ac014f2adb3f38


Or to build 3.10.70-rt75 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.70.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.70-rt75.patch.xz



You can also build from 3.10.70-rt74 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.70-rt74-rt75.patch.xz



Enjoy,

-- Steve


Changes from v3.10.70-rt74:

---

Daniel Wagner (1):
      work-simple: Simple work queue implemenation

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Kevin Hao (1):
      netpoll: guard the access to dev->npinfo with rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y

Mike Galbraith (4):
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()
      fs,btrfs: fix rt deadlock on extent_buffer->lock

Paul E. McKenney (4):
      timers: Track total number of timers in list
      timers: Reduce __run_timers() latency for empty list
      timers: Reduce future __run_timers() latency for newly emptied list
      timers: Reduce future __run_timers() latency for first add to empty list

Paul Gortmaker (1):
      sas-ata/isci: dont't disable interrupts in qc_issue handler

Sebastian Andrzej Siewior (3):
      gpio: omap: use raw locks for locking
      rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()

Steven Rostedt (1):
      create-rt-enqueue

Steven Rostedt (Red Hat) (2):
      Revert "timers: do not raise softirq unconditionally"
      Linux 3.10.70-rt75

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

Yong Zhang (1):
      ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later

----
 arch/arm/include/asm/cmpxchg.h     |   2 +
 arch/arm/include/asm/futex.h       |   4 +
 arch/arm/mm/fault.c                |   6 +
 arch/x86/include/asm/uv/uv_bau.h   |  14 +-
 arch/x86/include/asm/uv/uv_hub.h   |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |   2 +-
 arch/x86/platform/uv/tlb_uv.c      |  26 +-
 arch/x86/platform/uv/uv_time.c     |  21 +-
 drivers/gpio/gpio-omap.c           |  70 ++---
 drivers/scsi/libsas/sas_ata.c      |   4 +-
 fs/btrfs/ctree.c                   |   4 +-
 fs/btrfs/extent-tree.c             |   8 -
 include/linux/hrtimer.h            |   3 +-
 include/linux/netpoll.h            |  16 +-
 include/linux/rtmutex.h            |   8 +-
 include/linux/work-simple.h        |  24 ++
 kernel/futex.c                     | 407 +++++++++++--------------
 kernel/hrtimer.c                   |  31 +-
 kernel/rt.c                        |   8 +-
 kernel/rtmutex-debug.c             |   5 +-
 kernel/rtmutex-debug.h             |   7 +-
 kernel/rtmutex-tester.c            |   4 +-
 kernel/rtmutex.c                   | 604 +++++++++++++++++++++++++++----------
 kernel/rtmutex.h                   |   7 +-
 kernel/rtmutex_common.h            |  22 +-
 kernel/sched/Makefile              |   1 +
 kernel/sched/work-simple.c         | 172 +++++++++++
 kernel/timer.c                     |  72 ++---
 lib/locking-selftest.c             |  27 ++
 localversion-rt                    |   2 +-
 mm/memcontrol.c                    |   7 +-
 net/sunrpc/svc_xprt.c              |   4 +-
 32 files changed, 1057 insertions(+), 537 deletions(-)
---------------------------
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 4f009c10540d..a86b680dd7cf 100644
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
index d7434602d44c..10be5ebe31e2 100644
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
 
@@ -497,6 +500,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index a06983cdc125..afaaf2900796 100644
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
@@ -770,15 +770,15 @@ static inline int atom_asr(short i, struct atomic_short *v)
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
index 2c32df95bb78..2c676e8d39ac 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -502,7 +502,7 @@ struct uv_blade_info {
 	unsigned short	nr_online_cpus;
 	unsigned short	pnode;
 	short		memory_nid;
-	spinlock_t	nmi_lock;
+	raw_spinlock_t	nmi_lock;
 	unsigned long	nmi_count;
 };
 extern struct uv_blade_info *uv_blade_info;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index b32dbb411a9a..7a6ab4f38278 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -928,7 +928,7 @@ void __init uv_system_init(void)
 			uv_blade_info[blade].pnode = pnode;
 			uv_blade_info[blade].nr_possible_cpus = 0;
 			uv_blade_info[blade].nr_online_cpus = 0;
-			spin_lock_init(&uv_blade_info[blade].nmi_lock);
+			raw_spin_lock_init(&uv_blade_info[blade].nmi_lock);
 			min_pnode = min(pnode, min_pnode);
 			max_pnode = max(pnode, max_pnode);
 			blade++;
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 0f92173a12b6..7ddc988cfa93 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -695,9 +695,9 @@ static void destination_plugged(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -717,9 +717,9 @@ static void destination_timeout(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -740,7 +740,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -753,7 +753,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 			}
 		}
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -816,7 +816,7 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	spinlock_t *lock = &hmaster->uvhub_lock;
+	raw_spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -948,7 +948,7 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -960,10 +960,10 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
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
 
@@ -1880,9 +1880,9 @@ static void __init init_per_cpu_tunables(void)
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
index 54052125859a..0fb30e1d1cff 100644
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
@@ -503,19 +503,19 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
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
 
 	bank->irq_usage |= 1 << GPIO_INDEX(bank, gpio);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -632,14 +632,14 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (enable)
 		bank->context.wake_en |= gpio_bit;
 	else
 		bank->context.wake_en &= ~gpio_bit;
 
 	__raw_writel(bank->context.wake_en, bank->base + bank->regs->wkup_en);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -674,7 +674,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
 	 * not already been requested.
@@ -684,7 +684,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		_enable_gpio_module(bank, offset);
 	}
 	bank->mod_usage |= 1 << offset;
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -694,11 +694,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
@@ -796,11 +796,11 @@ static void gpio_irq_shutdown(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->irq_usage &= ~(1 << offset);
 	_disable_gpio_module(bank, offset);
 	_reset_gpio(bank, gpio);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
 	 * If this is the last IRQ to be freed in the bank,
@@ -824,10 +824,10 @@ static void gpio_mask_irq(struct irq_data *d)
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
@@ -838,7 +838,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
 		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
@@ -850,7 +850,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static struct irq_chip gpio_irq_chip = {
@@ -873,9 +873,9 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -888,9 +888,9 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	__raw_writel(bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -933,9 +933,9 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_direction(bank, offset, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
@@ -960,7 +960,7 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	int retval = 0;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	if (LINE_USED(bank->irq_usage, offset)) {
 			retval = -EINVAL;
@@ -971,7 +971,7 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	_set_gpio_direction(bank, offset, 0);
 
 exit:
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return retval;
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
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7fb054ba1b60..07753ee246f1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -81,7 +81,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 {
 	int i;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	/* lockdep really cares that we take all of these spinlocks
 	 * in the right order.  If any of the locks in the path are not
 	 * currently blocking, it is going to complain.  So, make really
@@ -108,7 +108,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 		}
 	}
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	if (held)
 		btrfs_clear_lock_blocking_rw(held, held_rw);
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f99c71e40f8b..920a85e82beb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6678,14 +6678,6 @@ again:
 		goto again;
 	}
 
-	if (btrfs_test_opt(root, ENOSPC_DEBUG)) {
-		static DEFINE_RATELIMIT_STATE(_rs,
-				DEFAULT_RATELIMIT_INTERVAL * 10,
-				/*DEFAULT_RATELIMIT_BURST*/ 1);
-		if (__ratelimit(&_rs))
-			WARN(1, KERN_DEBUG
-				"btrfs: block rsv returned %d\n", ret);
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
index fa2cb76a7029..c1e80c6272aa 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -86,9 +86,21 @@ static inline void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
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
index 5ebd0bbb6eaa..9340b866ce21 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -109,12 +109,10 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
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
index ae1068fdd786..e820a56daa6b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -643,95 +643,89 @@ void exit_pi_state_list(struct task_struct *curr)
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
-	struct plist_head *head;
-	struct task_struct *p;
 	pid_t pid = uval & FUTEX_TID_MASK;
 
-	head = &hb->chain;
+	/*
+	 * Userspace might have messed up non-PI and PI futexes [3]
+	 */
+	if (unlikely(!pi_state))
+		return -EINVAL;
 
-	plist_for_each_entry_safe(this, next, head, list) {
-		if (match_futex(&this->key, key)) {
-			/*
-			 * Sanity check the waiter before increasing
-			 * the refcount and attaching to it.
-			 */
-			pi_state = this->pi_state;
+	WARN_ON(!atomic_read(&pi_state->refcount));
+
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
-			 * Userspace might have messed up non-PI and
-			 * PI futexes [3]
+			 * No pi state owner, but the user space TID
+			 * is not 0. Inconsistent state. [5]
 			 */
-			if (unlikely(!pi_state))
+			if (pid)
 				return -EINVAL;
-
-			WARN_ON(!atomic_read(&pi_state->refcount));
-
 			/*
-			 * Handle the owner died case:
+			 * Take a ref on the state and return success. [4]
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
+			goto out_state;
+		}
 
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
+	}
 
-			/*
-			 * Bail out if user space manipulated the
-			 * futex value. If pi state exists then the
-			 * owner TID must be the same as the user
-			 * space TID. [9/10]
-			 */
-			if (pid != task_pid_vnr(pi_state->owner))
-				return -EINVAL;
+	/*
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
 
-		out_state:
-			atomic_inc(&pi_state->refcount);
-			*ps = pi_state;
-			return 0;
-		}
-	}
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
 
 	/*
 	 * We are the first waiter - try to look up the real owner and attach
@@ -774,7 +768,7 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	pi_state = alloc_pi_state();
 
 	/*
-	 * Initialize the pi_mutex in locked state and make 'p'
+	 * Initialize the pi_mutex in locked state and make @p
 	 * the owner of it:
 	 */
 	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
@@ -794,6 +788,36 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
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
@@ -817,113 +841,69 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
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
@@ -1039,22 +1019,6 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this)
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
@@ -1509,7 +1473,12 @@ retry_private:
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
 			put_futex_key(&key2);
 			put_futex_key(&key1);
@@ -1568,7 +1537,7 @@ retry_private:
 			this->pi_state = pi_state;
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
-							this->task, 1);
+							this->task);
 			if (ret == 1) {
 				/* We got the lock. */
 				requeue_pi_wake_futex(this, &key2, hb2);
@@ -2163,8 +2132,10 @@ retry_private:
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
 			queue_unlock(&q, hb);
 			put_futex_key(&q.key);
@@ -2184,9 +2155,9 @@ retry_private:
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
@@ -2248,11 +2219,10 @@ uaddr_faulted:
  */
 static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
-	struct futex_hash_bucket *hb;
-	struct futex_q *this, *next;
-	struct plist_head *head;
+	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
-	u32 uval, vpid = task_pid_vnr(current);
+	struct futex_hash_bucket *hb;
+	struct futex_q *match;
 	int ret;
 
 retry:
@@ -2265,61 +2235,50 @@ retry:
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
+	 * Check waiters first. We do not trust user space values at
+	 * all and we at least want to know if user space fiddled
+	 * with the futex value instead of blindly unlocking.
 	 */
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
-	 */
-	head = &hb->chain;
-
-	plist_for_each_entry_safe(this, next, head, list) {
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
 
+
 pi_faulted:
 	spin_unlock(&hb->lock);
 	put_futex_key(&key);
@@ -2551,7 +2510,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter, 1);
+		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 
 		spin_lock(&hb2->lock);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 1defbda1def8..1a28cafbac91 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1713,6 +1713,30 @@ static void run_hrtimer_softirq(struct softirq_action *h)
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
@@ -1725,13 +1749,6 @@ void hrtimer_run_queues(void)
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
diff --git a/kernel/rt.c b/kernel/rt.c
index 433ae4236181..1b3497d3b848 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
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
diff --git a/kernel/rtmutex-debug.c b/kernel/rtmutex-debug.c
index 13b243a323fa..2035a46ca489 100644
--- a/kernel/rtmutex-debug.c
+++ b/kernel/rtmutex-debug.c
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
diff --git a/kernel/rtmutex-debug.h b/kernel/rtmutex-debug.h
index ab29b6a22669..d0519c3432b6 100644
--- a/kernel/rtmutex-debug.h
+++ b/kernel/rtmutex-debug.h
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
diff --git a/kernel/rtmutex-tester.c b/kernel/rtmutex-tester.c
index 1d96dd0d93c1..a6b605b51b97 100644
--- a/kernel/rtmutex-tester.c
+++ b/kernel/rtmutex-tester.c
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
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 2671e5532534..5388ba98acaf 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -155,6 +155,31 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
 }
 #endif
 
+static inline void
+rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+{
+	plist_add(&waiter->list_entry, &lock->wait_list);
+}
+
+static inline void
+rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+{
+	plist_del(&waiter->list_entry, &lock->wait_list);
+}
+
+static inline void
+rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
+{
+	waiter->pi_list_entry.prio = waiter->list_entry.prio;
+	plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+}
+
+static inline void
+rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
+{
+	plist_del(&waiter->pi_list_entry, &task->pi_waiters);
+}
+
 static inline void init_lists(struct rt_mutex *lock)
 {
 	if (unlikely(!lock->wait_list.node_list.prev))
@@ -228,6 +253,32 @@ static void rt_mutex_wake_waiter(struct rt_mutex_waiter *waiter)
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
@@ -243,21 +294,65 @@ static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
  * Adjust the priority chain. Also used for deadlock detection.
  * Decreases task's usage by one - may thus free the task.
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
@@ -266,6 +361,9 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * carefully whether things change under us.
 	 */
  again:
+	/*
+	 * We limit the lock chain length for each invocation.
+	 */
 	if (++depth > max_lock_depth) {
 		static int prev_max;
 
@@ -283,13 +381,28 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 
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
@@ -327,20 +440,41 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
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
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
-		goto out_unlock_pi;
+	if (waiter->list_entry.prio == task->prio) {
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
@@ -348,83 +482,183 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
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
 
-	/* Requeue the waiter */
-	plist_del(&waiter->list_entry, &lock->wait_list);
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
+
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
+	rt_mutex_dequeue(lock, waiter);
 	waiter->list_entry.prio = task->prio;
-	plist_add(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_enqueue(lock, waiter);
 
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
-		plist_del(&top_waiter->pi_list_entry, &task->pi_waiters);
-		waiter->pi_list_entry.prio = waiter->list_entry.prio;
-		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		/*
+		 * The waiter became the new top (highest priority)
+		 * waiter on the lock. Replace the previous top waiter
+		 * in the owner tasks pi waiters list with this waiter
+		 * and adjust the priority of the owner.
+		 */
+		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		rt_mutex_enqueue_pi(task, waiter);
 		__rt_mutex_adjust_prio(task);
 
-	} else if (top_waiter == waiter) {
-		/* Deboost the owner */
-		plist_del(&waiter->pi_list_entry, &task->pi_waiters);
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
+		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
-		waiter->pi_list_entry.prio = waiter->list_entry.prio;
-		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		rt_mutex_enqueue_pi(task, waiter);
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
 
@@ -462,79 +696,122 @@ static inline int lock_is_stealable(struct task_struct *task,
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
 
-	if (waiter || rt_mutex_has_waiters(lock)) {
-		unsigned long flags;
-		struct rt_mutex_waiter *top;
-
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
-
-		/* remove the queued waiter. */
-		if (waiter) {
-			plist_del(&waiter->list_entry, &lock->wait_list);
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
-			top->pi_list_entry.prio = top->list_entry.prio;
-			plist_add(&top->pi_list_entry, &task->pi_waiters);
+			struct task_struct *pown = rt_mutex_top_waiter(lock)->task;
+
+			/*
+			 * If @task->prio is greater than or equal to
+			 * the top waiter priority (kernel view),
+			 * @task lost.
+			 */
+			if (task != pown && !lock_is_stealable(task, pown, mode))
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
@@ -559,7 +836,7 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
 				   struct task_struct *task,
-				   int detect_deadlock)
+				   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
@@ -606,7 +883,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
 		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_enqueue(lock, waiter);
 
 	task->pi_blocked_on = waiter;
 
@@ -617,13 +894,13 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_lock_irqsave(&owner->pi_lock, flags);
 	if (waiter == rt_mutex_top_waiter(lock)) {
-		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
-		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+		rt_mutex_dequeue_pi(owner, top_waiter);
+		rt_mutex_enqueue_pi(owner, waiter);
 
 		__rt_mutex_adjust_prio(owner);
 		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
-	} else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
+	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
 	}
 
@@ -648,7 +925,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
+	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
 	raw_spin_lock(&lock->wait_lock);
@@ -679,7 +956,7 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 	 * boosted mode and go back to normal after releasing
 	 * lock->wait_lock.
 	 */
-	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
+	rt_mutex_dequeue_pi(current, waiter);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -710,41 +987,44 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	int first = (waiter == rt_mutex_top_waiter(lock));
+	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
-	plist_del(&waiter->list_entry, &lock->wait_list);
+	rt_mutex_dequeue(lock, waiter);
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
 
-		plist_del(&waiter->pi_list_entry, &owner->pi_waiters);
+	rt_mutex_dequeue_pi(owner, waiter);
 
-		if (rt_mutex_has_waiters(lock)) {
-			struct rt_mutex_waiter *next;
+	if (rt_mutex_has_waiters(lock))
+		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-			next = rt_mutex_top_waiter(lock);
-			plist_add(&next->pi_list_entry, &owner->pi_waiters);
-		}
-		__rt_mutex_adjust_prio(owner);
+	__rt_mutex_adjust_prio(owner);
 
-		/* Store the lock on which owner is blocked or NULL */
+	/* Store the lock on which owner is blocked or NULL */
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
 		next_lock = task_blocked_on_lock(owner);
 
-		raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
-	}
+	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
 
 	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
 
+	/*
+	 * Don't walk the chain, if the owner task is not blocked
+	 * itself.
+	 */
 	if (!next_lock)
 		return;
 
@@ -753,7 +1033,8 @@ static void remove_waiter(struct rt_mutex *lock,
 
 	raw_spin_unlock(&lock->wait_lock);
 
-	rt_mutex_adjust_prio_chain(owner, 0, lock, next_lock, NULL, current);
+	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
+				   next_lock, NULL, current);
 
 	raw_spin_lock(&lock->wait_lock);
 }
@@ -782,8 +1063,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(task);
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-
-	rt_mutex_adjust_prio_chain(task, 0, NULL, next_lock, NULL, task);
+	rt_mutex_adjust_prio_chain(task, RT_MUTEX_MIN_CHAINWALK, NULL,
+				   next_lock, NULL, task);
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -1176,7 +1457,7 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
-		  int detect_deadlock)
+		  enum rtmutex_chainwalk chwalk)
 {
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
@@ -1201,7 +1482,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 			timeout->task = NULL;
 	}
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, detect_deadlock);
+	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
 
 	if (likely(!ret))
 		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter);
@@ -1209,8 +1490,9 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, detect_deadlock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
 	/*
@@ -1233,24 +1515,33 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
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
 	init_lists(lock);
 
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
 
@@ -1328,30 +1619,31 @@ rt_mutex_slowunlock(struct rt_mutex *lock)
  */
 static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int detect_deadlock,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
-				int detect_deadlock))
+				enum rtmutex_chainwalk chwalk))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, detect_deadlock);
+		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
 }
 
 static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout, int detect_deadlock,
+			struct hrtimer_sleeper *timeout,
+			enum rtmutex_chainwalk chwalk,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
 				      int detect_deadlock))
 {
-	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
+	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, timeout, detect_deadlock);
+		return slowfn(lock, state, timeout, chwalk);
 }
 
 static inline int
@@ -1384,7 +1676,7 @@ void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
 	might_sleep();
 
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, rt_mutex_slowlock);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 
@@ -1392,41 +1684,46 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
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
-				 detect_deadlock, rt_mutex_slowlock);
+	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, rt_mutex_slowlock);
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
+				       RT_MUTEX_FULL_CHAINWALK, rt_mutex_slowlock);
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
 
-	return rt_mutex_fastlock(lock, TASK_KILLABLE,
-				 detect_deadlock, rt_mutex_slowlock);
+	return rt_mutex_fastlock(lock, TASK_KILLABLE, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
 
@@ -1437,22 +1734,19 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
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
-				       detect_deadlock, rt_mutex_slowlock);
+				       RT_MUTEX_MIN_CHAINWALK, rt_mutex_slowlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 
@@ -1556,7 +1850,6 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  * @lock:		the rt_mutex to take
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
- * @detect_deadlock:	perform deadlock detection (1) or not (0)
  *
  * Returns:
  *  0 - task blocked on lock
@@ -1567,7 +1860,7 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  */
 int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
-			      struct task_struct *task, int detect_deadlock)
+			      struct task_struct *task)
 {
 	int ret;
 
@@ -1608,7 +1901,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 #endif
 
 	/* We enforce deadlock detection for futexes */
-	ret = task_blocks_on_rt_mutex(lock, waiter, task, 1);
+	ret = task_blocks_on_rt_mutex(lock, waiter, task,
+				      RT_MUTEX_FULL_CHAINWALK);
 
 	if (ret && !rt_mutex_owner(lock)) {
 		/*
@@ -1654,22 +1948,20 @@ struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
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
 
diff --git a/kernel/rtmutex.h b/kernel/rtmutex.h
index f6a1f3c133b1..c4060584c407 100644
--- a/kernel/rtmutex.h
+++ b/kernel/rtmutex.h
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
diff --git a/kernel/rtmutex_common.h b/kernel/rtmutex_common.h
index 6ec3dc1eab10..213c7bf3c0d9 100644
--- a/kernel/rtmutex_common.h
+++ b/kernel/rtmutex_common.h
@@ -102,6 +102,21 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
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
@@ -114,12 +129,11 @@ extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
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
index deaf90e4a1de..45759d3d5451 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -12,6 +12,7 @@ CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
 obj-y += core.o clock.o cputime.o idle_task.o fair.o rt.o stop_task.o
+obj-y += work-simple.o
 obj-$(CONFIG_SMP) += cpupri.o
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
index 40cfa14131ca..a2bfef4a8f23 100644
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
@@ -1678,6 +1661,7 @@ static int __cpuinit init_timers_cpu(int cpu)
 	base->timer_jiffies = jiffies;
 	base->next_timer = base->timer_jiffies;
 	base->active_timers = 0;
+	base->all_timers = 0;
 	return 0;
 }
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 23b856400e5c..3508e2c80465 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -569,6 +569,8 @@ GENERATE_TESTCASE(init_held_rsem)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 
@@ -584,9 +586,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
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
@@ -619,6 +624,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
 
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -642,6 +649,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 
@@ -657,6 +666,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
@@ -688,6 +699,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 
@@ -703,6 +716,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
@@ -736,6 +751,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 
@@ -751,10 +768,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
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
@@ -817,6 +838,10 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+#endif
+
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -855,6 +880,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 #undef E2
 #undef E3
 
+#endif
+
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
diff --git a/localversion-rt b/localversion-rt
index 7d028f4a9e56..54e7da6f49fb 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt74
+-rt75
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 33d8392f33eb..89540bca5c5b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2463,14 +2463,17 @@ static void __init memcg_stock_init(void)
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
index b9aad4723a9d..ab50dbd58c20 100644
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
 

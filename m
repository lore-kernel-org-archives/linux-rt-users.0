From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.0.5-rt3
Date: Thu, 11 Jun 2015 21:06:17 +0200
Message-ID: <20150611190617.GM16115@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.0.5-rt3 patch set.

Changes since v4.0.5-rt3

- fix blk-core compile on non-RT kernels. Patch by Paul Gortmaker.
- PS3 compile fix. Patch by Paul Gortmaker.
- fix a BUG_ON statement in the swap code. Reported by Clark Williams
  and Fernando Lopez-Lezcano.
- compile fix for Intel Atom "sst" Audio driver. Reported by Fernando
  Lopez-Lezcano.
- remove a bogus warning in the i915 driver. Patch by Clark Williams.
- fix a sleeping-while-atomic warning in memory compaction code.
  Reported by Joakim Hernberg
- fix a irq_work related regression on non-RT kernels introduced in the
  latest deadlock fix. Noticed and debugged by Steven Rostedt.

While doing the v4.0 I stumbled upon a few things. Therefore I plan to
reorder the -RT queue and merge patches where possible. Also I intend t=
o
drop PREEMPT_RTB and PREEMPT_RT_BASE unless there is need for it=E2=80=A6

Known issues:

      - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
        policy found" warnings after boot. It is gone after manually
        setting the policy (to something else than reported).

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the ne=
xt
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The delta patch against 4.0.5-rt2 is appended below and can be found he=
re:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/incr/patch-4=
=2E0.5-rt2-rt3.patch.xz  =20

The RT patch against 4.0.5 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patch-4.0.5-=
rt3.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patches-4.0.=
5-rt3.tar.xz

Sebastian

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/pl=
atforms/ps3/device-init.c
index 3f175e8aedb4..c4c02f91904c 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -752,7 +752,7 @@ static int ps3_notification_read_write(struct ps3_n=
otification_device *dev,
 	}
 	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
=20
-	res =3D wait_event_interruptible(dev->done.wait,
+	res =3D swait_event_interruptible(dev->done.wait,
 				       dev->done.done || kthread_should_stop());
 	if (kthread_should_stop())
 		res =3D -EINTR;
diff --git a/block/blk-core.c b/block/blk-core.c
index f8a4e9484eb3..ea9a9f41793d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -100,7 +100,7 @@ void blk_rq_init(struct request_queue *q, struct re=
quest *rq)
=20
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->timeout_list);
-#if CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_FULL
 	INIT_WORK(&rq->work, __blk_mq_complete_request_remote_work);
 #endif
 	rq->cpu =3D -1;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i91=
5/intel_display.c
index f75173c20f47..30b1d16caa0d 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -9745,7 +9745,7 @@ void intel_check_page_flip(struct drm_device *dev=
, int pipe)
 	struct drm_crtc *crtc =3D dev_priv->pipe_to_crtc_mapping[pipe];
 	struct intel_crtc *intel_crtc =3D to_intel_crtc(crtc);
=20
-	WARN_ON(!in_interrupt());
+	WARN_ON_NONRT(!in_interrupt());
=20
 	if (crtc =3D=3D NULL)
 		return;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 701b8ce36a21..4327e1a576cd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,6 +298,7 @@ extern unsigned long nr_free_pagecache_pages(void);
=20
=20
 /* linux/mm/swap.c */
+DECLARE_LOCAL_IRQ_LOCK(swapvec_lock);
 extern void lru_cache_add(struct page *);
 extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0b85716bf72b..292eea0cc412 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1450,7 +1450,8 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
+	if (in_irq())
+		irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/compaction.c b/mm/compaction.c
index 8c0d9459b54a..0b670021a977 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1387,10 +1387,12 @@ static int compact_zone(struct zone *zone, stru=
ct compact_control *cc)
 				cc->migrate_pfn & ~((1UL << cc->order) - 1);
=20
 			if (last_migrated_pfn < current_block_start) {
-				cpu =3D get_cpu();
+				cpu =3D get_cpu_light();
+				local_lock_irq(swapvec_lock);
 				lru_add_drain_cpu(cpu);
+				local_unlock_irq(swapvec_lock);
 				drain_local_pages(zone);
-				put_cpu();
+				put_cpu_light();
 				/* No more flushing until we migrate again */
 				last_migrated_pfn =3D 0;
 			}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9da0f3e9c1f3..ea10085f6a10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5822,6 +5822,7 @@ void mem_cgroup_swapout(struct page *page, swp_en=
try_t entry)
 {
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
+	unsigned long flags;
=20
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
@@ -5844,11 +5845,10 @@ void mem_cgroup_swapout(struct page *page, swp_=
entry_t entry)
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, 1);
=20
-	/* XXX: caller holds IRQ-safe mapping->tree_lock */
-	VM_BUG_ON(!irqs_disabled());
-
+	local_lock_irqsave(event_lock, flags);
 	mem_cgroup_charge_statistics(memcg, page, -1);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 }
=20
 /**
diff --git a/mm/swap.c b/mm/swap.c
index 15288296aa89..43d915765194 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -46,7 +46,7 @@ static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvec=
s);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
=20
 static DEFINE_LOCAL_IRQ_LOCK(rotate_lock);
-static DEFINE_LOCAL_IRQ_LOCK(swapvec_lock);
+DEFINE_LOCAL_IRQ_LOCK(swapvec_lock);
=20
 /*
  * This path almost never happens for VM activity - pages are normally
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 11c578651c1c..848f8f2ce6db 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -368,8 +368,8 @@ static inline void sst_restore_shim64(struct intel_=
sst_drv *ctx,
 	 * initialize by FW or driver when firmware is loaded
 	 */
 	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
-	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
-	sst_shim_write64(shim, SST_CSR, shim_regs->csr),
+	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx);
+	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
 	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
 }
=20

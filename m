From: Mike Galbraith <bitbucket@online.de>
Subject: [rfc patch] x86,uv: -rt conversions
Date: Wed, 19 Jun 2013 16:26:18 +0200
Message-ID: <1371651978.5845.75.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Dimitri Sivanich <sivanich@sgi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51727 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840Ab3FSO0X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Jun 2013 10:26:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The below is what I use to run -rt on UV boxen, diff generated against
3.8-rt.  Should the lock conversions perhaps wander to mainline?

Signed-off-by: Mike Galbraith <bitbucket@online.de>

---
 arch/x86/include/asm/uv/uv_bau.h   |   14 +++++++-------
 arch/x86/kernel/apic/x2apic_uv_x.c |    6 +++---
 arch/x86/platform/uv/tlb_uv.c      |   26 +++++++++++++-------------
 arch/x86/platform/uv/uv_time.c     |   21 +++++++++++++--------
 4 files changed, 36 insertions(+), 31 deletions(-)

Index: linux-2.6/arch/x86/include/asm/uv/uv_bau.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/uv/uv_bau.h
+++ linux-2.6/arch/x86/include/asm/uv/uv_bau.h
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
@@ -770,15 +770,15 @@ static inline int atom_asr(short i, stru
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
 
Index: linux-2.6/arch/x86/kernel/apic/x2apic_uv_x.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux-2.6/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -56,7 +56,7 @@ int uv_min_hub_revision_id;
 EXPORT_SYMBOL_GPL(uv_min_hub_revision_id);
 unsigned int uv_apicid_hibits;
 EXPORT_SYMBOL_GPL(uv_apicid_hibits);
-static DEFINE_SPINLOCK(uv_nmi_lock);
+static DEFINE_RAW_SPINLOCK(uv_nmi_lock);
 
 static struct apic apic_x2apic_uv_x;
 
@@ -695,10 +695,10 @@ int uv_handle_nmi(unsigned int reason, s
 	 * Use a lock so only one cpu prints at a time.
 	 * This prevents intermixed output.
 	 */
-	spin_lock(&uv_nmi_lock);
+	raw_spin_lock(&uv_nmi_lock);
 	pr_info("UV NMI stack dump cpu %u:\n", smp_processor_id());
 	dump_stack();
-	spin_unlock(&uv_nmi_lock);
+	raw_spin_unlock(&uv_nmi_lock);
 
 	return NMI_HANDLED;
 }
Index: linux-2.6/arch/x86/platform/uv/tlb_uv.c
===================================================================
--- linux-2.6.orig/arch/x86/platform/uv/tlb_uv.c
+++ linux-2.6/arch/x86/platform/uv/tlb_uv.c
@@ -695,9 +695,9 @@ static void destination_plugged(struct b
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -717,9 +717,9 @@ static void destination_timeout(struct b
 
 		quiesce_local_uvhub(hmaster);
 
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -740,7 +740,7 @@ static void disable_for_period(struct ba
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -753,7 +753,7 @@ static void disable_for_period(struct ba
 			}
 		}
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -816,7 +816,7 @@ static void record_send_stats(cycles_t t
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	spinlock_t *lock = &hmaster->uvhub_lock;
+	raw_spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -948,7 +948,7 @@ static int check_enable(struct bau_contr
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -960,10 +960,10 @@ static int check_enable(struct bau_contr
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
 
@@ -1880,9 +1880,9 @@ static void __init init_per_cpu_tunables
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
 
Index: linux-2.6/arch/x86/platform/uv/uv_time.c
===================================================================
--- linux-2.6.orig/arch/x86/platform/uv/uv_time.c
+++ linux-2.6/arch/x86/platform/uv/uv_time.c
@@ -58,7 +58,7 @@ static DEFINE_PER_CPU(struct clock_event
 
 /* There is one of these allocated per node */
 struct uv_rtc_timer_head {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	/* next cpu waiting for timer, local node relative: */
 	int		next_cpu;
 	/* number of cpus on this node: */
@@ -178,7 +178,7 @@ static __init int uv_rtc_allocate_timers
 				uv_rtc_deallocate_timers();
 				return -ENOMEM;
 			}
-			spin_lock_init(&head->lock);
+			raw_spin_lock_init(&head->lock);
 			head->ncpus = uv_blade_nr_possible_cpus(bid);
 			head->next_cpu = -1;
 			blade_info[bid] = head;
@@ -232,7 +232,7 @@ static int uv_rtc_set_timer(int cpu, u64
 	unsigned long flags;
 	int next_cpu;
 
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
 
 	next_cpu = head->next_cpu;
 	*t = expires;
@@ -244,12 +244,12 @@ static int uv_rtc_set_timer(int cpu, u64
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
 
@@ -268,7 +268,7 @@ static int uv_rtc_unset_timer(int cpu, i
 	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
 
 	if ((head->next_cpu == bcpu && uv_read_rtc(NULL) >= *t) || force)
 		rc = 1;
@@ -280,7 +280,7 @@ static int uv_rtc_unset_timer(int cpu, i
 			uv_rtc_find_next_timer(head, pnode);
 	}
 
-	spin_unlock_irqrestore(&head->lock, flags);
+	raw_spin_unlock_irqrestore(&head->lock, flags);
 
 	return rc;
 }
@@ -300,13 +300,18 @@ static int uv_rtc_unset_timer(int cpu, i
 static cycle_t uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
+	cycle_t cycles;
 
+	migrate_disable();
 	if (uv_get_min_hub_revision_id() == 1)
 		offset = 0;
 	else
 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
 
-	return (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
+	cycles = (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
+	migrate_enable();
+
+	return cycles;
 }
 
 /*



From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 20/36] x86: UV: raw_spinlock conversion
Date: Thu, 12 Mar 2015 15:21:59 -0400
Message-ID: <20150312192157.882657814@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>, Mike Galbraith <mgalbraith@suse.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0020-x86-UV-raw_spinlock-conversion.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Shrug.  Lots of hobbyists have a beast in their basement, right?

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/uv/uv_bau.h   | 14 +++++++-------
 arch/x86/include/asm/uv/uv_hub.h   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
 arch/x86/platform/uv/tlb_uv.c      | 26 +++++++++++++-------------
 arch/x86/platform/uv/uv_time.c     | 21 +++++++++++++--------
 5 files changed, 35 insertions(+), 30 deletions(-)

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
index a419814cea57..1d5859eff889 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -980,7 +980,7 @@ void __init uv_system_init(void)
 			uv_blade_info[blade].pnode = pnode;
 			uv_blade_info[blade].nr_possible_cpus = 0;
 			uv_blade_info[blade].nr_online_cpus = 0;
-			spin_lock_init(&uv_blade_info[blade].nmi_lock);
+			raw_spin_lock_init(&uv_blade_info[blade].nmi_lock);
 			min_pnode = min(pnode, min_pnode);
 			max_pnode = max(pnode, max_pnode);
 			blade++;
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a6b5affb024a..e9e67512d4a6 100644
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
 
@@ -1885,9 +1885,9 @@ static void __init init_per_cpu_tunables(void)
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
-- 
2.1.4

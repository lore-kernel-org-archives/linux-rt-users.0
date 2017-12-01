From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/15] Revert "memcontrol: Prevent scheduling while atomic in cgroup code"
Date: Fri, 01 Dec 2017 10:48:38 -0500
Message-ID: <20171201154911.602773549@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        <stable@vger.kernel.org>, Haiyang HY1 Tan <tanhy1@lenovo.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-Revert-memcontrol-Prevent-scheduling-while-atomic-in.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The commit "memcontrol: Prevent scheduling while atomic in cgroup code"
fixed this issue:

       refill_stock()
          get_cpu_var()
          drain_stock()
             res_counter_uncharge()
                res_counter_uncharge_until()
                   spin_lock() <== boom

But commit 3e32cb2e0a12b ("mm: memcontrol: lockless page counters") replaced
the calls to res_counter_uncharge() in drain_stock() to the lockless
function page_counter_uncharge(). There is no more spin lock there and no
more reason to have that local lock.

Cc: <stable@vger.kernel.org>
Reported-by: Haiyang HY1 Tan <tanhy1@lenovo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: That upstream commit appeared in v3.19 and the patch in
  question in v3.18.7-rt2 and v3.18 seems still to be maintained. So I
  guess that v3.18 would need the locallocks that we are about to remove
  here. I am not sure if any earlier versions have the patch
  backported.
  The stable tag here is because Haiyang reported (and debugged) a crash
  in 4.4-RT with this patch applied (which has get_cpu_light() instead
  the locallocks it gained in v4.9-RT).
  https://lkml.kernel.org/r/05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com
]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 12b94909ba7b..c04403033aec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1698,7 +1698,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_LOCAL_IRQ_LOCK(memcg_stock_ll);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 /**
@@ -1721,7 +1720,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -1729,7 +1728,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -1756,13 +1755,13 @@ static void drain_local_stock(struct work_struct *dummy)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1774,7 +1773,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -1783,7 +1782,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	}
 	stock->nr_pages += nr_pages;
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.13.2

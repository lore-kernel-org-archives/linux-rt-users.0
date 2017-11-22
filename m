From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Revert "memcontrol: Prevent scheduling while atomic in
 cgroup code"
Date: Wed, 22 Nov 2017 07:31:19 -0500
Message-ID: <20171122073119.31837a3f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/memcontrol.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25e0fd082f13..27549bf47139 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1723,7 +1723,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_LOCAL_IRQ_LOCK(memcg_stock_ll);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 /**
@@ -1746,7 +1745,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -1754,7 +1753,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -1785,13 +1784,13 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * The only protection from memory hotplug vs. drain_stock races is
 	 * that we always operate on local CPU stock here with IRQ disabled
 	 */
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1803,7 +1802,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_lock_irqsave(memcg_stock_ll, flags);
+	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -1815,7 +1814,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (stock->nr_pages > CHARGE_BATCH)
 		drain_stock(stock);
 
-	local_unlock_irqrestore(memcg_stock_ll, flags);
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.13.6

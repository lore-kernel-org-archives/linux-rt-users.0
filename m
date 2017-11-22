From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BUG] 4.4.x-rt - memcg: refill_stock() use get_cpu_light() has
 data corruption issue
Date: Wed, 22 Nov 2017 06:36:45 +0100
Message-ID: <1511329005.8762.0.camel@gmx.de>
References: <05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com>
         <20171121225002.0704d679@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: "'bigeasy@linutronix.de'" <bigeasy@linutronix.de>,
        "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Tong Tong3 Li <litong3@lenovo.com>,
        Feng Feng24 Liu <liufeng24@lenovo.com>,
        Jianqiang1 Lu <lujq1@lenovo.com>,
        Hongyong HY2 Zang <zanghy2@lenovo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Haiyang HY1 Tan <tanhy1@lenovo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121225002.0704d679@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-11-21 at 22:50 -0500, Steven Rostedt wrote:
> 
> Does it work if you revert the patch?

That would restore the gripe.  How about this..

mm, memcg: serialize consume_stock(), drain_local_stock() and refill_stock()

Haiyang HY1 Tan reports encountering races between drain_stock() and
refill_stock(), resulting in drain_stock() draining stock freshly assigned
by refill_stock().  This doesn't appear to have been safe before RT touched
any of it due do drain_local_stock() being preemptible until db2ba40c277d
came along and disabled irqs across the lot.  Rather than do that with
the upstream RT replacement with local_lock_irqsave/restore() since
older trees don't yet need to be irq safe, use the local lock name and
placement for consistency, but serialize with get/put_locked_var().

The below may not deserve full credit for the breakage, but it surely
didn't help, so tough, it gets to wear the BPB.

Reported-by: Haiyang HY1 Tan <tanhy1@lenovo.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Fixes: ("mm, memcg: make refill_stock() use get_cpu_light()")
---
 mm/memcontrol.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1861,6 +1861,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_LOCAL_IRQ_LOCK(memcg_stock_ll);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 /**
@@ -1882,12 +1883,12 @@ static bool consume_stock(struct mem_cgr
 	if (nr_pages > CHARGE_BATCH)
 		return ret;
 
-	stock = &get_cpu_var(memcg_stock);
+	stock = &get_locked_var(memcg_stock_ll, memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
 		stock->nr_pages -= nr_pages;
 		ret = true;
 	}
-	put_cpu_var(memcg_stock);
+	put_locked_var(memcg_stock_ll, memcg_stock);
 	return ret;
 }
 
@@ -1914,9 +1915,12 @@ static void drain_stock(struct memcg_sto
  */
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+	struct memcg_stock_pcp *stock;
+
+	stock = &get_locked_var(memcg_stock_ll, memcg_stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	put_locked_var(memcg_stock_ll, memcg_stock);
 }
 
 /*
@@ -1926,16 +1930,15 @@ static void drain_local_stock(struct wor
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
-	int cpu = get_cpu_light();
 
-	stock = &per_cpu(memcg_stock, cpu);
+	stock = &get_locked_var(memcg_stock_ll, memcg_stock);
 
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-	put_cpu_light();
+	put_locked_var(memcg_stock_ll, memcg_stock);
 }
 
 /*

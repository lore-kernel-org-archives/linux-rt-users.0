From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 6/7] Revert "memcontrol: Prevent scheduling while atomic in cgroup code"
Date: Wed,  4 Apr 2018 09:16:51 +0200
Message-ID: <20180404071652.24196-7-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
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
 mm/memcontrol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 493b4986d5dc..56f67a15937b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,17 +1925,14 @@ static void drain_local_stock(struct work_struct *dummy)
  */
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	int cpu = get_cpu_light();
-
-	stock = &per_cpu(memcg_stock, cpu);
+	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
 
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-	put_cpu_light();
+	put_cpu_var(memcg_stock);
 }
 
 /*
-- 
2.14.3

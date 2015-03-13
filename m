From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 23/27] scheduling while atomic in cgroup code
Date: Fri, 13 Mar 2015 11:18:04 -0400
Message-ID: <20150313151758.981271216@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60713 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945905AbbCMPfQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 11:35:16 -0400
Content-Disposition: inline; filename=0023-scheduling-while-atomic-in-cgroup-code.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.106-rt132-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

mm, memcg: make refill_stock() use get_cpu_light()

Nikita reported the following memcg scheduling while atomic bug:

Call Trace:
[e22d5a90] [c0007ea8] show_stack+0x4c/0x168 (unreliable)
[e22d5ad0] [c0618c04] __schedule_bug+0x94/0xb0
[e22d5ae0] [c060b9ec] __schedule+0x530/0x550
[e22d5bf0] [c060bacc] schedule+0x30/0xbc
[e22d5c00] [c060ca24] rt_spin_lock_slowlock+0x180/0x27c
[e22d5c70] [c00b39dc] res_counter_uncharge_until+0x40/0xc4
[e22d5ca0] [c013ca88] drain_stock.isra.20+0x54/0x98
[e22d5cc0] [c01402ac] __mem_cgroup_try_charge+0x2e8/0xbac
[e22d5d70] [c01410d4] mem_cgroup_charge_common+0x3c/0x70
[e22d5d90] [c0117284] __do_fault+0x38c/0x510
[e22d5df0] [c011a5f4] handle_pte_fault+0x98/0x858
[e22d5e50] [c060ed08] do_page_fault+0x42c/0x6fc
[e22d5f40] [c000f5b4] handle_page_fault+0xc/0x80

What happens:

   refill_stock()
      get_cpu_var()
      drain_stock()
         res_counter_uncharge()
            res_counter_uncharge_until()
               spin_lock() <== boom

Fix it by replacing get/put_cpu_var() with get/put_cpu_light().

Cc: stable-rt@vger.kernel.org
Reported-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/memcontrol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 107c0ba7b383..8c3dd645ac10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2061,14 +2061,17 @@ static void drain_local_stock(struct work_struct *dummy)
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
-- 
2.1.4



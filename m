From: Yang Shi <yang.shi@windriver.com>
Subject: [PATCH 1/2] rt: Don't call schedule_work_on in preemption disabled context
Date: Mon, 16 Sep 2013 14:09:18 -0700
Message-ID: <1379365759-5743-2-git-send-email-yang.shi@windriver.com>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <paul.gortmaker@windriver.com>, <yang.shi@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:63694 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3IPVOM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Sep 2013 17:14:12 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r8GLEBla013380
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2013 14:14:11 -0700 (PDT)
In-Reply-To: <1379365759-5743-1-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The following trace is triggered when running ltp oom test cases:

BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
in_atomic(): 1, irqs_disabled(): 0, pid: 17188, name: oom03
Preemption disabled at:[<ffffffff8112ba70>] mem_cgroup_reclaim+0x90/0xe0

CPU: 2 PID: 17188 Comm: oom03 Not tainted 3.10.10-rt3 #2
Hardware name: Intel Corporation Calpella platform/MATXM-CORE-411-B, BIOS 4.6.3 08/18/2010
ffff88007684d730 ffff880070df9b58 ffffffff8169918d ffff880070df9b70
ffffffff8106db31 ffff88007688b4a0 ffff880070df9b88 ffffffff8169d9c0
ffff88007688b4a0 ffff880070df9bc8 ffffffff81059da1 0000000170df9bb0
Call Trace:
[<ffffffff8169918d>] dump_stack+0x19/0x1b
[<ffffffff8106db31>] __might_sleep+0xf1/0x170
[<ffffffff8169d9c0>] rt_spin_lock+0x20/0x50
[<ffffffff81059da1>] queue_work_on+0x61/0x100
[<ffffffff8112b361>] drain_all_stock+0xe1/0x1c0
[<ffffffff8112ba70>] mem_cgroup_reclaim+0x90/0xe0
[<ffffffff8112beda>] __mem_cgroup_try_charge+0x41a/0xc40
[<ffffffff810f1c91>] ? release_pages+0x1b1/0x1f0
[<ffffffff8106f200>] ? sched_exec+0x40/0xb0
[<ffffffff8112cc87>] mem_cgroup_charge_common+0x37/0x70
[<ffffffff8112e2c6>] mem_cgroup_newpage_charge+0x26/0x30
[<ffffffff8110af68>] handle_pte_fault+0x618/0x840
[<ffffffff8103ecf6>] ? unpin_current_cpu+0x16/0x70
[<ffffffff81070f94>] ? migrate_enable+0xd4/0x200
[<ffffffff8110cde5>] handle_mm_fault+0x145/0x1e0
[<ffffffff810301e1>] __do_page_fault+0x1a1/0x4c0
[<ffffffff8169c9eb>] ? preempt_schedule_irq+0x4b/0x70
[<ffffffff8169e3b7>] ? retint_kernel+0x37/0x40
[<ffffffff8103053e>] do_page_fault+0xe/0x10
[<ffffffff8169e4c2>] page_fault+0x22/0x30

So, re-enable preemption before schedule_work_on, then disable preemption again.
See a similar change in commit f5eb5588262cab7232ed1d77cf612b327db50767
("ring-buffer: Do not use schedule_work_on() for current CPU") as a precedent.

Since mem_cgroup_reclaim acquires mutex lock before moving forward, and mutex
can promote priority of the process which holds the mutex under PI mechanism,
so it's safe to re-enable preemption for a short period of time because it
won't be preempted by lower priority process.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 mm/memcontrol.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 82a187a..9f7cc0f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2453,8 +2453,11 @@ static void drain_all_stock(struct mem_cgroup *root_memcg, bool sync)
 		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
-			else
+			else {
+				preempt_enable();
 				schedule_work_on(cpu, &stock->work);
+				preempt_disable();
+			}
 		}
 	}
 	put_cpu();
-- 
1.7.5.4


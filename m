From: Clark Williams <williams@redhat.com>
Subject: [RFC] mm: change irqs_disabled() test to spin_is_locked() in
 mem_cgroup_swapout
Date: Fri, 29 May 2015 10:48:15 -0500
Message-ID: <20150529104815.2d2e880c@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Johannes Weiner <hannes@cmpxchg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362AbbE2Ps2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 May 2015 11:48:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Johannes,

We are seeing a panic in the latest RT kernel (4.0.4-rt1) where a
VM_BUG_ON(!irqs_disabled()) in mm/memcontrol.c fires. This is because on
an RT kernel, rt_mutexes (which replace spinlocks) don't disable
interrupts while the lock is held. I talked to Steven and he suggested
that we replace the irqs_disabled() with spin_is_held(). 

Does this patch work for you?

Clark

From: Clark Williams <williams@redhat.com>
Date: Fri, 29 May 2015 10:28:55 -0500
Subject: [PATCH] mm: change irqs_disabled() to spin_is_locked() in mem_cgroup_swapout()

The irqs_disabled() check in mem_cgroup_swapout() fails on the latest
RT kernel because RT mutexes do not disable interrupts when held. Change
the test for the lock being held to use spin_is_locked.

Reported-by: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9da0f3e9c1f3..70befa14a8ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5845,7 +5845,7 @@ void mem_cgroup_swapout(struct page *page,
swp_entry_t entry) page_counter_uncharge(&memcg->memory, 1);
 
 	/* XXX: caller holds IRQ-safe mapping->tree_lock */
-	VM_BUG_ON(!irqs_disabled());
+	VM_BUG_ON(!spin_is_locked(&page_mapping(page)->tree_lock));
 
 	mem_cgroup_charge_statistics(memcg, page, -1);
 	memcg_check_events(memcg, page);
-- 
2.1.0


From: Clark Williams <williams@redhat.com>
Subject: [RFC][PATCH] mm: ifdef out VM_BUG_ON check on PREEMPT_RT_FULL
Date: Mon, 1 Jun 2015 13:14:52 -0500
Message-ID: <20150601131452.3e04f10a@sluggy>
References: <20150529104815.2d2e880c@sluggy>
	<20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbFASO4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2015 14:14:56 -0400
In-Reply-To: <20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 May 2015 14:26:14 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 29 May 2015 10:48:15 -0500 Clark Williams <williams@redhat.com> wrote:
> 
> > The irqs_disabled() check in mem_cgroup_swapout() fails on the latest
> > RT kernel because RT mutexes do not disable interrupts when held. Change
> > the test for the lock being held to use spin_is_locked.
> >
> > ...
> >
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5845,7 +5845,7 @@ void mem_cgroup_swapout(struct page *page,
> > swp_entry_t entry) page_counter_uncharge(&memcg->memory, 1);
> >  
> >  	/* XXX: caller holds IRQ-safe mapping->tree_lock */
> > -	VM_BUG_ON(!irqs_disabled());
> > +	VM_BUG_ON(!spin_is_locked(&page_mapping(page)->tree_lock));
> >  
> >  	mem_cgroup_charge_statistics(memcg, page, -1);
> >  	memcg_check_events(memcg, page);
> 
> spin_is_locked() returns zero on uniprocessor builds.  The results will
> be unhappy.  
> 
> I suggest just deleting the check.

Guess this is Johannes call. We can just #ifdef it out and that would
remain the same when we finally merge PREEMPT_RT in mainline. 

If Johannes wants to keep the check on non-RT, here's a patch:

From: Clark Williams <williams@redhat.com>
Date: Mon, 1 Jun 2015 13:10:39 -0500
Subject: [PATCH] mm: ifdef out VM_BUG_ON check on PREEMPT_RT_FULL

The irqs_disabled() check in mem_cgroup_swapout() fails on the latest
RT kernel because RT mutexes do not disable interrupts when held. Ifdef
this check out for PREEMPT_RT_FULL.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9da0f3e9c1f3..f3fcef7713f6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5844,8 +5844,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, 1);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 	/* XXX: caller holds IRQ-safe mapping->tree_lock */
 	VM_BUG_ON(!irqs_disabled());
+#endif
 
 	mem_cgroup_charge_statistics(memcg, page, -1);
 	memcg_check_events(memcg, page);
-- 
2.1.0


Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5614AC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B77761158
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 14:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbhHEOGS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:06:18 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:35413 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241868AbhHEOFS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 10:05:18 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 7031BCACC3
        for <linux-rt-users@vger.kernel.org>; Thu,  5 Aug 2021 15:05:00 +0100 (IST)
Received: (qmail 10131 invoked from network); 5 Aug 2021 14:05:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Aug 2021 14:05:00 -0000
Date:   Thu, 5 Aug 2021 15:04:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210805140458.GF6464@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
 <20210723100034.13353-3-mgorman@techsingularity.net>
 <87czqu2iew.ffs@tglx>
 <20210804095425.GA6464@techsingularity.net>
 <91b2f893-eb6a-d91d-3769-baba8601b0f6@suse.cz>
 <20210804142306.GE6464@techsingularity.net>
 <87h7g4123u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87h7g4123u.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 02:56:53PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 04 2021 at 15:23, Mel Gorman wrote:
> Mel,
> 
> > On Wed, Aug 04, 2021 at 03:42:25PM +0200, Vlastimil Babka wrote:
> >> The idea was not build-time, but runtime (hidden behind lockdep, VM_DEBUG or
> >> whatnot), i.e.:
> >> 
> >> <sched_expert> what that code needs is switch(item) { case foo1: case foo2:
> >> lockdep_assert_irqs_disabled(); break; case bar1: case bar2:
> >> lockdep_assert_preempt_disabled(); lockdep_assert_no_in_irq(); break; } or
> >> something along those lines
> >> 
> > Ok, that would potentially work. It may not even need to split the stats
> > into different enums. Simply document which stats need protection from
> > IRQ or preemption and use PROVE_LOCKING to check if preemption or IRQs
> > are disabled depending on the kernel config. I don't think it gets rid
> > of preempt_disable_rt unless the API was completely reworked with entry
> > points that describe the locking requirements. That would be tricky
> > because the requirements differ between kernel configurations.
> 
> Right. This won't get rid of the preempt disabling on RT, but I think we
> should rather open code this
> 
>        if (IS_ENABLED(CONFIG_PREEMPT_RT))
>        		preempt_dis/enable();
> 
> instead of proliferating these helper macros which have only one user left.
> 

Ok, that is reasonable. I tried creating a vmstat-specific helper but the
names were misleading so I ended up with the patch below which open-codes
it as you suggest. The comment is not accurate because "locking/local_lock:
Add RT support" is not upstream but it'll eventually be accurate.

Is this ok?

--8<--
From e5b7a2ffcf55e4b4030fd54e49f5c5a1d1864ebe Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 3 Jul 2009 08:30:13 -0500
Subject: [PATCH] mm/vmstat: Protect per cpu variables with preempt disable on
 RT

Disable preemption on -RT for the vmstat code. On vanila the code runs
in IRQ-off regions while on -RT it may not when stats are updated under
a local_lock. "preempt_disable" ensures that the same resources is not
updated in parallel due to preemption.

This patch differs from the preempt-rt version where __count_vm_event and
__count_vm_events are also protected. The counters are explicitly "allowed
to be to be racy" so there is no need to protect them from preemption. Only
the accurate page stats that are updated by a read-modify-write need
protection. This patch also differs in that a preempt_[en|dis]able_rt
helper is not used. As vmstat is the only user of the helper, it was
suggested that it be open-coded in vmstat.c instead of risking the helper
being used in unnecessary contexts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..2c7e7569a453 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -319,6 +319,16 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	/*
+	 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
+	 * atomicity is provided by IRQs being disabled -- either explicitly
+	 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
+	 * CPU migrations and preemption potentially corrupts a counter so
+	 * disable preemption.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -328,6 +338,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -350,6 +363,10 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		delta >>= PAGE_SHIFT;
 	}
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -359,6 +376,9 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -391,6 +411,10 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -399,6 +423,9 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -409,6 +436,10 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -417,6 +448,9 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -437,6 +471,10 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -445,6 +483,9 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -455,6 +496,10 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	/* See __mod_node_page_state */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -463,6 +508,9 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)

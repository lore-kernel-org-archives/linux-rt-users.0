Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF29EC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B994261163
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhHFIpR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:45:17 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:41337 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232709AbhHFIpQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 04:45:16 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 142DCBF1A0
        for <linux-rt-users@vger.kernel.org>; Fri,  6 Aug 2021 09:45:00 +0100 (IST)
Received: (qmail 1452 invoked from network); 6 Aug 2021 08:44:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Aug 2021 08:44:59 -0000
Date:   Fri, 6 Aug 2021 09:44:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Daniel Vacek <neelx.g@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210806084458.GG6464@techsingularity.net>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
 <20210805162206.664dfc8c090f2be5ea313d57@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210805162206.664dfc8c090f2be5ea313d57@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 04:22:06PM -0700, Andrew Morton wrote:
> On Thu,  5 Aug 2021 17:00:19 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > Disable preemption on -RT for the vmstat code. On vanila the code runs
> > in IRQ-off regions while on -RT it may not when stats are updated under
> > a local_lock. "preempt_disable" ensures that the same resources is not
> > updated in parallel due to preemption.
> > 
> > This patch differs from the preempt-rt version where __count_vm_event and
> > __count_vm_events are also protected. The counters are explicitly "allowed
> > to be to be racy" so there is no need to protect them from preemption. Only
> > the accurate page stats that are updated by a read-modify-write need
> > protection. This patch also differs in that a preempt_[en|dis]able_rt
> > helper is not used. As vmstat is the only user of the helper, it was
> > suggested that it be open-coded in vmstat.c instead of risking the helper
> > being used in unnecessary contexts.
> > 
> > ...
> >
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -319,6 +319,16 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> >  	long x;
> >  	long t;
> >  
> > +	/*
> > +	 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
> > +	 * atomicity is provided by IRQs being disabled -- either explicitly
> > +	 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
> > +	 * CPU migrations and preemption potentially corrupts a counter so
> > +	 * disable preemption.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_disable();
> 
> This is so obvious I expect it has been discussed, but...  why not
> 
> static inline void preempt_disable_if_rt(void)
> {
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 		preempt_disable();
> }
> 
> ?
> 

The changelog briefly mentions it "also differs in that a
preempt_[en|dis]able_rt" helper was not used. It is preferred that the RT
helper does not exist and potentially get reused in other contexts that
could have a different solution. Hence, it's open-coded for mm/vmstat.c
even though it looks awkward. Obviously the helper could be in mm/vmstat.c
but the only name that made sense was preempt_[en|dis]able_rt and that
would likely get promoted to a common header for some reason.

The vmstat counters are "special" in that they have to be fast, an
accurate counter must be available cheaply and they are updated from a
mix of IRQ-disabled and local_lock_irq-disabled sections where the latter
only disables CPU migrations (but not preemption) on PREEMPT_RT. It's
not a special case that should be encouraged but is somewhat justified
given how often vmstats get updated and its performance requirements.

The alternative would be to convert vmstat counters to percpu_counters.
It also takes care to protect from IRQ and preempt contexts based on
comments in the code and functionally is very similar to vmstat. However,
based on how it works, I think it would incur a performance regression
as well as having a larger memory footprint. The use of raw IRQ-safe
spinlocks risks parallel update scaling issues that vmstat avoids with
with rmw, cmpxchg and atomics depending on context combined combined with
workqueues to accumulate per-cpu values. Converting to percpu_counters
and then modifying the implementation to be similar to vmstat might work
but would also be high risk with some significant complexities such as
dealing with vmstat shepherd.

Hence, I think the open-coded is justified if somewhat clumsy so indicate
this is a special case we're willing to tolerate but also clumsy enough
that someone trying to copy it will be forced to think heavily about
their problem. The only change I'd like to make to the patch is to

s/See __mod_node_page_state/See __mod_zone_page_state/

which is based on an stupid typo compounded by cut&paste as noted by 
Daniel Vacek.

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94275C4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645DD60F58
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 09:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhHDJyp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:54:45 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:60171 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236350AbhHDJyo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 05:54:44 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 2F750FA9BB
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 10:54:31 +0100 (IST)
Received: (qmail 32135 invoked from network); 4 Aug 2021 09:54:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2021 09:54:30 -0000
Date:   Wed, 4 Aug 2021 10:54:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210804095425.GA6464@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
 <20210723100034.13353-3-mgorman@techsingularity.net>
 <87czqu2iew.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87czqu2iew.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 04, 2021 at 01:54:47AM +0200, Thomas Gleixner wrote:
> Mel!
> 

I hope the ! is not a sign that the patch is a wtf :)

> On Fri, Jul 23 2021 at 11:00, Mel Gorman wrote:
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
> > protection.
> >
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  mm/vmstat.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index b0534e068166..d06332c221b1 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -319,6 +319,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> >  	long x;
> >  	long t;
> >  
> > +	preempt_disable_rt();
> 
> Yes, this is smart to some extent. But in reality it's a bandaid simply
> because nobody can tell which item of vmstat requires which protection.
> 

They were not split correctly when first introduced unfortunately. I don't
recall why but it's very likely that it simply was not thought about very
heavily. The naming doesn't help because there is no clue to the names if
accuracy is needed for functional correctness. I only put heavy thought
into it when I was dealing with excessive overhead from accurate counters.

Most of zone_stat_item and node_stat_item *must* be accurate for
correctness (e.g. NR_FREE_PAGES drifting would be very bad) but not all.
NR_VMSCAN_IMMEDIATE does not need special protection for example, same
for NR_WRITTEN and NR_DIRTIED. Some of the WORKINGSET ones may not need
protection either but I didn't audit every single one. Either way, some
of the events could be moved out.

Commit f19298b9516c ("mm/vmstat: convert NUMA statistics to basic NUMA
counters") is an example where some counters were moved because they did
not require accuracy and were updated from fast paths. The existance of
the path allows some other counters to move relatively easily.

> If you go back in RT history then you will figure out that we were able
> to eliminate _all_ occurences of preempt_disable_rt() except for this
> one.
> 
> Even mm developers are wary about this:
> 
>  <tglx> so in vmstat.c there is this magic comment:
>  <tglx>  * For use when we know that interrupts are disabled
>  <tglx>  * or when we know that preemption is disabled and that
>  <tglx>  * particular counter cannot be updated from interrupt context.
>  <tglx> how can I know which counters need what?
>  <mm_expert> I don't think there's a list, one would have to check on counter to counter basis :/ 
>  <tglx> and of course there is nothing which validates that, right?
>  <mm_expert> exactly
> 

While I'm not "mm_expert", I agree with his/her statements. Each counter
would need to be audited and two question are asked

 o If this counter is inaccurate, does anything break?
 o If this counter is inaccurate, does it both increment and decrement
   allowing the possibility it goes negative?

The decision on that is looking at the counter and seeing if any
functional decision is made based on its value. So two examples;

	NR_VMSCAN_IMMEDIATE is a node-based counter that only every
	increments and is reported to userspace. No kernel code makes
	any decision based on its value. Therefore it's likely safe to
	move to numa_stat_item instead.

	Action: move it

	WORKINGSET_ACTIVATE_FILE is a node-based counter that is used to
	determine if a mem cgroup is potentially congested by looking at
	the ratio of cgroup to node refault rates as well as deciding if
	LRU file pages should be deactivate.  If that value drifts, the
	ratios are miscalculated and could lead to functional oddities
	and therefore must be accurate.

	Action: leave it alone

I guess it could be further split into state that must be accurate from
IRQ and non-IRQ contexts but that probably would be very fragile and
offer limited value.

> Brilliant stuff which prevents you to do any validation on this. Over
> the years there have been several issues where callers had to be fixed
> by analysing bug reports instead of having a proper instrumentation in
> that code which would have told the developer that he got it wrong.
> 

I'm not sure it could be validated at build-time but I'm just back from
holiday and may be lacking imagination.

> Of course on RT kernels the preempt_disable_rt() will serialize
> everything correctly, but as we have learned over the years just
> slapping _if_rt() or if_not_rt() variants of things around is most of
> the time papering over the underlying problem of badly defined
> protection scopes. Let's not proliferate that. As I said in the above
> IRC conversation:
> 
>  <tglx> I fundamentally hate this preempt_disable_rt() muck
> 

The issue is that even if this was properly audited and the inaccurate
and accurate counters were in the proper enums using the correct APIs, it
would still be necessary to protect the accurate counters from updates from
IRQ context. Hence, as I write this, I don't think preempt_[dis|en]able_rt
would go away and that is why I didn't continue with the series to break
out "accurate" stats

-- 
Mel Gorman
SUSE Labs

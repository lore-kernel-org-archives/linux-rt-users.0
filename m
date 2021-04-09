Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8393FC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48908611B0
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhDIH7z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:59:55 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:35905 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhDIH7z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 03:59:55 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id E90E2BAA35
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Apr 2021 08:59:41 +0100 (IST)
Received: (qmail 3562 invoked from network); 9 Apr 2021 07:59:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 07:59:41 -0000
Date:   Fri, 9 Apr 2021 08:59:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <20210409075939.GJ3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 09, 2021 at 08:39:45AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 08, 2021 at 06:42:44PM +0100, Mel Gorman wrote:
> > On Thu, Apr 08, 2021 at 12:52:07PM +0200, Peter Zijlstra wrote:
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index a68bacddcae0..e9e60d1a85d4 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -112,6 +112,13 @@ typedef int __bitwise fpi_t;
> > > >  static DEFINE_MUTEX(pcp_batch_high_lock);
> > > >  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
> > > >  
> > > > +struct pagesets {
> > > > +	local_lock_t lock;
> > > > +};
> > > > +static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> > > > +	.lock = INIT_LOCAL_LOCK(lock),
> > > > +};
> > > 
> > > So why isn't the local_lock_t in struct per_cpu_pages ? That seems to be
> > > the actual object that is protected by it and is already per-cpu.
> > > 
> > > Is that because you want to avoid the duplication across zones? Is that
> > > worth the effort?
> > 
> > When I wrote the patch, the problem was that zone_pcp_reset freed the
> > per_cpu_pages structure and it was "protected" by local_irq_save(). If
> > that was converted to local_lock_irq then the structure containing the
> > lock is freed before it is released which is obviously bad.
> > 
> > Much later when trying to make the allocator RT-safe in general, I realised
> > that locking was broken and fixed it in patch 3 of this series. With that,
> > the local_lock could potentially be embedded within per_cpu_pages safely
> > at the end of this series.
> 
> Fair enough; I was just wondering why the obvious solution wasn't chosen
> and neither changelog nor comment explain, so I had to ask :-)

It's a fair question and it was my first approach before I hit problems.
Thinking again this morning, I remembered that another problem I hit was
patterns like this

        local_lock_irqsave(&pagesets.lock, flags);
        pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);

turning into

	cpu = get_cpu();
        pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
        local_lock_irqsave(&pcp->lock, flags);

That has its own problems if zone->lock was acquired within the
local_lock_irqsave section (Section "spinlock_t and rwlock_t" in
Documentation/locking/locktypes.rst) so it has to turn into

	migrate_disable();
	pcp = this_cpu_ptr(zone->per_cpu_pageset);
        local_lock_irqsave(&pcp->lock, flags);

I did not want to start adding migrate_disable() in multiple places like
this because I'm guessing that new users of migrate_disable() need strong
justification and adding such code in page_alloc.c might cause cargo-cult
copy&paste in the future. Maybe it could be addressed with a helper like
this_cpu_local_lock or this_cpu_local_lock_irq but that means in some
cases that the PCP structure is looked up twice with patterns like this one

        local_lock_irqsave(&pagesets.lock, flags);
        free_unref_page_commit(page, pfn, migratetype);
        local_unlock_irqrestore(&pagesets.lock, flags);

To get around multiple lookups the helper becomes something that disables
migration, looks up the PCP structure, locks it and returns it with
pcp then passed around as appropriate. Not sure what I would call that
helper :P

In the end I just gave up and kept it simple as there is no benefit to
!PREEMPT_RT which just disables IRQs. Maybe it'll be worth considering when
PREEMPT_RT is upstream and can be enabled. The series was functionally
tested on the PREEMPT_RT tree by reverting the page_alloc.c patch and
applies this series and all of its prerequisites on top.

-- 
Mel Gorman
SUSE Labs

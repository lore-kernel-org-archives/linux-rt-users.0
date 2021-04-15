Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36702C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099D56101C
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 15:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhDOPaZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:30:25 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:53671 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhDOPaX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 11:30:23 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id CA5EE1C429C
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Apr 2021 16:29:59 +0100 (IST)
Received: (qmail 1618 invoked from network); 15 Apr 2021 15:29:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Apr 2021 15:29:59 -0000
Date:   Thu, 15 Apr 2021 16:29:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 11/11] mm/page_alloc: Embed per_cpu_pages locking within
 the per-cpu structure
Message-ID: <20210415152958.GL3697@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-12-mgorman@techsingularity.net>
 <de5d1dbb-fb56-9660-fadb-6318047305d4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <de5d1dbb-fb56-9660-fadb-6318047305d4@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 15, 2021 at 04:53:46PM +0200, Vlastimil Babka wrote:
> On 4/14/21 3:39 PM, Mel Gorman wrote:
> > struct per_cpu_pages is protected by the pagesets lock but it can be
> > embedded within struct per_cpu_pages at a minor cost. This is possible
> > because per-cpu lookups are based on offsets. Paraphrasing an explanation
> > from Peter Ziljstra
> > 
> >   The whole thing relies on:
> > 
> >     &per_cpu_ptr(msblk->stream, cpu)->lock == per_cpu_ptr(&msblk->stream->lock, cpu)
> > 
> >   Which is true because the lhs:
> > 
> >     (local_lock_t *)((zone->per_cpu_pages + per_cpu_offset(cpu)) + offsetof(struct per_cpu_pages, lock))
> > 
> >   and the rhs:
> > 
> >     (local_lock_t *)((zone->per_cpu_pages + offsetof(struct per_cpu_pages, lock)) + per_cpu_offset(cpu))
> > 
> >   are identical, because addition is associative.
> > 
> > More details are included in mmzone.h. This embedding is not completely
> > free for three reasons.
> > 
> > 1. As local_lock does not return a per-cpu structure, the PCP has to
> >    be looked up twice -- first to acquire the lock and again to get the
> >    PCP pointer.
> > 
> > 2. For PREEMPT_RT and CONFIG_DEBUG_LOCK_ALLOC, local_lock is potentially
> >    a spinlock or has lock-specific tracking. In both cases, it becomes
> >    necessary to release/acquire different locks when freeing a list of
> >    pages in free_unref_page_list.
> 
> Looks like this pattern could benefit from a local_lock API helper that would do
> the right thing? It probably couldn't optimize much the CONFIG_PREEMPT_RT case
> which would need to be unlock/lock in any case, but CONFIG_DEBUG_LOCK_ALLOC
> could perhaps just keep the IRQ's disabled and just note the change of what's
> acquired?
> 

A helper could potentially be used but right now, there is only one
call-site that needs this type of care so it may be overkill. A helper
was proposed that can lookup and lock a per-cpu structure which is
generally useful but does not suit the case where different locks need
to be acquired.

> > 3. For most kernel configurations, local_lock_t is empty and no storage is
> >    required. By embedding the lock, the memory consumption on PREEMPT_RT
> >    and CONFIG_DEBUG_LOCK_ALLOC is higher.
> 
> But I wonder, is there really a benefit to this increased complexity? Before the
> patch we had "pagesets" - a local_lock that protects all zones' pcplists. Now
> each zone's pcplists have own local_lock. On !PREEMPT_RT we will never take the
> locks of multiple zones from the same CPU in parallel, because we use
> local_lock_irqsave(). Can that parallelism happen on PREEMPT_RT, because that
> could perhaps justify the change?
> 

I don't think PREEMPT_RT gets additional parallelism because it's still
a per-cpu structure that is being protected. The difference is whether
we are protecting the CPU-N index for all per_cpu_pages or just one.
The patch exists because it was asked why the lock was not embedded within
the structure it's protecting. I initially thought that was unsafe and
I was wrong as explained in the changelog. But now that I find it *can*
be done but it's a bit ugly so I put it at the end of the series so it
can be dropped if necessary.

-- 
Mel Gorman
SUSE Labs

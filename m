Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872DC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166E761164
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352172AbhDNPTR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:19:17 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:42993 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352073AbhDNPTQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 11:19:16 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 519561C3667
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Apr 2021 16:18:53 +0100 (IST)
Received: (qmail 27104 invoked from network); 14 Apr 2021 15:18:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Apr 2021 15:18:52 -0000
Date:   Wed, 14 Apr 2021 16:18:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 04/11] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
Message-ID: <20210414151850.GG3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-5-mgorman@techsingularity.net>
 <7a7ec563-0519-a850-563a-9680a7bd00d3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7a7ec563-0519-a850-563a-9680a7bd00d3@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 14, 2021 at 02:56:45PM +0200, Vlastimil Babka wrote:
> On 4/7/21 10:24 PM, Mel Gorman wrote:
> > NUMA statistics are maintained on the zone level for hits, misses, foreign
> > etc but nothing relies on them being perfectly accurate for functional
> > correctness. The counters are used by userspace to get a general overview
> > of a workloads NUMA behaviour but the page allocator incurs a high cost to
> > maintain perfect accuracy similar to what is required for a vmstat like
> > NR_FREE_PAGES. There even is a sysctl vm.numa_stat to allow userspace to
> > turn off the collection of NUMA statistics like NUMA_HIT.
> > 
> > This patch converts NUMA_HIT and friends to be NUMA events with similar
> > accuracy to VM events. There is a possibility that slight errors will be
> > introduced but the overall trend as seen by userspace will be similar.
> > Note that while these counters could be maintained at the node level that
> > it would have a user-visible impact.
> 
> I guess this kind of inaccuracy is fine. I just don't like much
> fold_vm_zone_numa_events() which seems to calculate sums of percpu counters and
> then assign the result to zone counters for immediate consumption, which differs
> from other kinds of folds in vmstat that reset the percpu counters to 0 as they
> are treated as diffs to the global counters.
> 

The counters that are diffs fit inside an s8 and they are kept limited
because their "true" value is sometimes critical -- e.g. NR_FREE_PAGES
for watermark checking. So the level of drift has to be controlled and
the drift should not exist potentially forever so it gets updated
periodically.

The inaccurate counters are only exported to userspace. There is no need
to update them every few seconds so fold_vm_zone_numa_events() is only
called when a user cares but you raise a raise a valid below.

> So it seems that this intermediate assignment to zone counters (using
> atomic_long_set() even) is unnecessary and this could mimic sum_vm_events() that
> just does the summation on a local array?
> 

The atomic is unnecessary for sure but using a local array is
problematic because of your next point.

> And probably a bit more serious is that vm_events have vm_events_fold_cpu() to
> deal with a cpu going away, but after your patch the stats counted on a cpu just
> disapepar from the sums as it goes offline as there's no such thing for the numa
> counters.
> 

That is a problem I missed. Even if zonestats was preserved on
hot-remove, fold_vm_zone_numa_events would not be reading the CPU so
hotplug events jump all over the place.

So some periodic folding is necessary. I would still prefer not to do it
by time but it could be done only on overflow or when a file like
/proc/vmstat is read. I'll think about it a bit more and see what I come
up with.

Thanks!

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C3C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF5261179
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 12:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347678AbhDNM5y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233716AbhDNM5q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 08:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F0B1AFC8;
        Wed, 14 Apr 2021 12:56:46 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
Message-ID: <7a7ec563-0519-a850-563a-9680a7bd00d3@suse.cz>
Date:   Wed, 14 Apr 2021 14:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407202423.16022-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/7/21 10:24 PM, Mel Gorman wrote:
> NUMA statistics are maintained on the zone level for hits, misses, foreign
> etc but nothing relies on them being perfectly accurate for functional
> correctness. The counters are used by userspace to get a general overview
> of a workloads NUMA behaviour but the page allocator incurs a high cost to
> maintain perfect accuracy similar to what is required for a vmstat like
> NR_FREE_PAGES. There even is a sysctl vm.numa_stat to allow userspace to
> turn off the collection of NUMA statistics like NUMA_HIT.
> 
> This patch converts NUMA_HIT and friends to be NUMA events with similar
> accuracy to VM events. There is a possibility that slight errors will be
> introduced but the overall trend as seen by userspace will be similar.
> Note that while these counters could be maintained at the node level that
> it would have a user-visible impact.

I guess this kind of inaccuracy is fine. I just don't like much
fold_vm_zone_numa_events() which seems to calculate sums of percpu counters and
then assign the result to zone counters for immediate consumption, which differs
from other kinds of folds in vmstat that reset the percpu counters to 0 as they
are treated as diffs to the global counters.

So it seems that this intermediate assignment to zone counters (using
atomic_long_set() even) is unnecessary and this could mimic sum_vm_events() that
just does the summation on a local array?

And probably a bit more serious is that vm_events have vm_events_fold_cpu() to
deal with a cpu going away, but after your patch the stats counted on a cpu just
disapepar from the sums as it goes offline as there's no such thing for the numa
counters.

Thanks,
Vlastimil

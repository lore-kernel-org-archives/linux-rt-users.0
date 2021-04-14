Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D31C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07A16112F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352561AbhDNP5S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:57:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351195AbhDNP5Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 11:57:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6F03B0BA;
        Wed, 14 Apr 2021 15:56:53 +0000 (UTC)
Subject: Re: [PATCH 04/11] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
To:     Mel Gorman <mgorman@techsingularity.net>
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
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-5-mgorman@techsingularity.net>
 <7a7ec563-0519-a850-563a-9680a7bd00d3@suse.cz>
 <20210414151850.GG3697@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c4dff8a5-7959-c191-c66d-23a515244b80@suse.cz>
Date:   Wed, 14 Apr 2021 17:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414151850.GG3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 5:18 PM, Mel Gorman wrote:
> On Wed, Apr 14, 2021 at 02:56:45PM +0200, Vlastimil Babka wrote:
>> So it seems that this intermediate assignment to zone counters (using
>> atomic_long_set() even) is unnecessary and this could mimic sum_vm_events() that
>> just does the summation on a local array?
>> 
> 
> The atomic is unnecessary for sure but using a local array is
> problematic because of your next point.

IIUC vm_events seems to do fine without a centralized array and handling CPU hot
remove at the sime time ...

>> And probably a bit more serious is that vm_events have vm_events_fold_cpu() to
>> deal with a cpu going away, but after your patch the stats counted on a cpu just
>> disapepar from the sums as it goes offline as there's no such thing for the numa
>> counters.
>> 
> 
> That is a problem I missed. Even if zonestats was preserved on
> hot-remove, fold_vm_zone_numa_events would not be reading the CPU so
> hotplug events jump all over the place.
> 
> So some periodic folding is necessary. I would still prefer not to do it
> by time but it could be done only on overflow or when a file like
> /proc/vmstat is read. I'll think about it a bit more and see what I come
> up with.

... because vm_events_fold_cpu() seems to simply move the stats from the CPU
being offlined to the current one. So the same approach should be enough for
NUMA stats?

> Thanks!
> 


Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A708C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C926145A
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 12:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhDVMUa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:20:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:35802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235232AbhDVMUa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Apr 2021 08:20:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F664AF1A;
        Thu, 22 Apr 2021 12:19:54 +0000 (UTC)
Subject: Re: [PATCH 1/9] mm/page_alloc: Split per cpu page lists and zone
 stats
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
 <20210422111441.24318-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <45156f57-2fa9-71c8-aea5-d06d457c0236@suse.cz>
Date:   Thu, 22 Apr 2021 14:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210422111441.24318-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/22/21 1:14 PM, Mel Gorman wrote:
> The per-cpu page allocator lists and the per-cpu vmstat deltas are stored
> in the same struct per_cpu_pages even though vmstats have no direct impact
> on the per-cpu page lists. This is inconsistent because the vmstats for a
> node are stored on a dedicated structure. The bigger issue is that the
> per_cpu_pages structure is not cache-aligned and stat updates either
> cache conflict with adjacent per-cpu lists incurring a runtime cost or
> padding is required incurring a memory cost.
> 
> This patch splits the per-cpu pagelists and the vmstat deltas into separate
> structures. It's mostly a mechanical conversion but some variable renaming
> is done to clearly distinguish the per-cpu pages structure (pcp) from
> the vmstats (pzstats).
> 
> Superficially, this appears to increase the size of the per_cpu_pages
> structure but the movement of expire fills a structure hole so there is
> no impact overall.
> 
> [lkp@intel.com: Check struct per_cpu_zonestat has a non-zero size]
> [vbabka@suse.cz: Init zone->per_cpu_zonestats properly]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

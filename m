Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDC2C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DAC61153
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 09:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhDOJfS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:35:18 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:37341 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhDOJfR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 05:35:17 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 5FD92FAA02
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Apr 2021 10:34:54 +0100 (IST)
Received: (qmail 8512 invoked from network); 15 Apr 2021 09:34:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Apr 2021 09:34:54 -0000
Date:   Thu, 15 Apr 2021 10:34:52 +0100
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
Subject: Re: [PATCH 04/11] mm/vmstat: Inline NUMA event counter updates
Message-ID: <20210415093452.GI3697@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-5-mgorman@techsingularity.net>
 <6b25af48-9c6e-2c55-03d5-763de4aba149@suse.cz>
 <411a753f-ce03-389d-9a9f-93d17b284862@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <411a753f-ce03-389d-9a9f-93d17b284862@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 14, 2021 at 06:26:25PM +0200, Vlastimil Babka wrote:
> On 4/14/21 6:20 PM, Vlastimil Babka wrote:
> > On 4/14/21 3:39 PM, Mel Gorman wrote:
> >> __count_numa_event is small enough to be treated similarly to
> >> __count_vm_event so inline it.
> >> 
> >> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > 
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> >> ---
> >>  include/linux/vmstat.h | 9 +++++++++
> >>  mm/vmstat.c            | 9 ---------
> >>  2 files changed, 9 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> >> index fc14415223c5..dde4dec4e7dd 100644
> >> --- a/include/linux/vmstat.h
> >> +++ b/include/linux/vmstat.h
> >> @@ -237,6 +237,15 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
> >>  }
> >>  
> >>  #ifdef CONFIG_NUMA
> >> +/* See __count_vm_event comment on why raw_cpu_inc is used. */
> >> +static inline void
> >> +__count_numa_event(struct zone *zone, enum numa_stat_item item)
> >> +{
> >> +	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> >> +
> >> +	raw_cpu_inc(pzstats->vm_numa_event[item]);
> >> +}
> >> +
> >>  extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
> 
> Ah, but the line above should be removed.
> 

Yes it should!

-- 
Mel Gorman
SUSE Labs

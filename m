Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5EC433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB2761249
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhDOLYj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:24:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhDOLYi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 07:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3805AAF35;
        Thu, 15 Apr 2021 11:24:14 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-8-mgorman@techsingularity.net>
 <e5a41984-998f-730f-852b-3de82b582d01@suse.cz>
 <20210415093337.GH3697@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 07/11] mm/page_alloc: Remove duplicate checks if
 migratetype should be isolated
Message-ID: <a0146dfe-36de-387e-8ee0-48f282661234@suse.cz>
Date:   Thu, 15 Apr 2021 13:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415093337.GH3697@techsingularity.net>
Content-Type:   text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/15/21 11:33 AM, Mel Gorman wrote:
> On Wed, Apr 14, 2021 at 07:21:42PM +0200, Vlastimil Babka wrote:
>> On 4/14/21 3:39 PM, Mel Gorman wrote:
>> > Both free_pcppages_bulk() and free_one_page() have very similar
>> > checks about whether a page's migratetype has changed under the
>> > zone lock. Use a common helper.
>> > 
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> 
>> Seems like for free_pcppages_bulk() this patch makes it check for each page on
>> the pcplist
>> - zone->nr_isolate_pageblock != 0 instead of local bool (the performance might
>> be the same I guess on modern cpu though)
>> - is_migrate_isolate(migratetype) for a migratetype obtained by
>> get_pcppage_migratetype() which cannot be migrate_isolate so the check is useless.
>> 
>> As such it doesn't seem a worthwhile cleanup to me considering all the other
>> microoptimisations?
>> 
> 
> The patch was a preparation patch for the rest of the series to avoid code
> duplication and to consolidate checks together in one place to determine
> if they are even correct.
> 
> Until zone_pcp_disable() came along, it was possible to have isolated PCP
> pages in the lists even though zone->nr_isolate_pageblock could be 0 during
> memory hot-remove so the split in free_pcppages_bulk was not necessarily
> correct at all times.
> 
> The remaining problem is alloc_contig_pages, it does not disable
> PCPs so both checks are necessary. If that also disabled PCPs
> then check_migratetype_isolated could be deleted but the cost to
> alloc_contig_pages might be too high.

I see. Well that's unfortunate if checking zone->nr_isolate_pageblock is not
sufficient, as it was supposed to be :(
But I don't think the check_migratetype_isolated() check was helping in such
scenario as it was, anyway.

It's testing this:

+       if (unlikely(has_isolate_pageblock(zone) ||
+               is_migrate_isolate(migratetype))) {

In the context of free_one_page(), the 'migratetype' variable holds a value
that's read from pageblock in one of the callers of free_one_page():

migratetype = get_pcppage_migratetype(page);

and because it's read outside of zone lock, it might be a MIGRATE_ISOLATE even
though after we obtain the zone lock, we might find out it's not anymore. This
is explained in commit ad53f92eb416 ("mm/page_alloc: fix incorrect isolation
behavior by rechecking migratetype") as scenario 1.

However, in the context of free_pcppages_bulk(), the migratetype we are checking
in check_migratetype_isolated() is this one:

int mt = get_pcppage_migratetype(page);

That was the one determined while adding the page to pcplist, and is stored in
the struct page and we know it's not MIGRATE_ISOLATE otherwise the page would
not go to pcplist. But by rechecking this stored value, we would not be finding
the case where the underlying pageblock's migratetype would change to
MIGRATE_ISOLATE, anyway...

> I'll delete this patch for now because it's relatively minor and there
> should be other ways of keeping the code duplication down.
> 


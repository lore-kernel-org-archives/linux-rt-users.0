Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01AC433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC4861249
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 09:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhDOJeD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:34:03 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:50785 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhDOJeC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 05:34:02 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id E5C90FA9F5
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Apr 2021 10:33:38 +0100 (IST)
Received: (qmail 7775 invoked from network); 15 Apr 2021 09:33:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Apr 2021 09:33:38 -0000
Date:   Thu, 15 Apr 2021 10:33:37 +0100
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
Subject: Re: [PATCH 07/11] mm/page_alloc: Remove duplicate checks if
 migratetype should be isolated
Message-ID: <20210415093337.GH3697@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-8-mgorman@techsingularity.net>
 <e5a41984-998f-730f-852b-3de82b582d01@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e5a41984-998f-730f-852b-3de82b582d01@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 14, 2021 at 07:21:42PM +0200, Vlastimil Babka wrote:
> On 4/14/21 3:39 PM, Mel Gorman wrote:
> > Both free_pcppages_bulk() and free_one_page() have very similar
> > checks about whether a page's migratetype has changed under the
> > zone lock. Use a common helper.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Seems like for free_pcppages_bulk() this patch makes it check for each page on
> the pcplist
> - zone->nr_isolate_pageblock != 0 instead of local bool (the performance might
> be the same I guess on modern cpu though)
> - is_migrate_isolate(migratetype) for a migratetype obtained by
> get_pcppage_migratetype() which cannot be migrate_isolate so the check is useless.
> 
> As such it doesn't seem a worthwhile cleanup to me considering all the other
> microoptimisations?
> 

The patch was a preparation patch for the rest of the series to avoid code
duplication and to consolidate checks together in one place to determine
if they are even correct.

Until zone_pcp_disable() came along, it was possible to have isolated PCP
pages in the lists even though zone->nr_isolate_pageblock could be 0 during
memory hot-remove so the split in free_pcppages_bulk was not necessarily
correct at all times.

The remaining problem is alloc_contig_pages, it does not disable
PCPs so both checks are necessary. If that also disabled PCPs
then check_migratetype_isolated could be deleted but the cost to
alloc_contig_pages might be too high.

I'll delete this patch for now because it's relatively minor and there
should be other ways of keeping the code duplication down.

-- 
Mel Gorman
SUSE Labs

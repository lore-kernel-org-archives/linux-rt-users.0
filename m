Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921DC433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D319E613BB
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 13:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbhDMN1h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Apr 2021 09:27:37 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:39466 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239082AbhDMN1c (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Apr 2021 09:27:32 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id C7E40CAD73
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Apr 2021 14:27:11 +0100 (IST)
Received: (qmail 18223 invoked from network); 13 Apr 2021 13:27:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Apr 2021 13:27:11 -0000
Date:   Tue, 13 Apr 2021 14:27:09 +0100
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
Subject: Re: [PATCH 01/11] mm/page_alloc: Split per cpu page lists and zone
 stats
Message-ID: <20210413132708.GD3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-2-mgorman@techsingularity.net>
 <81cf880c-826e-6bbf-3af0-22d7aa2d3075@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <81cf880c-826e-6bbf-3af0-22d7aa2d3075@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 12, 2021 at 07:43:18PM +0200, Vlastimil Babka wrote:
> On 4/7/21 10:24 PM, Mel Gorman wrote:
> > @@ -6691,7 +6697,7 @@ static __meminit void zone_pcp_init(struct zone *zone)
> >  	 * relies on the ability of the linker to provide the
> >  	 * offset of a (static) per cpu variable into the per cpu area.
> >  	 */
> > -	zone->pageset = &boot_pageset;
> > +	zone->per_cpu_pageset = &boot_pageset;
> 
> I don't see any &boot_zonestats assignment here in zone_pcp_init() or its
> caller(s), which seems strange, as zone_pcp_reset() does it.
> 

Yes, it's required, well spotted!

-- 
Mel Gorman
SUSE Labs

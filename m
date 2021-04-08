Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A1C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 17:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEDC61108
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 17:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhDHRm7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:42:59 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:41157 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhDHRm6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Apr 2021 13:42:58 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 29DC31C3519
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Apr 2021 18:42:46 +0100 (IST)
Received: (qmail 18330 invoked from network); 8 Apr 2021 17:42:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Apr 2021 17:42:45 -0000
Date:   Thu, 8 Apr 2021 18:42:44 +0100
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
Message-ID: <20210408174244.GG3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 08, 2021 at 12:52:07PM +0200, Peter Zijlstra wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a68bacddcae0..e9e60d1a85d4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -112,6 +112,13 @@ typedef int __bitwise fpi_t;
> >  static DEFINE_MUTEX(pcp_batch_high_lock);
> >  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
> >  
> > +struct pagesets {
> > +	local_lock_t lock;
> > +};
> > +static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> > +	.lock = INIT_LOCAL_LOCK(lock),
> > +};
> 
> So why isn't the local_lock_t in struct per_cpu_pages ? That seems to be
> the actual object that is protected by it and is already per-cpu.
> 
> Is that because you want to avoid the duplication across zones? Is that
> worth the effort?

When I wrote the patch, the problem was that zone_pcp_reset freed the
per_cpu_pages structure and it was "protected" by local_irq_save(). If
that was converted to local_lock_irq then the structure containing the
lock is freed before it is released which is obviously bad.

Much later when trying to make the allocator RT-safe in general, I realised
that locking was broken and fixed it in patch 3 of this series. With that,
the local_lock could potentially be embedded within per_cpu_pages safely
at the end of this series.

-- 
Mel Gorman
SUSE Labs

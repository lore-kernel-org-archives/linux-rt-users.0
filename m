Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE23C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE57561222
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 14:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhDOOLd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 10:11:33 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:34669 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233286AbhDOOLc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 10:11:32 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id D26411C40AD
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Apr 2021 15:11:08 +0100 (IST)
Received: (qmail 27982 invoked from network); 15 Apr 2021 14:11:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Apr 2021 14:11:08 -0000
Date:   Thu, 15 Apr 2021 15:11:06 +0100
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
Subject: Re: [PATCH 09/11] mm/page_alloc: Avoid conflating IRQs disabled with
 zone->lock
Message-ID: <20210415141106.GK3697@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-10-mgorman@techsingularity.net>
 <838c6734-1e5d-6a26-8c88-90e89d407482@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <838c6734-1e5d-6a26-8c88-90e89d407482@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 15, 2021 at 02:25:36PM +0200, Vlastimil Babka wrote:
> > @@ -3294,6 +3295,7 @@ void free_unref_page_list(struct list_head *list)
> >  	struct page *page, *next;
> >  	unsigned long flags, pfn;
> >  	int batch_count = 0;
> > +	int migratetype;
> >  
> >  	/* Prepare pages for freeing */
> >  	list_for_each_entry_safe(page, next, list, lru) {
> > @@ -3301,15 +3303,28 @@ void free_unref_page_list(struct list_head *list)
> >  		if (!free_unref_page_prepare(page, pfn))
> >  			list_del(&page->lru);
> >  		set_page_private(page, pfn);
> 
> Should probably move this below so we don't set private for pages that then go
> through free_one_page()? Doesn't seem to be a bug, just unneccessary.
> 

Sure.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1d87ca364680..a9c1282d9c7b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3293,7 +3293,6 @@ void free_unref_page_list(struct list_head *list)
 		pfn = page_to_pfn(page);
 		if (!free_unref_page_prepare(page, pfn))
 			list_del(&page->lru);
-		set_page_private(page, pfn);
 
 		/*
 		 * Free isolated pages directly to the allocator, see
@@ -3307,6 +3306,8 @@ void free_unref_page_list(struct list_head *list)
 				list_del(&page->lru);
 			}
 		}
+
+		set_page_private(page, pfn);
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);

-- 
Mel Gorman
SUSE Labs

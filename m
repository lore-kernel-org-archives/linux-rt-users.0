Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4567C43461
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6D4610FA
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDHRsV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:48:21 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:59563 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHRsT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Apr 2021 13:48:19 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 60E61BAA43
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Apr 2021 18:48:06 +0100 (IST)
Received: (qmail 27078 invoked from network); 8 Apr 2021 17:48:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Apr 2021 17:48:06 -0000
Date:   Thu, 8 Apr 2021 18:48:04 +0100
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
Subject: Re: [PATCH 0/11 v2] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210408174804.GH3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <YG7hQeOthUbPBU86@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG7hQeOthUbPBU86@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 08, 2021 at 12:56:01PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 09:24:12PM +0100, Mel Gorman wrote:
> > Why local_lock? PREEMPT_RT considers the following sequence to be unsafe
> > as documented in Documentation/locking/locktypes.rst
> > 
> >    local_irq_disable();
> >    raw_spin_lock(&lock);
> 
> Almost, the above is actually OK on RT. The problematic one is:
> 
> 	local_irq_disable();
> 	spin_lock(&lock);
> 
> That doesn't work on RT since spin_lock() turns into a PI-mutex which
> then obviously explodes if it tries to block with IRQs disabled.
> 
> And it so happens, that's exactly the one at hand.

Ok, I completely messed up the leader because it was local_irq_disable()
+ spin_lock() that I was worried about. Once the series is complete,
it is replated with

  local_lock_irq(&lock_lock)
  spin_lock(&lock);

According to Documentation/locking/locktypes.rst, that should be safe.
I'll rephrase the justification.

-- 
Mel Gorman
SUSE Labs

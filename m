Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Sep 2021 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0CB60F6B
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Sep 2021 13:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbhIFNtn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 09:49:43 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:40335 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242521AbhIFNtn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Sep 2021 09:49:43 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 7813ABACA2
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Sep 2021 14:48:35 +0100 (IST)
Received: (qmail 13005 invoked from network); 6 Sep 2021 13:48:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Sep 2021 13:48:35 -0000
Date:   Mon, 6 Sep 2021 14:48:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210906134820.GA3959@techsingularity.net>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
 <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 31, 2021 at 06:45:46PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-05 17:00:19 [+0100], Mel Gorman wrote:
> >  mm/vmstat.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> The version in RT also covered the functions
>   __count_vm_event()
>   __count_vm_events()
> 
> in include/linux/vmstat.h. Were they dropped by mistake or on purpose? 
> 

Sorry for the long delay, this got lost in a mess of mail. It was
dropped on purpose and I tried to explain why in the changelog

	This patch differs from the preempt-rt version where
	__count_vm_event and __count_vm_events are also protected. The
	counters are explicitly "allowed to be to be racy" so there is
	no need to protect them from preemption. Only the accurate page
	stats that are updated by a read-modify-write need protection. This
	patch also differs in that a preempt_[en|dis]able_rt helper is not
	used. As vmstat is the only user of the helper, it was suggested
	that it be open-coded in vmstat.c instead of risking the helper
	being used in unnecessary contexts.

Does that answer your question?

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D6C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B2261405
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Apr 2021 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhDOOzk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 10:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234353AbhDOOyM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Apr 2021 10:54:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDC45AFE6;
        Thu, 15 Apr 2021 14:53:46 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-12-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 11/11] mm/page_alloc: Embed per_cpu_pages locking within
 the per-cpu structure
Message-ID: <de5d1dbb-fb56-9660-fadb-6318047305d4@suse.cz>
Date:   Thu, 15 Apr 2021 16:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-12-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> struct per_cpu_pages is protected by the pagesets lock but it can be
> embedded within struct per_cpu_pages at a minor cost. This is possible
> because per-cpu lookups are based on offsets. Paraphrasing an explanation
> from Peter Ziljstra
> 
>   The whole thing relies on:
> 
>     &per_cpu_ptr(msblk->stream, cpu)->lock == per_cpu_ptr(&msblk->stream->lock, cpu)
> 
>   Which is true because the lhs:
> 
>     (local_lock_t *)((zone->per_cpu_pages + per_cpu_offset(cpu)) + offsetof(struct per_cpu_pages, lock))
> 
>   and the rhs:
> 
>     (local_lock_t *)((zone->per_cpu_pages + offsetof(struct per_cpu_pages, lock)) + per_cpu_offset(cpu))
> 
>   are identical, because addition is associative.
> 
> More details are included in mmzone.h. This embedding is not completely
> free for three reasons.
> 
> 1. As local_lock does not return a per-cpu structure, the PCP has to
>    be looked up twice -- first to acquire the lock and again to get the
>    PCP pointer.
> 
> 2. For PREEMPT_RT and CONFIG_DEBUG_LOCK_ALLOC, local_lock is potentially
>    a spinlock or has lock-specific tracking. In both cases, it becomes
>    necessary to release/acquire different locks when freeing a list of
>    pages in free_unref_page_list.

Looks like this pattern could benefit from a local_lock API helper that would do
the right thing? It probably couldn't optimize much the CONFIG_PREEMPT_RT case
which would need to be unlock/lock in any case, but CONFIG_DEBUG_LOCK_ALLOC
could perhaps just keep the IRQ's disabled and just note the change of what's
acquired?

> 3. For most kernel configurations, local_lock_t is empty and no storage is
>    required. By embedding the lock, the memory consumption on PREEMPT_RT
>    and CONFIG_DEBUG_LOCK_ALLOC is higher.

But I wonder, is there really a benefit to this increased complexity? Before the
patch we had "pagesets" - a local_lock that protects all zones' pcplists. Now
each zone's pcplists have own local_lock. On !PREEMPT_RT we will never take the
locks of multiple zones from the same CPU in parallel, because we use
local_lock_irqsave(). Can that parallelism happen on PREEMPT_RT, because that
could perhaps justify the change?

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---

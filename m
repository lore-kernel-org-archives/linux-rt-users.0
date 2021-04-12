Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EEC433ED
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A91E6128A
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhDLL4e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:56:34 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:49700 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240502AbhDLL4d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Apr 2021 07:56:33 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id EF488BAB46
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Apr 2021 12:56:13 +0100 (IST)
Received: (qmail 16475 invoked from network); 12 Apr 2021 11:56:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 11:56:13 -0000
Date:   Mon, 12 Apr 2021 12:56:12 +0100
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
Message-ID: <20210412115612.GX3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
 <20210409075939.GJ3697@techsingularity.net>
 <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
 <20210409133256.GN3697@techsingularity.net>
 <YHCjK8OOhmxTbKu0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YHCjK8OOhmxTbKu0@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 09, 2021 at 08:55:39PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 02:32:56PM +0100, Mel Gorman wrote:
> > That said, there are some curious users already.
> > fs/squashfs/decompressor_multi_percpu.c looks like it always uses the
> > local_lock in CPU 0's per-cpu structure instead of stabilising a per-cpu
> > pointer. 
> 
> I'm not sure how you read that.
> 
> You're talking about this:
> 
>   local_lock(&msblk->stream->lock);
> 
> right? Note that msblk->stream is a per-cpu pointer, so
> &msblk->stream->lock is that same per-cpu pointer with an offset on.
> 
> The whole think relies on:
> 
> 	&per_cpu_ptr(msblk->stream, cpu)->lock == per_cpu_ptr(&msblk->stream->lock, cpu)
> 
> Which is true because the lhs:
> 
> 	(local_lock_t *)((msblk->stream + per_cpu_offset(cpu)) + offsetof(struct squashfs_stream, lock))
> 
> and the rhs:
> 
> 	(local_lock_t *)((msblk->stream + offsetof(struct squashfs_stream, lock)) + per_cpu_offset(cpu))
> 
> are identical, because addition is associative.
> 

Ok, I think I see and understand now, I didn't follow far enough down
into the macro magic and missed this observation so thanks for your
patience. The page allocator still incurs a double lookup of the per
cpu offsets but it should work for both the current local_lock_irq
implementation and the one in preempt-rt because the task will be pinned
to the CPU by either preempt_disable, migrate_disable or IRQ disable
depending on the local_lock implementation and kernel configuration.

I'll update the changelog and comment accordingly. I'll decide later
whether to leave it or move the location of the lock at the end of the
series. If the patch is added, it'll either incur the double lookup (not
that expensive, might be optimised by the compiler) or come up with a
helper that takes the lock and returns the per-cpu structure. The double
lookup probably makes more sense initially because there are multiple
potential users of a helper that says "pin to CPU, lookup, lock and return
a per-cpu structure" for both IRQ-safe and IRQ-unsafe variants with the
associated expansion of the local_lock API. It might be better to introduce
such a helper with multiple users converted at the same time and there are
other local_lock users in preempt-rt that could do with upstreaming first.

> > drivers/block/zram/zcomp.c appears to do the same although for
> > at least one of the zcomp_stream_get() callers, the CPU is pinned for
> > other reasons (bit spin lock held). I think it happens to work anyway
> > but it's weird and I'm not a fan.
> 
> Same thing.

Yep.

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6DC433C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 08:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C606161998
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 08:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhCaIwp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:52:45 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:44553 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhCaIwP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 04:52:15 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 9D573CACBD
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Mar 2021 09:52:14 +0100 (IST)
Received: (qmail 27995 invoked from network); 31 Mar 2021 08:52:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Mar 2021 08:52:14 -0000
Date:   Wed, 31 Mar 2021 09:52:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210331085213.GZ3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ingo, Thomas or Peter, is there any chance one of you could take a look
at patch "[PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to
local_lock" from this series? It's partially motivated by PREEMPT_RT. More
details below.

On Mon, Mar 29, 2021 at 01:06:42PM +0100, Mel Gorman wrote:
> This series requires patches in Andrew's tree so the series is also
> available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r15
> 
> The PCP (per-cpu page allocator in page_alloc.c) share locking requirements
> with vmstat which is inconvenient and causes some issues. Possibly because
> of that, the PCP list and vmstat share the same per-cpu space meaning that
> it's possible that vmstat updates dirty cache lines holding per-cpu lists
> across CPUs unless padding is used. The series splits that structure and
> separates the locking.
> 

The bulk page allocation series that the local_lock work had an
additional fix so I've rebased this onto

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r16

> Second, PREEMPT_RT considers the following sequence to be unsafe
> as documented in Documentation/locking/locktypes.rst
> 
>    local_irq_disable();
>    spin_lock(&lock);
> 
> The pcp allocator has this sequence for rmqueue_pcplist (local_irq_save)
> -> __rmqueue_pcplist -> rmqueue_bulk (spin_lock). This series explicitly
> separates the locking requirements for the PCP list (local_lock) and stat
> updates (irqs disabled). Once that is done, the length of time IRQs are
> disabled can be reduced and in some cases, IRQ disabling can be replaced
> with preempt_disable.
> 

It's this part I'm interested in even though it only partially addresses
the preempt-rt tree concerns. More legwork is needed for preempt-rt which
is outside the context of this series. At minimum, it involves

1. Split locking of pcp and buddy allocator instead of using spin_lock()
   when it's "known" that IRQs are disabled (not necessarily a valid
   assumption on PREEMPT_RT)
2. Split the zone lock into what protects the zone metadata and what
   protects the free lists

This looks straight-forward but it involves audit work and it may be
difficult to avoid regressing non-PREEMPT_RT kernels by disabling/enabling
IRQs when switching between the pcp allocator and the buddy allocator.

> After that, it was very obvious that zone_statistics in particular has way
> too much overhead and leaves IRQs disabled for longer than necessary. It
> has perfectly accurate counters requiring IRQs be disabled for parallel
> RMW sequences when inaccurate ones like vm_events would do. The series
> makes the NUMA statistics (NUMA_HIT and friends) inaccurate counters that
> only require preempt be disabled.
> 
> Finally the bulk page allocator can then do all the stat updates in bulk
> with IRQs enabled which should improve the efficiency of the bulk page
> allocator. Technically, this could have been done without the local_lock
> and vmstat conversion work and the order simply reflects the timing of
> when different series were implemented.
> 
> No performance data is included because despite the overhead of the
> stats, it's within the noise for most workloads but Jesper and Chuck may
> observe a significant different with the same tests used for the bulk
> page allocator. The series is more likely to be interesting to the RT
> folk in terms of slowing getting the PREEMPT tree into mainline.
> 
>  drivers/base/node.c    |  18 +--
>  include/linux/mmzone.h |  29 +++--
>  include/linux/vmstat.h |  65 ++++++-----
>  mm/mempolicy.c         |   2 +-
>  mm/page_alloc.c        | 173 ++++++++++++++++------------
>  mm/vmstat.c            | 254 +++++++++++++++--------------------------
>  6 files changed, 254 insertions(+), 287 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
Mel Gorman
SUSE Labs

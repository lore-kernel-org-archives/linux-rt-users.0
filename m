Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D17C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E566192C
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhC3Sw2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhC3SwF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Mar 2021 14:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617130325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMCpVlMlRD7NcZCE9ewfx3xVfYn50wJwXreF4M6Z7f4=;
        b=XMD3Ii9OiclANAcMhuISxUB0U2BBtQ3Q3gpK5BdlewpX3LIoSIfj8WJTamsxASKY6fUXFI
        OZ2eCemD20Yohw+VV6UQHatAPqF+MiQSvwAbRa/RiKc9SF0WOF+sLME1SsYN4x4xTMDqFC
        BWm9XcH7D8zNz2xiSkBjY0yHiHHrwL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-YkBKwRlwOwmf23SkhoZNIw-1; Tue, 30 Mar 2021 14:52:02 -0400
X-MC-Unique: YkBKwRlwOwmf23SkhoZNIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0751190B2A1;
        Tue, 30 Mar 2021 18:52:00 +0000 (UTC)
Received: from carbon (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81C1260861;
        Tue, 30 Mar 2021 18:51:55 +0000 (UTC)
Date:   Tue, 30 Mar 2021 20:51:54 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, brouer@redhat.com
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210330205154.1fe1e479@carbon>
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 29 Mar 2021 13:06:42 +0100
Mel Gorman <mgorman@techsingularity.net> wrote:

> This series requires patches in Andrew's tree so the series is also
> available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r15
> 
> tldr: Jesper and Chuck, it would be nice to verify if this series helps
> 	the allocation rate of the bulk page allocator. RT people, this
> 	*partially* addresses some problems PREEMPT_RT has with the page
> 	allocator but it needs review.

I've run a new micro-benchmark[1] which shows:
(CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz)

BASELINE
 single_page alloc+put: 194 cycles(tsc) 54.106 ns

LIST variant: time_bulk_page_alloc_free_list: step=bulk size

 Per elem: 200 cycles(tsc) 55.667 ns (step:1)
 Per elem: 143 cycles(tsc) 39.755 ns (step:2)
 Per elem: 132 cycles(tsc) 36.758 ns (step:3)
 Per elem: 128 cycles(tsc) 35.795 ns (step:4)
 Per elem: 123 cycles(tsc) 34.339 ns (step:8)
 Per elem: 120 cycles(tsc) 33.396 ns (step:16)
 Per elem: 118 cycles(tsc) 32.806 ns (step:32)
 Per elem: 115 cycles(tsc) 32.169 ns (step:64)
 Per elem: 116 cycles(tsc) 32.258 ns (step:128)

ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size

 Per elem: 195 cycles(tsc) 54.225 ns (step:1)
 Per elem: 127 cycles(tsc) 35.492 ns (step:2)
 Per elem: 117 cycles(tsc) 32.643 ns (step:3)
 Per elem: 111 cycles(tsc) 30.992 ns (step:4)
 Per elem: 106 cycles(tsc) 29.606 ns (step:8)
 Per elem: 102 cycles(tsc) 28.532 ns (step:16)
 Per elem: 99 cycles(tsc) 27.728 ns (step:32)
 Per elem: 98 cycles(tsc) 27.252 ns (step:64)
 Per elem: 97 cycles(tsc) 27.090 ns (step:128)

[1] https://github.com/xdp-project/xdp-project/blob/master/areas/mem/page_pool06_alloc_pages_bulk.org#micro-benchmark-page_bench04_bulk-local_lock-v1r15

This should be seen in comparison with the older micro-benchmark[2]
done on branch mm-bulk-rebase-v5r9.

BASELINE
 single_page alloc+put: Per elem: 199 cycles(tsc) 55.472 ns

LIST variant: time_bulk_page_alloc_free_list: step=bulk size

 Per elem: 206 cycles(tsc) 57.478 ns (step:1)
 Per elem: 154 cycles(tsc) 42.861 ns (step:2)
 Per elem: 145 cycles(tsc) 40.536 ns (step:3)
 Per elem: 142 cycles(tsc) 39.477 ns (step:4)
 Per elem: 142 cycles(tsc) 39.610 ns (step:8)
 Per elem: 137 cycles(tsc) 38.155 ns (step:16)
 Per elem: 135 cycles(tsc) 37.739 ns (step:32)
 Per elem: 134 cycles(tsc) 37.282 ns (step:64)
 Per elem: 133 cycles(tsc) 36.993 ns (step:128)

ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size

 Per elem: 202 cycles(tsc) 56.383 ns (step:1)
 Per elem: 144 cycles(tsc) 40.047 ns (step:2)
 Per elem: 134 cycles(tsc) 37.339 ns (step:3)
 Per elem: 128 cycles(tsc) 35.578 ns (step:4)
 Per elem: 120 cycles(tsc) 33.592 ns (step:8)
 Per elem: 116 cycles(tsc) 32.362 ns (step:16)
 Per elem: 113 cycles(tsc) 31.476 ns (step:32)
 Per elem: 110 cycles(tsc) 30.633 ns (step:64)
 Per elem: 110 cycles(tsc) 30.596 ns (step:128)

[2] https://github.com/xdp-project/xdp-project/blob/master/areas/mem/page_pool06_alloc_pages_bulk.org#micro-benchmark-page_bench04_bulk

This new patchset does show some improvements in the micro-benchmark.


> The PCP (per-cpu page allocator in page_alloc.c) share locking requirements
> with vmstat which is inconvenient and causes some issues. Possibly because
> of that, the PCP list and vmstat share the same per-cpu space meaning that
> it's possible that vmstat updates dirty cache lines holding per-cpu lists
> across CPUs unless padding is used. The series splits that structure and
> separates the locking.
> 
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

I've try to run some longer packet benchmarks later.  A quick test
showed performance was within same range, and slightly better.  The
perf report and objdump, did reveal that code layout prefers the label
"failed:" as the primary code path, which should only be used for
single page allocs, which is kind of weird. (But as performance is the
same or slightly better, I will not complain).


>  drivers/base/node.c    |  18 +--
>  include/linux/mmzone.h |  29 +++--
>  include/linux/vmstat.h |  65 ++++++-----
>  mm/mempolicy.c         |   2 +-
>  mm/page_alloc.c        | 173 ++++++++++++++++------------
>  mm/vmstat.c            | 254 +++++++++++++++--------------------------
>  6 files changed, 254 insertions(+), 287 deletions(-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


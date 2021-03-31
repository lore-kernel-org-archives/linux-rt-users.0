Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BDC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB43A6195D
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 07:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhCaHiO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 03:38:14 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:37824 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234168AbhCaHiJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 03:38:09 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 58AA3CACCC
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Mar 2021 08:38:07 +0100 (IST)
Received: (qmail 31482 invoked from network); 31 Mar 2021 07:38:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Mar 2021 07:38:07 -0000
Date:   Wed, 31 Mar 2021 08:38:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210331073805.GY3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
 <20210330205154.1fe1e479@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210330205154.1fe1e479@carbon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Mar 30, 2021 at 08:51:54PM +0200, Jesper Dangaard Brouer wrote:
> On Mon, 29 Mar 2021 13:06:42 +0100
> Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > This series requires patches in Andrew's tree so the series is also
> > available at
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r15
> > 
> > tldr: Jesper and Chuck, it would be nice to verify if this series helps
> > 	the allocation rate of the bulk page allocator. RT people, this
> > 	*partially* addresses some problems PREEMPT_RT has with the page
> > 	allocator but it needs review.
> 
> I've run a new micro-benchmark[1] which shows:
> (CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz)
> 
> <Editting to focus on arrays>
> BASELINE
>  single_page alloc+put: 194 cycles(tsc) 54.106 ns
> 
> ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size
> 
>  Per elem: 195 cycles(tsc) 54.225 ns (step:1)
>  Per elem: 127 cycles(tsc) 35.492 ns (step:2)
>  Per elem: 117 cycles(tsc) 32.643 ns (step:3)
>  Per elem: 111 cycles(tsc) 30.992 ns (step:4)
>  Per elem: 106 cycles(tsc) 29.606 ns (step:8)
>  Per elem: 102 cycles(tsc) 28.532 ns (step:16)
>  Per elem: 99 cycles(tsc) 27.728 ns (step:32)
>  Per elem: 98 cycles(tsc) 27.252 ns (step:64)
>  Per elem: 97 cycles(tsc) 27.090 ns (step:128)
> 
> This should be seen in comparison with the older micro-benchmark[2]
> done on branch mm-bulk-rebase-v5r9.
> 
> BASELINE
>  single_page alloc+put: Per elem: 199 cycles(tsc) 55.472 ns
> 
> ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size
> 
>  Per elem: 202 cycles(tsc) 56.383 ns (step:1)
>  Per elem: 144 cycles(tsc) 40.047 ns (step:2)
>  Per elem: 134 cycles(tsc) 37.339 ns (step:3)
>  Per elem: 128 cycles(tsc) 35.578 ns (step:4)
>  Per elem: 120 cycles(tsc) 33.592 ns (step:8)
>  Per elem: 116 cycles(tsc) 32.362 ns (step:16)
>  Per elem: 113 cycles(tsc) 31.476 ns (step:32)
>  Per elem: 110 cycles(tsc) 30.633 ns (step:64)
>  Per elem: 110 cycles(tsc) 30.596 ns (step:128)
> 

Ok, so bulk allocation is faster than allocating single pages, no surprise
there. Putting the array figures for bulk allocation into tabular format
and comparing we get;

Array variant (time to allocate a page in nanoseconds, lower is better)
        Baseline        Patched
1       56.383          54.225 (+3.83%)
2       40.047          35.492 (+11.38%)
3       37.339          32.643 (+12.58%)
4       35.578          30.992 (+12.89%)
8       33.592          29.606 (+11.87%)
16      32.362          28.532 (+11.85%)
32      31.476          27.728 (+11.91%)
64      30.633          27.252 (+11.04%)
128     30.596          27.090 (+11.46%)

The series is 11-12% faster when allocating multiple pages.  That's a
fairly positive outcome and I'll include this in the series leader if
you have no objections.

Thanks Jesper!

-- 
Mel Gorman
SUSE Labs

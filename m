Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD6C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 08:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10B8619D8
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 08:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhCaISQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234197AbhCaIRy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 04:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617178672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bTqLjMGBkNyk6LPfhvftRY7GVRzCJFKJwpWtZQvrdY=;
        b=bxq8/UeN840xD8FxtBJr/6TeZjv63MefU0pkHwOhreGopYAL7hv1mjBogRHAlAtDO4u3MV
        vCcIY0EoOcXmYSeee9dz4E0QiPxAN8osEItTuELSPdvarTYJDMCqxI2s1fHHZJxNDk3/nV
        rdgPHD4IO6Bn9gYJ+41+kRcAYVxxb4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-vV6X7zIlNfaW18iSYhKvUA-1; Wed, 31 Mar 2021 04:17:48 -0400
X-MC-Unique: vV6X7zIlNfaW18iSYhKvUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33BB8710FD;
        Wed, 31 Mar 2021 08:17:45 +0000 (UTC)
Received: from carbon (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 597E46A900;
        Wed, 31 Mar 2021 08:17:40 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:17:39 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, brouer@redhat.com
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210331101739.0cc3630e@carbon>
In-Reply-To: <20210331073805.GY3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
        <20210330205154.1fe1e479@carbon>
        <20210331073805.GY3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 31 Mar 2021 08:38:05 +0100
Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Mar 30, 2021 at 08:51:54PM +0200, Jesper Dangaard Brouer wrote:
> > On Mon, 29 Mar 2021 13:06:42 +0100
> > Mel Gorman <mgorman@techsingularity.net> wrote:
> >   
> > > This series requires patches in Andrew's tree so the series is also
> > > available at
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r15
> > > 
> > > tldr: Jesper and Chuck, it would be nice to verify if this series helps
> > > 	the allocation rate of the bulk page allocator. RT people, this
> > > 	*partially* addresses some problems PREEMPT_RT has with the page
> > > 	allocator but it needs review.  
> > 
> > I've run a new micro-benchmark[1] which shows:
> > (CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz)
> > 
> > <Editting to focus on arrays>
> > BASELINE
> >  single_page alloc+put: 194 cycles(tsc) 54.106 ns
> > 
> > ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size
> > 
> >  Per elem: 195 cycles(tsc) 54.225 ns (step:1)
> >  Per elem: 127 cycles(tsc) 35.492 ns (step:2)
> >  Per elem: 117 cycles(tsc) 32.643 ns (step:3)
> >  Per elem: 111 cycles(tsc) 30.992 ns (step:4)
> >  Per elem: 106 cycles(tsc) 29.606 ns (step:8)
> >  Per elem: 102 cycles(tsc) 28.532 ns (step:16)
> >  Per elem: 99 cycles(tsc) 27.728 ns (step:32)
> >  Per elem: 98 cycles(tsc) 27.252 ns (step:64)
> >  Per elem: 97 cycles(tsc) 27.090 ns (step:128)
> > 
> > This should be seen in comparison with the older micro-benchmark[2]
> > done on branch mm-bulk-rebase-v5r9.
> > 
> > BASELINE
> >  single_page alloc+put: Per elem: 199 cycles(tsc) 55.472 ns
> > 
> > ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size
> > 
> >  Per elem: 202 cycles(tsc) 56.383 ns (step:1)
> >  Per elem: 144 cycles(tsc) 40.047 ns (step:2)
> >  Per elem: 134 cycles(tsc) 37.339 ns (step:3)
> >  Per elem: 128 cycles(tsc) 35.578 ns (step:4)
> >  Per elem: 120 cycles(tsc) 33.592 ns (step:8)
> >  Per elem: 116 cycles(tsc) 32.362 ns (step:16)
> >  Per elem: 113 cycles(tsc) 31.476 ns (step:32)
> >  Per elem: 110 cycles(tsc) 30.633 ns (step:64)
> >  Per elem: 110 cycles(tsc) 30.596 ns (step:128)
> >   
> 
> Ok, so bulk allocation is faster than allocating single pages, no surprise
> there. Putting the array figures for bulk allocation into tabular format
> and comparing we get;
> 
> Array variant (time to allocate a page in nanoseconds, lower is better)
>         Baseline        Patched
> 1       56.383          54.225 (+3.83%)
> 2       40.047          35.492 (+11.38%)
> 3       37.339          32.643 (+12.58%)
> 4       35.578          30.992 (+12.89%)
> 8       33.592          29.606 (+11.87%)
> 16      32.362          28.532 (+11.85%)
> 32      31.476          27.728 (+11.91%)
> 64      30.633          27.252 (+11.04%)
> 128     30.596          27.090 (+11.46%)
> 
> The series is 11-12% faster when allocating multiple pages.  That's a
> fairly positive outcome and I'll include this in the series leader if
> you have no objections.

That is fine by me to add this to the cover letter.  I like your
tabular format as it makes is easier to compare. If you use the
nanosec measurements and not the cycles, you should state that
this was run on a CPU E5-1650 v4 @ 3.60GHz.  You might notice that the
factor between cycles(tsc) and ns is very close to 3.6.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


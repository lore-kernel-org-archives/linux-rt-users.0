Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3800C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A308A6113A
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhDIS5v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhDIS5v (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 14:57:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46FC061763;
        Fri,  9 Apr 2021 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ty1LGS3v38Chtaw1svPzlAmEjDpxvcnRksGoyQD0C+o=; b=dllxp3SIl7dJb2SWmtFHijzg05
        BMWCiqHMAwP4HIGF0KTqW8xzuklitWYigJdw70af2VurVYfGvC7Oxm2N2raBt/q53boGyBc7YtFNr
        8AJ3+yj8A3//tQz4Ef/5qaFW+VjQZcybr1RAOmVc/1cVU4jbdipfQjWS2Nok/eYyRSImo4LElQ4bV
        yifBHCzF1ZT+TFNmmDcUT/sw8pPkUQneDX0gLUrNG9eFz1kwz87nDBEauMz2d2WnZVP4U6XR0pVf4
        BnKVa8aQrBqviiX7uH2lUu0jO0ntht0Ii8YGU6z3b3t6GArBRGhx7VAjAYt90WlB/0VHg/tdBvekJ
        JoY5ctFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwI9-000nMk-Lg; Fri, 09 Apr 2021 18:55:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6AD730001B;
        Fri,  9 Apr 2021 20:55:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEDE52C49B0B8; Fri,  9 Apr 2021 20:55:39 +0200 (CEST)
Date:   Fri, 9 Apr 2021 20:55:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <YHCjK8OOhmxTbKu0@hirez.programming.kicks-ass.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
 <20210409075939.GJ3697@techsingularity.net>
 <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
 <20210409133256.GN3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409133256.GN3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 09, 2021 at 02:32:56PM +0100, Mel Gorman wrote:
> That said, there are some curious users already.
> fs/squashfs/decompressor_multi_percpu.c looks like it always uses the
> local_lock in CPU 0's per-cpu structure instead of stabilising a per-cpu
> pointer. 

I'm not sure how you read that.

You're talking about this:

  local_lock(&msblk->stream->lock);

right? Note that msblk->stream is a per-cpu pointer, so
&msblk->stream->lock is that same per-cpu pointer with an offset on.

The whole think relies on:

	&per_cpu_ptr(msblk->stream, cpu)->lock == per_cpu_ptr(&msblk->stream->lock, cpu)

Which is true because the lhs:

	(local_lock_t *)((msblk->stream + per_cpu_offset(cpu)) + offsetof(struct squashfs_stream, lock))

and the rhs:

	(local_lock_t *)((msblk->stream + offsetof(struct squashfs_stream, lock)) + per_cpu_offset(cpu))

are identical, because addition is associative.

> drivers/block/zram/zcomp.c appears to do the same although for
> at least one of the zcomp_stream_get() callers, the CPU is pinned for
> other reasons (bit spin lock held). I think it happens to work anyway
> but it's weird and I'm not a fan.

Same thing.

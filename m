Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76847C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F3D610C8
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 06:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhDIGoS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIGoS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 02:44:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFFC061760;
        Thu,  8 Apr 2021 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lNcDyfnAaDVyz40OLs8W9SQUkBFyn/zS9u4y9qrOz48=; b=LxMeQ6k8WthDPtYXuu4E0irPGY
        7Ar8Y4AF86u8heDiFDTN1+VMvsAi4j/qT/SU7BXXCIAn3qzzZasBvuMVGajAUrVoWxHKxjMMfjYht
        +6pnLIZeRofrEJmEDuTgDk3kIAOZK/S8EXfk4j1ZnNUzgsfy5BT4/RPwNoGho9hSEn7DKvMO/aUZB
        9T/a0YGP1hyTP709qleUG/EiV3sk3DUbxjli95g1G6DCCRPG9l/K1xeJXItxIODHBqAxxeqJYk6DO
        OH+6U8EBEllUbAfpLmKdjb+DRu3gLwzGda35IEcqaH3WgjZ5eohbqicuA2iMPPWUnJ1XsamyfP/Co
        LGthylxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUkny-00AJTb-NC; Fri, 09 Apr 2021 06:40:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47FAB30001B;
        Fri,  9 Apr 2021 08:39:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A51F20C8BCEB; Fri,  9 Apr 2021 08:39:45 +0200 (CEST)
Date:   Fri, 9 Apr 2021 08:39:45 +0200
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
Message-ID: <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408174244.GG3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 08, 2021 at 06:42:44PM +0100, Mel Gorman wrote:
> On Thu, Apr 08, 2021 at 12:52:07PM +0200, Peter Zijlstra wrote:
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index a68bacddcae0..e9e60d1a85d4 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -112,6 +112,13 @@ typedef int __bitwise fpi_t;
> > >  static DEFINE_MUTEX(pcp_batch_high_lock);
> > >  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
> > >  
> > > +struct pagesets {
> > > +	local_lock_t lock;
> > > +};
> > > +static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> > > +	.lock = INIT_LOCAL_LOCK(lock),
> > > +};
> > 
> > So why isn't the local_lock_t in struct per_cpu_pages ? That seems to be
> > the actual object that is protected by it and is already per-cpu.
> > 
> > Is that because you want to avoid the duplication across zones? Is that
> > worth the effort?
> 
> When I wrote the patch, the problem was that zone_pcp_reset freed the
> per_cpu_pages structure and it was "protected" by local_irq_save(). If
> that was converted to local_lock_irq then the structure containing the
> lock is freed before it is released which is obviously bad.
> 
> Much later when trying to make the allocator RT-safe in general, I realised
> that locking was broken and fixed it in patch 3 of this series. With that,
> the local_lock could potentially be embedded within per_cpu_pages safely
> at the end of this series.

Fair enough; I was just wondering why the obvious solution wasn't chosen
and neither changelog nor comment explain, so I had to ask :-)

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9FC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 08:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9118161002
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 08:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDIIZw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDIIZv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 04:25:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C61C061760;
        Fri,  9 Apr 2021 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=202l/8ec2GuA0yYlL8VYlkW1ikC/xFbRwp677ztTmrI=; b=vu0yr3dinpWHKRiVN6tLRNy8Wr
        e1KRO0UidkfKw1AL875vbYnBHFXCCDgU5flhr/lNEKtITFJ2CHja61VS3EtWNp1f8R94VbSBPO/Z6
        tijZcjtdRXmjKBQQemlMfaWCZDwsftTPXsvGrXZPTfFg09UxjtDPuENVT9Nn8Ez0sJuh3O25AXzR8
        Ow4soMPjO19XZAKJwaJNbgPx64GvExgNthSBEopQqVd1VSHsQ/JUKiAG0iYdB1pB/HS/bPSlM8mbj
        N0M7e3lSv8tpoa6YNwA8xlD3QP3JUFeIw+bHZM4Z0gj8UIkZpPkeNgWnpU+xX3eSjuYDIT9C9phBV
        pxFYZMVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUmRF-00034F-US; Fri, 09 Apr 2021 08:24:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 145F730001B;
        Fri,  9 Apr 2021 10:24:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDC032C232894; Fri,  9 Apr 2021 10:24:24 +0200 (CEST)
Date:   Fri, 9 Apr 2021 10:24:24 +0200
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
Message-ID: <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
 <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
 <20210408174244.GG3697@techsingularity.net>
 <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net>
 <20210409075939.GJ3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409075939.GJ3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 09, 2021 at 08:59:39AM +0100, Mel Gorman wrote:
> In the end I just gave up and kept it simple as there is no benefit to
> !PREEMPT_RT which just disables IRQs. Maybe it'll be worth considering when
> PREEMPT_RT is upstream and can be enabled. The series was functionally
> tested on the PREEMPT_RT tree by reverting the page_alloc.c patch and
> applies this series and all of its prerequisites on top.

Right, I see the problem. Fair enough; perhaps ammend the changelog to
include some of that so that we can 'remember' in a few months why the
code is 'funneh'.

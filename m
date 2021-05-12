Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09897C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CC961363
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhELNJR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhELNJQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 09:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670EC061574;
        Wed, 12 May 2021 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jTX4gzWKShL/XTiUmkd/o8USkf8u11UVE+IExZK6ITM=; b=gqshIcC+dyOecZ2JS/yexX1axc
        bwvY9yOEwFOz7uAw47CawsfFbuaoeAFnu9YI0X69rHsurpY7C/lyAt13vhHx2ca91DPGxEXyly1x9
        56w1DlWIocSRbWWFJUe0XZoxhZuGol5S4oh3NAtt8IlUXaviIXUMVqr/RrVvpjsL5myc6o7Gbrs+S
        EjTLvxCTeNsxSAD6lW/1tnQzUIuvDEXH14guOqf8hEGsLbqYZtNhzobMdxs4pO6SYsN6ZlIFsCmb6
        8/FELlmWM0uKYJUTo+E1+gP0vS9Gomf4jd3Ardij7VAmXjQ7dqdcReJPO/V8vRUkfWMwf/7rUOJPV
        ksqbhPWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoZM-008HuX-Qz; Wed, 12 May 2021 13:06:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ADC430026A;
        Wed, 12 May 2021 15:06:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5F8F286DD4FB; Wed, 12 May 2021 15:06:31 +0200 (CEST)
Date:   Wed, 12 May 2021 15:06:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9 v6] Use local_lock for pcp protection and reduce stat
 overhead
Message-ID: <YJvS17mXYukJEqJG@hirez.programming.kicks-ass.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 12, 2021 at 10:54:49AM +0100, Mel Gorman wrote:
> 
>  drivers/base/node.c    |  18 +--
>  include/linux/mmzone.h |  31 +++--
>  include/linux/vmstat.h |  65 ++++++-----
>  mm/mempolicy.c         |   2 +-
>  mm/page_alloc.c        | 255 ++++++++++++++++++++++++-----------------
>  mm/vmstat.c            | 246 +++++++++++++++++----------------------
>  6 files changed, 324 insertions(+), 293 deletions(-)

LGTM,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

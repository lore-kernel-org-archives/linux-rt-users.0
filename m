Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE3C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612B160FA0
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhIUWH0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhIUWHY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 18:07:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F9C061574;
        Tue, 21 Sep 2021 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/UjHBXWKbw/Bq/O4XA3P2t47w4xKmeiHWunwBQt2FI=; b=bFWwtBro5+TnqlxOVXw1Un4YD7
        wWIWFF2Di+S+8FjiQRvOB3x/FUpIpwjO84lkVb6kPN5gmfM6yQDwjTsd9Hdnvev4iHO/p+gn1RBz8
        CETK/G3cHnFpiEH3NYdv+Oe5xEGrbrmgAKXz/Hzgwo1ScfHUDfeXkRBspMOLHmaYvHrp358KxpCKA
        oxB9s8gFzSdQr9ewiOUIFTTnqdCCKBYgCBNIx+TQwOut9BzJvuMVI1Fsh1pyxeeGs15H08P/sbIPK
        kyF+xuwlVp3C7LB4GV7tBh/Y+jkcIpmLoSKw/hrkXMmFZUXOrxgOdJElf/wyyKtw/gAaURW+u1U2V
        NLiE4o2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSnrr-004Dui-2C; Tue, 21 Sep 2021 22:04:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2471F981483; Wed, 22 Sep 2021 00:03:58 +0200 (CEST)
Date:   Wed, 22 Sep 2021 00:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, juri.lelli@redhat.com,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com,
        mgorman@suse.de, ppandit@redhat.com, williams@redhat.com,
        bigeasy@linutronix.de, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache
 locking
Message-ID: <20210921220358.GN4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <20210921161323.607817-3-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921161323.607817-3-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 21, 2021 at 06:13:20PM +0200, Nicolas Saenz Julienne wrote:
> +static inline void lru_cache_lock(struct lru_cache_locks *locks)
> +{
> +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> +		/* Avoid migration between this_cpu_ptr() and spin_lock() */
> +		migrate_disable();
> +		spin_lock(this_cpu_ptr(&locks->spin));
> +	} else {
> +		local_lock(&locks->local);
> +	}
> +}

> +static inline void lru_cache_unlock(struct lru_cache_locks *locks)
> +{
> +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> +		spin_unlock(this_cpu_ptr(&locks->spin));
> +		migrate_enable();
> +	} else {
> +		local_unlock(&locks->local);
> +	}
> +}

*why* use migrate_disable(), that's horrible!

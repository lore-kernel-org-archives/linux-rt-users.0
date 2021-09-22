Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1202C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA01861131
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhIVL37 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhIVL36 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:29:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D5C061574;
        Wed, 22 Sep 2021 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7ZSl4YWEnGCJruUgFbe6upY9ZIlVKrfq0rf1wn9qT4=; b=bpBVu4IjgGl0Zdm/lkC2DT5zDD
        IhqLDeZhP/xM0SbN4iNNX7YYqL9GuSxmrTDAaLhFK27VashqlEnQ2VXBC0Lfp0Wvvl/sXmsnb+ugw
        hfyQjy61RtFfG2mwcw3i/dWbKC1UkAxey2W/3bolaSXZjkN3F9ND/B0R3rV6TCUDUV62Y4g2HW8jf
        Ul15D8IR+ZtAwEcVkNEQgKADdTCzvPqIUtyKaJLv1idSFLkeq5yAWbHuG0u/dsKc3qkHDieX7c50o
        UjFf2lfi2EK8du47kNWIO40f3sGcSmrix9/myZOWr7pqXuTWFlttdRQHMn7gt6+ROw3vY9bP5njv3
        YAM+81pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT0QE-004yj0-Li; Wed, 22 Sep 2021 11:28:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 493529816EA; Wed, 22 Sep 2021 13:28:17 +0200 (CEST)
Date:   Wed, 22 Sep 2021 13:28:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, juri.lelli@redhat.com,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com,
        mgorman@suse.de, ppandit@redhat.com, williams@redhat.com,
        bigeasy@linutronix.de, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
Message-ID: <20210922112817.GO4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 21, 2021 at 07:59:51PM +0200, Vlastimil Babka wrote:

> These days the pcplist protection is done by local_lock, which solved
> the RT concerns. Probably a stupid/infeasible idea, but maybe what you
> want to achieve could be more generally solved at the local_lock level?
> That on NOHZ_FULL CPUs, local_locks could have this mode where they
> could synchronize with remote cpus?

local_lock and spinlock have different rules, local_lock for example can
never cause an irq inversion, unlike a spinlock.

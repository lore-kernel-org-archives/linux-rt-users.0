Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1558C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEBF60EE7
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhIVLjP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhIVLjP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:39:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B43C061574;
        Wed, 22 Sep 2021 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RwsCAE+OHhIYLCRUvjot7FXo3qXO/fM/QdTY3eoicBE=; b=pJ542YUkBGcydIoTtqmd5NyNP/
        EusNxpYUYPclLz3WBCyHkVIrAxRjj1ZhyhZvgmcV1vVOGVLvBFb1sJ2nnPz9osrFFvmhH4nXGTSDc
        FJnSoeea20CodQVBmXGVBBmSFRcQVAmKEa0xkNzcxAuLbRmG4T4z0Vh/nXTwz6zlFnivqQaOvU3eR
        VY2yAhQhn96XWL+MwfqI1pbGVR9zb4VVQJ27oAQOJlwika0fNmTR2UfEnwxxueebX0eQMqnyH12qU
        cmtcjC/yYZ3zGgQHmlULgX8mOsHJ86oEvGNTo5xZsK/tBfoAVrPQ6LRWAJist4zXyNaPZCRDgJBvI
        h0722hNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT0ZF-004ynh-61; Wed, 22 Sep 2021 11:37:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9D879816EA; Wed, 22 Sep 2021 13:37:36 +0200 (CEST)
Date:   Wed, 22 Sep 2021 13:37:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     nsaenzju@redhat.com
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, juri.lelli@redhat.com,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com,
        mgorman@suse.de, ppandit@redhat.com, williams@redhat.com,
        bigeasy@linutronix.de, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache
 locking
Message-ID: <20210922113736.GP4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <20210921161323.607817-3-nsaenzju@redhat.com>
 <20210921220358.GN4323@worktop.programming.kicks-ass.net>
 <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 22, 2021 at 10:47:07AM +0200, nsaenzju@redhat.com wrote:
> On Wed, 2021-09-22 at 00:03 +0200, Peter Zijlstra wrote:
> > On Tue, Sep 21, 2021 at 06:13:20PM +0200, Nicolas Saenz Julienne wrote:
> > > +static inline void lru_cache_lock(struct lru_cache_locks *locks)
> > > +{
> > > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > > +		/* Avoid migration between this_cpu_ptr() and spin_lock() */
> > > +		migrate_disable();
> > > +		spin_lock(this_cpu_ptr(&locks->spin));
> > > +	} else {
> > > +		local_lock(&locks->local);
> > > +	}
> > > +}
> > 
> > > +static inline void lru_cache_unlock(struct lru_cache_locks *locks)
> > > +{
> > > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > > +		spin_unlock(this_cpu_ptr(&locks->spin));
> > > +		migrate_enable();
> > > +	} else {
> > > +		local_unlock(&locks->local);
> > > +	}
> > > +}
> > 
> > *why* use migrate_disable(), that's horrible!
> 
> I was trying to be mindful of RT. They don't appreciate people taking spinlocks
> just after having disabled preemption.
> 
> I think getting local_lock(&locks->local) is my only option then. But it adds
> an extra redundant spinlock in the RT+NOHZ_FULL case.

That doesn't make it less horrible. The fundamental problem you seem to
have is that you have to do the this_cpu thing multiple times.

If instead you make sure to only ever do the per-cpu deref *once* and
then make sure you use the same lru_rotate.pvec as you used
lru_rotate.locks, it all works out much nicer.

Then you can write things like:

	struct lru_rotate *lr = raw_cpu_ptr(&lru_rotate);

	frob_lock(&lr->locks);
	frob_pvec(&lr->pvec);
	frob_unlock(&lr->locks);

and it all no longer matters if you got this or that CPU's instance.

After all, you no longer rely on per-cpu ness for serialization but the
lock.

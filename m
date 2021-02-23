Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C66C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F6F64DE7
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 14:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhBWOWG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBWOWC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 09:22:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E1C061574;
        Tue, 23 Feb 2021 06:21:21 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:21:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614090080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teDU304o4orU9wi3x1wUaMwyYWDTSBXOaHNrx5ClT0w=;
        b=2ZFBXIkVYYN+nfCFMhN/kFjRVgHW8puY2SXmz4LEKGGgLUncGkXWOrZSwoCghFhYtR+0B+
        WtPmbg5RS4xdWq4hxg1404dlLYeX8B1nl0sqxT/iSdGPS8B9+EQX6bJrSz60txeX1elHLY
        UJuc7DdwyciRZtLdZ7N2eL0hXxoiKyZFSWSOa+CpigNZAQxC6YaEfZPpDLl4v/qWuEXt75
        hQJzYWVPVm0s4qW06fwuBPD49s1CfD4EOueDsOPESr9YTIyMw7koMtkWSNCgwafaW+0GHl
        qIGWtjJp/HvT7g0wY3dOI9iiT82sEd1QG7g7UFBrvA7otZ+CLf2L64NjiYndRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614090080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teDU304o4orU9wi3x1wUaMwyYWDTSBXOaHNrx5ClT0w=;
        b=4c33A1S2mV08nn7HeTxSpQILp2jnu0Nz6hii5AhOHt0Qbh5Zt3CCoH3QqXLLwQn84Nitl1
        HnqJztvf+r2WUzCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT v5.11-rt7] WARNING at include/linux/seqlock.h:271
 nft_counter_eval
Message-ID: <20210223142118.u22yhw3ku4ttx5hq@linutronix.de>
References: <YDTdo+jETVr983t6@localhost.localdomain>
 <20210223110015.ybl7feu43wvtjoqu@linutronix.de>
 <YDUI5M5FQLycOd33@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDUI5M5FQLycOd33@localhost.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-23 14:53:40 [+0100], Juri Lelli wrote:
> 
> So, I'm a bit confused and I'm very likely missing details (still
> digesting the seqprop_ magic), but write_seqcount_being() has
> 
>  if (seqprop_preemptible(s))
>      preempt_disable();
> 
> which in this case (no lock associated) is defined to return false, 
> while it should return true on RT (or in some occasions)? Or maybe this
> is what you are saying already.

write_seqcount_begin() has seqprop_assert() at the very beginning which
ends in __seqprop_assert() in your case (seqcount_t). Your warning.


> Also, the check for preemption been disabled happens before we can
> actually potentially disable it, no?

That seqprop_preemptible() is true for !RT for mutex/ww_mutex locks. On
RT it is always false since it does lock()+unlock() of the lock that is
part of the seqcount.

But back to the original issue: at write_seqcount_begin() preemption is
disabled !RT implicit by local_bh_disable(). Therefore no warning.
On RT local_bh_disable() disables BH on the CPUs so locking wise (since
it is a per-CPU seqcount it should work. Preemption remains enabled so
we have a warning.

I have no idea what annotation would be best here. Having a
local_bh_disable() type of a lock and the seqcount is not part of the data
structure it protects is less than ideal.
However, if I understand this correct then this nft_counter_percpu_priv
exists once per nft rule. The seqcount exists once per-CPU since it is
unlikely to modify two counters at once on a single CPU :) So there is
that.

While looking at it, there is nft_counter_reset() which modifies the
values without a seqcount write lock. This might be okay.

> Thanks for the quick reply!
> 
> Best,
> Juri

Sebastian

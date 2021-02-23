Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B5C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8424464DE9
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 14:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhBWOUu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBWOUr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 09:20:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C5C06174A;
        Tue, 23 Feb 2021 06:20:07 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:20:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614090004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzTN7zIIE4/8D9vTZDJiCxOd1/gCyd3XlCjlnumqjY0=;
        b=TcJLwYrYH2ngitGvAMieIsqEJBU3uQvxle0gB/TyAU4nQv+VjdZJZERTNGOb33iOUkfrYw
        9bxOaAl96IE04FaGdJSuaUniZkWFzVoEq9JOxaG0r+WI4TlObUf7EWu+hudQElgkias7AB
        eQa6m6hziHR06h/hJYKlVW6PPuPl0eaWHcdQg9vqhPwUFWoALqki2bww04Tv2gPsvi83ma
        5NSJNzTJTj+61q9Wexp7ck8fVUUq3bR0uAxtJa7ql6KB9efoSvjv6HjRy84V9w/wfwKUVB
        H+1/XOJYBzY7cXqd3PrcEz/BG/8OwLV8CEHs+Zawsu0RraA1qXwQprS75wV/2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614090004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzTN7zIIE4/8D9vTZDJiCxOd1/gCyd3XlCjlnumqjY0=;
        b=AVtug7zRAi97ZP1EOJb4Sdhlh28PpPwHz9v8+sk3UVvbFjN0sJ712qeNCCCnlFzL+uKC2a
        1E3HBwEwrbXyv6Dw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RT v5.11-rt7] WARNING at include/linux/seqlock.h:271
 nft_counter_eval
Message-ID: <YDUPEsdMAMWjmm8Z@lx-t490>
References: <YDTdo+jETVr983t6@localhost.localdomain>
 <20210223110015.ybl7feu43wvtjoqu@linutronix.de>
 <YDUI5M5FQLycOd33@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDUI5M5FQLycOd33@localhost.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Feb 23, 2021 at 02:53:40PM +0100, Juri Lelli wrote:
> On 23/02/21 12:00, Sebastian Andrzej Siewior wrote:
> > On 2021-02-23 11:49:07 [+0100], Juri Lelli wrote:
> > > Hi,
> > Hi,
> >
> > > I'm seeing the following splat right after boot (or during late boot
> > > phases) with v5.11-rt7 (LOCKDEP enabled).
> > …
> > > [   85.273588] WARNING: CPU: 5 PID: 1416 at include/linux/seqlock.h:271 nft_counter_eval+0x95/0x130 [nft_counter]
> > …
> > > [   85.273713] RIP: 0010:nft_counter_eval+0x95/0x130 [nft_counter]
> >
> > This is a per-CPU seqcount_t in net/netfilter/nft_counter.c which is
> > only protected by local_bh_disabled(). The warning expects preemption
> > to be disabled which is the case on !RT but not on RT.
> >
> > Not sure what to do about this. It is doing anything wrong as of now. It
> > is noisy.
>
> So, I'm a bit confused and I'm very likely missing details (still
> digesting the seqprop_ magic), but write_seqcount_being() has
>
>  if (seqprop_preemptible(s))
>      preempt_disable();
>
> which in this case (no lock associated) is defined to return false,

Preemption is disabled if and only if:

  1. It's a CONFIG_PREEMPT_RT=n system
  2. There's a lock associated with the sequence counter
  3. That lock is also preemptible (e.g., a mutex)

In your case, the 3 condititions are OFF. You're on a PREEMPT_RT=y
kernel and the sequence counter in question has no lock associated.

As Sebastian summarized, the error is just "noisy" at this point.

We will of course need to find a (mainline-friendly) way to let the
lockdep splat go away for -rt kernels. But for now, it's not harmful.

Good luck,

--
Ahmed S. Darwish

Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2BDC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E8361102
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbhHEVIk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 17:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241387AbhHEVIj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 17:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71EF260EBC;
        Thu,  5 Aug 2021 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628197704;
        bh=SRtaowijoG8twAxHHQPP1frqmBFYAiBOGw+39md1RVo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nHRGhN7ts/aOENkjY13K+SLhMIvNR351kTPTtkF6AnSvp5rr/ExKU5kckq0dKRbpY
         O6+vZb5T1E5OZ/iJVTPbClsqti5PgCkvIULQYEfLc0ffrXYE6czPD2xZPkOCzDu0SV
         ehNOYEfQBriqlXvRGwYghWT9mMTFacUzReWgtgHw1jGf1UAvE7bUBwx9WqPmgffoPa
         i9djO3u2yhnd6R7dbjnJz8WaI/kVG/o44IsEbL2vTumJaocbnWNIcQFwHTL6F6bm2b
         3+R3xcp+yWN5TVVD8yR9/UpOnGZCf9kcbEu5i/Sb0t0eoF37mJWDuGa9wfdujoTxhR
         9Ih14r7LrNMmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D48D5C271F; Thu,  5 Aug 2021 14:08:24 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:08:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <20210805210824.GA1203206@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 09:03:37AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 05, 2021 at 10:01:23AM +0200, Juri Lelli wrote:
> > Certain configurations (e.g., systems that make heavy use of netns)
> > need to use synchronize_rcu_expedited() to service RCU grace periods
> > even after boot.
> > 
> > Even though synchronize_rcu_expedited() has been traditionally
> > considered harmful for RT for the heavy use of IPIs, it is perfectly
> > usable under certain conditions (e.g. nohz_full).
> > 
> > Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
> > its default value to 1 (enabled) to avoid regressions. Users who need
> > synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
> > boot=0 in the kernel cmdline.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Makes sense to me!
> 
> But would another of the -rt people be willing to give an Acked-by?
> For example, maybe they would prefer this kernel boot parameter to be
> exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> situations where rcu_normal_after_boot makes sense?

Ah, and this will also need to be reflected in the WARN_ON_ONCE()
in synchronize_rcu_expedited_wait() in kernel/rcu/tree_exp.h.

							Thanx, Paul

> > ---
> >  kernel/rcu/update.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index c21b38cc25e9..0fdbf937edac 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -57,9 +57,7 @@
> >  module_param(rcu_expedited, int, 0);
> >  module_param(rcu_normal, int, 0);
> >  static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> > -#ifndef CONFIG_PREEMPT_RT
> >  module_param(rcu_normal_after_boot, int, 0);
> > -#endif
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> >  
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > -- 
> > 2.31.1
> > 

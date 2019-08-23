Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77980C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 03:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578C921744
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbfHWDX2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 23:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732939AbfHWDX2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 23:23:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA05D83F3C;
        Fri, 23 Aug 2019 03:23:27 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76FD45D784;
        Fri, 23 Aug 2019 03:23:24 +0000 (UTC)
Message-ID: <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Thu, 22 Aug 2019 22:23:23 -0500
In-Reply-To: <20190822133955.GA29841@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-2-swood@redhat.com>
         <20190821233358.GU28441@linux.ibm.com> <20190822133955.GA29841@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 23 Aug 2019 03:23:27 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-08-22 at 09:39 -0400, Joel Fernandes wrote:
> On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > ---
> > > Another question is whether non-raw spinlocks are intended to create
> > > an
> > > RCU read-side critical section due to implicit preempt disable.
> > 
> > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > consolidation?  If not, I don't see why they should do so after that
> > consolidation in -rt.
> 
> May be I am missing something, but I didn't see the connection between
> consolidation and this patch. AFAICS, this patch is so that
> rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?

Before consolidation, RT mapped rcu_read_lock_bh_held() to
rcu_read_lock_bh() and called rcu_read_lock() from rcu_read_lock_bh().  This
somehow got lost when rebasing on top of 5.0.

> > >  include/linux/rcupdate.h |  4 ++++
> > >  kernel/rcu/update.c      |  4 ++++
> > >  kernel/softirq.c         | 12 +++++++++---
> > >  3 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 388ace315f32..d6e357378732 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
> > >  static inline void rcu_read_lock_bh(void)
> > >  {
> > >  	local_bh_disable();
> > > +#ifndef CONFIG_PREEMPT_RT_FULL
> > >  	__acquire(RCU_BH);
> > >  	rcu_lock_acquire(&rcu_bh_lock_map);
> > >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > >  			 "rcu_read_lock_bh() used illegally while idle");
> > > +#endif
> > 
> > Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
> > We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
> > for lockdep-enabled -rt kernels, right?
> 
> Since this function is small, I prefer if -rt defines their own
> rcu_read_lock_bh() which just does the local_bh_disable(). That would be
> way
> cleaner IMO. IIRC, -rt does similar things for spinlocks, but it has been
> sometime since I look at the -rt patchset.

I'll do it whichever way you all decide, though I'm not sure I agree about
it being cleaner (especially while RT is still out-of-tree and a change to
the non-RT version that fails to trigger a merge conflict is a concern).

What about moving everything but the local_bh_disable into a separate
function called from rcu_read_lock_bh, and making that a no-op on RT?

> > >  
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index 016c66a98292..a9cdf3d562bc 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -296,7 +296,11 @@ int rcu_read_lock_bh_held(void)
> > >  		return 0;
> > >  	if (!rcu_lockdep_current_cpu_online())
> > >  		return 0;
> > > +#ifdef CONFIG_PREEMPT_RT_FULL
> > > +	return lock_is_held(&rcu_lock_map) || irqs_disabled();
> > > +#else
> > >  	return in_softirq() || irqs_disabled();
> > > +#endif
> > 
> > And globally.
> 
> And could be untangled a bit as well:
> 
> if (irqs_disabled())
> 	return 1;
> 
> if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> 	return lock_is_held(&rcu_lock_map);
> 
> return in_softirq();

OK.

-Scott



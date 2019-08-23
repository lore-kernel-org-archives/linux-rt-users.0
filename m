Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88991C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596C923402
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfHWCg0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbfHWCgZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 22:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 901B718C4271;
        Fri, 23 Aug 2019 02:36:25 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B026D600CD;
        Fri, 23 Aug 2019 02:36:21 +0000 (UTC)
Message-ID: <2981acb99554a80211118350975577ab8faa3a2d.camel@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Thu, 22 Aug 2019 21:36:21 -0500
In-Reply-To: <20190821233358.GU28441@linux.ibm.com>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-2-swood@redhat.com>
         <20190821233358.GU28441@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 23 Aug 2019 02:36:25 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2019-08-21 at 16:33 -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 388ace315f32..d6e357378732 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
> >  static inline void rcu_read_lock_bh(void)
> >  {
> >  	local_bh_disable();
> > +#ifndef CONFIG_PREEMPT_RT_FULL
> >  	__acquire(RCU_BH);
> >  	rcu_lock_acquire(&rcu_bh_lock_map);
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> >  			 "rcu_read_lock_bh() used illegally while idle");
> > +#endif
> 
> Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
> We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
> for lockdep-enabled -rt kernels, right?

OK.

> > @@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip,
> > > > unsigned int cnt)
> >  	WARN_ON_ONCE(count < 0);
> >  	local_irq_enable();
> >  
> > -	if (!in_atomic())
> > +	if (!in_atomic()) {
> > +		rcu_read_unlock();
> >  		local_unlock(bh_lock);
> > +	}
> 
> The return from in_atomic() is guaranteed to be the same at
> local_bh_enable() time as was at the call to the corresponding
> local_bh_disable()?

That's an existing requirement on RT (which rcutorture currently violates)
due to bh_lock.

> I could have sworn that I ran afoul of this last year.  Might these
> added rcu_read_lock() and rcu_read_unlock() calls need to check for
> CONFIG_PREEMPT_RT_FULL?

This code is already under a PREEMPT_RT_FULL ifdef.

-Scott



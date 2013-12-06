From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] read_lock migrate_disable pushdown to rt_read_lock
Date: Fri, 6 Dec 2013 10:25:32 -0500
Message-ID: <20131206102532.712d4ae4@gandalf.local.home>
References: <20131205234449.GF15603@opentech.at>
	<20131205211951.5c2eaa0f@gandalf.local.home>
	<20131206023334.GA26623@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:36802 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751030Ab3LFPZh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Dec 2013 10:25:37 -0500
In-Reply-To: <20131206023334.GA26623@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Dec 2013 03:33:34 +0100
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> > > -	migrate_disable();
> > >  	if (rt_mutex_owner(lock) != current) {
> > >  		ret = rt_mutex_trylock(lock);
> > > -		if (ret)
> > > +		if (ret) {
> > > +			migrate_disable();
> > >  			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
> > > +		}
> > 
> > I like this patch in general, but I'm nervous about this part.
> > 
> > What was the original reason to disable migration before checking the
> > mutex owner? Seems like we should have only disabled it on success. I'm
> > assuming there was some subtle reason not to.
> >
> 
> I think that it was simply being treated semantically as a lock - but it
> is actually not.
>                        hold a
>  migrate_disable/lock  per_cpu  unlock/migrate_enable
>  lock/migrate_disable  per_cpu  migrate_enable/unlcok
>  lock/migrate_disable  per_cpu  unlock/migrate_enable
>  migrate_disable/lock  per_cpu  migrate_enable/unlcok
>                        reference
> 
> are all equivalent - the only thing you need to ensure that the per cpu 
> object will not be accessed before both lock and migration_disable have
> been sucessful. So from my understanding this is safe.

I think you may be right, but I'm still a little nervous about this
code. But that's good. We all should be nervous about any locking
code ;-)

> 
> if we get migrated after a succesful trylock what would go wrong ?
> the protected object will not be accessed until after the spin_trylock
> returned so migration is disabled

I agree.

> 
> > If there was some strange reason, I'm not convinced that your change
> > makes that reason go away.
> >
> IF there is a reason then this patch is broken - my conclusion up to now
> is that there is no such reason.
> 

Let me analyze the original code first. I'll poke peterz and tglx too
to make sure this modification is OK.

Thanks,

-- Steve

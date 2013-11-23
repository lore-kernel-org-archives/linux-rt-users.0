From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] allow preemption in recursive migrate_disable call
Date: Sat, 23 Nov 2013 06:19:25 +0100
Message-ID: <20131123051925.GA9730@opentech.at>
References: <20131120003333.GA13545@opentech.at> <20131121101913.GZ10022@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:56604 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab3KWFT1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Nov 2013 00:19:27 -0500
Content-Disposition: inline
In-Reply-To: <20131121101913.GZ10022@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Nov 2013, Peter Zijlstra wrote:

> On Wed, Nov 20, 2013 at 01:33:33AM +0100, Nicholas Mc Guire wrote:
> > From a7259c360b6c8b873f5fcf6d5eed0ae78534a6c5 Mon Sep 17 00:00:00 2001
> > From: Nicholas Mc Guire <der.herr@hofr.at>
> > Date: Wed, 20 Nov 2013 07:22:09 +0800
> > Subject: [PATCH] allow preemption in recursive migrate_disable call
> > 
> >  Minor cleanup in migrate_disable/migrate_enable. The recursive case
> >  does not need to disable preemption as it is "pinned" to the current
> >  cpu any way so it is safe to preempt it.
> > 
> >  No functional change to migrate_disable/enable
> > 
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > ---
> >  kernel/sched/core.c |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a7fafc28..22fa2e2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2418,13 +2418,12 @@ void migrate_disable(void)
> >  	}
> >  #endif
> >  
> > -	preempt_disable();
> >  	if (p->migrate_disable) {
> >  		p->migrate_disable++;
> > -		preempt_enable();
> >  		return;
> >  	}
> >  
> > +	preempt_disable();
> >  	preempt_lazy_disable();
> >  	pin_current_cpu();
> >  	p->migrate_disable = 1;
> > @@ -2454,13 +2453,12 @@ void migrate_enable(void)
> >  #endif
> >  	WARN_ON_ONCE(p->migrate_disable <= 0);
> >  
> > -	preempt_disable();
> >  	if (migrate_disable_count(p) > 1) {
> >  		p->migrate_disable--;
> > -		preempt_enable();
> >  		return;
> >  	}
> >  
> > +	preempt_disable();
> >  	if (unlikely(migrate_disabled_updated(p))) {
> >  		/*
> >  		 * Undo whatever update_migrate_disable() did, also see there
> 
> Is there a reason one uses p->migrate_disable and the other uses
> migrate_disable_count(p) ? 
>
in the update case incrementting is fine with or without 
MIGRATE_DISABLE_SET_AFFIN set, in the migrate_enable case though
if the nesting level were actuall 1 and MIGRATE_DISABLE_SET_AFFIN were set
we would end up in the wrong branch (1<<30)+1 > 1.

thx!
hofrat

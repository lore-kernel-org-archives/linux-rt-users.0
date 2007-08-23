From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Thu, 23 Aug 2007 17:51:05 +0200
Message-ID: <20070823155105.GA29405@elte.hu>
References: <20070817003751.GN3954@unix.sh> <1187883233.1453.60.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:43773 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764762AbXHWPvV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Aug 2007 11:51:21 -0400
Content-Disposition: inline
In-Reply-To: <1187883233.1453.60.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> On Thu, 2007-08-16 at 21:37 -0300, Luis Claudio R. Goncalves wrote:
> > Hello,
> > 
> > The values in /proc/loadavgrt are sometimes the real load and sometimes
> > garbage. As you can see in th tests below, it occurs from in 2.6.21.5-rt20 
> > to 2.6.23-rc2-rt2. The code for calc_load(), in kernel/timer.c has not
> > changed much in -rt patches.
> 
> > 
> > Signed-off-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
> > ---
> > 
> > diff --git a/kernel/sched.c b/kernel/sched.c
> > index 811a502..c61609a 100644
> > --- a/kernel/sched.c
> > +++ b/kernel/sched.c
> > @@ -2520,6 +2520,13 @@ unsigned long rt_nr_uninterruptible(void)
> >  	for_each_online_cpu(i)
> >  		sum += cpu_rq(i)->rt_nr_uninterruptible;
> >  
> > +	/*
> > +	 * Since we read the counters lockless, it might be slightly
> > +	 * inaccurate. Do not allow it to go below zero though:
> > +	 */
> > +	if (unlikely((long)sum < 0))
> > +		sum = 0;
> > +
> >  	return sum;
> >  }
> >  
> > diff --git a/linux-2.6.21.x86_64/kernel/timer.c b/linux-2.6.21.x86_64_lc/kernel/timer.c
> > index 882ca9d..0e49bf6 100644
> > --- a/linux-2.6.21.x86_64/kernel/timer.c
> > +++ b/linux-2.6.21.x86_64_lc/kernel/timer.c
> > @@ -1432,23 +1432,25 @@ unsigned long avenrun_rt[3];
> >  static inline void calc_load(unsigned long ticks)
> >  {
> >  	unsigned long active_tasks; /* fixed-point */
> > +	unsigned long active_rt_tasks; /* fixed-point */
> >  	static int count = LOAD_FREQ;
> >  
> >  	count -= ticks;
> >  	if (unlikely(count < 0)) {
> >  		active_tasks = count_active_tasks();
> > +		active_rt_tasks = count_active_rt_tasks();
> 
> Where is this used?

what is "this"? /proc/loadavg? Or the code/patch you quoted?

	Ingo

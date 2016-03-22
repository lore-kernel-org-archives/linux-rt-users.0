From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 3/3] cyclictest: initialize 'stop' early
Date: Tue, 22 Mar 2016 10:59:53 -0400
Message-ID: <20160322105953.1b50ca8f@redhat.com>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
	<1458239345-30892-4-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603221553550.10687@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbcCVO75 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:59:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id B198846217
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 14:59:56 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603221553550.10687@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 Mar 2016 15:55:10 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Thu, 17 Mar 2016, Luiz Capitulino wrote:
> 
> > For some modes like MODE_CLOCK_NANOSLEEP, the clock
> > is already ticking when 'stop' is initialized. This
> > shouldn't matter, as this memset() should very fast
> > (I'd guess a few dozens or hundrends nanoseconds at
> > most?), but I also think there's no reason to do it
> > this late. So, initialize it along with everything
> > else.
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index f5a67dc..202939f 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -829,6 +829,8 @@ static void *timerthread(void *param)
> >  		tspec.it_interval = interval;
> >  	}
> >  
> > +	memset(&stop, 0, sizeof(stop));
> > +
> >  	memset(&schedp, 0, sizeof(schedp));
> >  	schedp.sched_priority = par->prio;
> >  	if (setscheduler(0, par->policy, &schedp))
> > @@ -868,10 +870,10 @@ static void *timerthread(void *param)
> >  	tsnorm(&next);
> >  
> >  	if (duration) {
> > -		memset(&stop, 0, sizeof(stop)); /* grrr */
> >  		stop = now;
> >  		stop.tv_sec += duration;
> >  	}
> > +
> >  	if (par->mode == MODE_CYCLIC) {
> >  		if (par->timermode == TIMER_ABSTIME)
> >  			tspec.it_value = next;
> > -- 
> > 2.1.0
> > 
> > --
> 
> Not sure about this one. It might be okay, but it certainly
> makes the code messier. Is this just a theorectical possibility
> or do you have some evidence that this is a problem?
> 
> I think I'll skip it for now unless you can show that it's a
> real problem.

It's not a problem. Personally, I think it's a good practice
to do all the initialization before the clock starts ticking,
but that doesn't mean that we have a problem with that memset.

From: Philipp Schrader <philipp@peloton-tech.com>
Subject: Re: RCU splat on boot from an idle CPU
Date: Thu, 3 Sep 2015 09:55:46 -0700
Message-ID: <20150903165411.GA25462@philipp-debian.peloton-tech.com>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
 <alpine.DEB.2.11.1509011721510.15006@nanos>
 <20150902153823.749a9f73@gandalf.local.home>
 <CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
 <20150902230729.GZ4029@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36688 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbICQzu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2015 12:55:50 -0400
Received: by pacwi10 with SMTP id wi10so51935736pac.3
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2015 09:55:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150902230729.GZ4029@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 02, 2015 at 04:07:29PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 02, 2015 at 03:10:04PM -0700, Philipp Schrader wrote:
> > I've got the following patch now that makes the splat disappear:
> > 
> > diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> > index aaade2e..d0e1d0e 100644
> > --- a/kernel/trace/trace_irqsoff.c
> > +++ b/kernel/trace/trace_irqsoff.c
> > @@ -450,7 +450,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
> >  #ifdef CONFIG_PROVE_LOCKING
> >  void time_hardirqs_on(unsigned long a0, unsigned long a1)
> >  {
> > -       trace_preemptirqsoff_hist(IRQS_ON, 0);
> > +       trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
> >         if (!preempt_trace() && irq_trace())
> >                 stop_critical_timing(a0, a1);
> >  }
> > @@ -459,7 +459,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
> >  {
> >         if (!preempt_trace() && irq_trace())
> >                 start_critical_timing(a0, a1);
> > -       trace_preemptirqsoff_hist(IRQS_OFF, 1);
> > +       trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
> >  }
> > 
> >  #else /* !CONFIG_PROVE_LOCKING */
> > 
> > Does that look reasonable?
> > Or could this cause a problem down the road?
> 
> Looks good to me!

Should I submit a patch for this or is this just a fix for my particular kernel
configuration? I don't yet understand the code well enough to know the answer.
Thanks,
Philipp

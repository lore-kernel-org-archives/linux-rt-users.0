From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [SOLVED, RFC] Re: hrtimer problem on AT91RM9200
Date: Tue, 15 Sep 2009 17:29:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909151716450.8957@localhost.localdomain>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de>
 <20090911230735.GA23652@pengutronix.de> <4AAE1FF8.90007@newtec.dk> <20090914111020.GA2901@pengutronix.de> <20090915092934.GA2717@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1780779744-1253028559=:8957"
Cc: Bo Hansen <bh@newtec.dk>, john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46670 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbZIOP31 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2009 11:29:27 -0400
In-Reply-To: <20090915092934.GA2717@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1780779744-1253028559=:8957
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Sep 2009, Uwe Kleine-König wrote:
> Hello,
> 
> I'm able to reproduce this now.  The problem is really that
> hrtimer_interrupt() tries to program the next timer event which fails 4
> times in a row, because the expiry time is already in the past when
> tick_dev_program_event is called.  This happens because there are so
> much timers with small expiry times. (cyclictest -t40 on an UP machine)

Pretty much the case which triggers the hang mechanism.

> Addionally the fourth interation was short (probably because then there
> were no expired timers to check for) and so the try_time argument to
> hrtimer_interrupt_hanging was small and so min_delta_ns was decreased
> instead of increased.

He, what is decreasing min_delta_ns ? There is no such code.
 
> I wonder why increasing min_delta_ns is supposed to fix something here.
> Actually some pressure that results in hrtimer_interrupt_hanging being
> called can always happen independently of min_delta_ns' value.

It ensures that the timer interrupts are delayed sufficiently that
something else than the timer interrupt has a chance to get on the
CPU.

> And moreover, is it sensible to change the value of
> force_clock_reprogram?  This makes the system harder to benchmark,
> because to guarantee a certain latency now you have to check both
> situations force_clock_reprogram==1 and force_clock_reprogram==0.
> 
> My suggestion is to do the following:
>   - fix hrtimer_interrupt_hanging not to decrease min_delta_ns

It does not decrease anything, so what's to fix there ?

>   - in clockevents_program_event instead of
> 	if (delta <= 0)
> 		return -ETIME;
>     do
> 	if (delta <= -dev->min_delta_ns)
> 		return -ETIME;
> 
>     I'm not sure though if -dev->min_delta_ns is the right value or if
>     that is a good idea at all.

You might expire timers early, which is wrong.

Thanks,

	tglx
--8323328-1780779744-1253028559=:8957--

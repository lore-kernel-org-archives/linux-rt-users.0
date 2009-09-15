From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [SOLVED, RFC] Re: hrtimer problem on AT91RM9200
Date: Tue, 15 Sep 2009 21:06:57 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909152059310.8957@localhost.localdomain>
References: <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de> <20090911230735.GA23652@pengutronix.de> <4AAE1FF8.90007@newtec.dk>
 <20090914111020.GA2901@pengutronix.de> <20090915092934.GA2717@pengutronix.de> <alpine.LFD.2.00.0909151716450.8957@localhost.localdomain> <20090915184003.GA19766@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1964759858-1253041618=:8957"
Cc: Bo Hansen <bh@newtec.dk>, john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38275 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbZIOTHF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2009 15:07:05 -0400
In-Reply-To: <20090915184003.GA19766@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1964759858-1253041618=:8957
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Sep 2009, Uwe Kleine-König wrote:
> On Tue, Sep 15, 2009 at 05:29:17PM +0200, Thomas Gleixner wrote:
> > He, what is decreasing min_delta_ns ? There is no such code.
> hrtimer_interrupt_hanging() can decrease min_delta_ns.
> 
> Look at Bo's reports: min_delta_ns is initially 61036 and he gets
> 
> 	hrtimer: interrupt too slow, forcing clock min delta to 52482 ns

So the problem is that min delta is too small due to an unhandled
32bit overflow.

But that's not a decrease by any means. It's simply an 32bit overflow
bug which needs to be fixed.
 
> > It ensures that the timer interrupts are delayed sufficiently that
> > something else than the timer interrupt has a chance to get on the
> > CPU.
> Hhhhm, doesn't destroy that any upper bound for latency.  If a process
> succeeds to install many timers that expire one after another with a
> short delta in between min_delta_ns goes up.  This in turn mean that
> even high priority processes loose the ability to sleep a short period.

Yes, we know that already and it's on the list of things which need to
be solved.
  
Thanks,

	tglx
--8323328-1964759858-1253041618=:8957--

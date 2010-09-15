From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 15:33:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1009151520000.2416@localhost6.localdomain6>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su> <4C8F8B79.1010300@theptrgroup.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeff Angielski <jeff@theptrgroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41100 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab0IONdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 09:33:43 -0400
In-Reply-To: <4C8F8B79.1010300@theptrgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

B1;2401;0cOn Tue, 14 Sep 2010, Jeff Angielski wrote:

> On 09/14/2010 10:30 AM, Nikita V. Youshchenko wrote:
> > > > > anyone can say preempt rt is hard real time?
> > > > 
> > > > Hard realtime has something to do with how you define "missing the
> > > > deadline". If somebody cuts the cable of your roboter controller in
> > > > the factory hall, the system misses the deadline. So it is all about
> > > > probabilities: hard realtime systems have a very, very low probability
> > > > of missing the deadline. However, in real life systems, it is>   0%.
> > > > 
> > > > So yes, if you talk about real world, it is hard realtime.
> > > 
> > > No.  Preempt rt it's not hard realtime.
> > > 
> > > But most people/companies who think they need hard realtime really
> > > don't.  They can live with soft realtime and have a really low
> > > probability of missing deadlines and having long latencies.  For these
> > > people, the preempt rt is adequate.
> > 
> > Isn't any case where preempt-rt does not behave as hard reatlime a bug in
> > preempt-rt, that should be reported to this list and eventually fixed?
> 
> That is a philosophical question for the preempt-rt maintainers.
> 
> I *believe* that the design goal for the preempt rt code is to minimize kernel
> latency.  It's not to make the kernel deterministic to support hard realtime.

The design goal is deterministic behaviour. Not more, not less.

And yes, we aim for hard realtime - as hard as it gets given the
circumstances and for the vast majority of applications.

We do _NOT_ aim for

   - a system which provides mathematical prove of it's correctness
     simply because that's not feasible.

     I know that the purists will answer that such a system can't be
     hard real-time by definition, but I can live with that. :)

   - the extreme corner cases where response time guarantees in the
     single digit microseconds range are required. Simply because we
     run on hardware which has already builtin latencies (not
     controlable by the OS) in the two digits microseconds range.

> So I don't know if I'd call it a bug, but rather on the wish list for future
> enhancements.

If there is non deterministic behaviour, it's a bug which should be
reported and fixed.

Thanks,

	tglx

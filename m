From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Mon, 12 Sep 2011 10:05:33 +0200
Message-ID: <1315814733.21927.16.camel@marge.simson.net>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315764876.6352.61.camel@marge.simson.net>
	 <alpine.LFD.2.02.1109120924540.2723@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:33703 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751967Ab1ILIFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Sep 2011 04:05:37 -0400
In-Reply-To: <alpine.LFD.2.02.1109120924540.2723@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-09-12 at 09:33 +0200, Thomas Gleixner wrote:
> On Sun, 11 Sep 2011, Mike Galbraith wrote:
> 
> > I'm very definitely missing sirq threads from the wakeup latency POV.
> > 
> > (Other things are muddying the water, eg. rcu boost, if wired up and
> > selected always ramming boosted threads through the roof instead of
> > configured boost prio.. etc etc, but this definitely improves my latency
> > woes a lot)
> > 
> > This is a giant step backward from "let's improve abysmal throughput",
> > so I'm wondering if anyone has better ideas.
> 
> One of the problems we have are the signal based timers (posix-timer,
> itimer).

That's the biggest part of my jitter troubles.

>  We really want to move the penalty for those into the context
> of the thread/process to which those timers belong. The trick is to
> just note the expiry of a timer and wake up the target which has to
> deal with the real work in his own context and on his own
> account. That's rather simple for thread bound signals, but has a lot
> of implications with process wide ones. Though it should be doable and
> I'd rather see that solved than hacking around with the split softirqs

That definitely sounds like a better idea.. for someone who thoroughly
understands signals.
 
> > WRT below: "fixes" are dinky, this is not...
> > 
> > sched, rt, sirq: resurrect sirq threads for RT_FULL
> > 
> > Not-signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> Not-that-delighted: tglx

Ditto.

	-Mike


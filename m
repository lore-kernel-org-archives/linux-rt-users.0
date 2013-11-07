From: Mike Galbraith <bitbucket@online.de>
Subject: Re: CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo
Date: Thu, 07 Nov 2013 04:26:39 +0100
Message-ID: <1383794799.5441.16.camel@marge.simpson.net>
References: <1383228427.5272.36.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1311061842160.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1311061842160.23353@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-11-06 at 18:49 +0100, Thomas Gleixner wrote: 
> On Thu, 31 Oct 2013, Mike Galbraith wrote:
> 
> > Hi Frederic,
> > 
> > The tick wakes ksoftirqd, ensuring nr_running test ain't gonna happen
> > when an otherwise lonely task takes the timer interrupt.  Deferring to
> > softirq processing time..... works.
> 
> -ENOPARSE
> 
> What the heck is this patch doing aside of slapping #ifdeffery all
> over the place?

It ain't a patch, it's a diagnostic.

> I bet you are trying to work around some of the side effects of the
> occasional tick which is still necessary despite of full nohz, right?

Nope, I wanted to check out cost of nohz_full for rt, and found that it
doesn't work at all instead, looked, and found that the sole running
task has just awakened ksoftirqd when it wants to shut the tick down, so
that shutdown never happens. 

> Bah, we want to solve the underlying problems and get rid of the tick
> completely instead of hiding the issues by magic hackery.

That's why I mentioned it.  That ".... works" has a whooooole different
meaning than "this is the fix" :)

-Mike

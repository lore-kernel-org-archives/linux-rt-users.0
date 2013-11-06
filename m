From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo
Date: Wed, 6 Nov 2013 18:49:41 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311061842160.23353@ionos.tec.linutronix.de>
References: <1383228427.5272.36.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383228427.5272.36.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 31 Oct 2013, Mike Galbraith wrote:

> Hi Frederic,
> 
> The tick wakes ksoftirqd, ensuring nr_running test ain't gonna happen
> when an otherwise lonely task takes the timer interrupt.  Deferring to
> softirq processing time..... works.

-ENOPARSE

What the heck is this patch doing aside of slapping #ifdeffery all
over the place?

I bet you are trying to work around some of the side effects of the
occasional tick which is still necessary despite of full nohz, right?

Bah, we want to solve the underlying problems and get rid of the tick
completely instead of hiding the issues by magic hackery.
 
Thanks,

	tglx

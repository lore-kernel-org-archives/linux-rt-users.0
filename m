From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.1-rt11
Date: Wed, 17 Aug 2011 06:28:52 +0200
Message-ID: <1313555332.5605.7.camel@marge.simson.net>
References: <1313232790.25267.7.camel@twins>
	 <1313236135.4486.10.camel@marge.simson.net>
	 <1313236713.25267.10.camel@twins>
	 <1313243965.4486.36.camel@marge.simson.net>
	 <20110813162735.GA2650@linux.vnet.ibm.com>
	 <1313295821.6334.5.camel@marge.simson.net> <4E4A7BE3.5090902@us.ibm.com>
	 <1313507408.6321.4.camel@marge.simson.net>
	 <20110816193128.GE2404@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36025 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750959Ab1HQE25 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2011 00:28:57 -0400
In-Reply-To: <20110816193128.GE2404@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-08-16 at 12:31 -0700, Paul E. McKenney wrote:
> On Tue, Aug 16, 2011 at 05:10:08PM +0200, Mike Galbraith wrote:
> > On Tue, 2011-08-16 at 07:17 -0700, Nivedita Singhvi wrote:
> > 
> > > Mike,
> > > 
> > > Which test were you running? Because I'm not seeing it
> > > on our x3550 M3..
> > 
> > -rt11 did not trip up just idling along like a couple earlier releases
> > did, but did stall when I tried to run ltp realtime testcases.
> 
> But please note that if your realtime workload is CPU-bound with prio
> greater than that of RCU_SOFTIRQ, stalls would be expected.

The (broken) jitter testcase runs two threads, an interrupter thread at
prio 80, and a worker at 10.  Both sleep.  I just ran the testcase
standalone, and no stall happened, so perhaps something from an earlier
testcase got stuck.. or something.

I'll try maxing out boost, and see what happens.  It was set to 50.

	-Mike


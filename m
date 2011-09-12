From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Mon, 12 Sep 2011 09:33:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109120924540.2723@ionos>
References: <alpine.LFD.2.02.1109101052340.2723@ionos> <1315764876.6352.61.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60077 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab1ILHdl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Sep 2011 03:33:41 -0400
In-Reply-To: <1315764876.6352.61.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 11 Sep 2011, Mike Galbraith wrote:

> I'm very definitely missing sirq threads from the wakeup latency POV.
> 
> (Other things are muddying the water, eg. rcu boost, if wired up and
> selected always ramming boosted threads through the roof instead of
> configured boost prio.. etc etc, but this definitely improves my latency
> woes a lot)
> 
> This is a giant step backward from "let's improve abysmal throughput",
> so I'm wondering if anyone has better ideas.

One of the problems we have are the signal based timers (posix-timer,
itimer). We really want to move the penalty for those into the context
of the thread/process to which those timers belong. The trick is to
just note the expiry of a timer and wake up the target which has to
deal with the real work in his own context and on his own
account. That's rather simple for thread bound signals, but has a lot
of implications with process wide ones. Though it should be doable and
I'd rather see that solved than hacking around with the split softirqs
 
> WRT below: "fixes" are dinky, this is not...
> 
> sched, rt, sirq: resurrect sirq threads for RT_FULL
> 
> Not-signed-off-by: Mike Galbraith <efault@gmx.de>

Not-that-delighted: tglx

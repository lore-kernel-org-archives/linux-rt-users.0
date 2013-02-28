From: Mike Galbraith <bitbucket@online.de>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Thu, 28 Feb 2013 06:59:33 +0100
Message-ID: <1362031173.4460.87.camel@marge.simpson.net>
References: <1361551010.32441.50.camel@marge.simpson.net>
	 <1361907944.11373.57.camel@gandalf.local.home>
	 <1361938754.4599.88.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58791 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab3B1F7o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Feb 2013 00:59:44 -0500
In-Reply-To: <1361938754.4599.88.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2013-02-27 at 05:19 +0100, Mike Galbraith wrote: 
> On Tue, 2013-02-26 at 14:45 -0500, Steven Rostedt wrote: 

> > I would be interested in seeing what happens if we just made rt_tasks
> > spin instead of sleep (call yield). Actually, if we made real-time tasks
> > always spin (never sleep), just yield, if this would give us much better
> > performance.
> 
> Maybe you can get that working without the requeueing  Without it being
> a global head -> tail -> head thing, my big box died and died and.. 

As noted, prior to global queue to head, I made dead box.. a lot.

However, yesterday I had to hunt down a localhost throughput regression
in 3.0.65 (794ed393) anyway, and I used the opportunity to do a little
concurrent tinkering...

With SCHED_OTHER brain-o fixed up, as mentioned, -rt beat its NOPREEMPT
parent tree at hefty tbench throughput.  This morning, I tried real rt
spinning again, only yielding when mandatory.  With global queue to head
in place, no silent box syndrome happened, worked fine.  That should
mean that across the box contention induced jitter can shrink by sched
cost * players, no?

Maybe with some refinement, experiment will work out.

Longish jitter test just finished, though worst case doesn't look any
better (darn), it doesn't look any worse either, so I'll poke send.

(hm, maybe if I avoid pounding raw lock through the floor...)

-Mike


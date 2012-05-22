From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 22 May 2012 19:07:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205221906250.3231@ionos>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>   <alpine.LFD.2.02.1205221553400.3231@ionos>  <1337701801.13348.56.camel@gandalf.stny.rr.com>  <alpine.LFD.2.02.1205221803290.3231@ionos> <1337705539.13348.81.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39404 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2EVRHt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 May 2012 13:07:49 -0400
In-Reply-To: <1337705539.13348.81.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 May 2012, Steven Rostedt wrote:

> On Tue, 2012-05-22 at 18:40 +0200, Thomas Gleixner wrote:
> 
> > > I'm all for benchmarks. But right now, making all readers pass through a
> > > single mutex is a huge bottle neck for a lot of loads. Yes, they are
> > > mostly Java loads, but for some strange reason, our customers seems to
> > > like to run Java on our RT kernel :-p
> > 
> > I'm well aware that mmap_sem is a PITA but replacing one nightmare
> > with the next one is not the best approach.
> 
> Perhaps we could just change the mmap_sem to use this approach. Create a
> new type of rwsem/lock for -rt that we can be picky about.
> 
> Yeah, mmap_sem is a real PITA and it would be nice to have a solution
> that can be used until we can convert it to an RCU lock.

That still wants to be verified with numbers on a machine with at
least 32 cores and workloads which are mmap heavy. And before we don't
have such numbers we can really stop arguing about that solution.

Thanks,

	tglx

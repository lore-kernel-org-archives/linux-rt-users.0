From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 22 May 2012 12:52:19 -0400
Message-ID: <1337705539.13348.81.camel@gandalf.stny.rr.com>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
	  <alpine.LFD.2.02.1205221553400.3231@ionos>
	 <1337701801.13348.56.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1205221803290.3231@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31576 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab2EVQwV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 May 2012 12:52:21 -0400
In-Reply-To: <alpine.LFD.2.02.1205221803290.3231@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-22 at 18:40 +0200, Thomas Gleixner wrote:

> > I'm all for benchmarks. But right now, making all readers pass through a
> > single mutex is a huge bottle neck for a lot of loads. Yes, they are
> > mostly Java loads, but for some strange reason, our customers seems to
> > like to run Java on our RT kernel :-p
> 
> I'm well aware that mmap_sem is a PITA but replacing one nightmare
> with the next one is not the best approach.

Perhaps we could just change the mmap_sem to use this approach. Create a
new type of rwsem/lock for -rt that we can be picky about.

Yeah, mmap_sem is a real PITA and it would be nice to have a solution
that can be used until we can convert it to an RCU lock.

-- Steve



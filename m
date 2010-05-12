From: Steven Rostedt <rostedt@goodmis.org>
Subject: RE: PREEMPT_RT patch vs RTAI/Xenomai
Date: Wed, 12 May 2010 12:07:23 -0400
Message-ID: <1273680443.27703.33.camel@gandalf.stny.rr.com>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>, linux-rt-users@vger.kernel.org
To: Asier Tamayo <asier.tamayo@ona-electroerosion.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:37083 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab0ELQHZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 12:07:25 -0400
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-05-11 at 17:30 +0200, Asier Tamayo wrote:
> Hello Nivedita,
> 
> Thanks for your answer.
> 
> > What are your criteria?  Do you care about anything other
> > than performance (availability, upgrades, cost, support,
> > compatibility, tools, ...)?
> > 
> > (...) you're best off testing the solutions that you can 
> > get hold of with your own workload, in your own environment.
> > 
> Performance is a must. Besides, costs and tools are very important.
> Support is also important, but I guess I'd find some good support for
> any of the solutions.
> 
> My new CPU has an Intel Atom N270 @1.6 GHz processor. At the moment
> (during the porting it might be optimized), I have 5 drivers requering
> hard real-time (no loop can be skipped) and being called every 2 to 10
> ms. In fact, at the beginning I was using 1 ms, but I had some
> problems with the hard real-time and changed the timing to 2 ms. I do
> not consider using a legacy OS emulation.

If tuned properly, PREEMPT_RT can easily handle 1ms requirements. On a
standard x86 CPU (we support others than x86) our goal is never to be
over 100us in reaction time.


> 
> I know my final decission will have to be made after some real tests
> on my own system, but at this moment I'm trying to gather as much
> information as I can, regarding the pros and cons of each solution.

One of the main benefits with running PREEMPT_RT is that any app that
works on PREEMPT_RT also works on standard Linux. No special syscalls
are needed. Which also means you can debug on any Linux box and then
test on the PREEMP_RT box.

-- Steve




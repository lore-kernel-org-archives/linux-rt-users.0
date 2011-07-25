From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: On migrate_disable() and latencies
Date: Mon, 25 Jul 2011 10:21:50 +0200
Message-ID: <1311582110.2617.40.camel@laptop>
References: <1311329992.27400.23.camel@twins>
	 <20110722174500.GB32014@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	rostedt <rostedt@goodmis.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34573 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1GYIRU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jul 2011 04:17:20 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QlGLn-0003Xo-QZ
	for linux-rt-users@vger.kernel.org; Mon, 25 Jul 2011 08:17:19 +0000
In-Reply-To: <20110722174500.GB32014@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-22 at 19:45 +0200, Nicholas Mc Guire wrote:

> > Therefore the worst case latency is in the order of
> > max-migrate-disable-period * nr-cpus.
> 
> + something like sum of (interrupt rate [n] /
> max-migrate-disable-period * nr-cpus) * top-half handler [n]. if you
> go on with theoretical WCET analysis on multicore systems you will
> always end up at the conclusion that only UP is suitable for RT....

+ preemption cost + migration costs etc.. :-)

> > Currently we have no means of measuring these latencies, this is
> > something we need to grow, I think Steven can fairly easy craft a
> > migrate_disable runtime tracer -- it needs to use t->se.sum_exec_runtime
> > for measure so as to only count the actual time spend on the task and
> > ignore any time it was blocked.
>  
> well this is a similar problem as with the WCET "calculations" - you can
> calculate theoretical worst cases - but the question is what the actual
> distribution of "stacking" is and thus what the probability is that you
> manage to stack tasks in this way.

Sure, and yes those are thing to look at.

> One could I guess put some relatively simple instrumentation in to monitor
> this stacking problem - quit independant of actually measuring the times 

Yes, that would be very easy to do.

> > Once we have this, its back to the old game of 'lock'-breaking.
> >
> if the stacking problem does not practically exist then it might not be worth
> the effort to resolve it with elaborate lock breaking.

Fully agreed, its just that I wanted to share my understanding of the
problem space (both Thomas and I thought on-list email was a better
location that private IRC logs ;-), and we need to get the know the
problem before we can decide to ignore it ;-)

Ignoring unknowns always leads to surprises.


From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 20 Mar 2015 10:27:33 -0400
Message-ID: <20150320102733.10316214@gandalf.local.home>
References: <20150318144946.2f3cc982@gandalf.local.home>
	<20150320102542.GY23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:38992 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750764AbbCTO1h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2015 10:27:37 -0400
In-Reply-To: <20150320102542.GY23123@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 20 Mar 2015 11:25:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 18, 2015 at 02:49:46PM -0400, Steven Rostedt wrote:
> > +static int find_next_push_cpu(struct rq *rq)
> > +{
> > +	struct rq *next_rq;
> > +	int cpu;
> > +
> > +	while (1) {
> 
> We typically tend to write: for (;;), instead, however would a do { }
> while () loop not make more sense here?

You know, I use to do "for (;;)" instead of "while (1)" because to me
"for (;;)" == "forever". But people have since convinced me that
"while (1)" is better. I don't really care so I just did the switch :-p


> 
> 	do {
> 		cpu = rto_next_cpu(rq);
> 		if (cpu >= nr_cpu_ids)
> 			break;
> 
> 		next_rq = cpu_rq(cpu);
> 	} while (next_rq->rt.highest_prio.next >= rq->rt.highest_prio.curr);

Ah, that does make sense. Not sure why I had it the way I did. I think
it had to do with the way I thought about the algorithm. I did it in
layers. As there were more than one break, I probably just figured to
do them explicitly.

Want me to send an updated patch?

-- Steve


> 
> > +	return cpu;
> > +}


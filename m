From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline
 scheduler
Date: Tue, 29 Mar 2016 13:10:56 -0400
Message-ID: <20160329131056.5b01780b@gandalf.local.home>
References: <cover.1459182044.git.bristot@redhat.com>
	<14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
	<20160329151649.GA12845@twins.programming.kicks-ass.net>
	<20160329115700.40acb336@gandalf.local.home>
	<20160329160401.GB3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:59013 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752364AbcC2RLN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 13:11:13 -0400
In-Reply-To: <20160329160401.GB3430@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Mar 2016 18:04:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 29, 2016 at 11:57:00AM -0400, Steven Rostedt wrote:
> > Hmm, I probably could add tracing infrastructure that would let us
> > extend existing tracepoints. That is, without modifying sched_switch,
> > we could add a new tracepoint that when enabled, would attach itself to
> > the sched_switch tracepoint and record different information. Like a
> > special sched_switch_deadline tracepoint, that would record the existing
> > runtime,deadline and period for deadline tasks. It wont add more
> > tracepoints into the core scheduler, but use the existing one.  
> 
> Urgh; maybe. But I would would not want the new thing to be called
> _deadline, maybe _v{n} id anything and have a KERN_WARNING emitted when
> people enable the old one.

I wasn't thinking of having a new sched switch, I was thinking of
having multiple ones. And not versions, as the one for a deadline task
wouldn't be applicable for a non deadline task. But regardless, I'm
also thinking of something else.

> 
> Ideally we'd rename the old one, but I suspect even that would break
> stuff :/

Yes, we don't want to get rid of the old one. But it shouldn't break
anything if we extend it. I'm thinking of extending it with a dynamic
array to store the deadline task values (runtime, period). And for non
deadline tasks, the array would be empty (size zero). I think that
could be doable and maintain backward compatibility.

-- Steve

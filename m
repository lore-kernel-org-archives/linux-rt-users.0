From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 22:11:45 +0200
Message-ID: <20160329201145.GC3430@twins.programming.kicks-ass.net>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
 <20160329160401.GB3430@twins.programming.kicks-ass.net>
 <20160329131056.5b01780b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58734 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053AbcC2ULs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 16:11:48 -0400
Content-Disposition: inline
In-Reply-To: <20160329131056.5b01780b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 29, 2016 at 01:10:56PM -0400, Steven Rostedt wrote:
> On Tue, 29 Mar 2016 18:04:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Urgh; maybe. But I would would not want the new thing to be called
> > _deadline, maybe _v{n} id anything and have a KERN_WARNING emitted when
> > people enable the old one.
> 
> I wasn't thinking of having a new sched switch, I was thinking of
> having multiple ones. And not versions, as the one for a deadline task
> wouldn't be applicable for a non deadline task. But regardless, I'm
> also thinking of something else.

No, it should really stay one tracepoint, useful for all scheduling.

> > Ideally we'd rename the old one, but I suspect even that would break
> > stuff :/
> 
> Yes, we don't want to get rid of the old one. But it shouldn't break
> anything if we extend it. I'm thinking of extending it with a dynamic
> array to store the deadline task values (runtime, period). And for non
> deadline tasks, the array would be empty (size zero). I think that
> could be doable and maintain backward compatibility.

Why the complexity? Why not just tack those 32 bytes on and get on with
life?

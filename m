From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline
 scheduler
Date: Tue, 29 Mar 2016 17:49:30 -0400
Message-ID: <20160329174930.3b445608@gandalf.local.home>
References: <cover.1459182044.git.bristot@redhat.com>
	<14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
	<20160329151649.GA12845@twins.programming.kicks-ass.net>
	<20160329115700.40acb336@gandalf.local.home>
	<20160329160401.GB3430@twins.programming.kicks-ass.net>
	<20160329131056.5b01780b@gandalf.local.home>
	<20160329201145.GC3430@twins.programming.kicks-ass.net>
	<20160329162907.418cb972@gandalf.local.home>
	<56FAEC3D.1070300@redhat.com>
	<20160329210343.GP3408@twins.programming.kicks-ass.net>
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
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:59732 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753985AbcC2Vte (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 17:49:34 -0400
In-Reply-To: <20160329210343.GP3408@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Mar 2016 23:03:43 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > And any change on it, now and in the future, will cause confusion for
> > 99.999% of raw sched_switch users.  
> 
> Sod that, this attitude makes me want to rip out all sched tracepoints.
> 
> > Without considering those who wrote bad applications that will break,  
> 
> That's bonus points, right?
> 
> I'm seriously annoyed with this hard ABI for tracepoints crap.

No need. Userspace tools that use tracepoints should be able to be
fixed. Linus has been a bit lenient with respect to tracepoint
breakage, if we can get tools updated before we change them. He's
mentioned that tracepoints are a bit special because they are so tied
to the internals of the kernel, and those tools that read them, should
be a bit tied to the kernel as well. But we need to make sure those
tools still work with updates. Thus we need to work with the tools that
might break.

That also means that if there's bad applications that will break, they
should be fixed.

With that. I'm not concerned at all about users being inconvenienced
that tracepoint data isn't what they want to see, as long as they can
get the information out that they do need. A tool can always massage
the tracepoints into whatever nice formality that users expect.

Wasted space is a concern to me because that means lack of data, which
is what I don't want. Confusing data can be changed by userspace to be
less confusing. Missing data is gone and there's nothing userspace can
do about it.

-- Steve

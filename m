From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 14:32:54 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603171431490.3978@nanos>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com> <20160316233530.GA8731@kroah.com> <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com> <20160316221751.71816309@grimm.local.home> <20160317073605.GM6344@twins.programming.kicks-ass.net>
 <20160317080526.GB6679@osadl.at> <20160317101823.GQ6344@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1603171214530.3978@nanos> <20160317080629.1af8f733@grimm.local.home> <20160317121333.GU6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Joel Fernandes <agnel.joel@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60156 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030751AbcCQNe3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 09:34:29 -0400
In-Reply-To: <20160317121333.GU6344@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 17 Mar 2016, Peter Zijlstra wrote:
> On Thu, Mar 17, 2016 at 08:06:29AM -0400, Steven Rostedt wrote:
> > On Thu, 17 Mar 2016 12:16:11 +0100 (CET)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > On Thu, 17 Mar 2016, Peter Zijlstra wrote:
> > > > Also, maybe the tracer should measure the time from need_resched()
> > > > getting true until the next preemption point, instead of the entire time
> > > > preemption was disabled. Which would avoid the entire issue altogether.  
> > > 
> > > Well, that only gives you the information on a actual preemption, but not
> > > information about long preempt disabled regions which can cause a problem
> > > eventually.
> > > 
> > 
> > Actually, I was thinking the reverse. If need_resched() is called and
> > is false, then do a reset of the preemption time. But if need_resched()
> > is true, then do nothing, as that would measure the total time preempt
> > disable was set and a task could not schedule.
> > 
> > Question is, should this be a hook and each location audited, or add
> > this to need_resched() itself?
> 
> Is anybody calling need_resched() and then not doing anything with the
> value?

Probably not. So Stevens idea makes a lot of sense.

Thanks,

	tglx
 

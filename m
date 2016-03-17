From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 11:18:23 +0100
Message-ID: <20160317101823.GQ6344@twins.programming.kicks-ass.net>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
 <20160316233530.GA8731@kroah.com>
 <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
 <20160316221751.71816309@grimm.local.home>
 <20160317073605.GM6344@twins.programming.kicks-ass.net>
 <20160317080526.GB6679@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <agnel.joel@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55888 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935471AbcCQKS1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 06:18:27 -0400
Content-Disposition: inline
In-Reply-To: <20160317080526.GB6679@osadl.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 17, 2016 at 08:05:26AM +0000, Nicholas Mc Guire wrote:
> scanning for that patter with a quite relaxed spatch did not
> turn up more than a hand full:
> 
> @resched_spin exists@
> position p;
> @@
> 
> (
> * while@p (...) {
>           ...
>           if (need_resched() || ...)
>                   break;
>           ...
>           \(cpu_relax\|cpu_relax_lowlatency\)();
>   }
> |
> * while@p (!need_resched()) {
>           ...
>           \(cpu_relax\|cpu_relax_lowlatency\)();
>   }
> )
> 
> @script:python@
> p << resched_spin.p;
> @@
> print "%s:%s " % (p[0].file,p[0].line)                                          
> 
> 
> is this making some wrong assumptions here or is this
> really so infrequent ? 

Ah, a tool, nice! :-)

There should be one in the osq_lock, one in mutex, one in rwsem-xadd,
davidlohr was adding one to rt_mutex; and these are the one I can
remember from the top of my head.

But I would not be surprised if there are a fair few more. Also for (;;)
is a frequent loop pattern.

My biggest worry is how to not forget adding this annotation if we
create yet another instance of this. The tool could help I suppose.

Also, maybe the tracer should measure the time from need_resched()
getting true until the next preemption point, instead of the entire time
preemption was disabled. Which would avoid the entire issue altogether.

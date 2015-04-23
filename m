From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 16:40:39 -0400
Message-ID: <20150423164039.623193a3@gandalf.local.home>
References: <20150423190825.714359844@goodmis.org>
	<alpine.DEB.2.11.1504232148520.13914@nanos>
	<20150423160925.7d108eaa@gandalf.local.home>
	<alpine.DEB.2.11.1504232211540.13914@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1504232211540.13914@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015 22:21:11 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

 
> > Is the NMI code generic enough now to know that an NMI triggered, and
> > we could detect that and ignore the latencies if one did. Or perhaps
> > even add a tracepoint in the start and end of an NMI, to account for
> > it, (add hooks there), in case there's any SMIs that sneak in after an
> > NMI.
> 
> There are tracepoints in nmi_enter() and nmi_exit() at least in the
> kernel source I'm looking at.

Ah, the "trace_hardirq_enter()". That would be something I could hook
into, as the only thing that could trigger that when interrupts are
disabled happen to be NMIs.

>  
> > I guess I could also add an NMI notifier to let me know. But I know how
> > much everyone loves notifiers :-)
> 
> I was tempted to tell you to shoot yourself, but realized in time
> that this would be politically incorrect. 

And I would have to go all CodeOfConflict on you.

>  
> > > 
> > > Aside of that isn't there a way to detect SMI crap with performance
> > > counters on recent hardware?
> > > 
> > 
> > Nothing I know of that is generic enough. And just because an SMI
> > triggers, doesn't mean it's bad if it is quick enough. We have had
> > arguments with HW vendors about their SMIs, and used the hwlat_detector
> > to show that their SMIs are not as innocent as they claim. But we also
> > have seen SMIs trigger under 1us, where it doesn't affect the system.
> 
> I know of a SMI event counter which is available on newer CPUs and
> Intel promised to add a SMI cycle counter as well. I have no idea
> whether that one ever materialized. PeterZ should know.

Hmm, a cycle counter would be good to add.

> 
> But at least on the machines which have the event counter it would be
> usefull to include that information as well.

I'll try to add onto this series to include SMI counters if they exist.

Thanks,

-- Steve

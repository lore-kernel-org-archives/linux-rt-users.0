From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 16:56:58 -0400
Message-ID: <20150423165658.30f0b046@gandalf.local.home>
References: <20150423190825.714359844@goodmis.org>
	<alpine.DEB.2.11.1504232148520.13914@nanos>
	<20150423160925.7d108eaa@gandalf.local.home>
	<alpine.DEB.2.11.1504232211540.13914@nanos>
	<20150423164039.623193a3@gandalf.local.home>
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
In-Reply-To: <20150423164039.623193a3@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015 16:40:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 23 Apr 2015 22:21:11 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
>  
> > > Is the NMI code generic enough now to know that an NMI triggered, and
> > > we could detect that and ignore the latencies if one did. Or perhaps
> > > even add a tracepoint in the start and end of an NMI, to account for
> > > it, (add hooks there), in case there's any SMIs that sneak in after an
> > > NMI.
> > 
> > There are tracepoints in nmi_enter() and nmi_exit() at least in the
> > kernel source I'm looking at.
> 
> Ah, the "trace_hardirq_enter()". That would be something I could hook
> into, as the only thing that could trigger that when interrupts are
> disabled happen to be NMIs.
> 

and the naming convention fooled me :-(

That's not a tracepoint, it's a hook into lockdep. There's also a
ftrace_nmi_enter/exit() there too, that was once used for handling NMIs
when modifying the function counters via stop machine. But now that we
have switched to breakpoints, we do not need that anymore.

The only user of the ftrace_nmi_enter/exit() calls is sh. Although it's
not supported anymore, I'm sure I could use these handlers for the
hwlat_detector too. I believe jump_labels are allowed in NMI context,
and we could add hooks there to be able to jump to hwlat code.

I can add a wrapper for sh to make sure that still works (even though
there's no more maintainer that I know of for the arch).

-- Steve

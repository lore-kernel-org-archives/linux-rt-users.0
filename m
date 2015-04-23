From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 22:21:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504232211540.13914@nanos>
References: <20150423190825.714359844@goodmis.org> <alpine.DEB.2.11.1504232148520.13914@nanos> <20150423160925.7d108eaa@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38916 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbbDWUU5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 16:20:57 -0400
In-Reply-To: <20150423160925.7d108eaa@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 23 Apr 2015, Steven Rostedt wrote:
> On Thu, 23 Apr 2015 21:51:47 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > That's fine, but this still lacks a detection of NMI
> > disturbance. We've seen false positives reported over and over when
> > stuff like the NMI watchdog or perf was enabled while running this.
> 
> I was waiting for someone to point that out :-)

Always to your service :)
 
> Is the NMI code generic enough now to know that an NMI triggered, and
> we could detect that and ignore the latencies if one did. Or perhaps
> even add a tracepoint in the start and end of an NMI, to account for
> it, (add hooks there), in case there's any SMIs that sneak in after an
> NMI.

There are tracepoints in nmi_enter() and nmi_exit() at least in the
kernel source I'm looking at.
 
> I guess I could also add an NMI notifier to let me know. But I know how
> much everyone loves notifiers :-)

I was tempted to tell you to shoot yourself, but realized in time
that this would be politically incorrect. 
 
> > 
> > Aside of that isn't there a way to detect SMI crap with performance
> > counters on recent hardware?
> > 
> 
> Nothing I know of that is generic enough. And just because an SMI
> triggers, doesn't mean it's bad if it is quick enough. We have had
> arguments with HW vendors about their SMIs, and used the hwlat_detector
> to show that their SMIs are not as innocent as they claim. But we also
> have seen SMIs trigger under 1us, where it doesn't affect the system.

I know of a SMI event counter which is available on newer CPUs and
Intel promised to add a SMI cycle counter as well. I have no idea
whether that one ever materialized. PeterZ should know.

But at least on the machines which have the event counter it would be
usefull to include that information as well.

Thanks,

	tglx

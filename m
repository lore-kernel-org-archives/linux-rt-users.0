From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 16:09:25 -0400
Message-ID: <20150423160925.7d108eaa@gandalf.local.home>
References: <20150423190825.714359844@goodmis.org>
	<alpine.DEB.2.11.1504232148520.13914@nanos>
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
In-Reply-To: <alpine.DEB.2.11.1504232148520.13914@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015 21:51:47 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:


> That's fine, but this still lacks a detection of NMI
> disturbance. We've seen false positives reported over and over when
> stuff like the NMI watchdog or perf was enabled while running this.

I was waiting for someone to point that out :-)

Is the NMI code generic enough now to know that an NMI triggered, and
we could detect that and ignore the latencies if one did. Or perhaps
even add a tracepoint in the start and end of an NMI, to account for
it, (add hooks there), in case there's any SMIs that sneak in after an
NMI.

I guess I could also add an NMI notifier to let me know. But I know how
much everyone loves notifiers :-)

> 
> Aside of that isn't there a way to detect SMI crap with performance
> counters on recent hardware?
> 

Nothing I know of that is generic enough. And just because an SMI
triggers, doesn't mean it's bad if it is quick enough. We have had
arguments with HW vendors about their SMIs, and used the hwlat_detector
to show that their SMIs are not as innocent as they claim. But we also
have seen SMIs trigger under 1us, where it doesn't affect the system.

-- Steve

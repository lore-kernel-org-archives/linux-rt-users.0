From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] preempt: Debug for possible missed preemption checks
Date: Fri, 17 Jan 2014 10:08:56 +0100
Message-ID: <20140117090856.GE11314@laptop.programming.kicks-ass.net>
References: <20140116235751.084728c8@gandalf.local.home>
 <20140116211214.581197e5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140116211214.581197e5.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jan 16, 2014 at 09:12:14PM -0800, Andrew Morton wrote:
> On Thu, 16 Jan 2014 23:57:51 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > When PROVE_LOCKING and PREEMPT is configured, the preempt state
> > tracking is active. Testing this out, I added a module that did the
> > following:
> 
> So I assume your kernel at least has no instances of this bug, so we
> don't need the patch ;) It *is* a fairly daft thing to do.

Yeah, its exceedingly daft, but I do run into it every so often. Say
once a year or so.

Also, its usually not really a problem on 'normal' kernels, but it
absolutely blows on -rt.

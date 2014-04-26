From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] rtmutex: Do not prio boost when timeout is used
Date: Sat, 26 Apr 2014 07:17:02 -0400
Message-ID: <20140426071702.2a866fc5@gandalf.local.home>
References: <20140425162848.0e1deed8@gandalf.local.home>
	<20140426110437.GK26782@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140426110437.GK26782@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 26 Apr 2014 13:04:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 25, 2014 at 04:28:48PM -0400, Steven Rostedt wrote:
> > I've been discussing an issue on IRC with deadlock checking and found
> > something wrong with it. Mainly, if any of the locks have a timeout,
> > then even if the chain loops, there is no real deadlock. If one of the
> > locks in the chain times out, then things will move forward again.
> 
> 
> POSIX (opengroup):
> 
>  http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_timedlock.html
> 
> Explicitly states that pthread_mutex_timedlock() should participate in
> the PI chain, it also states that its perfectly valid for this function
> to return -EDEADLK.
> 
> Therefore, there's nothing wrong. If this behaviour breaks userspace,
> its already broken for not actually expecting the right thing.

Fair enough. Thanks for the link.

-- Steve

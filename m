From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] rtmutex: Do not prio boost when timeout is used
Date: Sat, 26 Apr 2014 13:04:37 +0200
Message-ID: <20140426110437.GK26782@laptop.programming.kicks-ass.net>
References: <20140425162848.0e1deed8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140425162848.0e1deed8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Apr 25, 2014 at 04:28:48PM -0400, Steven Rostedt wrote:
> I've been discussing an issue on IRC with deadlock checking and found
> something wrong with it. Mainly, if any of the locks have a timeout,
> then even if the chain loops, there is no real deadlock. If one of the
> locks in the chain times out, then things will move forward again.


POSIX (opengroup):

 http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_timedlock.html

Explicitly states that pthread_mutex_timedlock() should participate in
the PI chain, it also states that its perfectly valid for this function
to return -EDEADLK.

Therefore, there's nothing wrong. If this behaviour breaks userspace,
its already broken for not actually expecting the right thing.

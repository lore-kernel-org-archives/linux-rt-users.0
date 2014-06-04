From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] rtmutex: Handle when top lock owner changes
Date: Wed, 4 Jun 2014 20:02:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1406041951210.3319@nanos>
References: <1400855410-14773-1-git-send-email-brad.mouring@ni.com> <1400855410-14773-2-git-send-email-brad.mouring@ni.com> <20140603210609.62de6451@gandalf.local.home> <alpine.DEB.2.10.1406041623170.3319@nanos> <20140604114411.0fe51c1d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brad Mouring <bmouring@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140604114411.0fe51c1d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 4 Jun 2014, Steven Rostedt wrote:

> On Wed, 4 Jun 2014 17:32:37 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > T3 releases L3
> > T2 gets L3
> > T2 drops L3 and L2
> > T2 blocks on L4 held by T4
> > T4 blocked on L5 held by T5
> > 
> > So we happily boost T4 and T5. Not what we really want to do.
> > 
> > Nasty, isn't it ?
> > 
> 
> Actually, we may go up a chain, but we never do any unnecessary
> boosting. That's because the boost is done with rt_mutex_adjust_prio()
> which gets the prio from rt_mutex_getprio() which reads the
> task->normal_prio and compares it to the task_top_pi_waiter(task)->prio,
> which will always be correct as we have the necessary locks.

Indeed.
 
> And we don't even need to worry about the chain we miss. That is, if
> task A is blocked on a lock owned by D at the time, but as we go up the
> chain, D releases the lock and B grabs it, B will still up its priority
> based on the waiters of the lock (that is A), and if B blocks, it will
> boost the tasks that own the lock it blocks on, where B is still
> influenced by A.
> 
> The fact that we only update the prio based on the actual waiters and
> don't carry a prio up the chain (which you designed, and I thought was
> quite ingenious by the way), we may waste time going up a chain, but
> the priority inheritance is still accurate.

Duh. I actually had to lookup my notes from back then. There is even a
lenghty IRC discussion about not propagating the least waiters prio,
but lookup the actual lock waiters. Good, so we just walk for nothing
and waste some cpu cycles.

My brain still suffers from 3 days staring into futex.c

I'll fixup the check so it wont break the real deadlock case and queue
it.

Thanks,

	tglx

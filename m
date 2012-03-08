From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 13:23:11 -0500
Message-ID: <1331230991.25686.452.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1203072225020.2742@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2012-03-07 at 22:49 +0100, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.2.9-rt17 release.
> 
> Changes vs. 3.2.9-rt17:
> 
>   * Cherry-picked a scheduled for 3.2.10 genirq fix
> 
>   * Add missing preemption checks for softirqd wakeups
> 
>   * Implement cpu_chill() and use it in dcache and networking
> 
>     RT suffers from trylock or other busywait loops. When the lock
>     holder / updater is preempted. This is basically the same problem
>     as we experienced with seqlocks and especially their open coded
>     variants. Though it's way harder to solve. 
> 
>     The trylock loops are usually implemented to deal with reverse
>     lock ordering. On !RT this only needs to loop when one of the
>     locks is held on another cpu. On RT the lock holder can be
>     preempted which in turn puts the preempting task into an eternal
>     retry loop.
> 
>     I tried to implement spin_trydeadlock() - thanks Peter for the
>     brilliant function name - which basically boosts the lock holder
>     w/o deadlocking, but it turned out to become a quite horrible mess
>     close to the infamous multiple reader boosting code.

Thanks for the reference :-p

> 
>     Before my brain deadlocked on trylocks I took the easy way out and
>     replaced the cpu_relax() calls in those retry loops with
>     cpu_chill() calls.
> 
>     cpu_chill() defaults to cpu_relax() for !RT. On RT is simply puts
>     the task to sleep for a tick, so the preempted lock holder/updater
>     can make progress.
> 
>     I think that's reasonable as the affected code pathes are not RT
>     critical and not likely to hit. fs operations have no RT
>     guarantees at all, so it might affect random fs scanners which get
>     blocked on a rename or delete operation going on. I don't think
>     that's a real issue. Feel free to yell if you find out that it
>     hurts, but be aware that I might ask _you_ to twist _your_ brain
>     around implementing spin_trydeadlock().
> 

So basically what you tried to do was just set the owner of the lock to
have the priority of the task that wants the lock, until it releases it?
But by doing it without having this task sleep?

I'm guessing the difficulty came with the "waiter"? That's because the
waiter is on the stack of the process that is waiting. If the waiter
isn't waiting, then you can't create the waiter structure, as the stack
isn't available to use.

Did you try it so that it blocks only if the owner is not blocked, and
if the owner blocks, it wakes up the one waiting it on a
spin_trydeadlock()? But this probably has issues if the owner is blocked
on the lock the task has, you would have to do the sleep anyway.

What if you moved the "trydeadlock" into the cpu_chill()? Thus you can
have:

cpu_chill(&parent->d-lock);

on !RT it's still just a cpu_relax(), but on RT it will boost the owner
of the lock, and will block only as long as the owner chain is running.
The difference between cpu_chill() blocking and doing the blocking at
the spin_trydeadlock(), is that here we release a lock which should make
something have forward progress. Doing it before the release of the lock
probably doesn't help. Unless you had spin_trydeadlock() do the release
of the lock too?

It would be interesting to see what was tried.

-- Steve

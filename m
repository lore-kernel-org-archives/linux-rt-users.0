From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Tue, 8 Sep 2015 15:35:25 -0400
Message-ID: <20150908153525.7db8b543@gandalf.local.home>
References: <20150904011900.730816481@goodmis.org>
	<alpine.DEB.2.11.1509051217330.15006@nanos>
	<20150905120457.GA21338@gmail.com>
	<alpine.DEB.2.11.1509070959440.15006@nanos>
	<20150908125934.7b60fca7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150908125934.7b60fca7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 8 Sep 2015 12:59:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 7 Sep 2015 10:35:25 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > 			    
> >    So, if taskC has higher priority than taskB and therefor than
> >    taskA, taskB will do the lock/trylock/unlock/boost dance in
> >    circles.
> 
> Yeah, I was aware of this scenario, in which case, it just shows the
> nastiness of a spinning trylock. Even with the current situation, the
> task is going to constantly be spinning until TaskA can run. The
> difference, is that it will let other tasks run during that 1 ms sleep.
> The current code works, but as you said, by some definition of works ;-)
>

I thought about this a little more, but did not do any coding yet. Just
wanted to bounce off some ideas.

First, I still want to keep the spin_try_or_boost_lock() logic, maybe
call it, spin_trylock_or_boost() as we are not really boosting the
lock, but the owner.

Still have the requirement that if you don't get the lock, you must
still call cpu_chill().

But to get rid of the three issues you have with my current patch, I
have some ideas.

First let me express the three issues you have to make sure that we are
in-sync.

 Issue #1) The task owning the requested lock is on another CPU and is
  blocked by an even higher task. Thus the trylock spinner hogs its CPU
  preventing further progress of other tasks that want to run on that
  CPU.

 Issue #2) There could be a temporary leak of priority if the caller of
  the trylock_or_boost returns after the cpu_chill() with -EAGAIN and
  does something different.

 Issue #3) The boosting is not related to anything. If the trylock
  spinner gets boosted (or deboosted), there's no trail back to the
  owner of the lock.


To solve the above, we need to keep some state between the failed call
to spin_trylock_or_boost() and cpu_chill() (which is why there would be
a requirement to call cpu_chill() on a failed attempt to acquire the
lock).

We could add a static waiter to the task_struct, such that a failed
spin_trylock_or_boost() would add that waiter to the pi_list of the
owner, and of the waiters of the lock. This waiter will need to have a
flag stating that it's not a blocked task, and that a loop around the
pi locking will not detect it as a deadlock.

Now, if the trylock spinner either blocks on another lock, or fails to
get another trylock_or_boost(), it would unhook this waiter, and do
all the work that is required to unhook it (deboost owners, etc). That
is, a task can only be using one waiter at a time (to prevent any other
strange behaviors). It can only boost one task at a time, it can't be
boosting more than one. The last call to a spin_lock or
spin_trylock_or_boost() always wins (gets to use the waiter).

When the owner of the lock releases the lock, if this waiter is the top
waiter, it will have to grab the task's pi_lock, set the lock pointer to
NULL, and wake it up.

Then, when the trylock spinner gets around to the cpu_chill(), That
code will check if the static waiter of the task_struct is in use. It
will grab its own pi_lock, check if the waiter lock is NULL, if not, it
will go to sleep.


This solves:

 Issue #1) if the lock is still in use, the cpu_chill() will sleep, not
  yield.

 Issue #2) The trylock spinner does not go past the cpu_chill() while
  the last spin_trylock_or_boost() owner has not released the lock. The
  owner will not have leaked that priority.

 Issue #3) Use of a static waiter allows changing of boosting to occur.
  The priority chain will need to be modified to take this into account.


This would be more complex than what I proposed, but it would also
solve the issues that you brought up. The fact that a task can only
block with one waiter (it gives up the last trylock_or_boost if it
needs to block on something else that needs a waiter, or tries another
trylock_or_boost and fails to get the lock) will keep the complexity
down. It would prevent a task being in a chain twice.

Thoughts?

-- Steve

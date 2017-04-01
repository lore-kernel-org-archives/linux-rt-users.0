From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 0/4] rwsem/rt: Lift the single reader restriction
Date: Sat, 01 Apr 2017 12:50:58 +0200
Message-ID: <20170401105058.958246042@linutronix.de>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

R/W semaphores in RT do not allow multiple readers because a writer
blocking on the sempahore would have deal with all the readers in terms of
priority or budget inheritance. While multi reader priority boosting would
be possible (it has been attempted before), multi reader budget inheritance
is impossible.

It's obvious that the single reader restriction has severe performance
problems for situations with heavy reader contention.

A typical issue is the contention of mmap_sem. The main issue with mmap_sem
vs. process shared futexes has been cured for some architectures by
switching to fast GUP, but it still persists for those architectures which
do not (yet) implement it.

Non-RT workloads suffer also from mmap_sem contention when they trigger a
massive amount of page faults on multiple threads.

There is another issue with R/W semaphores. 

The single reader restriction is not violating the !RT semantics of R/W
sempahores, because on !RT R/W sempahores are writer fair. That means, that
when a writer blocks on a contended R/W semaphore newly incoming readers
block behind the writer. This prevents writer starvation.

So the following scenario is resulting in a deadlock independent of RT:

T1
down_read(sem);
wait_for_event();
  schedule()

T2
down_write(sem);
  blocks_on(sem);
    schedule();

T3
down_read(sem);		<- T3 cannot take sem for read and blocks behind T2
...			===> DEADLOCK!
wake_waiters();

Though there is a very subtle semantical difference on RT versus the
following scenario:

T1
down_read(sem);
wait_for_event();
  schedule()

T2
if (down_write_trylock(sem))
  do_something()

T3
down_read(sem);
...
wake_waiters();

That works on mainline, but breaks on RT due to the single reader
restriction.

Yes, that's ugly and should be forbidden, but there is code in the mainline
kernel which relies on that (e.g. Radeon driver).

Finding and fixing such constructs is not an easy task and aside of that
the single reader restriction is a performance bottleneck.

After analyzing the writer sides of R/W semaphores I came to the conclusion
that down_writes() happen in expensive code pathes which should not be
invoked in high priority tasks anyway. And if user space is stupid enough
to do so, then it's nothing we should worry about. Doing mmap() in your
high priority task is stupid to begin with.

The following patch series changes the RT implementation of R/W sempahores
to a multi reader model, which is not writer fair. That means writers have
to wait until the last reader left the critical section and readers are
allowed to take the semaphore for read even when a writer is blocked.

This means there is a risk of writer starvation, but the pathological
workloads which trigger it, are not necessarily the typical RT workloads.

It cures the Radeon mess, lowers the contention on mmap_sem for certain
workloads and did not have any negative impact in our initial testing on RT
behaviour.

I think it's worth to expose it to a wider audience of users for testing,
so we can figure out it whether there are dragons lurking.

Thanks,

	tglx

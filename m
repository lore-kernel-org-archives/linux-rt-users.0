From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT v2 0/3] RT: Fix trylock deadlock without msleep() hack
Date: Thu, 10 Sep 2015 10:50:55 -0400
Message-ID: <20150910145055.948545589@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(Frozen shark deflectors set on hold)

I wont describe the trylock live lock issue again, for that please see
v1 of this patch set:

  http://lkml.kernel.org/r/20150904011900.730816481@goodmis.org

My solution there was to add a spin_try_or_boost_lock() call that would
temporarily boost the owner of the lock if the lock was held. The boosting
will last until the task unlocks any lock, then it would reset that boost.

In the mean time, the caller of the trylock would then call cpu_chill() which
was turned into a sched_yield() hoping that if it was blocking the owner
the owner (now boosted to the same priority) would get a chance to run.

Thomas Gleixner had issues with this approach (and rightfully so).

 #1) if the owner was blocked by an even higher priority task on another
     CPU, the trylock spinner would constantly spin and block that
     CPU from having any other user.

 #2) There was a temporary priority leak (although this isn't so bad
     because the leak is bounded). Where if the trylock spinner hit
     a condition to not spin anymore. The owner of the lock would still
     have the unneeded boost till it released that lock.

 #3) There's no connection with the trylock spinner and the owner. If
     the spinner was deboosted, or boosted, the owner of the lock would
     not see that change.


With my new approach (this patch series), the above can be solved. Note,
1 and 2 are solved, but 3 still needs some tweaks with the priority chain.
But first lets describe the new approach.

Before describing the new approach, I need to describe the rt_mutex_waiter.
This is the descriptor used to hold most of the state of a blocked task
in the priority inheritance chain. When a task blocks on a rtmutex,
the rt_mutex_waiter (called waiter from now on) is allocated on the
stack and initialized. It points to the lock as well as the blocked task.
It has hooks to link into the owner's priority list as well as the
lock's wait list. The waiter is used extensively in the pi code.

The waiter can be allocated on the stack because a blocked task wont need
the pi code once it is woken and is finished with the rtmutex call.
But this wont work with the spin_trylock_or_boost() (renamed from the
previous spin_try_or_boost_lock()). That is because the trylock_or_boost
call will finish and the waiter will still be in use. The scope of this
waiter needs to be from the trylock_or_boost() call, all the way to the
cpu_chill() call (which must be called after a failed spin_trylock_or_boost()).

To solve the need of a waiter beyond the scope of a function call, a
waiter descriptor is added to the task_struct. This "static" waiter can
now be used to boost tasks after a failed spin_trylock_or_boost() and
keep the state between the trylock spinner and the owner of the lock.

Some caveats are needed though. A task can only boost one other task at a time.
If two spin_trylock_or_boost() calls are done and both failed. Only the first
one will boost the owner of the task. The second one (which would for now
give a warning, because I don't see why two failed attempts would be done),
will be ignored.

If the task calls spin_trylock_or_boost() fails, and boosts the owner, and then
calls a normal spin_lock() and fails, the boosted task from the
trylock_or_boost will be released. That is, the waiter on the task_struct
will be removed from the lock and owner's pi list, before the task blocks
on the spin_lock. This prevents any strange anomaly with having one task
with two waiters. As stated before. A task may only boost one other task
at a time, never two or more. That is, it may only be in one pi chain at
a time. This keeps the complexity down.

When the task gets around to calling cpu_chill(), the cpu_chill() will
check the "static" waiter, and see if there's a lock assigned to it.
If there is, it will set a new flag in the waiter stating that it wants
to be woken, and will sleep. If there's no lock assigned, that means either
the lock was released in the mean time, or the task blocked on another lock
and had to release that waiter. In either case, the cpu_chill() simply
calls cpu_relax() and continues.

When the owner of the lock releases the lock, if the top_waiter is a static
waiter (waiter == &waiter->task.rt_waiter), then the waiter is removed not
only from the pi_list of the old owner, but also from the wait_list of the
lock itself. The waiter->lock is set to NULL too. This lets the waiter->task
know that the lock has been freed. The old owner will only wake up the
task if the waiter flag is set to do so. Otherwise it may cause a spurious
wake up. If the flag is not set, then the trylock spinner has not made it to
the cpu_chill() yet, and with the waiter->lock cleared, the cpu_chill() will
not sleep.

The waiter->task->pi_lock is used to synchronize the modifications of the
static waiter.

Now, one might notice that we could just keep the task on the lock's wait_list
and that way lower priority tasks could not steal that lock. This would
be nice, but there's a major problem. And this problem is also the reason
for patch 3 (a new patch in the series). That is, because the trylock
spinner is not actually blocked on the lock, there's no guarantee that the
lock will stay around by the time the spinner calls cpu_chill().


    CPU0		   CPU1
    ----		   ----
  lock(dev->B)
			lock(A)
			trylock(dev->B)
			  [boost and link on lock]
			unlock(A)
  unlock(dev->B)
  lock(A)
  free(dev)
  unlock(A)

			cpu_chill()


See the problem?

If the owner kept the trylock spinner on the lock, there's nothing in the
logic that prevents that lock from being freed. In fact, in this case it
was lock A that protects the lock from being freed. But the trylock spinner
releases that lock before calling cpu_chill().

Because of the above, the unlock(dev->B) must remove all top waiters that
are there due to a spin_trylock_or_boost(). If there are normal waiters,
nothing needs to be done, because the normal waiter would have to be in
a path that guarantees the lock stays around (otherwise it would bug on
mainline too), and when the normal waiter gets the lock and releases it
it will remove any waiters that are below it.

I boot tested this, and ran my simple module to see if it works, and
it does. But this code is more complex, and I'm sure there's bugs in it.
This is still in RFC, and there's some clean ups that can be done.
But I think this is a better solution than the one I supplied before,
albeit a bit more complex. But it handles the issues that Thomas brought
up. #3 isn't fixed, because that will require the pi chain checking
tasks that are not blocked, but boost via its static waiter. This would
not be hard to fix, and probably can be fixed by changing cpu_chill()
to boost again before it sleeps.

Thoughts?

-- Steve

---

Steven Rostedt (Red Hat) (3):
      locking: Add spin_trylock_or_boost() infrastructure
      rt: Make cpu_chill() call rt_mutex_wait_for_lock() and add new cpu_rest() as msleep(1)
      rtmutex: Wake up all top trylock waiters on unlock


 block/blk-ioc.c                 |    4 
 fs/autofs4/expire.c             |    2 
 fs/dcache.c                     |    6 
 fs/namespace.c                  |    2 
 include/linux/delay.h           |   13 +
 include/linux/rtmutex.h         |    1 
 include/linux/sched.h           |   50 +++++
 include/linux/spinlock.h        |    5 
 include/linux/spinlock_rt.h     |   15 +
 kernel/locking/rtmutex.c        |  376 +++++++++++++++++++++++++++++++++++++++-
 kernel/locking/rtmutex_common.h |   22 --
 kernel/time/hrtimer.c           |   17 +
 kernel/workqueue.c              |    2 
 net/packet/af_packet.c          |    4 
 net/rds/ib_rdma.c               |    2 
 15 files changed, 478 insertions(+), 43 deletions(-)

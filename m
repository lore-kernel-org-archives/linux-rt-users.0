From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep() hack
Date: Thu, 03 Sep 2015 21:19:00 -0400
Message-ID: <20150904011900.730816481@goodmis.org>
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

(Frozen shark deflectors on)

Currently the solution to prevent the trylock livelock (described below)
is to change cpu_relax() to cpu_chill() that is simply a msleep(1) that
hopes that the owner of the lock runs and releases the lock and nobody
else takes that lock by the time the task wakes up from the msleep.
When I showed this at LinuxCon/LinuxPlumbers, I was able to see the entire
audience wince at once. It was a beautiful sight, and I wish I took a picture.
Interesting enough, everyone winced to their left side.

This patch set is an attempt to solve the issue in a more deterministic
manner. By introducing a new primitive called spin_try_or_boost_lock(), which
will try to take the lock, and if it fails, it will boost the owner of the
lock to its own priority if needed.

Because we do not want to add an extra field to the locking, or have the
trylock caller block in any way, the solution is to give the owner a temporary
priority boost that is lost as soon as it releases any spinlock (that was
converted to a rtmutex). This new boosted priority is saved in the task
struct, and cleared on releasing any spinlock. Sure, it may release a
different spinlock than the one it was boosted by, but it still will make
progress, and will be boosted again by the trylock spinner. Each time
the owner gets boosted it will move forward till it can release the wanted
lock.

The cpu_chill() will now become a sched_yield(), which will allow the newly
boosted task to run ahead of the spinner (it is of the same priority). When the
task releases a lock, it loses its priority, and the trylock spinner can
try again.

Now, there's a few locations where cpu_chill() is not used for a trylock,
but instead it spins on a bit or some status that will be updated by another
task. As this other task may also be blocked by the spinner, it needs to be
handled as well. As we do not know who the updating task is, there's still
no way to boost it. Maybe in the future we can come up with another API
that can handle this. For now, we will still use the msleep(), but instead
of using cpu_chill(), another primitive is created called cpu_rest() :-)
The cpu_rest() (which I think is more descriptive of a msleep(1)) acts the
same as the current cpu_chill(). Hopefully we can remove that too.

There are a lot of trylocks in the kernel, and I'm sure there's more around
that need to be convert to this method. I think this is an elegant solution
but others may feel differently. As I think a msleep() hail mary is extremely
non deterministic, it's a blemish for a kernel that prides itself on adding
determinism.

I tested this with a module that forces the race. If you want that too, I can
supply it as well. I did some basic testing, but I just recently got this
working so there may be bugs. This is an RFC to see if it is worth while
to implement.

[ Note, this still needs to be tested against non PREEMPT_RT configs ]

Thanks!

-- Steve

Steven Rostedt (Red Hat) (3):
      locking: Add spin_try_or_boost_lock() infrastructure
      locking: Convert trylock spinners over to spin_try_or_boost_lock()
      rt: Make cpu_chill() into yield() and add new cpu_rest() as msleep(1)

---
 block/blk-ioc.c             |   4 ++--
 fs/autofs4/expire.c         |   2 +-
 fs/dcache.c                 |   6 +++---
 fs/namespace.c              |   2 +-
 include/linux/delay.h       |  13 +++++++++++++
 include/linux/init_task.h   |   8 ++++++++
 include/linux/rtmutex.h     |   1 +
 include/linux/sched.h       |  27 +++++++++++++++++++++++++
 include/linux/spinlock.h    |   5 +++++
 include/linux/spinlock_rt.h |  13 +++++++++++++
 kernel/locking/rtmutex.c    | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/core.c         |  14 +++++++++++++
 kernel/time/hrtimer.c       |   4 ++--
 kernel/workqueue.c          |   2 +-
 net/packet/af_packet.c      |   4 ++--
 net/rds/ib_rdma.c           |   2 +-
 16 files changed, 204 insertions(+), 24 deletions(-)

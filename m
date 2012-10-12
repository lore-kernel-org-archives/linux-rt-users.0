From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] [ANNOUNCE] 3.2.31-rt47-rc1 stable review
Date: Thu, 11 Oct 2012 21:20:24 -0400
Message-ID: <20121012012024.056658930@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.31-rt47-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 10/16/2012.

Enjoy,

-- Steve


To build 3.2.31-rt47-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.31.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.31-rt47-rc1.patch.xz

You can also build from 3.2.31-rt46 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.31-rt46-rt47-rc1.patch.xz


Changes from 3.2.31-rt46:

---


Steven Rostedt (2):
      softirq: Init softirq local lock after per cpu section is set up
      Linux 3.2.31-rt47-rc1

Thomas Gleixner (6):
      random: Make it work on rt
      mm: slab: Fix potential deadlock
      mm: page_alloc: Use local_lock_on() instead of plain spinlock
      rt: rwsem/rwlock: lockdep annotations
      sched: Better debug output for might sleep
      stomp_machine: Use mutex_trylock when called from inactive cpu

----
 drivers/char/random.c     |   10 ++++++----
 include/linux/irqdesc.h   |    1 +
 include/linux/locallock.h |   19 +++++++++++++++++++
 include/linux/random.h    |    2 +-
 include/linux/sched.h     |    4 ++++
 init/main.c               |    2 +-
 kernel/irq/handle.c       |    7 +++++--
 kernel/irq/manage.c       |    6 ++++++
 kernel/rt.c               |   46 ++++++++++++++++++++++++---------------------
 kernel/sched.c            |   23 +++++++++++++++++++++--
 kernel/stop_machine.c     |   13 +++++++++----
 localversion-rt           |    2 +-
 mm/page_alloc.c           |    4 ++--
 mm/slab.c                 |   10 ++--------
 14 files changed, 103 insertions(+), 46 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] Linux 3.18.18-rt16-rc1
Date: Tue, 04 Aug 2015 21:18:26 -0400
Message-ID: <20150805011826.881627614@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.18.18-rt16-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 8/10/2015.

Enjoy,

-- Steve


To build 3.18.18-rt16-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.18.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.18-rt16-rc1.patch.xz

You can also build from 3.18.18-rt15 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.18-rt15-rt16-rc1.patch.xz


Changes from 3.18.18-rt15:

---


Davidlohr Bueso (2):
      futex: Implement lockless wakeups
      ipc/mqueue: Implement lockless pipelined wakeups

Peter Zijlstra (1):
      sched: Implement lockless wake-queues

Sebastian Andrzej Siewior (2):
      Revert "slub: delay ctor until the object is requested"
      kernel/irq_work: fix non RT case

Steven Rostedt (Red Hat) (1):
      Linux 3.18.18-rt16-rc1

Thomas Gleixner (1):
      mm/slub: move slab initialization into irq enabled region

----
 include/linux/sched.h | 46 ++++++++++++++++++++++++++++
 ipc/mqueue.c          | 53 +++++++++++++++++++-------------
 kernel/futex.c        | 33 ++++++++++----------
 kernel/sched/core.c   | 46 ++++++++++++++++++++++++++++
 kernel/time/timer.c   |  3 +-
 localversion-rt       |  2 +-
 mm/slub.c             | 85 +++++++++++++++++++++++----------------------------
 7 files changed, 182 insertions(+), 86 deletions(-)

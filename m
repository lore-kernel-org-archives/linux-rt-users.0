From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/6] [ANNOUNCE] 3.2.44-rt65-rc1
Date: Fri, 03 May 2013 20:59:55 -0400
Message-ID: <20130504005955.061874443@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.44-rt65-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/7/2013.

Enjoy,

-- Steve


To build 3.2.44-rt65-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.44-rt65-rc1.patch.xz

You can also build from 3.2.44-rt64 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.44-rt64-rt65-rc1.patch.xz


Changes from 3.2.44-rt64:

---


Eric Dumazet (1):
      tcp: force a dst refcount when prequeue packet

Paul E. McKenney (1):
      sched: Add is_idle_task() to handle invalidated uses of idle_cpu()

Steven Rostedt (2):
      x86/mce: Defer mce wakeups to threads for PREEMPT_RT
      swap: Use unique local lock name for swap_lock

Steven Rostedt (Red Hat) (2):
      rcutiny: Fix typo of using swake_up() instead of swait_wake()
      Linux 3.2.44-rt65-rc1

----
 arch/x86/kernel/cpu/mcheck/mce.c |   78 +++++++++++++++++++++++++++++---------
 include/linux/sched.h            |    8 ++++
 include/net/tcp.h                |    1 +
 kernel/rcutiny_plugin.h          |    2 +-
 localversion-rt                  |    2 +-
 mm/swap.c                        |   20 +++++-----
 6 files changed, 82 insertions(+), 29 deletions(-)

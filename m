From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] Linux 4.4.97-rt111-rc1
Date: Tue, 21 Nov 2017 11:06:54 -0500
Message-ID: <20171121160654.493640386@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.4.97-rt111-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/27/2017.

Enjoy,

-- Steve


To build 4.4.97-rt111-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.97.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.97-rt111-rc1.patch.xz

You can also build from 4.4.97-rt110 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.97-rt110-rt111-rc1.patch.xz


Changes from 4.4.97-rt110:

---


Peter Zijlstra (1):
      sched: Remove TASK_ALL

Sebastian Andrzej Siewior (4):
      timer/hrtimer: check properly for a running timer
      random: avoid preempt_disable()ed section
      sched/migrate disable: handle updated task-mask mg-dis section
      kernel/locking: use an exclusive wait_q for sleepers

Steven Rostedt (VMware) (1):
      Linux 4.4.97-rt111-rc1

Thomas Gleixner (2):
      rtmutex: Make lock_killable work
      sched: Prevent task state corruption by spurious lock wakeup

----
 drivers/char/random.c    | 10 +++---
 include/linux/hrtimer.h  |  8 ++++-
 include/linux/sched.h    | 19 ++++++++++--
 kernel/fork.c            |  1 +
 kernel/locking/rtmutex.c | 21 +++++--------
 kernel/sched/core.c      | 81 +++++++++++++++++++++++++++++++++++++++++-------
 localversion-rt          |  2 +-
 7 files changed, 109 insertions(+), 33 deletions(-)

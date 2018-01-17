From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/13] Linux 3.18.91-rt98-rc1
Date: Wed, 17 Jan 2018 10:14:04 -0500
Message-ID: <20180117151404.093229667@goodmis.org>
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

This is the RT stable review cycle of patch 3.18.91-rt98-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 1/19/2018.

Enjoy,

-- Steve


To build 3.18.91-rt98-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.91.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.91-rt98-rc1.patch.xz

You can also build from 3.18.91-rt97 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.91-rt97-rt98-rc1.patch.xz


Changes from 3.18.91-rt97:

---


Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Mike Galbraith (1):
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Mikulas Patocka (1):
      locking/rt-mutex: fix deadlock in device mapper / block-IO

Sebastian Andrzej Siewior (7):
      random: avoid preempt_disable()ed section
      fs: convert two more BH_Uptodate_Lock related bitspinlocks
      md/raid5: do not disable interrupts
      Revert "fs: jbd2: pull your plug when waiting for space"
      kernel/hrtimer: migrate deferred timer on CPU down
      rt/locking: allow recursive local_trylock()
      net: use trylock in icmp_sk

Steven Rostedt (VMware) (1):
      Linux 3.18.91-rt98-rc1

Thomas Gleixner (2):
      rtmutex: Make lock_killable work
      sched: Prevent task state corruption by spurious lock wakeup

----
 drivers/char/random.c     | 10 ++++++----
 drivers/md/raid5.c        |  4 ++--
 fs/ext4/page-io.c         |  6 ++----
 fs/jbd2/checkpoint.c      |  2 --
 include/linux/locallock.h |  9 +++++++++
 kernel/cpu_pm.c           | 43 ++++++-------------------------------------
 kernel/locking/rtmutex.c  | 44 +++++++++++++++++++++++++++-----------------
 kernel/sched/core.c       |  2 +-
 kernel/time/hrtimer.c     | 20 ++++++++++++++++----
 localversion-rt           |  2 +-
 net/ipv4/icmp.c           |  6 +++++-
 11 files changed, 75 insertions(+), 73 deletions(-)

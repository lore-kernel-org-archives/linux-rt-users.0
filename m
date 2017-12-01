From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/15] Linux 4.9.65-rt57-rc1
Date: Fri, 01 Dec 2017 10:49:59 -0500
Message-ID: <20171201154959.375846909@goodmis.org>
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

[ Sorry for the duplicate, I tried to cancel sending, but quilt decided
  to send anyway :-p ]

Dear RT Folks,

This is the RT stable review cycle of patch 4.9.65-rt57-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/5/2017.

Enjoy,

-- Steve


To build 4.9.65-rt57-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.65.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.65-rt57-rc1.patch.xz

You can also build from 4.9.65-rt56 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.65-rt56-rt57-rc1.patch.xz


Changes from 4.9.65-rt56:

---


Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Mike Galbraith (2):
      rtmutex: Fix lock stealing logic
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Sebastian Andrzej Siewior (10):
      Revert "fs: jbd2: pull your plug when waiting for space"
      posixtimer: init timer only with CONFIG_POSIX_TIMERS enabled
      PM / CPU: replace raw_notifier with atomic_notifier (fixup)
      kernel/hrtimer: migrate deferred timer on CPU down
      net: take the tcp_sk_lock lock with BH disabled
      kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
      Bluetooth: avoid recursive locking in hci_send_to_channel()
      iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr() for ->flush_queue
      rt/locking: allow recursive local_trylock()
      locking/rtmutex: don't drop the wait_lock twice

Steven Rostedt (VMware) (2):
      Revert "memcontrol: Prevent scheduling while atomic in cgroup code"
      Linux 4.9.65-rt57-rc1

----
 drivers/iommu/amd_iommu.c |  4 +--
 fs/jbd2/checkpoint.c      |  2 --
 include/linux/init_task.h |  2 +-
 include/linux/locallock.h |  9 ++++++
 kernel/cpu_pm.c           | 50 +++++++++-----------------------
 kernel/locking/rtmutex.c  | 74 +++++++++++++++++++++++------------------------
 kernel/time/hrtimer.c     | 35 ++++++++++++++++------
 localversion-rt           |  2 +-
 mm/memcontrol.c           | 13 ++++-----
 net/bluetooth/hci_sock.c  | 17 +++++++----
 net/ipv4/tcp_ipv4.c       |  8 ++---
 11 files changed, 108 insertions(+), 108 deletions(-)

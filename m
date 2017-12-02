From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/9] Linux 4.4.102-rt117-rc1
Date: Fri, 01 Dec 2017 20:36:58 -0500
Message-ID: <20171202013658.149533964@goodmis.org>
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

This is the RT stable review cycle of patch 4.4.102-rt117-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/5/2017.

Enjoy,

-- Steve


To build 4.4.102-rt117-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.102.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.102-rt117-rc1.patch.xz

You can also build from 4.4.102-rt116 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.102-rt116-rt117-rc1.patch.xz


Changes from 4.4.102-rt116:

---


Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Mike Galbraith (1):
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Sebastian Andrzej Siewior (6):
      Revert "fs: jbd2: pull your plug when waiting for space"
      kernel/hrtimer: migrate deferred timer on CPU down
      kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
      Bluetooth: avoid recursive locking in hci_send_to_channel()
      rt/locking: allow recursive local_trylock()
      net: use trylock in icmp_sk

Steven Rostedt (VMware) (1):
      Linux 4.4.102-rt117-rc1

----
 fs/jbd2/checkpoint.c      |  2 --
 include/linux/locallock.h |  9 +++++++++
 kernel/cpu_pm.c           | 43 ++++++-------------------------------------
 kernel/time/hrtimer.c     | 35 ++++++++++++++++++++++++++---------
 localversion-rt           |  2 +-
 net/bluetooth/hci_sock.c  | 17 +++++++++++------
 net/ipv4/icmp.c           |  6 +++++-
 7 files changed, 58 insertions(+), 56 deletions(-)

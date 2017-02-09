From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 4.1.38-rt45-rc1
Date: Thu, 09 Feb 2017 10:32:52 -0500
Message-ID: <20170209153252.869145006@goodmis.org>
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

This is the RT stable review cycle of patch 4.1.38-rt45-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/13/2017.

Enjoy,

-- Steve


To build 4.1.38-rt45-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.38-rt45-rc1.patch.xz

You can also build from 4.1.38-rt44 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.38-rt44-rt45-rc1.patch.xz


Changes from 4.1.38-rt44:

---


Sebastian Andrzej Siewior (2):
      net: free the sbs in skbufhead
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (1):
      net: Have __napi_schedule_irqoff() disable interrupts on RT

Steven Rostedt (Red Hat) (1):
      Linux 4.1.38-rt45-rc1

Yang Shi (1):
      arm: kprobe: replace patch_lock to raw lock

----
 arch/arm/kernel/patch.c   |  6 +++---
 include/linux/netdevice.h | 12 ++++++++++++
 kernel/workqueue.c        |  2 ++
 localversion-rt           |  2 +-
 net/core/dev.c            | 10 ++++++++++
 5 files changed, 28 insertions(+), 4 deletions(-)

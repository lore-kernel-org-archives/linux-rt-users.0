From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/10] Linux 3.14.79-rt85-rc1
Date: Thu, 22 Sep 2016 22:49:27 -0400
Message-ID: <20160923024927.685936218@goodmis.org>
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

This is the RT stable review cycle of patch 3.14.79-rt85-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/25/2016.

Enjoy,

-- Steve


To build 3.14.79-rt85-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.79.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.79-rt85-rc1.patch.xz

You can also build from 3.14.79-rt84 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.79-rt84-rt85-rc1.patch.xz


Changes from 3.14.79-rt84:

---


Mike Galbraith (1):
      scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in fcoe_recv_frame()

Sebastian Andrzej Siewior (8):
      timers: wakeup all timer waiters
      timers: wakeup all timer waiters without holding the base lock
      sched: lazy_preempt: avoid a warning in the !RT case
      net: add back the missing serialization in ip_send_unicast_reply()
      net: add a lock around icmp_sk()
      fs/dcache: resched/chill only if we make no progress
      x86/preempt-lazy: fixup should_resched()
      fs/dcache: incremental fixup of the retry routine

Steven Rostedt (Red Hat) (1):
      Linux 3.14.79-rt85-rc1

----
 arch/x86/include/asm/preempt.h | 17 +++++++++++++++--
 drivers/scsi/fcoe/fcoe.c       |  2 +-
 fs/dcache.c                    | 17 +++++++++++++++--
 kernel/sched/core.c            |  2 +-
 kernel/timer.c                 |  4 ++--
 localversion-rt                |  2 +-
 net/ipv4/icmp.c                |  8 ++++++++
 net/ipv4/tcp_ipv4.c            |  7 +++++++
 8 files changed, 50 insertions(+), 9 deletions(-)

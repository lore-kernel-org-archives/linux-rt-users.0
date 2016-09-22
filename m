From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/10] Linux 4.4.21-rt31-rc1
Date: Thu, 22 Sep 2016 17:47:52 -0400
Message-ID: <20160922214752.178698951@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030481AbcIVVsV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 17:48:21 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 4.4.21-rt31-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/25/2016.

Enjoy,

-- Steve


To build 4.4.21-rt31-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.21.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.21-rt31-rc1.patch.xz

You can also build from 4.4.21-rt30 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.21-rt30-rt31-rc1.patch.xz


Changes from 4.4.21-rt30:

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
      Linux 4.4.21-rt31-rc1

----
 arch/x86/include/asm/preempt.h | 17 +++++++++++++++--
 drivers/scsi/fcoe/fcoe.c       |  2 +-
 fs/dcache.c                    | 18 ++++++++++++------
 kernel/sched/core.c            |  2 +-
 kernel/time/timer.c            |  4 ++--
 localversion-rt                |  2 +-
 net/ipv4/icmp.c                |  8 ++++++++
 net/ipv4/tcp_ipv4.c            |  7 +++++++
 8 files changed, 47 insertions(+), 13 deletions(-)

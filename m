From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] Linux 3.4.112-rt144-rc1
Date: Fri, 23 Sep 2016 12:48:00 -0400
Message-ID: <20160923164800.627094159@goodmis.org>
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

This is the RT stable review cycle of patch 3.4.112-rt144-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2016.

Enjoy,

-- Steve


To build 3.4.112-rt144-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.112.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.112-rt144-rc1.patch.xz

You can also build from 3.4.112-rt143 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.112-rt143-rt144-rc1.patch.xz


Changes from 3.4.112-rt143:

---


Sebastian Andrzej Siewior (6):
      timers: wakeup all timer waiters
      timers: wakeup all timer waiters without holding the base lock
      net: add back the missing serialization in ip_send_unicast_reply()
      net: add a lock around icmp_sk()
      fs/dcache: resched/chill only if we make no progress
      fs/dcache: incremental fixup of the retry routine

Steven Rostedt (Red Hat) (1):
      Linux 3.4.112-rt144-rc1

----
 fs/dcache.c         | 17 +++++++++++++++--
 kernel/timer.c      |  4 ++--
 localversion-rt     |  2 +-
 net/ipv4/icmp.c     |  8 ++++++++
 net/ipv4/tcp_ipv4.c |  7 +++++++
 5 files changed, 33 insertions(+), 5 deletions(-)

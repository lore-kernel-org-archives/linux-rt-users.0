From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] [ANNOUNCE] 3.6.11.2-rt34-rc1
Date: Fri, 03 May 2013 17:37:03 -0400
Message-ID: <20130503213703.521223574@goodmis.org>
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

This is the RT stable review cycle of patch 3.6.11.2-rt34-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/7/2013.

Enjoy,

-- Steve


To build 3.6.11.2-rt34-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.6.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.6.11.2.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.11.2-rt34-rc1.patch.xz

You can also build from 3.6.11.2-rt33 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.11.2-rt33-rt34-rc1.patch.xz


Changes from 3.6.11.2-rt33:

---


Eric Dumazet (1):
      tcp: force a dst refcount when prequeue packet

Priyanka Jain (1):
      powerpc/64bit,PREEMPT_RT: Check preempt_count before preempting

Steven Rostedt (2):
      x86/mce: Defer mce wakeups to threads for PREEMPT_RT
      swap: Use unique local lock name for swap_lock

Steven Rostedt (Red Hat) (1):
      Linux 3.6.11.2-rt34-rc1

----
 arch/powerpc/kernel/entry_64.S   |    2 +
 arch/x86/kernel/cpu/mcheck/mce.c |   78 +++++++++++++++++++++++++++++---------
 include/net/tcp.h                |    1 +
 localversion-rt                  |    2 +-
 mm/swap.c                        |   20 +++++-----
 5 files changed, 75 insertions(+), 28 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.4.42-rt57-rc1
Date: Fri, 03 May 2013 17:58:32 -0400
Message-ID: <20130503215832.688847775@goodmis.org>
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

This is the RT stable review cycle of patch 3.4.42-rt57-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/7/2013.

Enjoy,

-- Steve


To build 3.4.42-rt57-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.42.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.42-rt57-rc1.patch.xz

You can also build from 3.4.42-rt56 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.42-rt56-rt57-rc1.patch.xz


Changes from 3.4.42-rt56:

---


Eric Dumazet (1):
      tcp: force a dst refcount when prequeue packet

Steven Rostedt (2):
      x86/mce: Defer mce wakeups to threads for PREEMPT_RT
      swap: Use unique local lock name for swap_lock

Steven Rostedt (Red Hat) (1):
      Linux 3.4.42-rt57-rc1

----
 arch/x86/kernel/cpu/mcheck/mce.c |   78 +++++++++++++++++++++++++++++---------
 include/net/tcp.h                |    1 +
 localversion-rt                  |    2 +-
 mm/swap.c                        |   20 +++++-----
 4 files changed, 73 insertions(+), 28 deletions(-)

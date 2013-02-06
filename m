From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/6] [ANNOUNCE] 3.2.38-rt57-rc1 stable review
Date: Wed, 06 Feb 2013 17:02:10 -0500
Message-ID: <20130206220210.823160521@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.38-rt57-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/8/2013.

Enjoy,

-- Steve


To build 3.2.38-rt57-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.38-rt57-rc1.patch.xz

You can also build from 3.2.38-rt56 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.38-rt56-rt57-rc1.patch.xz


Changes from 3.2.38-rt56:

---


Steven Rostedt (1):
      Linux 3.2.38-rt57-rc1

Thomas Gleixner (5):
      drivers-tty-pl011-irq-disable-madness.patch
      mmci: Remove bogus local_irq_save()
      sched: Init idle->on_rq in init_idle()
      sched: Check for idle task in might_sleep()
      mm: swap: Initialize local locks early

----
 drivers/mmc/host/mmci.c         |    5 -----
 drivers/tty/serial/amba-pl011.c |   15 ++++++++++-----
 kernel/sched.c                  |    4 +++-
 localversion-rt                 |    2 +-
 mm/swap.c                       |   12 +++++++++---
 5 files changed, 23 insertions(+), 15 deletions(-)

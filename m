From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] [ANNOUNCE] 3.0.20-rt36-rc1
Date: Wed, 08 Feb 2012 20:59:26 -0500
Message-ID: <20120209015926.851312665@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.20-rt36-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. (Note, due to issues with kernel.org, nothing
can currently be deleted from the web interface).
This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/10/2012.

Enjoy,

-- Steve


To build 3.0.20-rt36-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.20.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.20-rt36-rc1.patch.xz

You can also build from 3.0.20-rt35 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.20-rt35-rt36-rc1.patch.xz


Changes from 3.0.20-rt35:

---


Oleg Nesterov (1):
      signal/x86: Delay calling signals in atomic

Steven Rostedt (3):
      x86: Do not disable preemption in int3 on 32bit
      futex: Fix bug on when a requeued RT task times out
      Linux 3.0.20-rt36-rc1

Thomas Gleixner (4):
      genirq: Unmask oneshot irqs when thread was not woken
      genirq: Handle pending irqs in irq_startup()
      timer-fd: Prevent live lock
      genirq: Allow disabling of softirq processing in irq thread context

----
 arch/x86/include/asm/signal.h |   13 ++++++++++++
 arch/x86/kernel/signal.c      |    9 ++++++++
 arch/x86/kernel/traps.c       |   32 ++++++++++++++++++++++--------
 fs/timerfd.c                  |    2 +-
 include/linux/interrupt.h     |    2 +
 include/linux/irq.h           |    4 ++-
 include/linux/sched.h         |    4 +++
 kernel/irq/autoprobe.c        |    4 +-
 kernel/irq/chip.c             |   42 ++++++++++++++++++++++++++++++++--------
 kernel/irq/internals.h        |    2 +-
 kernel/irq/manage.c           |   15 ++++++++++++-
 kernel/irq/settings.h         |   12 +++++++++++
 kernel/rtmutex.c              |   32 ++++++++++++++++++++++++++++++-
 kernel/rtmutex_common.h       |    1 +
 kernel/signal.c               |   37 ++++++++++++++++++++++++++++++++++-
 kernel/softirq.c              |    7 ++++++
 localversion-rt               |    2 +-
 17 files changed, 191 insertions(+), 29 deletions(-)

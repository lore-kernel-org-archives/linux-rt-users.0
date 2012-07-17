From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/12] [ANNOUNCE] 3.4.4-rt14-rc2 stable review
Date: Tue, 17 Jul 2012 11:31:15 -0400
Message-ID: <20120717153115.606116459@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.4-rt14-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/18/2012.

What changed between -rc1:

  Patch was added:
    cpu/rt: Fix cpu_hotplug variable initialization

Enjoy,

-- Steve


To build 3.4.4-rt14-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.4.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.4-rt14-rc2.patch.xz

You can also build from 3.4.4-rt13 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.4-rt13-rt14-rc2.patch.xz


Changes from 3.4.4-rt13:

---


Carsten Emde (4):
      Latency histogramms: Cope with backwards running local trace clock
      Latency histograms: Adjust timer, if already elapsed when programmed
      Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
      Latency histograms: Detect another yet overlooked sharedprio condition

Mike Galbraith (1):
      fs, jbd: pull your plug when waiting for space

Steven Rostedt (5):
      cpu/rt: Rework cpu down for PREEMPT_RT
      cpu/rt: Fix cpu_hotplug variable initialization
      workqueue: Revert workqueue: Fix PF_THREAD_BOUND abuse
      workqueue: Revert workqueue: Fix cpuhotplug trainwreck
      Linux 3.4.4-rt14-rc2

Thomas Gleixner (1):
      slab: Prevent local lock deadlock

Yong Zhang (1):
      perf: Make swevent hrtimer run in irq instead of softirq

----
 fs/jbd/checkpoint.c         |    2 +
 include/linux/cpu.h         |    6 +-
 include/linux/hrtimer.h     |    3 +
 include/linux/sched.h       |    9 +-
 include/linux/workqueue.h   |    5 +-
 init/Kconfig                |    1 +
 kernel/cpu.c                |  240 ++++++++++++++----
 kernel/events/core.c        |    1 +
 kernel/hrtimer.c            |   16 +-
 kernel/sched/core.c         |   82 +++++-
 kernel/trace/latency_hist.c |   74 +++---
 kernel/workqueue.c          |  578 +++++++++++++++++++++++++++++++------------
 localversion-rt             |    2 +-
 mm/slab.c                   |   26 +-
 14 files changed, 788 insertions(+), 257 deletions(-)

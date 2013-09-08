From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/19] 3.6.11.8-rt41-rc1 stable review
Date: Sun, 08 Sep 2013 11:13:55 -0400
Message-ID: <20130908151355.362583092@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
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

This is the RT stable review cycle of patch 3.6.11.8-rt41-rc1.

Please scream at me if I messed something up. Please test the patches t=
oo.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release can=
didate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/11/2013.

Enjoy,

-- Steve


To build 3.6.11.8-rt41-rc1 directly, the following patches should be ap=
plied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.6.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.6.11.8.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.11.8=
-rt41-rc1.patch.xz

You can also build from 3.6.11.8-rt40 by applying the incremental patch=
:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.1=
1.8-rt40-rt41-rc1.patch.xz


Changes from 3.6.11.8-rt40:

---


Ivo Sieben (1):
      genirq: Set irq thread to RT priority on creation

John Kacur (1):
      hpsa: fix warning with smp_processor_id() in preemptible section

Mike Galbraith (1):
      x86/mce: fix mce timer interval

Paul Gortmaker (1):
      list_bl.h: make list head locking RT safe

Sebastian Andrzej Siewior (5):
      kernel/cpu: fix cpu down problem if kthread's cpu is going down
      kernel/hotplug: restore original cpu mask oncpu/down
      gpu: i915: allow the user not to do the wbinvd
      drm/i915: drop trace_i915_gem_ring_dispatch on rt
      genirq: do not invoke the affinity callback via a workqueue

Steven Rostedt (5):
      sched/workqueue: Only wake up idle workers if not blocked on slee=
ping spin lock
      rt,ntp: Move call to schedule_delayed_work() to helper thread
      hwlat-detector: Update hwlat_detector to add outer loop detection
      hwlat-detector: Use trace_clock_local if available
      hwlat-detector: Use thread instead of stop machine

Steven Rostedt (Red Hat) (2):
      hwlat-detect/trace: Export trace_clock_local for hwlat-detector
      Linux 3.6.11.8-rt41-rc1

Thomas Gleixner (1):
      sched: Distangle worker accounting from rqlock

Uwe Kleine-K=C3=B6nig (1):
      list_bl.h: fix it for for !SMP && !DEBUG_SPINLOCK

Zhao Hongjiang (1):
      timers: prepare for full preemption improve

----
 arch/x86/kernel/cpu/mcheck/mce.c           |    2 +-
 drivers/gpu/drm/i915/i915_gem.c            |   17 +++-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +
 drivers/misc/hwlat_detector.c              |  117 +++++++++++++++++---=
--------
 drivers/scsi/hpsa.c                        |    2 +-
 include/linux/interrupt.h                  |    1 +
 include/linux/list_bl.h                    |   28 ++++++-
 kernel/cpu.c                               |   29 ++++++-
 kernel/irq/manage.c                        |   90 +++++++++++++++++++-=
-
 kernel/sched/core.c                        |   68 ++++------------
 kernel/time/ntp.c                          |   40 ++++++++++
 kernel/timer.c                             |    8 +-
 kernel/trace/trace_clock.c                 |    1 +
 kernel/workqueue.c                         |   59 +++++++-------
 kernel/workqueue_sched.h                   |    5 +-
 localversion-rt                            |    2 +-
 16 files changed, 319 insertions(+), 152 deletions(-)

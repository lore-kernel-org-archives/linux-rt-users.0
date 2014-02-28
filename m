From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/11] Linux 3.10.32-rt31-rc1
Date: Fri, 28 Feb 2014 08:34:54 -0500
Message-ID: <20140228133454.373761937@goodmis.org>
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

This is the RT stable review cycle of patch 3.10.32-rt31-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/3/2014.

Enjoy,

-- Steve


To build 3.10.32-rt31-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.32.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.32-rt31-rc1.patch.xz

You can also build from 3.10.32-rt30 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.32-rt30-rt31-rc1.patch.xz


Changes from 3.10.32-rt30:

---


Nicholas Mc Guire (1):
      net: ip_send_unicast_reply: add missing local serialization

Sebastian Andrzej Siewior (4):
      Revert "x86: Disable IST stacks for debug/int 3/stack fault for PREEMPT_RT"
      kernel/hrtimer: be non-freezeable in cpu_chill()
      arm/unwind: use a raw_spin_lock
      leds: trigger: disable CPU trigger on -RT

Steven Rostedt (3):
      timer: Raise softirq if there's irq_work
      timer/rt: Always raise the softirq if there's irq_work to be done
      rt: Make cpu_chill() use hrtimer instead of msleep()

Steven Rostedt (Red Hat) (1):
      Linux 3.10.32-rt31-rc1

Thomas Gleixner (1):
      timers: do not raise softirq unconditionally

Tiejun Chen (1):
      rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()

----
 arch/arm/kernel/unwind.c             | 14 +++++-----
 arch/x86/include/asm/page_64_types.h | 21 +++++----------
 arch/x86/kernel/cpu/common.c         |  2 --
 arch/x86/kernel/dumpstack_64.c       |  4 ---
 drivers/leds/trigger/Kconfig         |  2 +-
 include/linux/delay.h                |  2 +-
 include/linux/hrtimer.h              |  3 +--
 kernel/hrtimer.c                     | 50 +++++++++++++++++++-----------------
 kernel/rcutree.c                     |  5 ++++
 kernel/timer.c                       | 35 ++++++++++++++++++++++---
 localversion-rt                      |  2 +-
 net/ipv4/ip_output.c                 |  9 ++++---
 12 files changed, 86 insertions(+), 63 deletions(-)

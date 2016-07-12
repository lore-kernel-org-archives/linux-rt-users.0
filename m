From: Steven Rostedt <rostedt@goodmis.org>
Subject: Linux 4.1.27-rt31-rc2
Date: Tue, 12 Jul 2016 19:18:00 -0400
Message-ID: <20160712191800.2f90f3a8@gandalf.local.home>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:59590 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751203AbcGLXSX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 19:18:23 -0400
In-Reply-To: <20160712142405.634544943@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 4.1.27-rt31-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/14/2016.

Only difference from v1 is the removal of "ARM: imx: always use TWD on
IMX6Q"

Enjoy,

-- Steve


To build 4.1.27-rt31-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-4.1.27.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.27-rt31-rc2.patch.xz

You can also build from 4.1.27-rt30 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.27-rt30-rt31-rc2.patch.xz


Changes from 4.1.27-rt30:

---


Alexandre Belloni (5):
      ARM: at91: pm: simply call at91_pm_init
      ARM: at91: pm: find and remap the pmc
      ARM: at91: pm: move idle functions to pm.c
      ARM: at91: remove useless includes and function prototypes
      usb: gadget: atmel: access the PMC using regmap

Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (2):
      mm/zsmalloc: Use get/put_cpu_light in zs_map_object()/zs_unmap_object()
      drivers/block/zram: Replace bit spinlocks with rtmutex for -rt

Peter Zijlstra (1):
      sched,preempt: Fix preempt_count manipulations

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (6):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      drivers/block/zram: fixup compile for !RT
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 4.1.27-rt31-rc2

Thomas Gleixner (1):
      perf/x86/intel/rapl: Make PMU lock raw

----
 arch/arm/kernel/entry-armv.S                |  6 ++-
 arch/arm/mach-at91/at91rm9200.c             |  2 -
 arch/arm/mach-at91/at91sam9.c               |  2 -
 arch/arm/mach-at91/generic.h                | 13 +-----
 arch/arm/mach-at91/pm.c                     | 70 ++++++++++++++++++++++++-----
 arch/arm/mach-at91/sama5.c                  |  2 +-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 20 ++++-----
 arch/x86/kernel/kvm.c                       | 37 +++++++--------
 drivers/block/zram/zram_drv.c               | 30 +++++++------
 drivers/block/zram/zram_drv.h               | 41 +++++++++++++++++
 drivers/clk/at91/pmc.c                      | 15 -------
 drivers/usb/gadget/udc/atmel_usba_udc.c     | 20 ++++-----
 drivers/usb/gadget/udc/atmel_usba_udc.h     |  2 +
 include/asm-generic/preempt.h               |  4 +-
 include/linux/list_bl.h                     | 12 ++---
 include/linux/locallock.h                   |  6 +++
 kernel/printk/printk.c                      | 10 +++++
 kernel/trace/trace_events.c                 |  8 ++++
 localversion-rt                             |  2 +-
 mm/swap.c                                   | 37 ++++++++++++---
 mm/zsmalloc.c                               |  4 +-
 net/core/dev.c                              |  4 ++
 22 files changed, 235 insertions(+), 112 deletions(-)

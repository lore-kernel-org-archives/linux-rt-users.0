From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Linux 3.12.38-rt53-rc3
Date: Tue, 17 Mar 2015 18:21:17 -0400
Message-ID: <20150317182117.16e26852@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:44166 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753294AbbCQWVU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2015 18:21:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.12.38-rt53-rc3.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/20/2015.

Enjoy,

-- Steve


To build 3.12.38-rt53-rc3 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.38-rt53-rc3.patch.xz

You can also build from 3.12.38-rt52 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.38-rt52-rt53-rc3.patch.xz


Changes from 3.12.38-rt52:

---


Daniel Wagner (2):
      work-simple: Simple work queue implemenation
      thermal: Defer thermal wakups to threads

Gustavo Bittencourt (1):
      rtmutex: enable deadlock detection in ww_mutex_lock functions

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Kevin Hao (1):
      netpoll: guard the access to dev->npinfo with rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y

Mike Galbraith (6):
      rt: fix __ww_mutex_lock_interruptible() lockdep annotation
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()
      locking: ww_mutex: fix ww_mutex vs self-deadlock
      fs,btrfs: fix rt deadlock on extent_buffer->lock

Paul E. McKenney (4):
      timers: Track total number of timers in list
      timers: Reduce __run_timers() latency for empty list
      timers: Reduce future __run_timers() latency for newly emptied list
      timers: Reduce future __run_timers() latency for first add to empty list

Paul Gortmaker (1):
      sas-ata/isci: dont't disable interrupts in qc_issue handler

Sebastian Andrzej Siewior (4):
      gpio: omap: use raw locks for locking
      rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()
      fs/aio: simple simple work

Steven Rostedt (1):
      create-rt-enqueue

Steven Rostedt (Red Hat) (2):
      Revert "timers: do not raise softirq unconditionally"
      Linux 3.12.38-rt53-rc3

Thomas Gleixner (14):
      rtmutex: Simplify rtmutex_slowtrylock()
      rtmutex: Simplify and document try_to_take_rtmutex()
      rtmutex: No need to keep task ref for lock owner check
      rtmutex: Clarify the boost/deboost part
      rtmutex: Document pi chain walk
      rtmutex: Simplify remove_waiter()
      rtmutex: Confine deadlock logic to futex
      rtmutex: Cleanup deadlock detector debug logic
      rtmutex: Avoid pointless requeueing in the deadlock detection chain walk
      futex: Make unlock_pi more robust
      futex: Use futex_top_waiter() in lookup_pi_state()
      futex: Split out the waiter check from lookup_pi_state()
      futex: Split out the first waiter attachment from lookup_pi_state()
      futex: Simplify futex_lock_pi_atomic() and make it more robust

Yadi.hu (1):
      ARM: enable irq in translation/section permission fault handlers

Yong Zhang (1):
      ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later

----
 arch/arm/include/asm/cmpxchg.h         |   2 +
 arch/arm/include/asm/futex.h           |   4 +
 arch/arm/mm/fault.c                    |   6 +
 arch/x86/include/asm/uv/uv_bau.h       |  14 +-
 arch/x86/include/asm/uv/uv_hub.h       |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c     |   2 +-
 arch/x86/platform/uv/tlb_uv.c          |  26 +-
 arch/x86/platform/uv/uv_time.c         |  21 +-
 drivers/gpio/gpio-omap.c               |  70 ++--
 drivers/scsi/libsas/sas_ata.c          |   4 +-
 drivers/thermal/x86_pkg_temp_thermal.c |  50 ++-
 fs/aio.c                               |  24 +-
 fs/btrfs/ctree.c                       |   4 +-
 fs/btrfs/extent-tree.c                 |   8 -
 include/linux/hrtimer.h                |   3 +-
 include/linux/netpoll.h                |  16 +-
 include/linux/rtmutex.h                |   8 +-
 include/linux/work-simple.h            |  24 ++
 kernel/futex.c                         | 407 ++++++++++-----------
 kernel/hrtimer.c                       |  31 +-
 kernel/rt.c                            |   8 +-
 kernel/rtmutex-debug.c                 |   5 +-
 kernel/rtmutex-debug.h                 |   7 +-
 kernel/rtmutex-tester.c                |   4 +-
 kernel/rtmutex.c                       | 628 ++++++++++++++++++++++++---------
 kernel/rtmutex.h                       |   7 +-
 kernel/rtmutex_common.h                |  22 +-
 kernel/sched/Makefile                  |   1 +
 kernel/sched/work-simple.c             | 172 +++++++++
 kernel/timer.c                         |  72 ++--
 lib/locking-selftest.c                 |  27 ++
 localversion-rt                        |   2 +-
 mm/memcontrol.c                        |  13 +-
 net/sunrpc/svc_xprt.c                  |   4 +-
 34 files changed, 1143 insertions(+), 555 deletions(-)

Diff from -rc2:
---
diff --git a/localversion-rt b/localversion-rt
index ee99e6c64538..28146e914ab2 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt53-rc2
+-rt53-rc3
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba7a8ae06476..8565a826543e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2415,16 +2415,18 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	bool ret = true;
+	int cpu;
 
 	if (nr_pages > CHARGE_BATCH)
 		return false;
 
-	stock = &get_cpu_var(memcg_stock);
+	cpu = get_cpu_light();
+	stock = &per_cpu(memcg_stock, cpu);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages)
 		stock->nr_pages -= nr_pages;
 	else /* need to call res_counter_charge */
 		ret = false;
-	put_cpu_var(memcg_stock);
+	put_cpu_light();
 	return ret;
 }
 

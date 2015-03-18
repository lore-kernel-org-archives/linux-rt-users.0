From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Linux 3.2.68-rt99-rc4
Date: Wed, 18 Mar 2015 10:04:36 -0400
Message-ID: <20150318100436.33c90fe5@gandalf.local.home>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.68-rt99-rc4.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/20/2015.

Enjoy,

-- Steve


To build 3.2.68-rt99-rc4 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.68.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.68-rt99-rc4.patch.xz

You can also build from 3.2.68-rt98 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.68-rt98-rt99-rc4.patch.xz


Changes from 3.2.68-rt98:

---


Daniel Wagner (1):
      work-simple: Simple work queue implemenation

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Mike Galbraith (4):
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()
      fs,btrfs: fix rt deadlock on extent_buffer->lock

Sebastian Andrzej Siewior (3):
      gpio: omap: use raw locks for locking
      rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()

Steven Rostedt (1):
      create-rt-enqueue

Steven Rostedt (Red Hat) (1):
      Linux 3.2.68-rt99-rc4

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

----
 arch/arm/include/asm/futex.h       |   4 +
 arch/arm/mm/fault.c                |   6 +
 arch/x86/include/asm/uv/uv_bau.h   |  12 +-
 arch/x86/include/asm/uv/uv_hub.h   |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |  12 +-
 arch/x86/platform/uv/tlb_uv.c      |  30 +-
 arch/x86/platform/uv/uv_time.c     |  21 +-
 drivers/gpio/gpio-omap.c           |  64 ++--
 fs/btrfs/ctree.c                   |   4 +-
 include/linux/rtmutex.h            |   8 +-
 include/linux/work-simple.h        |  24 ++
 kernel/Makefile                    |   2 +-
 kernel/futex.c                     | 407 +++++++++++--------------
 kernel/rt.c                        |   8 +-
 kernel/rtmutex-debug.c             |   5 +-
 kernel/rtmutex-debug.h             |   7 +-
 kernel/rtmutex-tester.c            |   4 +-
 kernel/rtmutex.c                   | 603 +++++++++++++++++++++++++++----------
 kernel/rtmutex.h                   |   7 +-
 kernel/rtmutex_common.h            |  22 +-
 kernel/work-simple.c               | 172 +++++++++++
 lib/locking-selftest.c             |  27 ++
 localversion-rt                    |   2 +-
 mm/memcontrol.c                    |   7 +-
 net/sunrpc/svc_xprt.c              |   4 +-
 25 files changed, 988 insertions(+), 476 deletions(-)

Diff from -rc3:
---
diff --git a/localversion-rt b/localversion-rt
index f756c3d9344c..057634ab6b28 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt99-rc3
+-rt99-rc4
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 00a1012ecfec..663f1a01b519 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2011,15 +2011,13 @@ static bool consume_stock(struct mem_cgroup *memcg)
 {
 	struct memcg_stock_pcp *stock;
 	bool ret = true;
-	int cpu;
 
-	cpu = get_cpu_light();
-	stock = &per_cpu(memcg_stock, cpu);
+	stock = &get_cpu_var(memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages)
 		stock->nr_pages--;
 	else /* need to call res_counter_charge */
 		ret = false;
-	put_cpu_light();
+	put_cpu_var(memcg_stock);
 	return ret;
 }
 

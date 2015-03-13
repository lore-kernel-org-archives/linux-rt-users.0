From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/25] Linux 3.2.68-rt99-rc1
Date: Fri, 13 Mar 2015 11:18:25 -0400
Message-ID: <20150313151825.583263173@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60807 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945921AbbCMPfY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 11:35:24 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.68-rt99-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/16/2015.

Enjoy,

-- Steve


To build 3.2.68-rt99-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.68.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.68-rt99-rc1.patch.xz

You can also build from 3.2.68-rt98 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.68-rt98-rt99-rc1.patch.xz


Changes from 3.2.68-rt98:

---


Daniel Wagner (1):
      work-simple: Simple work queue implemenation

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Mike Galbraith (3):
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()

Sebastian Andrzej Siewior (3):
      gpio: omap: use raw locks for locking
      rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()

Steven Rostedt (1):
      create-rt-enqueue

Steven Rostedt (Red Hat) (1):
      Linux 3.2.68-rt99-rc1

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
 24 files changed, 986 insertions(+), 474 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: Linux 3.14.72-rt76-rc2
Date: Tue, 12 Jul 2016 19:21:54 -0400
Message-ID: <20160712192154.69536da2@gandalf.local.home>
References: <20160712164759.154249453@goodmis.org>
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
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:39975 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750843AbcGLXWD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 19:22:03 -0400
In-Reply-To: <20160712164759.154249453@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.14.72-rt76-rc2.

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


To build 3.14.72-rt76-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.72.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.72-rt76-rc2.patch.xz

You can also build from 3.14.72-rt75 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.72-rt75-rt76-rc2.patch.xz


Changes from 3.14.72-rt75:

---


Corey Minyard (1):
      x86: Fix an RT MCE crash

Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (1):
      mm/zsmalloc: Use get/put_cpu_light in zs_map_object()/zs_unmap_object()

Peter Zijlstra (1):
      sched,preempt: Fix preempt_count manipulations

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (5):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 3.14.72-rt76-rc2

Thomas Gleixner (1):
      perf/x86/intel/rapl: Make PMU lock raw

----
 arch/arm/kernel/entry-armv.S                |  6 ++++-
 arch/x86/kernel/cpu/mcheck/mce.c            |  3 ++-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 20 ++++++++--------
 arch/x86/kernel/kvm.c                       | 37 +++++++++++++++--------------
 include/asm-generic/preempt.h               |  4 ++--
 include/linux/list_bl.h                     | 12 ++++++----
 include/linux/locallock.h                   |  6 +++++
 include/trace/ftrace.h                      |  3 +++
 kernel/printk/printk.c                      | 10 ++++++++
 localversion-rt                             |  2 +-
 mm/swap.c                                   | 37 +++++++++++++++++++++++------
 mm/zsmalloc.c                               |  4 ++--
 net/core/dev.c                              |  4 ++++
 13 files changed, 101 insertions(+), 47 deletions(-)

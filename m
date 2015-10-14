From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 0/4] Simple wait queue support
Date: Wed, 14 Oct 2015 09:43:18 +0200
Message-ID: <1444808602-29500-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

As Peter pointed out the conversion to swait in completion is not so
simple. For the time being I drop it and look at them later again.
The main reason is that complete_all() can be called from hard-irq/atomic
context and we can't use swake_up_all() because that function wants
to run with IRQs enabled. If we can ensure that all callers of
complete_all() are running under normal context for -rt.

In this version I tried to weed out all obvious typos for the
different platforms which I missed in v1. 

These patches are against

  tip/master e6f195fd5c80214c5a4f139ee28798e66e20aa8f

also available as git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git tip-swait

cheers,
daniel

[I got the numbering wrong in v1, so instead 'PATCH v1' you find it
 as 'PATCH v0' series]

changes since v1 (PATCH v0)
 - rebased and fixed some typos found by cross building
   for S390, ARM and powerpc. For some unknown reason didn't catch
   them last time.
 - dropped completion patches because it is not clear yet
   how to handle complete_all() calls hard-irq/atomic contexts
   and swake_up_all.

changes since v0 (RFC v0)
 - promoted the series to PATCH state instead of RFC
 - fixed a few fallouts with build all and some cross compilers
   such ARM, PowerPC, S390.
 - Added the simple waitqueue transformation for KVM from -rt
   including some numbers requested by Paolo.
 - Added a commit message to PeterZ's patch. Hope he likes it.

v1: http://lwn.net/Articles/656942/
v0: http://lwn.net/Articles/653586/

Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org

Daniel Wagner (1):
  rcu: Do not call swake_up_all with rnp->lock holding

Marcelo Tosatti (1):
  KVM: use simple waitqueue for vcpu->wq

Paul Gortmaker (1):
  rcu: use simple wait queues where possible in rcutree

Peter Zijlstra (Intel) (1):
  wait.[ch]: Introduce the simple waitqueue (swait) implementation

 arch/arm/kvm/arm.c                  |   4 +-
 arch/arm/kvm/psci.c                 |   4 +-
 arch/powerpc/include/asm/kvm_host.h |   4 +-
 arch/powerpc/kvm/book3s_hv.c        |  23 +++--
 arch/s390/include/asm/kvm_host.h    |   2 +-
 arch/s390/kvm/interrupt.c           |   8 +-
 arch/x86/kvm/lapic.c                |   6 +-
 include/linux/kvm_host.h            |   5 +-
 include/linux/swait.h               | 172 ++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c                   |  17 ++--
 kernel/rcu/tree.h                   |  10 ++-
 kernel/rcu/tree_plugin.h            |  32 ++++---
 kernel/sched/Makefile               |   2 +-
 kernel/sched/swait.c                | 122 +++++++++++++++++++++++++
 virt/kvm/async_pf.c                 |   4 +-
 virt/kvm/kvm_main.c                 |  17 ++--
 16 files changed, 370 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

-- 
2.4.3

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] Linux 3.10.102-rt113-rc1
Date: Tue, 12 Jul 2016 12:57:49 -0400
Message-ID: <20160712165749.741663758@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.10.102-rt113-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/14/2016.

Enjoy,

-- Steve


To build 3.10.102-rt113-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.102.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.102-rt113-rc1.patch.xz

You can also build from 3.10.102-rt112 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.102-rt112-rt113-rc1.patch.xz


Changes from 3.10.102-rt112:

---


Corey Minyard (1):
      x86: Fix an RT MCE crash

Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (4):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 3.10.102-rt113-rc1

----
 arch/arm/kernel/entry-armv.S     |  6 +++++-
 arch/x86/kernel/cpu/mcheck/mce.c |  3 ++-
 arch/x86/kernel/kvm.c            | 37 +++++++++++++++++++------------------
 include/linux/list_bl.h          | 12 +++++++-----
 include/trace/ftrace.h           |  3 +++
 kernel/printk.c                  | 10 ++++++++++
 localversion-rt                  |  2 +-
 net/core/dev.c                   |  4 ++++
 8 files changed, 51 insertions(+), 26 deletions(-)

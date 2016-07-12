From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] Linux 3.2.81-rt117-rc1
Date: Tue, 12 Jul 2016 16:54:44 -0400
Message-ID: <20160712205444.115211356@goodmis.org>
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

This is the RT stable review cycle of patch 3.2.81-rt117-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/14/2016.

Enjoy,

-- Steve


To build 3.2.81-rt117-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.81.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.81-rt117-rc1.patch.xz

You can also build from 3.2.81-rt116 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.81-rt116-rt117-rc1.patch.xz


Changes from 3.2.81-rt116:

---


Corey Minyard (1):
      x86: Fix an RT MCE crash

Sebastian Andrzej Siewior (1):
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (2):
      Revert: KVM: lapic: mark LAPIC timer handler as irqsafe
      Linux 3.2.81-rt117-rc1

----
 arch/x86/kernel/cpu/mcheck/mce.c |  3 ++-
 arch/x86/kvm/lapic.c             | 42 +++-------------------------------------
 include/trace/ftrace.h           |  3 +++
 localversion-rt                  |  2 +-
 4 files changed, 9 insertions(+), 41 deletions(-)

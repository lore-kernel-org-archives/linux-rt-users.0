From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/6] Linux 3.14.48-rt49-rc1
Date: Thu, 06 Aug 2015 18:17:36 -0400
Message-ID: <20150806221736.555188732@goodmis.org>
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

This is the RT stable review cycle of patch 3.14.48-rt49-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 8/10/2015.

Note, these changes appear to make NO_HZ_FULL work as well as 3.18-rt does.

Enjoy,

-- Steve


To build 3.14.48-rt49-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.48.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.48-rt49-rc1.patch.xz

You can also build from 3.14.48-rt48 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.48-rt48-rt49-rc1.patch.xz


Changes from 3.14.48-rt48:

---


Bogdan Purcareata (1):
      powerpc/kvm: Disable in-kernel MPIC emulation for PREEMPT_RT_FULL

Frederic Weisbecker (1):
      x86-Tell-irq-work-about-self-IPI-support-3.14

Sebastian Andrzej Siewior (1):
      Revert "slub: delay ctor until the object is requested"

Steven Rostedt (1):
      xfs: Disable percpu SB on PREEMPT_RT_FULL

Steven Rostedt (Red Hat) (1):
      Linux 3.14.48-rt49-rc1

Thomas Gleixner (1):
      mm/slub: move slab initialization into irq enabled region

----
 arch/powerpc/kvm/Kconfig        |  1 +
 arch/x86/include/asm/Kbuild     |  1 -
 arch/x86/include/asm/irq_work.h | 11 ++++++
 arch/x86/kernel/irq_work.c      |  2 +-
 fs/xfs/xfs_linux.h              |  2 +-
 localversion-rt                 |  2 +-
 mm/slub.c                       | 86 +++++++++++++++++++----------------------
 7 files changed, 54 insertions(+), 51 deletions(-)
 create mode 100644 arch/x86/include/asm/irq_work.h

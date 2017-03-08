From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] Linux 3.10.105-rt120-rc1
Date: Wed, 08 Mar 2017 15:30:07 -0500
Message-ID: <20170308203007.731237400@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.10.105-rt120-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/10/2017.

Enjoy,

-- Steve


To build 3.10.105-rt120-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.105.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.105-rt120-rc1.patch.xz

You can also build from 3.10.105-rt119 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.105-rt119-rt120-rc1.patch.xz


Changes from 3.10.105-rt119:

---


Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Sebastian Andrzej Siewior (3):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Steven Rostedt (VMware) (1):
      Linux 3.10.105-rt120-rc1

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper

----
 arch/x86/mm/pageattr.c     |  8 ++++++++
 include/linux/module.h     |  6 ++++++
 include/linux/mutex_rt.h   |  5 +++++
 include/linux/percpu.h     |  1 +
 include/linux/radix-tree.h | 10 +---------
 kernel/lockdep.c           | 32 +++++++++++++++++++++++---------
 kernel/module.c            | 36 ++++++++++++++++++++++++------------
 lib/radix-tree.c           | 21 +++++++++++++--------
 localversion-rt            |  2 +-
 mm/percpu.c                | 37 +++++++++++++++++++++++--------------
 10 files changed, 105 insertions(+), 53 deletions(-)

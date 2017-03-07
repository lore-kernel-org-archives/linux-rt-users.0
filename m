From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/10] Linux 4.4.50-rt63-rc1
Date: Tue, 07 Mar 2017 16:20:41 -0500
Message-ID: <20170307212041.431615000@goodmis.org>
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

This is the RT stable review cycle of patch 4.4.50-rt63-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/10/2017.

**** NOTE ****

Julia Cartwright has kindly offered to take over maintaining v4.1-rt.
She will be sending out and maintaining patches and the v4.1-rt git tree.

Thank you Julia!

**** **** ****
 
Enjoy,

-- Steve


To build 4.4.50-rt63-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.50.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.50-rt63-rc1.patch.xz

You can also build from 4.4.50-rt62 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.50-rt62-rt63-rc1.patch.xz


Changes from 4.4.50-rt62:

---


Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Julia Cartwright (1):
      pinctrl: qcom: Use raw spinlock variants

Mike Galbraith (1):
      cpuset: Convert callback_lock to raw_spinlock_t

Sebastian Andrzej Siewior (4):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      sched/rt: Add a missing rescheduling point
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Steven Rostedt (VMware) (1):
      Linux 4.4.50-rt63-rc1

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper

----
 arch/x86/mm/pageattr.c             |  8 +++++
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++--------------
 include/linux/module.h             |  6 ++++
 include/linux/mutex_rt.h           |  5 +++
 include/linux/percpu.h             |  1 +
 include/linux/radix-tree.h         | 12 ++-----
 kernel/cpuset.c                    | 66 +++++++++++++++++++-------------------
 kernel/locking/lockdep.c           | 33 +++++++++++++------
 kernel/module.c                    | 36 ++++++++++++++-------
 kernel/sched/deadline.c            |  3 +-
 kernel/sched/rt.c                  |  3 +-
 lib/radix-tree.c                   | 23 +++++++------
 localversion-rt                    |  2 +-
 mm/percpu.c                        | 37 +++++++++++++--------
 14 files changed, 166 insertions(+), 117 deletions(-)

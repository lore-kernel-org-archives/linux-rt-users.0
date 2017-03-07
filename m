From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 0/9] Linux 4.1.38-rt46-rc1
Date: Tue, 7 Mar 2017 16:32:50 -0600
Message-ID: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.1.38-rt46-rc1.  Please review
the included patches, and test!

The -rc release will be uploaded to kernel.org and will be deleted when the
final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/10/2017.

Many thanks to Steven Rostedt for all of his efforts in maintaining v4.1-rt,
and his continued mentorship!

   Julia

----------------------------------------------------------------
To build 4.1.38-rt46-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.38-rt46-rc1.patch.xz

You can also build from 4.1.38-rt46-rc1 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.38-rt45-rt46-rc1.patch.xz

----------------------------------------------------------------
Dan Murphy (1):
  lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
  x86/mm/cpa: avoid wbinvd() for PREEMPT

Julia Cartwright (2):
  pinctrl: qcom: Use raw spinlock variants
  Linux 4.1.38-rt46-rc1

Mike Galbraith (1):
  cpuset: Convert callback_lock to raw_spinlock_t

Sebastian Andrzej Siewior (3):
  radix-tree: use local locks
  rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from
    export symbol
  rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Thomas Gleixner (1):
  lockdep: Handle statically initialized PER_CPU locks proper

 arch/x86/mm/pageattr.c             |  8 +++++
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++--------------
 include/linux/module.h             |  6 ++++
 include/linux/mutex_rt.h           |  5 +++
 include/linux/percpu.h             |  1 +
 include/linux/radix-tree.h         | 12 ++-----
 kernel/cpuset.c                    | 66 +++++++++++++++++++-------------------
 kernel/locking/lockdep.c           | 33 +++++++++++++------
 kernel/module.c                    | 36 ++++++++++++++-------
 lib/radix-tree.c                   | 22 ++++++++-----
 localversion-rt                    |  2 +-
 mm/percpu.c                        | 37 +++++++++++++--------
 12 files changed, 164 insertions(+), 112 deletions(-)

-- 
2.11.1

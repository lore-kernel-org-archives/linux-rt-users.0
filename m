From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] Linux 3.18.48-rt54-rc1
Date: Wed, 08 Mar 2017 15:20:55 -0500
Message-ID: <20170308202055.192561119@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753778AbdCHUYc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Mar 2017 15:24:32 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.18.48-rt54-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/10/2017.

Enjoy,

-- Steve


To build 3.18.48-rt54-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.48.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.48-rt54-rc1.patch.xz

You can also build from 3.18.48-rt53 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.48-rt53-rt54-rc1.patch.xz


Changes from 3.18.48-rt53:

---


Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Julia Cartwright (1):
      pinctrl: qcom: Use raw spinlock variants

Sebastian Andrzej Siewior (3):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Steven Rostedt (VMware) (1):
      Linux 3.18.48-rt54-rc1

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper

----
 arch/x86/mm/pageattr.c             |  8 +++++++
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++-------------------
 include/linux/module.h             |  6 +++++
 include/linux/mutex_rt.h           |  5 ++++
 include/linux/percpu.h             |  1 +
 include/linux/radix-tree.h         | 12 ++--------
 kernel/locking/lockdep.c           | 32 ++++++++++++++++++-------
 kernel/module.c                    | 36 ++++++++++++++++++----------
 lib/radix-tree.c                   | 23 +++++++++++-------
 localversion-rt                    |  2 +-
 mm/percpu.c                        | 37 ++++++++++++++++++-----------
 11 files changed, 131 insertions(+), 79 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] Linux 4.9.61-rt52-rc2
Date: Thu, 23 Nov 2017 00:23:17 -0500
Message-ID: <20171123052317.319740795@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.9.61-rt52-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/27/2017.

Note, I realized I only backported from v4.13.10-rt3 and not v4.13.13-rt5.
Added a few more patches.

Enjoy,

-- Steve


To build 4.9.61-rt52-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.61.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.61-rt52-rc2.patch.xz

You can also build from 4.9.61-rt51 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.61-rt51-rt52-rc2.patch.xz


Changes from 4.9.61-rt51:

---


Haris Okanovic (1):
      tpm_tis: fix stall after iowrite*()s

Mike Galbraith (1):
      drivers/zram: fix zcomp_stream_get() smp_processor_id() use in preemptible code

Mikulas Patocka (1):
      locking/rt-mutex: fix deadlock in device mapper / block-IO

Sebastian Andrzej Siewior (3):
      fs/dcache: disable preemption on i_dir_seq's write side
      fs: convert two more BH_Uptodate_Lock related bitspinlocks
      md/raid5: do not disable interrupts

Steven Rostedt (VMware) (1):
      Linux 4.9.61-rt52-rc2

----
 drivers/block/zram/zcomp.c |  3 ++-
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 drivers/md/raid5.c         |  4 ++--
 fs/dcache.c                | 12 +++++++-----
 fs/ext4/page-io.c          |  6 ++----
 fs/inode.c                 |  2 +-
 fs/libfs.c                 |  6 ++++--
 fs/xfs/xfs_aops.c          |  6 ++----
 include/linux/fs.h         |  2 +-
 kernel/locking/rtmutex.c   | 13 +++++++++++++
 localversion-rt            |  2 +-
 11 files changed, 62 insertions(+), 23 deletions(-)

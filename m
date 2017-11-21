From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] Linux 4.9.61-rt52-rc1
Date: Tue, 21 Nov 2017 11:04:42 -0500
Message-ID: <20171121160442.866038796@goodmis.org>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdKUQFS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 11:05:18 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 4.9.61-rt52-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/27/2017.

Enjoy,

-- Steve


To build 4.9.61-rt52-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.61.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.61-rt52-rc1.patch.xz

You can also build from 4.9.61-rt51 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.61-rt51-rt52-rc1.patch.xz


Changes from 4.9.61-rt51:

---


Haris Okanovic (1):
      tpm_tis: fix stall after iowrite*()s

Mike Galbraith (1):
      drivers/zram: fix zcomp_stream_get() smp_processor_id() use in preemptible code

Sebastian Andrzej Siewior (1):
      fs/dcache: disable preemption on i_dir_seq's write side

Steven Rostedt (VMware) (1):
      Linux 4.9.61-rt52-rc1

----
 drivers/block/zram/zcomp.c |  3 ++-
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 fs/dcache.c                | 12 +++++++-----
 fs/inode.c                 |  2 +-
 fs/libfs.c                 |  6 ++++--
 include/linux/fs.h         |  2 +-
 localversion-rt            |  2 +-
 7 files changed, 43 insertions(+), 13 deletions(-)

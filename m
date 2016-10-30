From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] Linux 3.2.83-rt121-rc1
Date: Sun, 30 Oct 2016 12:51:09 -0400
Message-ID: <20161030165109.200928387@goodmis.org>
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

This is the RT stable review cycle of patch 3.2.83-rt121-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/2/2016.

Enjoy,

-- Steve


To build 3.2.83-rt121-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.83.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.83-rt121-rc1.patch.xz

You can also build from 3.2.83-rt120 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.83-rt120-rt121-rc1.patch.xz


Changes from 3.2.83-rt120:

---


Ben Hutchings (2):
      genirq: Fix pointer cast warning for randomness on 32-bit architectures
      work-simple: Add missing #include <linux/export.h>

Steven Rostedt (Red Hat) (1):
      Linux 3.2.83-rt121-rc1

----
 kernel/irq/manage.c  | 3 ++-
 kernel/work-simple.c | 1 +
 localversion-rt      | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

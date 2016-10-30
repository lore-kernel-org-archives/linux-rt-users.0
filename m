From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] Linux 3.10.104-rt117-rc1
Date: Sun, 30 Oct 2016 12:49:31 -0400
Message-ID: <20161030164931.614263675@goodmis.org>
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

This is the RT stable review cycle of patch 3.10.104-rt117-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/2/2016.

Enjoy,

-- Steve


To build 3.10.104-rt117-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.104.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.104-rt117-rc1.patch.xz

You can also build from 3.10.104-rt116 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.104-rt116-rt117-rc1.patch.xz


Changes from 3.10.104-rt116:

---


Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (1):
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 3.10.104-rt117-rc1

----
 Makefile             |  2 +-
 kernel/trace/trace.c | 22 +++++++++++-----------
 localversion-rt      |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

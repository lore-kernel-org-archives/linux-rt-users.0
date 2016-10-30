From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 4.1.35-rt41-rc1
Date: Sun, 30 Oct 2016 12:46:35 -0400
Message-ID: <20161030164635.444929710@goodmis.org>
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

This is the RT stable review cycle of patch 4.1.35-rt41-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/2/2016.

Enjoy,

-- Steve


To build 4.1.35-rt41-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.35.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.35-rt41-rc1.patch.xz

You can also build from 4.1.35-rt40 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.35-rt40-rt41-rc1.patch.xz


Changes from 4.1.35-rt40:

---


Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (3):
      zsmalloc: turn that get_cpu_light() into a local_lock()
      x86/apic: get rid of "warning: 'acpi_ioapic_lock' defined but not used"
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 4.1.35-rt41-rc1

----
 Makefile                    |  2 +-
 arch/x86/kernel/acpi/boot.c |  2 ++
 kernel/trace/trace.c        | 32 ++++++++++++++++----------------
 localversion-rt             |  2 +-
 mm/zsmalloc.c               |  6 ++++--
 5 files changed, 24 insertions(+), 20 deletions(-)

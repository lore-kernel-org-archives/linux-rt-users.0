From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.0.65-rt92-rc1
Date: Tue, 19 Feb 2013 00:31:16 -0500
Message-ID: <20130219053116.706325380@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.65-rt92-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/22/2013.

Enjoy,

-- Steve


To build 3.0.65-rt92-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.65.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.65-rt92-rc1.patch.xz

You can also build from 3.0.65-rt91 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.65-rt91-rt92-rc1.patch.xz


Changes from 3.0.65-rt91:

---


Steven Rostedt (2):
      acpi/rt: Convert acpi_gbl_hardware lock back to a raw_spinlock_t
      Linux 3.0.65-rt92-rc1

Thomas Gleixner (2):
      x86/32: Use kmap switch for non highmem as well
      rcutiny: Use simple waitqueue

----
 arch/x86/kernel/process_32.c    |    2 +-
 drivers/acpi/acpica/acglobal.h  |    2 +-
 drivers/acpi/acpica/hwregs.c    |    4 ++--
 drivers/acpi/acpica/hwxface.c   |    4 ++--
 drivers/acpi/acpica/utmutex.c   |    4 ++--
 include/acpi/platform/aclinux.h |   14 ++++++++++++++
 include/linux/sched.h           |    4 +++-
 kernel/rcutiny_plugin.h         |    9 +++++----
 localversion-rt                 |    2 +-
 9 files changed, 31 insertions(+), 14 deletions(-)

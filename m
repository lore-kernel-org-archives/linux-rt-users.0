From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] [ANNOUNCE] 3.2.38-rt58-rc1 stable review
Date: Mon, 18 Feb 2013 22:56:23 -0500
Message-ID: <20130219035623.277664914@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2898 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab3BSD4q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2013 22:56:46 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.38-rt58-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/22/2013.

Enjoy,

-- Steve


To build 3.2.38-rt58-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.38.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.38-rt58-rc1.patch.xz

You can also build from 3.2.38-rt57 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.38-rt57-rt58-rc1.patch.xz


Changes from 3.2.38-rt57:

---


Bu, Yitian (1):
      printk: Fix rq->lock vs logbuf_lock unlock lock inversion

Steven Rostedt (2):
      acpi/rt: Convert acpi_gbl_hardware lock back to a raw_spinlock_t
      Linux 3.2.38-rt58-rc1

Thomas Gleixner (4):
      x86/32: Use kmap switch for non highmem as well
      serial: Imx: Fix recursive locking bug
      wait-simple: Simple waitqueue implementation
      rcutiny: Use simple waitqueue

----
 arch/x86/kernel/process_32.c    |    2 +-
 drivers/acpi/acpica/acglobal.h  |    2 +-
 drivers/acpi/acpica/hwregs.c    |    4 +-
 drivers/acpi/acpica/hwxface.c   |    4 +-
 drivers/acpi/acpica/utmutex.c   |    4 +-
 drivers/tty/serial/imx.c        |   11 ++-
 include/acpi/platform/aclinux.h |   14 ++++
 include/linux/sched.h           |    4 +-
 include/linux/wait-simple.h     |  172 +++++++++++++++++++++++++++++++++++++++
 kernel/Makefile                 |    2 +-
 kernel/printk.c                 |    2 +-
 kernel/rcutiny_plugin.h         |   17 ++--
 kernel/wait-simple.c            |  119 +++++++++++++++++++++++++++
 localversion-rt                 |    2 +-
 14 files changed, 337 insertions(+), 22 deletions(-)

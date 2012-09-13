From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] [ANNOUNCE] 3.0.42-rt64-rc1 stable review
Date: Thu, 13 Sep 2012 14:52:34 -0400
Message-ID: <20120913185234.912247144@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.42-rt64-rc1.

----
Note: The patches have not been uploaded to kernel.org yet. I've
recently changed the subkey that I use to sign the patches as the
old subkey is about to expire. But unfortunately, kernel.org has
not updated its key ring, and is refusing my current subkey.

I have a ticket open with kernel.org to resolve the issue. But until
then, this mailing is the only place the patches exist.
----

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/17/2012.

Enjoy,

-- Steve


To build 3.0.42-rt64-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.42.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.42-rt64-rc1.patch.xz

You can also build from 3.0.42-rt63 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.42-rt63-rt64-rc1.patch.xz


Changes from 3.0.42-rt63:

---


Frank Rowand (1):
      fix printk flush of messages

Steven Rostedt (1):
      Linux 3.0.42-rt64-rc1

----
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 drivers/tty/sysrq.c                         |   23 -----------------------
 include/linux/sysrq.h                       |    5 -----
 kernel/printk.c                             |    5 ++---
 lib/Kconfig.debug                           |   22 ----------------------
 localversion-rt                             |    2 +-
 6 files changed, 4 insertions(+), 55 deletions(-)

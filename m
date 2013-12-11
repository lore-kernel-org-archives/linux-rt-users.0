From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 3.8.13.13-rt26-rc1
Date: Tue, 10 Dec 2013 19:46:31 -0500
Message-ID: <20131211004631.950208564@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:9592 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751237Ab3LKAqo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Dec 2013 19:46:44 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.8.13.13-rt26-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/13/2013.

Enjoy,

-- Steve


To build 3.8.13.13-rt26-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.8.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.8.13.13.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/patch-3.8.13.13-rt26-rc1.patch.xz

You can also build from 3.8.13.13-rt25 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.8/incr/patch-3.8.13.13-rt25-rt26-rc1.patch.xz


Changes from 3.8.13.13-rt25:

---


Peter Zijlstra (1):
      lockdep: Correctly annotate hardirq context in irq_exit()

Sebastian Andrzej Siewior (2):
      a few open coded completions
      rtmutex: use a trylock for waiter lock in trylock

Steven Rostedt (Red Hat) (1):
      Linux 3.8.13.13-rt26-rc1

Tiejun Chen (1):
      cpu_down: move migrate_enable() back

----
 drivers/net/wireless/orinoco/orinoco_usb.c |  2 +-
 drivers/usb/gadget/f_fs.c                  |  2 +-
 drivers/usb/gadget/inode.c                 |  4 +--
 include/linux/netdevice.h                  |  2 +-
 include/linux/spinlock_rt.h                |  1 +
 kernel/cpu.c                               |  2 +-
 kernel/rtmutex.c                           | 31 +++++++++++++++++---
 kernel/softirq.c                           | 45 ++++++++++++++++++++++++++++--
 kernel/timer.c                             |  2 +-
 localversion-rt                            |  2 +-
 10 files changed, 78 insertions(+), 15 deletions(-)

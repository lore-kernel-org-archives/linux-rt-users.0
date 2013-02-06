From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] [ANNOUNCE] 3.0.62-rt88-rc1 stable review
Date: Wed, 06 Feb 2013 17:06:08 -0500
Message-ID: <20130206220608.862416001@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4937 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab3BFWGd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 17:06:33 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.62-rt88-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/8/2013.

Enjoy,

-- Steve


To build 3.0.62-rt88-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.62.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.62-rt88-rc1.patch.xz

You can also build from 3.0.62-rt87 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.62-rt87-rt88-rc1.patch.xz


Changes from 3.0.62-rt87:

---


Steven Rostedt (1):
      Linux 3.0.62-rt88-rc1

Thomas Gleixner (4):
      drivers-tty-pl011-irq-disable-madness.patch
      mmci: Remove bogus local_irq_save()
      sched: Init idle->on_rq in init_idle()
      mm: swap: Initialize local locks early

----
 drivers/mmc/host/mmci.c         |    5 -----
 drivers/tty/serial/amba-pl011.c |   15 ++++++++++-----
 kernel/sched.c                  |    1 +
 localversion-rt                 |    2 +-
 mm/swap.c                       |   12 +++++++++---
 5 files changed, 21 insertions(+), 14 deletions(-)

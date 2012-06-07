From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.0.33-rt54-rc1
Date: Thu, 07 Jun 2012 11:51:48 -0400
Message-ID: <20120607155148.698959275@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26904 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab2FGPwW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2012 11:52:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.33-rt54-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 6/12/2012.

Enjoy,

-- Steve


To build 3.0.33-rt54-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.33.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.33-rt54-rc1.patch.xz

You can also build from 3.0.33-rt53 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.33-rt53-rt54-rc1.patch.xz


Changes from 3.0.33-rt53:

---


John Kacur (1):
      scsi: qla2xxx: Use local_irq_save_nort() in qla2x00_poll

Priyanka Jain (1):
      net,RT:REmove preemption disabling in netif_rx()

Steven Rostedt (1):
      Linux 3.0.33-rt54-rc1

Thomas Gleixner (1):
      mips-remove-smp-reserve-lock.patch

----
 arch/mips/cavium-octeon/smp.c     |    6 ------
 drivers/scsi/qla2xxx/qla_inline.h |    4 ++--
 localversion-rt                   |    2 +-
 net/core/dev.c                    |    8 ++++----
 4 files changed, 7 insertions(+), 13 deletions(-)

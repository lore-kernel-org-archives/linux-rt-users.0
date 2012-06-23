From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] [ANNOUNCE] 3.4.3-rt12-rc1 stable review
Date: Fri, 22 Jun 2012 23:05:48 -0400
Message-ID: <20120623030548.500374594@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16850 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2FWDGm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2012 23:06:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.3-rt12-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 6/24/2012.

Enjoy,

-- Steve


To build 3.4.3-rt12-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.3.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.3-rt12-rc1.patch.xz

You can also build from 3.4.3-rt11 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.3-rt11-rt12-rc1.patch.xz


Changes from 3.4.3-rt11:

---


Steven Rostedt (2):
      spinlock/rt: Include bug.h in spinlock_rt.h to satisfy BUG() usage
      Linux 3.4.3-rt12-rc1

Thomas Gleixner (1):
      Oops during Init IRQ

----
 arch/powerpc/platforms/8xx/m8xx_setup.c |    1 +
 arch/powerpc/sysdev/cpm1.c              |    1 +
 include/linux/spinlock_rt.h             |    2 ++
 localversion-rt                         |    2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

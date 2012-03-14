From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] [ANNOUNCE] 3.0.23-rt40-rc1
Date: Tue, 13 Mar 2012 22:26:58 -0400
Message-ID: <20120314022658.783312660@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:22142 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965224Ab2CNC3q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Mar 2012 22:29:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.23-rt40-rc1.

Please scream at me if I messed something up. Please test the patches too.

Note that this release will be quick, and I plan on pushing out
3.0.23-rt40 tomorrow, and start testing and release 3.0.24-rt41.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/14/2012.

Enjoy,

-- Steve


To build 3.0.23-rt40-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.23.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.23-rt40-rc1.patch.xz

You can also build from 3.0.23-rt39 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.23-rt39-rt40-rc1.patch.xz


Changes from 3.0.23-rt39:

---


Steven Rostedt (2):
      Revert "ACPI: Convert embedded controller lock to raw spinlock"
      Linux 3.0.23-rt40-rc1

Thomas Gleixner (5):
      softirq: Check preemption after reenabling interrupts
      rt: Introduce cpu_chill()
      fs: dcache: Use cpu_chill() in trylock loops
      fs: namespace: Use cpu_chill() instead of cpu_relax()
      net: Use cpu_chill() instead of cpu_relax()

----
 block/blk-iopoll.c      |    3 +++
 block/blk-softirq.c     |    3 +++
 drivers/acpi/ec.c       |   22 +++++++++++-----------
 drivers/acpi/internal.h |    2 +-
 fs/autofs4/autofs_i.h   |    1 +
 fs/autofs4/expire.c     |    2 +-
 fs/dcache.c             |    7 ++++---
 fs/namespace.c          |    3 ++-
 include/linux/delay.h   |    6 ++++++
 include/linux/preempt.h |    3 +++
 localversion-rt         |    2 +-
 net/core/dev.c          |    6 ++++++
 net/rds/ib_rdma.c       |    3 ++-
 13 files changed, 44 insertions(+), 19 deletions(-)

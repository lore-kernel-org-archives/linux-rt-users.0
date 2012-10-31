From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.4.15-rt26-rc1 stable review
Date: Tue, 30 Oct 2012 20:29:10 -0400
Message-ID: <20121031002910.195421780@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14294 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab2JaA3o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2012 20:29:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.15-rt26-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/2/2012.

Enjoy,

-- Steve


To build 3.4.15-rt26-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.15.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.15-rt26-rc1.patch.xz

You can also build from 3.4.15-rt25 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.15-rt25-rt26-rc1.patch.xz


Changes from 3.4.15-rt25:

---


Steven Rostedt (1):
      Linux 3.4.15-rt26-rc1

Thomas Gleixner (2):
      rcu: Disable RCU_FAST_NO_HZ on RT
      net: netfilter: Serialize xt_write_recseq sections on RT

Watanabe (1):
      hrtimer: Raise softirq if hrtimer irq stalled

----
 include/linux/locallock.h          |    4 ++++
 include/linux/netfilter/x_tables.h |    7 +++++++
 init/Kconfig                       |    2 +-
 kernel/hrtimer.c                   |    9 ++++-----
 localversion-rt                    |    2 +-
 net/netfilter/core.c               |    6 ++++++
 6 files changed, 23 insertions(+), 7 deletions(-)

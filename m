From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] Linux 3.2.60-rt89-rc1
Date: Mon, 14 Jul 2014 16:06:34 -0400
Message-ID: <20140714200634.590977709@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:17963 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756946AbaGNUGx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jul 2014 16:06:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.60-rt89-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/17/2014.

Enjoy,

-- Steve


To build 3.2.60-rt89-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.60.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.60-rt89-rc1.patch.xz

You can also build from 3.2.60-rt88 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.60-rt88-rt89-rc1.patch.xz


Changes from 3.2.60-rt88:

---


Steven Rostedt (1):
      sched: Do not clear PF_NO_SETAFFINITY flag in select_fallback_rq()

Steven Rostedt (Red Hat) (1):
      Linux 3.2.60-rt89-rc1

Thomas Gleixner (1):
      workqueue: Prevent deadlock/stall on RT

Zhao Hongjiang (1):
      hrtimer:fix the miss of hrtimer_peek_ahead_timers in nort code

----
 kernel/hrtimer.c   |  6 +++++-
 kernel/sched.c     | 16 +++++-----------
 kernel/workqueue.c | 41 +++++++++++++++++++++++++++++++++++------
 localversion-rt    |  2 +-
 4 files changed, 46 insertions(+), 19 deletions(-)

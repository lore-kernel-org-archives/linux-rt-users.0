From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] [ANNOUNCE] 3.2.22-rt35-rc1 stable review
Date: Thu, 12 Jul 2012 19:18:27 -0400
Message-ID: <20120712231827.084920483@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3868 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162552Ab2GLXT6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2012 19:19:58 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.22-rt35-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/16/2012.

Enjoy,

-- Steve


To build 3.2.22-rt35-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.22.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.22-rt35-rc1.patch.xz

You can also build from 3.2.22-rt34 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.22-rt34-rt35-rc1.patch.xz


Changes from 3.2.22-rt34:

---


Carsten Emde (4):
      Latency histogramms: Cope with backwards running local trace clock
      Latency histograms: Adjust timer, if already elapsed when programmed
      Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
      Latency histograms: Detect another yet overlooked sharedprio condition

Mike Galbraith (1):
      fs, jbd: pull your plug when waiting for space

Steven Rostedt (1):
      Linux 3.2.22-rt35-rc1

Thomas Gleixner (1):
      slab: Prevent local lock deadlock

Yong Zhang (1):
      perf: Make swevent hrtimer run in irq instead of softirq

----
 fs/jbd/checkpoint.c         |    2 ++
 include/linux/hrtimer.h     |    3 ++
 include/linux/sched.h       |    2 +-
 init/Kconfig                |    1 +
 kernel/events/core.c        |    1 +
 kernel/hrtimer.c            |   16 ++++++++--
 kernel/trace/latency_hist.c |   74 +++++++++++++++++++++++--------------------
 localversion-rt             |    2 +-
 mm/slab.c                   |   26 ++++++++++++---
 9 files changed, 85 insertions(+), 42 deletions(-)

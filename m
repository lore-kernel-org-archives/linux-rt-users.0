From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] [ANNOUNCE] 3.2.23-rt37-rc1 stable review
Date: Tue, 17 Jul 2012 22:04:27 -0400
Message-ID: <20120718020427.338763317@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16448 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GRCFL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Jul 2012 22:05:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.23-rt37-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/19/2012.

Enjoy,

-- Steve


To build 3.2.23-rt37-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.23.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.23-rt37-rc1.patch.xz

You can also build from 3.2.23-rt36 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.23-rt36-rt37-rc1.patch.xz


Changes from 3.2.23-rt36:

---


Steven Rostedt (5):
      cpu/rt: Rework cpu down for PREEMPT_RT
      cpu/rt: Fix cpu_hotplug variable initialization
      workqueue: Revert workqueue: Fix PF_THREAD_BOUND abuse
      workqueue: Revert workqueue: Fix cpuhotplug trainwreck
      Linux 3.2.23-rt37-rc1

----
 include/linux/cpu.h       |    6 +-
 include/linux/sched.h     |    7 +
 include/linux/workqueue.h |    5 +-
 kernel/cpu.c              |  240 +++++++++++++++----
 kernel/sched.c            |   82 ++++++-
 kernel/workqueue.c        |  578 ++++++++++++++++++++++++++++++++-------------
 localversion-rt           |    2 +-
 7 files changed, 704 insertions(+), 216 deletions(-)

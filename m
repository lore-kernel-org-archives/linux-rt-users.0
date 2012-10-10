From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/8] [ANNOUNCE] 3.4.13-rt22-rc1 stable review
Date: Wed, 10 Oct 2012 09:34:06 -0400
Message-ID: <20121010133406.053812290@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:23841 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab2JJNf3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 09:35:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.13-rt22-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 10/15/2012.

Enjoy,

-- Steve


To build 3.4.13-rt22-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.13.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.13-rt22-rc1.patch.xz

You can also build from 3.4.13-rt21 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.13-rt21-rt22-rc1.patch.xz


Changes from 3.4.13-rt21:

---


Steven Rostedt (2):
      softirq: Init softirq local lock after per cpu section is set up
      Linux 3.4.13-rt22-rc1

Thomas Gleixner (6):
      random: Make it work on rt
      mm: slab: Fix potential deadlock
      mm: page_alloc: Use local_lock_on() instead of plain spinlock
      rt: rwsem/rwlock: lockdep annotations
      sched: Better debug output for might sleep
      stomp_machine: Use mutex_trylock when called from inactive cpu

----
 drivers/char/random.c     |   10 ++++++----
 include/linux/irqdesc.h   |    1 +
 include/linux/locallock.h |   19 +++++++++++++++++++
 include/linux/random.h    |    2 +-
 include/linux/sched.h     |    4 ++++
 init/main.c               |    2 +-
 kernel/irq/handle.c       |    7 +++++--
 kernel/irq/manage.c       |    6 ++++++
 kernel/rt.c               |   46 ++++++++++++++++++++++++---------------------
 kernel/sched/core.c       |   23 +++++++++++++++++++++--
 kernel/stop_machine.c     |   13 +++++++++----
 localversion-rt           |    2 +-
 mm/page_alloc.c           |    4 ++--
 mm/slab.c                 |   10 ++--------
 14 files changed, 103 insertions(+), 46 deletions(-)

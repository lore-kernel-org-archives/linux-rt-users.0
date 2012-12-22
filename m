From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.0.57-rt82-rc1 stable review
Date: Sat, 22 Dec 2012 12:12:01 -0500
Message-ID: <20121222171201.588460638@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.57-rt82-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/27/2012.

Enjoy,

-- Steve


To build 3.0.57-rt82-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.57.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.57-rt82-rc1.patch.xz

You can also build from 3.0.57-rt81 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.57-rt81-rt82-rc1.patch.xz


Changes from 3.0.57-rt81:

---


Steven Rostedt (1):
      Linux 3.0.57-rt82-rc1

Thomas Gleixner (3):
      sched: Adjust sched_reset_on_fork when nothing else changes
      sched: Queue RT tasks to head when prio drops
      sched: Consider pi boosting in setscheduler

----
 include/linux/sched.h |    5 +++++
 kernel/rtmutex.c      |   12 +++++++++++
 kernel/sched.c        |   54 ++++++++++++++++++++++++++++++++++++++-----------
 localversion-rt       |    2 +-
 4 files changed, 60 insertions(+), 13 deletions(-)

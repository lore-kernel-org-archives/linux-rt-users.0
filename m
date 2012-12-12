From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] [ANNOUNCE] 3.0.55-rt80-rc1 stable review
Date: Tue, 11 Dec 2012 19:53:42 -0500
Message-ID: <20121212005342.348897923@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.55-rt80-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/14/2012, let's hope it's not an unexpected journey!

Enjoy,

-- Steve


To build 3.0.55-rt80-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.55.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.55-rt80-rc1.patch.xz

You can also build from 3.0.55-rt79 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.55-rt79-rt80-rc1.patch.xz


Changes from 3.0.55-rt79:

---


Steven Rostedt (1):
      Linux 3.0.55-rt80-rc1

Thomas Gleixner (1):
      sched: Queue RT tasks to head when prio drops

----
 kernel/sched.c  |   16 ++++++++++++----
 localversion-rt |    2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

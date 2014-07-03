From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] Linux 3.2.60-rt88-rc1
Date: Thu, 03 Jul 2014 08:55:29 -0400
Message-ID: <20140703125529.692457366@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.2.60-rt88-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/7/2014.

Enjoy,

-- Steve


To build 3.2.60-rt88-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.60.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.60-rt88-rc1.patch.xz

You can also build from 3.2.60-rt87 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.60-rt87-rt88-rc1.patch.xz


Changes from 3.2.60-rt87:

---


Ben Hutchings (1):
      Fix latency histogram after "hrtimer: Set expiry time before switch_hrtimer_base()"

Steven Rostedt (Red Hat) (1):
      Linux 3.2.60-rt88-rc1

----
 kernel/hrtimer.c | 10 +++++-----
 localversion-rt  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] [ANNOUNCE] 3.4.15-rt25-rc1 stable review
Date: Fri, 26 Oct 2012 18:28:35 -0400
Message-ID: <20121026222835.523598217@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.15-rt25-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 10/29/2013.

Enjoy,

-- Steve


To build 3.4.15-rt25-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.15.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.15-rt25-rc1.patch.xz

You can also build from 3.4.15-rt24 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.15-rt24-rt25-rc1.patch.xz


Changes from 3.4.15-rt24:

---


Steven Rostedt (1):
      Linux 3.4.15-rt25-rc1

Thomas Gleixner (1):
      rcu: rcutiny: Prevent RCU stall

----
 kernel/rcutiny_plugin.h |    2 +-
 localversion-rt         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

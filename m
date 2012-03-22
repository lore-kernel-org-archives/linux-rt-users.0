From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] [ANNOUNCE] 3.0.25-rt44-rc2
Date: Wed, 21 Mar 2012 22:33:09 -0400
Message-ID: <20120322023309.083011587@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.25-rt44-rc2.

This release added the patch from 3.2-rt:
   printk-disable-migration-instead-of-preemption.patch
as Luis Claudio R. Goncalves pointed out as missing.
 
Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/23/2012.

Enjoy,

-- Steve


To build 3.0.25-rt44-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.25.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.25-rt44-rc2.patch.xz

You can also build from 3.0.25-rt43 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.25-rt43-rt44-rc2.patch.xz


Changes from 3.0.25-rt43:

---


Richard Weinberger (1):
      printk: Disable migration instead of preemption

Steven Rostedt (2):
      Revert "kprobes: adjust "fix a memory leak in function pre_handler_kretprobe()""
      Linux 3.0.25-rt44-rc2

----
 kernel/kprobes.c |    4 ++--
 kernel/printk.c  |    4 ++--
 localversion-rt  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] [ANNOUNCE] 3.0.25-rt44-rc1
Date: Wed, 21 Mar 2012 16:12:27 -0400
Message-ID: <20120321201227.979421546@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16768 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab2CUUNL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 16:13:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.25-rt44-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/23/2012.

Enjoy,

-- Steve


To build 3.0.25-rt44-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.25.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.25-rt44-rc1.patch.xz

You can also build from 3.0.25-rt43 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.25-rt43-rt44-rc1.patch.xz


Changes from 3.0.25-rt43:

---


Steven Rostedt (2):
      Revert "kprobes: adjust "fix a memory leak in function pre_handler_kretprobe()""
      Linux 3.0.25-rt44-rc1

----
 kernel/kprobes.c |    4 ++--
 localversion-rt  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

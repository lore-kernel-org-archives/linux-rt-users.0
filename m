From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] [ANNOUNCE] 3.4.22-rt34-rc1 stable review
Date: Tue, 11 Dec 2012 19:45:57 -0500
Message-ID: <20121212004557.110050982@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3389 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab2LLAsW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Dec 2012 19:48:22 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.22-rt34-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/14/2012, let's hope it's not an unexpected journey!

Enjoy,

-- Steve


To build 3.4.22-rt34-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.22.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.22-rt34-rc1.patch.xz

You can also build from 3.4.22-rt33 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.22-rt33-rt34-rc1.patch.xz


Changes from 3.4.22-rt33:

---


Steven Rostedt (1):
      Linux 3.4.22-rt34-rc1

Thomas Gleixner (1):
      sched: Queue RT tasks to head when prio drops

----
 kernel/sched/core.c |   16 ++++++++++++----
 localversion-rt     |    2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

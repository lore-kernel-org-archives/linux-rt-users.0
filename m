From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] Linux 3.18.47-rt52-rc1
Date: Thu, 09 Feb 2017 11:45:10 -0500
Message-ID: <20170209164510.503129025@goodmis.org>
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

This is the RT stable review cycle of patch 3.18.47-rt52-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/13/2017.

Enjoy,

-- Steve


To build 3.18.47-rt52-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.47.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.47-rt52-rc1.patch.xz

You can also build from 3.18.47-rt51 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.47-rt51-rt52-rc1.patch.xz


Changes from 3.18.47-rt51:

---


Sebastian Andrzej Siewior (1):
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (VMware) (1):
      Linux 3.18.47-rt52-rc1

----
 kernel/workqueue.c | 2 ++
 localversion-rt    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

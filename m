From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 0/4] Linux 4.1.46-rt52-rc1
Date: Fri, 10 Nov 2017 10:33:22 -0600
Message-ID: <cover.1510269414.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.1.46-rt52-rc1.  Please review
the included patches, and test!

You might ask: "Where was 4.1.46-rt51?".  The answer is: it was released
silently, and only as a means to facilitate release-level bisection.
Version 4.1.46-rt51 has known issues to be resolved by the pending
release of -rt52.

The -rc release will be uploaded to kernel.org and will be deleted when the
final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/15/2017.

   Julia

----------------------------------------------------------------
To build 4.1.46-rt52-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.46.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.46-rt52-rc1.patch.xz

You can also build from 4.1.46-rt51 release by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.46-rt51-rt52-rc1.patch.xz

Julia Cartwright (2):
  workqueue: fixup rcu check for RT
  Linux 4.1.46-rt52-rc1

Sebastian Andrzej Siewior (2):
  PM / CPU: replace raw_notifier with atomic_notifier (fixup)
  kernel/hrtimer: migrate deferred timer on CPU down

 kernel/cpu_pm.c       | 7 +++++++
 kernel/time/hrtimer.c | 5 +++++
 kernel/workqueue.c    | 2 +-
 localversion-rt       | 2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.14.2

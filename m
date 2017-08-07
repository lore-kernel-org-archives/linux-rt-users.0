From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 0/6] Linux 4.1.42-rt50-rc1
Date: Mon, 7 Aug 2017 12:40:56 -0500
Message-ID: <20170807174102.5448-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.1.42-rt50-rc1.  Please review
the included patches, and test!

The -rc release will be uploaded to kernel.org and will be deleted when the
final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 8/14/2017.

   Julia

----------------------------------------------------------------
To build 4.1.42-rt50-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.42.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.42-rt50-rc1.patch.xz

You can also build from 4.1.42-rt49 release by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.42-rt49-rt50-rc1.patch.xz

----------------------------------------------------------------
Alex Shi (1):
  cpu_pm: replace raw_notifier to atomic_notifier

Julia Cartwright (1):
  Linux 4.1.42-rt50-rc1

Peter Zijlstra (2):
  lockdep: Fix per-cpu static objects
  sched: Remove TASK_ALL

Thomas Gleixner (2):
  rtmutex: Make lock_killable work
  sched: Prevent task state corruption by spurious lock wakeup

 include/linux/sched.h    |  1 -
 include/linux/smp.h      | 12 ++++++++++++
 init/main.c              |  8 ++++++++
 kernel/cpu_pm.c          | 43 ++++++-------------------------------------
 kernel/locking/rtmutex.c | 19 +++++++------------
 kernel/module.c          |  6 +++++-
 kernel/sched/core.c      |  2 +-
 localversion-rt          |  2 +-
 mm/percpu.c              |  5 ++++-
 9 files changed, 44 insertions(+), 54 deletions(-)

-- 
2.13.1

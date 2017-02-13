From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.12.70-rt94
Date: Mon, 13 Feb 2017 17:33:04 -0500
Message-ID: <20170213173304.76d1c27b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.12.70-rt94 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.12-rt
  Head SHA1: bc92224d9c0e616125b2bcda8be5c7d1d35a612e


Or to build 3.12.70-rt94 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.70.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.70-rt94.patch.xz



You can also build from 3.12.70-rt93 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.70-rt93-rt94.patch.xz



Enjoy,

-- Steve


Changes from v3.12.70-rt93:

---

Sebastian Andrzej Siewior (1):
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (VMware) (1):
      Linux 3.12.70-rt94

----
 kernel/workqueue.c | 2 ++
 localversion-rt    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5e7cd0dcf6a4..6d36faa3b666 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1135,9 +1135,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
+		rcu_read_lock();
 		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
 		put_pwq(pwq);
 		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
+		rcu_read_unlock();
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index e98a1fe050bd..8d02a9bac500 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt93
+-rt94

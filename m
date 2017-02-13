From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.47-rt52
Date: Mon, 13 Feb 2017 17:32:32 -0500
Message-ID: <20170213173232.718f7859@gandalf.local.home>
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

I'm pleased to announce the 3.18.47-rt52 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: f5cd67daa1a9e2f3be2c70e715e50b03c8dd0df1


Or to build 3.18.47-rt52 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.47.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.47-rt52.patch.xz



You can also build from 3.18.47-rt51 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.47-rt51-rt52.patch.xz



Enjoy,

-- Steve


Changes from v3.18.47-rt51:

---

Sebastian Andrzej Siewior (1):
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (VMware) (1):
      Linux 3.18.47-rt52

----
 kernel/workqueue.c | 2 ++
 localversion-rt    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6122f386dd5d..8af30f579c15 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1109,9 +1109,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
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
index 75493460c41f..66a5ed8bf3d7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt51
+-rt52

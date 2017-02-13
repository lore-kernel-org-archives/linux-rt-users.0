From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.104-rt118
Date: Mon, 13 Feb 2017 17:33:35 -0500
Message-ID: <20170213173335.25757cc7@gandalf.local.home>
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

I'm pleased to announce the 3.10.104-rt118 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: 1aa9282631e195c26f9cb97222a2d85bff3a6870


Or to build 3.10.104-rt118 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.104.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.104-rt118.patch.xz



You can also build from 3.10.104-rt117 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.104-rt117-rt118.patch.xz



Enjoy,

-- Steve


Changes from v3.10.104-rt117:

---

Sebastian Andrzej Siewior (1):
      workqueue: use rcu_readlock() in put_pwq_unlocked()

Steven Rostedt (VMware) (1):
      Linux 3.10.104-rt118

----
 kernel/workqueue.c | 2 ++
 localversion-rt    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0572fa0a47f9..cc14c288b6e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1119,9 +1119,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
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
index 9788245dd428..4e32122c6b30 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt117
+-rt118

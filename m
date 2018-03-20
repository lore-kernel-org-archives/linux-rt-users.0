From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.28-rt23
Date: Wed, 21 Mar 2018 00:26:21 +0100
Message-ID: <20180320232620.jp4yglglk64jnztd@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.28-rt23 patch set. 

Changes since v4.14.28-rt22:

  - The RCU boosting code could enable interrupts too early which could
    lead to a deadlock. Reported by Roosen Henri, fixed by Boqun Feng.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.28-rt22 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.28-rt22-rt23.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.28-rt23

The RT patch against v4.14.28 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.28-rt23.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.28-rt23.tar.xz

Sebastian

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 838c8a6f662c..0cb716ba3be0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2206,11 +2206,12 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
 	DEFINE_WAKE_Q(wake_q);
 	DEFINE_WAKE_Q(wake_sleeper_q);
+	unsigned long flags;
 	bool postunlock;
 
-	raw_spin_lock_irq(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	postunlock = __rt_mutex_futex_unlock(lock, &wake_q, &wake_sleeper_q);
-	raw_spin_unlock_irq(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
 		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
diff --git a/localversion-rt b/localversion-rt
index c29508d21914..9a218ca23053 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt22
+-rt23

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.19.15-rt12
Date: Mon, 14 Jan 2019 16:31:10 +0100
Message-ID: <20190114153110.adzcpnmlegvivqkc@linutronix.de>
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

I'm pleased to announce the v4.19.15-rt12 patch set. 

Changes since v4.19.15-rt11:

  - The read lock of a rwlock did not preserve the task state. This led
    to a wrong state while using ptrace. Reported by Joe Korty.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.19.15-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.15-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.15-rt12

The RT patch against v4.19.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.15-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patches-4.19.15-rt12.tar.xz

Sebastian

diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index f2e155b2c4a8b..c3b91205161cc 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -128,7 +128,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	 * That would put Reader1 behind the writer waiting on
 	 * Reader2 to call read_unlock() which might be unbound.
 	 */
-	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_init_waiter(&waiter, true);
 	rt_spin_lock_slowlock_locked(m, &waiter, flags);
 	/*
 	 * The slowlock() above is guaranteed to return with the rtmutex is
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12

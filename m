From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.4-rt7
Date: Thu, 14 Jul 2016 19:15:41 +0200
Message-ID: <20160714171541.GC12152@linutronix.de>
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

I'm pleased to announce the v4.6.4-rt7 patch set.

Changes since v4.6.4-rt6:

  - Wake up all waiters of del_timer_sync(). Usually there should not
    be more than just one waiter (per timer base) but it possible to
    gain more.

  - Wake up the waiters of del_timer_sync() after dropping the base lock.

Known issues
    - CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.4-rt6 is appended below and can be found here:

     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.4-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.4-rt7

The RT patch against 4.6.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.4-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.4-rt7.tar.xz

Sebastian

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5f9d3599ef0a..716ef84a5d87 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1051,7 +1051,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 		   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1313,8 +1313,8 @@ static inline void __run_timers(struct tvec_base *base)
 			}
 		}
 	}
-	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/localversion-rt b/localversion-rt
index 8fc605d80667..045478966e9f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7

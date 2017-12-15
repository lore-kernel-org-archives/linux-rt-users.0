From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.6-rt7
Date: Fri, 15 Dec 2017 19:26:07 +0100
Message-ID: <20171215182607.wk7pe6t27yb3wz5e@linutronix.de>
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

I'm pleased to announce the v4.14.6-rt7 patch set. 

Changes since v4.14.6-rt6:

  - The hrtimer-softirq code did not properly handle migrated timer. A
    NOHZ_FULL system would probably hang during boot. Reported by bert
    schulze.

  - The check whether a hrtimer has been setup and started in softirq
    or non-softirq context has been disabled for RT and the workaround
    of the has been disabled. This is almost always true for -RT because
    most timers are shifted to the other context and the check serves no
    purpose.

  - A fix a possible memory leak in kmem_cache_alloc_bulk(). It is
    harmless because that function has no users.

  - Add an additional include in swait.h which causes some builds to
    fail. Reported by kbuild test robot.

  - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patch
    has been updated to v7.

Known issues
	An UP System compiled with SMP support may crash while the
	scheduler is looking for a RT task. A workaround is to compile
	an UP kernel for single CPU system. Reported by Daniel Wagner.

The delta patch appended at the bottom of this email contains all the
changes except tracing due to the size of the tracing delta. For
complete diff please visit
	https://git.kernel.org/rt/linux-rt-devel/d/v4.14.6-rt7/v4.14.6-rt6

The delta patch against v4.14.6-rt6 is can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.6-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.6-rt7

The RT patch against v4.14.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.6-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.6-rt7.tar.xz

Sebastian

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 7963f3c03fb0..853f3e61a9f4 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <asm/current.h>
 
 /*
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2fff8790bc56..c2c344fda487 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -422,8 +422,10 @@ static inline void debug_hrtimer_activate(struct hrtimer *timer,
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match, when a timer is started via__hrtimer_start_range_ns().
 	 */
+#ifndef CONFIG_PREEMPT_RT_BASE
 	if (modecheck)
-		WARN_ON_ONCE((mode & HRTIMER_MODE_SOFT) & !timer->is_soft);
+		WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
+#endif
 
 	debug_object_activate(timer, &hrtimer_debug_descr);
 }
@@ -799,16 +801,18 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 		expires = 0;
 
 	if (timer->is_soft) {
-		if (cpu_base->softirq_activated)
+		struct hrtimer_cpu_base *timer_cpu_base = base->cpu_base;
+
+		if (timer_cpu_base->softirq_activated)
 			return;
 
-		if (!ktime_before(expires, cpu_base->softirq_expires_next))
+		if (!ktime_before(expires, timer_cpu_base->softirq_expires_next))
 			return;
 
-		cpu_base->softirq_next_timer = timer;
-		cpu_base->softirq_expires_next = expires;
+		timer_cpu_base->softirq_next_timer = timer;
+		timer_cpu_base->softirq_expires_next = expires;
 
-		if (!ktime_before(expires, cpu_base->expires_next) ||
+		if (!ktime_before(expires, timer_cpu_base->expires_next) ||
 		    !reprogram)
 			return;
 	}
diff --git a/localversion-rt b/localversion-rt
index 8fc605d80667..045478966e9f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/slub.c b/mm/slub.c
index 8eff8449f67a..013b1af99f87 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3240,6 +3240,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
+	free_delayed(&to_free);
 	slab_post_alloc_hook(s, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;

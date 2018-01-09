From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.12-rt10
Date: Tue, 9 Jan 2018 13:34:33 +0100
Message-ID: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
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

I'm pleased to announce the v4.14.12-rt10 patch set. 

Changes since v4.14.8-rt9:

  - updated to v4.14.12

  - An additional include to avoid a build failure on ARM after a header
    disappeared somewhere during the stable update.

  - The patch "nohz: Prevent erroneous tick stop invocations" was merged
    differently upstream. The original issue where a slow box could lock up
    with a pending timer remained. I currently assume that this is a RT only
    issue and keep the patch as RT only.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.12-rt10

The RT patch against v4.14.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.12-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.12-rt10.tar.xz

The RT-specific delta is appended below.

Sebastian
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
+#include <linux/types.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -838,8 +838,13 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
+#ifdef CONFIG_PREEMPT_RT_BASE
 	if ((idle_cpu(cpu) || tick_nohz_full_cpu(cpu)) &&
-	    !need_resched() && !local_softirq_pending()) {
+	    !need_resched() && !local_softirq_pending())
+#else
+	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu))
+#endif
+	{
 		if (!in_interrupt())
 			tick_nohz_irq_exit();
 	}
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10

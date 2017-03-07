From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.13-rt12
Date: Wed, 8 Mar 2017 00:10:06 +0100
Message-ID: <20170307231006.p7wtnnlajecuysp6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdCGXMv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Mar 2017 18:12:51 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.9.13-rt12 patch set. 

Changes since v4.9.13-rt11:

  - hrtimer_cancel() may not cancel a timer which is currently running
    in the softirq context. Reported by Alexander Gerasiov.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.13-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.13-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.13-rt12

The RT patch against v4.9.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.13-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.13-rt12.tar.xz

Sebastian
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -455,7 +455,13 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  */
 static inline int hrtimer_callback_running(const struct hrtimer *timer)
 {
-	return timer->base->cpu_base->running == timer;
+	if (timer->base->cpu_base->running == timer)
+		return 1;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (timer->base->cpu_base->running_soft == timer)
+		return 1;
+#endif
+	return 0;
 }
 
 /* Forward a hrtimer so it expires after now: */
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12

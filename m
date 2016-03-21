From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH -rt] kernel/time: unbreak nohz in -rt
Date: Mon, 21 Mar 2016 15:12:38 -0400
Message-ID: <20160321151238.43fdfc1d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: riel@redhat.com, bigeasy@linutronix.de, tglx@linutronix.de,
	fweisbec@gmail.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43874 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569AbcCUTim (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Mar 2016 15:38:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

nohz support (nohz-full and nohz-idle) is currently
broken in the RT kernel. Meaning that, the tick is
never de-activated even when a core is idle or when
nohz_full= is passed.

The reason for this is that get_next_timer_interrupt()
in the RT kernel *always* returns "basem + TICK_NSEC"
which translates to "there's a timer firing in the
next tick". This causes tick_nohz_stop_sched_tick()
to never deactivate the tick.

This patch is like tylenol, it doesn't fix the problem, it
just reliefs the symptons by making tick_nohz_stop_sched_tick()
succeed if: 1. a core doesn't have any legacy timers
pending and 2. there's no hrtimer firing in the next tick.

Also, note that this issue has another side effect: it
causes the ktimersoftd thread to always take 1%-2% of CPU
time on all cores, even if they are idle. As it turns out,
the tick handling code path unconditionally raises the
TIMER_SOFTIRQ line. This is an upstream kernel behavior.
I believe people are not noticing the CPU usage because
nohz-idle papers over this problem.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fee8682..2bf49af 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1451,8 +1451,14 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	/*
 	 * On PREEMPT_RT we cannot sleep here. As a result we can't take
 	 * the base lock to check when the next timer is pending and so
-	 * we assume the next jiffy.
+	 * we assume the next jiffy if there are active timers.
 	 */
+	local_irq_disable();
+	if (!base->active_timers) {
+		local_irq_enable();
+		return cmp_next_hrtimer_event(basem, expires);
+	}
+	local_irq_enable();
 	return basem + TICK_NSEC;
 #endif
 	spin_lock(&base->lock);
-- 
2.1.0


From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] time/hrtimer: disable that mode check
Date: Wed, 13 Dec 2017 14:58:35 +0100
Message-ID: <20171213135835.rwtcf7kj45a6x4tt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On -RT we push all timers by default into the soft-mode. The
"start/update" code does not use that SOFT bit so we always see that
warning.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I am going to fold it into the original patch since only v4.14 is
affected.

 kernel/time/hrtimer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2fff8790bc56..f4df924d4b48 100644
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
-- 
2.15.0

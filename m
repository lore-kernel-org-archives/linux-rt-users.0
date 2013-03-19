From: Steven Rostedt <rostedt@goodmis.org>
Subject: Fixup for 3.4.34 merge conflict
Date: Tue, 19 Mar 2013 12:50:34 -0400
Message-ID: <1363711834.5938.39.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

Merging 3.4.34 into stable 3.4-rt I hit the following conflict:

diff --cc kernel/hrtimer.c
index 9114899,cdd5607..0000000
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@@ -643,30 -640,9 +643,33 @@@ static inline void hrtimer_init_hres(st
   * and expiry check is done in the hrtimer_interrupt or in the softirq.
   */
  static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
- 					    struct hrtimer_clock_base *base,
- 					    int wakeup)
+ 					    struct hrtimer_clock_base *base)
  {
++<<<<<<< HEAD
 +	if (base->cpu_base->hres_active && hrtimer_reprogram(timer, base)) {
 +		if (!wakeup)
 +			return -ETIME;
 +
 +#ifdef CONFIG_PREEMPT_RT_BASE
 +		/*
 +		 * Move softirq based timers away from the rbtree in
 +		 * case it expired already. Otherwise we would have a
 +		 * stale base->first entry until the softirq runs.
 +		 */
 +		if (!hrtimer_rt_defer(timer))
 +			return -ETIME;
 +#endif
 +		raw_spin_unlock(&base->cpu_base->lock);
 +		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 +		raw_spin_lock(&base->cpu_base->lock);
 +
 +		return 0;
 +	}
 +
 +	return 0;
++=======
+ 	return base->cpu_base->hres_active && hrtimer_reprogram(timer, base);
++>>>>>>> v3.4.34
  }
  
  static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
@@@ -1054,18 -982,19 +1056,34 @@@ int __hrtimer_start_range_ns(struct hrt
  	 *
  	 * XXX send_remote_softirq() ?
  	 */
++<<<<<<< HEAD
 +	if (leftmost && new_base->cpu_base == &__get_cpu_var(hrtimer_bases)) {
 +		ret = hrtimer_enqueue_reprogram(timer, new_base, wakeup);
 +		if (ret) {
 +			/*
 +			 * In case we failed to reprogram the timer (mostly
 +			 * because out current timer is already elapsed),
 +			 * remove it again and report a failure. This avoids
 +			 * stale base->first entries.
 +			 */
 +			debug_deactivate(timer);
 +			__remove_hrtimer(timer, new_base,
 +					timer->state & HRTIMER_STATE_CALLBACK, 0);
++=======
+ 	if (leftmost && new_base->cpu_base == &__get_cpu_var(hrtimer_bases)
+ 		&& hrtimer_enqueue_reprogram(timer, new_base)) {
+ 		if (wakeup) {
+ 			/*
+ 			 * We need to drop cpu_base->lock to avoid a
+ 			 * lock ordering issue vs. rq->lock.
+ 			 */
+ 			raw_spin_unlock(&new_base->cpu_base->lock);
+ 			raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+ 			local_irq_restore(flags);
+ 			return ret;
+ 		} else {
+ 			__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
++>>>>>>> v3.4.34
  		}
  	}
  

As 3.4.34 stable included commit b22affe0a "hrtimer: Prevent
hrtimer_enqueue_reprogram race" which conflicts with the current code in
-rt as you can see above.

Below is the final change I did to handle this code. I'm running tests
on it now. I tried to keep the same basic logic that -rt has. Let me
know if you have issues with this. I'll wait a few days before I push
this to kernel.org.

-- Steve


diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 9114899..2328c04 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -643,30 +643,9 @@ static inline void hrtimer_init_hres(struct hrtimer_cpu_base *base)
  * and expiry check is done in the hrtimer_interrupt or in the softirq.
  */
 static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
-					    struct hrtimer_clock_base *base,
-					    int wakeup)
+					    struct hrtimer_clock_base *base)
 {
-	if (base->cpu_base->hres_active && hrtimer_reprogram(timer, base)) {
-		if (!wakeup)
-			return -ETIME;
-
-#ifdef CONFIG_PREEMPT_RT_BASE
-		/*
-		 * Move softirq based timers away from the rbtree in
-		 * case it expired already. Otherwise we would have a
-		 * stale base->first entry until the softirq runs.
-		 */
-		if (!hrtimer_rt_defer(timer))
-			return -ETIME;
-#endif
-		raw_spin_unlock(&base->cpu_base->lock);
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
-		raw_spin_lock(&base->cpu_base->lock);
-
-		return 0;
-	}
-
-	return 0;
+	return base->cpu_base->hres_active && hrtimer_reprogram(timer, base);
 }
 
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
@@ -747,8 +726,7 @@ static inline int hrtimer_switch_to_hres(void) { return 0; }
 static inline void
 hrtimer_force_reprogram(struct hrtimer_cpu_base *base, int skip_equal) { }
 static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
-					    struct hrtimer_clock_base *base,
-					    int wakeup)
+					    struct hrtimer_clock_base *base)
 {
 	return 0;
 }
@@ -1054,19 +1032,39 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 *
 	 * XXX send_remote_softirq() ?
 	 */
-	if (leftmost && new_base->cpu_base == &__get_cpu_var(hrtimer_bases)) {
-		ret = hrtimer_enqueue_reprogram(timer, new_base, wakeup);
-		if (ret) {
+	if (leftmost && new_base->cpu_base == &__get_cpu_var(hrtimer_bases)
+		&& hrtimer_enqueue_reprogram(timer, new_base)) {
+
+		if (wakeup
+#ifdef CONFIG_PREEMPT_RT_BASE
+		    /*
+		     * Move softirq based timers away from the rbtree in
+		     * case it expired already. Otherwise we would have a
+		     * stale base->first entry until the softirq runs.
+		     */
+		    && hrtimer_rt_defer(timer)
+#endif
+			) {
 			/*
-			 * In case we failed to reprogram the timer (mostly
-			 * because out current timer is already elapsed),
-			 * remove it again and report a failure. This avoids
-			 * stale base->first entries.
+			 * We need to drop cpu_base->lock to avoid a
+			 * lock ordering issue vs. rq->lock.
 			 */
-			debug_deactivate(timer);
-			__remove_hrtimer(timer, new_base,
-					timer->state & HRTIMER_STATE_CALLBACK, 0);
+			raw_spin_unlock(&new_base->cpu_base->lock);
+			raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+			local_irq_restore(flags);
+			return ret;
 		}
+
+		/*
+		 * In case we failed to reprogram the timer (mostly
+		 * because out current timer is already elapsed),
+		 * remove it again and report a failure. This avoids
+		 * stale base->first entries.
+		 */
+		debug_deactivate(timer);
+		__remove_hrtimer(timer, new_base,
+				 timer->state & HRTIMER_STATE_CALLBACK, 0);
+		ret = -ETIME;
 	}
 
 	unlock_hrtimer_base(timer, &flags);

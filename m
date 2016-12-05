From: Haris Okanovic <haris.okanovic@ni.com>
Subject: [RFC] timers: Don't wake ktimersoftd on every tick
Date: Mon, 5 Dec 2016 14:07:02 -0600
Message-ID: <20161205200702.17248-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>,
        <haris.okanovic@ni.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:52182 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751672AbcLEUil (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Dec 2016 15:38:41 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We recently upgraded from 4.1 to 4.6 and noticed a minor latency
regression caused by an additional thread wakeup (ktimersoftd) in
interrupt context on every tick. The wakeups are from
run_local_timers() raising TIMER_SOFTIRQ. Both TIMER and SCHED softirq
coalesced into one ksoftirqd wakeup prior to Sebastian's change to split
timers into their own thread (c002d3c0).

There's already logic in run_local_timers() to avoid some unnecessary
wakeups of ksoftirqd, but it doesn't seems to catch them all. In
particular, I've seen many unnecessary wakeups when jiffies increments
prior to run_local_timers().

This patch attempts to improve things by servicing timers in interrupt
context until one or more are ready to fire:

 * Increments base->clk to keep up with jiffies in interrupt context
 * Wakes ktimersoftd only when pending_map shows one or more ready
   timers

`cyclictest -p 98 -m` (4h run, no cpu affinity) shows ~5-10% decrease in
22-70us latency range, but a ~21% increase 20-21us and mixed results
 >70us. No change in max jitter. No change when `-S` is used.

[Traces]

ftp://ftp.ni.com/outgoing/tp01-timer-peek-traces.tgz
(Email me if link dies. Server periodically purges old files.)

Prior to this change, event traces of an idle system (before.dat) show
TIMER softirq_raise()s each tick without subsequent timer_expire_entries()s.
I.e. ktimesoftd woke to perform no work on both CPUs. after.dat only shows
TIMER softirq_raise()s only when followed by one or more expiring timers.

[Hardware/software/config]

 NI cRIO-9033
  2 core Intel Atom CPU

 Kernel 4.8.6-rt5
  CONFIG_HZ_PERIODIC=y

[Concerns/Issues/questions]

I'm relatively new to the timer subsystem, so please feel free to poke
as many holes as possible in this change. A few things that concern me
at the moment are:

Can jiffies change while one or more cpus is inside tick_sched_timer(),
 in interrupt context? I'm copying jiffies to a local variable in
 has_expired_timers() to ensure it doesn't run unbounded, but I'm not
 sure if that's necessary.

There may be a faster way to query pending_map. I copied the current
 algorithm from __collect_expired_timers(), which performs a linear
 search of each level for each clk, up to jiffies+HZ.

Special considerations for testing NO_HZ builds?

Other performance benchmark I should run?

Source: https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek

Thanks,
Haris
---
 kernel/time/timer.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ba53447..c6241ac 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1374,6 +1374,49 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
+/* Called in interrupt context to quickly check if one or
+ * more timers are expired in base
+ */
+static bool has_expired_timers(struct timer_base *base)
+{
+	bool res = false;
+	unsigned long clk, end_clk, idx;
+	int i;
+
+	raw_spin_lock(&base->lock);
+
+	end_clk = jiffies;
+	if (unlikely(time_after(end_clk, base->clk + HZ))) {
+		/* Don't spend too much time in interrupt context. If we didn't
+		 * service timers in the last second, defer to ktimersoftd.
+		 */
+		res = true;
+		goto end;
+	}
+
+	for ( ; base->clk <= end_clk; base->clk++) {
+		clk = base->clk;
+		for (i = 0; i < LVL_DEPTH; i++) {
+			idx = (clk & LVL_MASK) + i * LVL_SIZE;
+
+			if (test_bit(idx, base->pending_map)) {
+				res = true;
+				goto end;
+			}
+
+			/* Is it time to look at the next level? */
+			if (clk & LVL_CLK_MASK)
+				break;
+			/* Shift clock for the next level granularity */
+			clk >>= LVL_CLK_SHIFT;
+		}
+	}
+
+	end:
+	raw_spin_unlock(&base->lock);
+	return res;
+}
+
 static int __collect_expired_timers(struct timer_base *base,
 				    struct hlist_head *heads)
 {
@@ -1686,12 +1729,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->clk) || !has_expired_timers(base)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->clk) || !has_expired_timers(base))
 			return;
 	}
 	raise_softirq(TIMER_SOFTIRQ);
-- 
2.10.1


From: Jan Engelhardt <jengelh@medozas.de>
Subject: [archive] 2.6.31-rt timekeeping workaround
Date: Sat, 12 Sep 2009 21:00:35 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0909122057160.5958@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from borg.medozas.de ([188.40.89.202]:57561 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbZILTAe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Sep 2009 15:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 14B3E25C6A
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Sep 2009 21:00:36 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


As previously suggested[1], the patch still works, but seemed to 
have needed some rebasing onto the new version. It is provided below.
Makes my Xorg behave normal again in 2.6.31-(rc8)-rt. (It reading 2.6.30
is just a side artifact of the build environment.)

[1] http://marc.info/?l=linux-kernel&m=124725068404348&w=2

---
 kernel/hrtimer.c          |   56 ++++++++++++++++++++
 kernel/time/timekeeping.c |  123 ----------------------------------------------
 2 files changed, 56 insertions(+), 123 deletions(-)

Index: linux-2.6.30/kernel/hrtimer.c
===================================================================
--- linux-2.6.30.orig/kernel/hrtimer.c
+++ linux-2.6.30/kernel/hrtimer.c
@@ -48,6 +48,37 @@
 
 #include <asm/uaccess.h>
 
+/**
+ * ktime_get - get the monotonic time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+ktime_t ktime_get(void)
+{
+	struct timespec now;
+
+	ktime_get_ts(&now);
+
+	return timespec_to_ktime(now);
+}
+EXPORT_SYMBOL_GPL(ktime_get);
+
+/**
+ * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+ktime_t ktime_get_real(void)
+{
+	struct timespec now;
+
+	getnstimeofday(&now);
+
+	return timespec_to_ktime(now);
+}
+
+EXPORT_SYMBOL_GPL(ktime_get_real);
+
 /*
  * The timer bases:
  *
@@ -75,6 +106,31 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base,
 	}
 };
 
+/**
+ * ktime_get_ts - get the monotonic clock in timespec format
+ * @ts:		pointer to timespec variable
+ *
+ * The function calculates the monotonic clock from the realtime
+ * clock and the wall_to_monotonic offset and stores the result
+ * in normalized timespec format in the variable pointed to by @ts.
+ */
+void ktime_get_ts(struct timespec *ts)
+{
+	struct timespec tomono;
+	unsigned long seq;
+
+	do {
+		seq = read_atomic_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		tomono = wall_to_monotonic;
+
+	} while (read_atomic_seqretry(&xtime_lock, seq));
+
+	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
+				ts->tv_nsec + tomono.tv_nsec);
+}
+EXPORT_SYMBOL_GPL(ktime_get_ts);
+
 /*
  * Get the coarse grained time at the softirq based on xtime and
  * wall_to_monotonic.
Index: linux-2.6.30/kernel/time/timekeeping.c
===================================================================
--- linux-2.6.30.orig/kernel/time/timekeeping.c
+++ linux-2.6.30/kernel/time/timekeeping.c
@@ -124,75 +124,6 @@ void getnstimeofday(struct timespec *ts)
 
 EXPORT_SYMBOL(getnstimeofday);
 
-ktime_t ktime_get(void)
-{
-	cycle_t cycle_now, cycle_delta;
-	unsigned int seq;
-	s64 secs, nsecs;
-
-	WARN_ON(timekeeping_suspended);
-
-	do {
-		seq = read_atomic_seqbegin(&xtime_lock);
-		secs = xtime.tv_sec + wall_to_monotonic.tv_sec;
-		nsecs = xtime.tv_nsec + wall_to_monotonic.tv_nsec;
-
-		/* read clocksource: */
-		cycle_now = clocksource_read(clock);
-
-		/* calculate the delta since the last update_wall_time: */
-		cycle_delta = (cycle_now - clock->cycle_last) & clock->mask;
-
-		/* convert to nanoseconds: */
-		nsecs += cyc2ns(clock, cycle_delta);
-
-	} while (read_atomic_seqretry(&xtime_lock, seq));
-	/*
-	 * Use ktime_set/ktime_add_ns to create a proper ktime on
-	 * 32-bit architectures without CONFIG_KTIME_SCALAR.
-	 */
-	return ktime_add_ns(ktime_set(secs, 0), nsecs);
-}
-EXPORT_SYMBOL_GPL(ktime_get);
-
-/**
- * ktime_get_ts - get the monotonic clock in timespec format
- * @ts:		pointer to timespec variable
- *
- * The function calculates the monotonic clock from the realtime
- * clock and the wall_to_monotonic offset and stores the result
- * in normalized timespec format in the variable pointed to by @ts.
- */
-void ktime_get_ts(struct timespec *ts)
-{
-	cycle_t cycle_now, cycle_delta;
-	struct timespec tomono;
-	unsigned int seq;
-	s64 nsecs;
-
-	WARN_ON(timekeeping_suspended);
-
-	do {
-		seq = read_atomic_seqbegin(&xtime_lock);
-		*ts = xtime;
-		tomono = wall_to_monotonic;
-
-		/* read clocksource: */
-		cycle_now = clocksource_read(clock);
-
-		/* calculate the delta since the last update_wall_time: */
-		cycle_delta = (cycle_now - clock->cycle_last) & clock->mask;
-
-		/* convert to nanoseconds: */
-		nsecs = cyc2ns(clock, cycle_delta);
-
-	} while (read_atomic_seqretry(&xtime_lock, seq));
-
-	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
-				ts->tv_nsec + tomono.tv_nsec + nsecs);
-}
-EXPORT_SYMBOL_GPL(ktime_get_ts);
-
 /**
  * do_gettimeofday - Returns the time of day in a timeval
  * @tv:		pointer to the timeval to be set
@@ -293,63 +224,9 @@ static void change_clocksource(void)
 static inline void clocksource_forward_now(void) { }
 static inline void change_clocksource(void) { }
 
-/**
- * ktime_get - get the monotonic time in ktime_t format
- *
- * returns the time in ktime_t format
- */
-ktime_t ktime_get(void)
-{
-	struct timespec now;
-
-	ktime_get_ts(&now);
-
-	return timespec_to_ktime(now);
-}
-EXPORT_SYMBOL_GPL(ktime_get);
-
-/**
- * ktime_get_ts - get the monotonic clock in timespec format
- * @ts:		pointer to timespec variable
- *
- * The function calculates the monotonic clock from the realtime
- * clock and the wall_to_monotonic offset and stores the result
- * in normalized timespec format in the variable pointed to by @ts.
- */
-void ktime_get_ts(struct timespec *ts)
-{
-	struct timespec tomono;
-	unsigned long seq;
-
-	do {
-		seq = read_atomic_seqbegin(&xtime_lock);
-		getnstimeofday(ts);
-		tomono = wall_to_monotonic;
-
-	} while (read_atomic_seqretry(&xtime_lock, seq));
-
-	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
-				ts->tv_nsec + tomono.tv_nsec);
-}
-EXPORT_SYMBOL_GPL(ktime_get_ts);
 #endif /* !GENERIC_TIME */
 
 /**
- * ktime_get_real - get the real (wall-) time in ktime_t format
- *
- * returns the time in ktime_t format
- */
-ktime_t ktime_get_real(void)
-{
-	struct timespec now;
-
-	getnstimeofday(&now);
-
-	return timespec_to_ktime(now);
-}
-EXPORT_SYMBOL_GPL(ktime_get_real);

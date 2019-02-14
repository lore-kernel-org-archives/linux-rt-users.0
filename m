From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 1/2] time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
Date: Thu, 14 Feb 2019 14:37:15 +0100
Message-ID: <20190214133716.10187-2-juri.lelli@redhat.com>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
Cc: linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
To: tglx@linutronix.de, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214133716.10187-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

While running cyclictest on isolated CPUs I noticed the following odd
behavior, where CPU0 is one of the housekeeping CPUs and CPU2 is
isolated:

     <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
     <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
     <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
     <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
 cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
 cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
 cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]

While cyclitest was arming the hrtimer while running on isolated CPU2
(by means of clock_nanosleep), the hrtimer was then firing on CPU0. This
is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
the timer is not pinned, as it is currently the case.

The problem with this is that we are measuring wake up latencies across
isolated and !isolated domains, which is against the purpose of
configuring the latter.

Since PREEMPT_RT_FULL already forces HARD mode for hrtimers armed by
tasks running with RT policies, it makes sense to also force PINNED mode
under the same conditions.

This patch implements this behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h | 2 ++
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2bdb047c7656..c6d4941c7dd8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -56,6 +56,8 @@ enum hrtimer_mode {
 	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
 
+	HRTIMER_MODE_PINNED_HARD = HRTIMER_MODE_PINNED | HRTIMER_MODE_HARD,
+
 	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 851b2134e77f..4a905fb721a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1717,7 +1717,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 #ifdef CONFIG_PREEMPT_RT_FULL
 	if (!(mode & (HRTIMER_MODE_SOFT | HRTIMER_MODE_HARD))) {
 		if (task_is_realtime(current) || system_state != SYSTEM_RUNNING)
-			mode |= HRTIMER_MODE_HARD;
+			mode |= HRTIMER_MODE_PINNED_HARD;
 		else
 			mode |= HRTIMER_MODE_SOFT;
 	}
-- 
2.17.2

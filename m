From: Zhao Hongjiang <zhaohongjiang37@gmail.com>
Subject: [PATCH] hrtimer:fix the miss of hrtimer_peek_ahead_timers in nort
 code
Date: Fri, 08 Mar 2013 15:03:42 +0800
Message-ID: <51398D4E.70406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58906 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab3CHHDq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Mar 2013 02:03:46 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so1091336pad.26
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Mar 2013 23:03:46 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Zhao Hongjiang <zhaohongjiang@huawei.com>

When we run the test "taskset -c 1 stress -m 1 --vm-bytes 50M" and
"taskset -c 1 cyclictest -t 1 -p 80 -n -m -v" with rt closed 3.4.26-rt38 kernel,
the cyclictest's result is anomalous as follow:
       0:     278:       1
       0:     279:       2
       0:     280:      17
       0:     281:    1657
       0:     282:    1680
       0:     283:    4678
       0:     284:    7026
       0:     285:    6678
       0:     286:    9677
       0:     287:   12678
       0:     288:   13090
       0:     289:   14678
       0:     290:   17677
       0:     291:   20155
       0:     292:   19678
       0:     293:   22679
       0:     294:   25676
       0:     295:   26218
       0:     296:   27679
       0:     297:   30677
       0:     298:   33283
       0:     299:   32677
       0:     300:   35676
and the result is increase continuously forever. We find that the patch
"hrtimer-fixup-hrtimer-callback-changes-for-preempt-rt.patch"(commit id is
64abd3f22112032a343f77de78bed60dfda2c58f) has missed hrtimer_peek_ahead_timers()
in hrtimer_rt_run_pending() fuction in nort code. We fix this and the test
result isn't increase continuously as same as the result with nort 3.4.26
kernel as follow:
       0:     636:       8
       0:     637:       7
       0:     638:       8
       0:     639:       9
       0:     640:       7
       0:     641:       9
       0:     642:       8
       0:     643:       8
       0:     644:       8
       0:     645:      32
       0:     646:    8683
       0:     647:    7760
       0:     648:    6784
       0:     649:    5797
       0:     650:    4810
       0:     651:    3823
       0:     652:    2836
       0:     653:    1849
       0:     654:     862
       0:     655:       7
       0:     656:       7
       0:     657:       7
       0:     658:       6
       0:     659:       8
       0:     660:       7


Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
Signed-off-by: Weng Meiling <wengmeiling.weng@huawei.com>
---
 kernel/hrtimer.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 9114899..bcd40d8 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1427,7 +1427,11 @@ static int hrtimer_rt_defer(struct hrtimer *timer)

 #else

-static inline void hrtimer_rt_run_pending(void) { }
+static inline void hrtimer_rt_run_pending(void)
+{
+	hrtimer_peek_ahead_timers();
+}
+
 static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }

 #endif
-- 1.7.1

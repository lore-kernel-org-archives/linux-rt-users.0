From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/5] count_active_rt_tasks() is undefined when CONFIG_PREEMPT_RT is not set.
Date: Tue, 04 Sep 2007 17:09:02 +1000
Message-ID: <20070904070902.4429732CA0A@thor>
References: <1188889742.376.642108109551.qpush@thor>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:35380 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbXIDHV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 03:21:29 -0400
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id C3AD913C30
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 15:09:02 +0800 (WST)
In-Reply-To: <1188889742.376.642108109551.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Also, it looks to me that active_rt_tasks[] was never modified.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 kernel/timer.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: working/kernel/timer.c
===================================================================
--- working.orig/kernel/timer.c	2007-09-04 16:46:40.000000000 +1000
+++ working/kernel/timer.c	2007-09-04 16:46:54.000000000 +1000
@@ -953,21 +953,25 @@ unsigned long avenrun_rt[3];
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
-	unsigned long active_rt_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
+#ifdef CONFIG_PREEMPT_RT
+	unsigned long active_rt_tasks; /* fixed-point */
+#endif
 
 	count -= ticks;
 	if (unlikely(count < 0)) {
 		active_tasks = count_active_tasks();
+#ifdef CONFIG_PREEMPT_RT
 		active_rt_tasks = count_active_rt_tasks();
+#endif
 		do {
 			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
 			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
 			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
 #ifdef CONFIG_PREEMPT_RT
-			CALC_LOAD(avenrun_rt[0], EXP_1, active_tasks);
-			CALC_LOAD(avenrun_rt[1], EXP_5, active_tasks);
-			CALC_LOAD(avenrun_rt[2], EXP_15, active_tasks);
+			CALC_LOAD(avenrun_rt[0], EXP_1, active_rt_tasks);
+			CALC_LOAD(avenrun_rt[1], EXP_5, active_rt_tasks);
+			CALC_LOAD(avenrun_rt[2], EXP_15, active_rt_tasks);
 #endif
 			count += LOAD_FREQ;
 

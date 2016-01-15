From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 7/9] kernel/time: hrtimer: fix forward declaration
Date: Fri, 15 Jan 2016 20:21:11 +0100
Message-ID: <1452885673-30891-8-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34321 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbcAOT1H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:07 -0500
Received: by mail-lb0-f173.google.com with SMTP id cl12so102771403lbc.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:06 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Forward declare function hrtimer_wakeup before use.

Used allmodconfig+CONFIG_OF=n and this caused a compilation error
without this fix:
../kernel/time/hrtimer.c: In function '__hrtimer_run_queues':
../kernel/time/hrtimer.c:1464:27: error: 'hrtimer_wakeup' undeclared
(first use in this function)
        timer->function == hrtimer_wakeup ?

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index fdd2b85..138d6f9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1436,6 +1436,8 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 #endif
 
 
+static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
+
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
@@ -1490,8 +1492,6 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
-static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);

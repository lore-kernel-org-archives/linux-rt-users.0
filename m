From: Carsten Emde <C.Emde@osadl.org>
Subject: trace/latency-hist: Repair missing forward declaration
Date: Tue, 5 Jan 2016 09:55:44 +0100
Message-ID: <568B8510.1080904@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41630 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbcAEJRW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 04:17:22 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas & Sebastian,

Move forward declaration of hrtimer_wakeup() up to make it available
when needed.

Thanks,
	-Carsten.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
  kernel/time/hrtimer.c |    3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-4.4.0-rc6-rt1/kernel/time/hrtimer.c
===================================================================
--- linux-4.4.0-rc6-rt1.orig/kernel/time/hrtimer.c
+++ linux-4.4.0-rc6-rt1/kernel/time/hrtimer.c
@@ -1435,6 +1435,7 @@ static inline int hrtimer_rt_defer(struc

  #endif

+static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);

  static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, 
ktime_t now)
  {
@@ -1490,8 +1491,6 @@ static void __hrtimer_run_queues(struct
  		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
  }

-static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);

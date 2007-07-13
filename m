From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt 4/6] Add trace_preempt_*_idle() support for ARM.
Date: Fri, 13 Jul 2007 10:52:18 -0700
Message-ID: <20070713175228.623525155@mvista.com>
References: <20070713175214.336577416@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:38941 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760089AbXGMSNH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:13:07 -0400
Content-Disposition: inline; filename=arm-trace-preempt-idle.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add trace functions to ARM idle loop and also move the
tick_nohz_restart_sched_tick() after the local_irq_disable() as is
done on x86.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/kernel/process.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/process.c
+++ linux-2.6/arch/arm/kernel/process.c
@@ -165,11 +165,13 @@ void cpu_idle(void)
 		while (!need_resched() && !need_resched_delayed())
 			idle();
 		leds_event(led_idle_end);
-		tick_nohz_restart_sched_tick();
 		local_irq_disable();
+		trace_preempt_exit_idle();
+		tick_nohz_restart_sched_tick();
 		__preempt_enable_no_resched();
 		__schedule();
 		preempt_disable();
+		trace_preempt_enter_idle();
 		local_irq_enable();
 	}
 }

--

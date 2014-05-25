From: minyard@acm.org
Subject: [PATCH] arm: Set hardirq tracing to on when idling
Date: Sun, 25 May 2014 14:15:23 -0500
Message-ID: <1401045323-7116-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

The CPU will go to idle with interrupts off, but the interrupts
will wake up the idle.  This was causing very long irqsoff trace
values because, basically, the whole idle time was traces with
irqs off, even though they weren't really off.  Rework the idle
code to turn hardirq tracing to on befor calling idle.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/arm/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

I'm not sure this is correct for all ARM boards, but it fixes the
issue for the Vexpress board I have.  No more 4 second irqsoff
times.

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1ca6cf1..92413af 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -133,11 +133,12 @@ void (*arm_pm_idle)(void);
 
 static void default_idle(void)
 {
+	trace_hardirqs_on();
 	if (arm_pm_idle)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
-- 
1.8.3.1

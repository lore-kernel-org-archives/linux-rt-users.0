From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] arm: lazy preempt: correct resched condition
Date: Tue, 24 May 2016 13:30:36 +0200
Message-ID: <20160524113036.GA27094@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If we get out of preempt_schedule_irq() then we check for NEED_RESCHED
and call the former function again if set because the preemption counter
has be zero at this point.
However the counter for lazy-preempt might not be zero therefore we have
to check the counter before looking at the need_resched_lazy flag.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/entry-armv.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d66b1aef2083..d044cea59f54 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -244,7 +244,11 @@ ENDPROC(__irq_svc)
 	bne	1b
 	tst	r0, #_TIF_NEED_RESCHED_LAZY
 	reteq	r8				@ go again
-	b	1b
+	ldr	r0, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
+	teq	r0, #0				@ if preempt lazy count != 0
+	beq	1b
+	ret	r8				@ go again
+
 #endif
 
 __und_fault:
-- 
2.8.1

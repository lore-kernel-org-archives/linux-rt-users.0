From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 11/15] arm: lazy preempt: correct resched condition
Date: Tue, 12 Jul 2016 10:29:18 -0400
Message-ID: <20160712142920.426968770@goodmis.org>
References: <20160712142907.636678217@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0011-arm-lazy-preempt-correct-resched-condition.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.36-rt38-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If we get out of preempt_schedule_irq() then we check for NEED_RESCHED
and call the former function again if set because the preemption counter
has be zero at this point.
However the counter for lazy-preempt might not be zero therefore we have
to check the counter before looking at the need_resched_lazy flag.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/kernel/entry-armv.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 61af605ae614..1c4842879e17 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -236,7 +236,11 @@ svc_preempt:
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

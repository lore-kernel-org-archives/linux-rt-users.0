From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] powerpc/64bit,PREEMPT_RT: Check preempt_count before preempting
Date: Fri, 03 May 2013 17:37:06 -0400
Message-ID: <20130503213818.087747521@goodmis.org>
References: <20130503213703.521223574@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Priyanka Jain <Priyanka.Jain@freescale.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-powerpc-64bit-PREEMPT_RT-Check-preempt_count-before-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Priyanka Jain <Priyanka.Jain@freescale.com>

In ret_from_except_lite() with CONFIG_PREEMPT enabled,
add the missing check to compare value of preempt_count
with zero before continuing with preemption process of
the current task.
If preempt_count is non-zero, restore reg and return,
else continue the preemption process.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kernel/entry_64.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a9b98cc..7af1ea7 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -596,6 +596,8 @@ resume_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Check if we need to preempt */
 	lwz	r8,TI_PREEMPT(r9)
+	cmpwi	0,r8,0		/* if non-zero, just restore regs and return */
+	bne	restore
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne+	1f
 
-- 
1.7.10.4

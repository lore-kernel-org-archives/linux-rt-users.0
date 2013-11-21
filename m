From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/5] genirq: Set the irq thread policy without checking CAP_SYS_NICE
Date: Thu, 21 Nov 2013 13:43:58 -0500
Message-ID: <20131121184629.497182845@goodmis.org>
References: <20131121184357.391591135@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Ivo Sieben <meltedpianoman@gmail.com>,
	Thomas Pfaff <tpfaff@pcs.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-genirq-Set-the-irq-thread-policy-without-checking-CA.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.52-rt74-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Pfaff <tpfaff@pcs.com>

In commit ee23871389 ("genirq: Set irq thread to RT priority on
creation") we moved the assigment of the thread's priority from the
thread's function into __setup_irq(). That function may run in user
context for instance if the user opens an UART node and then driver
calls requests in the ->open() callback. That user may not have
CAP_SYS_NICE and so the irq thread won't run with the SCHED_OTHER
policy.

This patch uses sched_setscheduler_nocheck() so we omit the CAP_SYS_NICE
check which is otherwise required for the SCHED_OTHER policy.

Cc: Ivo Sieben <meltedpianoman@gmail.com>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[bigeasy: rewrite the changelog]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 88a4ff5..5b51ba7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1041,7 +1041,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			goto out_mput;
 		}
 
-		sched_setscheduler(t, SCHED_FIFO, &param);
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
 
 		/*
 		 * We keep the reference to the task struct even if
-- 
1.8.4.rc3

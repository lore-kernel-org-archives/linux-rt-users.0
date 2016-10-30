From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] genirq: Fix pointer cast warning for randomness on 32-bit
 architectures
Date: Sun, 30 Oct 2016 12:51:10 -0400
Message-ID: <20161030165121.794646459@goodmis.org>
References: <20161030165109.200928387@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-genirq-Fix-pointer-cast-warning-for-randomness-on-32.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.83-rt121-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

gcc warns about casting directly from a 32-bit pointer to u64.  In the
current rt patch series we cast to unsigned long to avoid the warning,
but this fix hasn't been backported to all versions.

Link: http://lkml.kernel.org/r/20160929170041.GW10601@decadent.org.uk

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/irq/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c4677795d7c8..b1683ba80c88 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -897,7 +897,8 @@ static int irq_thread(void *data)
 #ifdef CONFIG_PREEMPT_RT_FULL
 			migrate_disable();
 			add_interrupt_randomness(action->irq, 0,
-						 desc->random_ip ^ (u64) action);
+						 desc->random_ip ^
+						 (unsigned long) action);
 			migrate_enable();
 #endif
 		}
-- 
2.9.3

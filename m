From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] kernel: softirq: unlock with irqs on
Date: Wed, 02 Mar 2016 15:14:09 -0500
Message-ID: <20160302201414.657228926@goodmis.org>
References: <20160302201406.143206126@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-kernel-softirq-unlock-with-irqs-on.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.110-rt140-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

We unlock the lock while the interrupts are off. This isn't a problem
now but will get because the migrate_disable() + enable are not
symmetrical in regard to the status of interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ecf0ab0f7b4d..d2c870a826da 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -561,10 +561,10 @@ static int __thread_do_softirq(int cpu)
 	 */
 	if (local_softirq_pending())
 		__do_softirq_common(cpu >= 0);
-	local_unlock(local_softirq_lock);
 	unpin_current_cpu();
-	preempt_disable();
 	local_irq_enable();
+	local_unlock(local_softirq_lock);
+	preempt_disable();
 	return 0;
 }
 
-- 
2.7.0

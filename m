From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/11] rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()
Date: Fri, 28 Feb 2014 08:34:58 -0500
Message-ID: <20140228133535.785759588@goodmis.org>
References: <20140228133454.373761937@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Tiejun Chen <tiejun.chen@windriver.com>,
	Bin Jiang <bin.jiang@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-rcutree-rcu_bh_qs-disable-irq-while-calling-rcu_pree.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.32-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tiejun Chen <tiejun.chen@windriver.com>

Any callers to the function rcu_preempt_qs() must disable irqs in
order to protect the assignment to ->rcu_read_unlock_special. In
RT case, rcu_bh_qs() as the wrapper of rcu_preempt_qs() is called
in some scenarios where irq is enabled, like this path,

do_single_softirq()
    |
    + local_irq_enable();
    + handle_softirq()
    |    |
    |    + rcu_bh_qs()
    |        |
    |        + rcu_preempt_qs()
    |
    + local_irq_disable()

So here we'd better disable irq directly inside of rcu_bh_qs() to
fix this, otherwise the kernel may be freezable sometimes as
observed. And especially this way is also kind and safe for the
potential rcu_bh_qs() usage elsewhere in the future.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
Signed-off-by: Bin Jiang <bin.jiang@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index 55915b1..dcb79e9 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -187,7 +187,12 @@ static void rcu_preempt_qs(int cpu);
 
 void rcu_bh_qs(int cpu)
 {
+	unsigned long flags;
+
+	/* Callers to this function, rcu_preempt_qs(), must disable irqs. */
+	local_irq_save(flags);
 	rcu_preempt_qs(cpu);
+	local_irq_restore(flags);
 }
 #else
 void rcu_bh_qs(int cpu)
-- 
1.8.5.3

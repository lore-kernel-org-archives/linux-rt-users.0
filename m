From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RT 2/2][RFC] let RCU stall messages escape with
 CONFIG_PREEMPT_RT_FULL
Date: Tue, 4 Dec 2012 20:52:21 -0800
Message-ID: <50BED305.9090308@am.sony.com>
References: <50BED1DA.7070907@am.sony.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "paulmck@linux.vnet.ibm.com"
 <paulmck@linux.vnet.ibm.com>, "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50BED1DA.7070907@am.sony.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org


The printk()s in RCU stall warnings do not get flushed to the console
on ARM.  Add the oops_in_progress flag back into the special trylock case in
console_trylock_for_printk(), and set the flag using "bust_spinlocks(1)".
This allows the printk() output to be flushed to the console.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 kernel/printk.c  |    5 	3 +	2 -	0 !
 kernel/rcutree.c |   14 	14 +	0 -	0 !
 2 files changed, 17 insertions(+), 2 deletions(-)

Index: b/kernel/printk.c
===================================================================
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -1390,8 +1390,9 @@ static int console_trylock_for_printk(un
 {
 	int retval = 0, wake = 0;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		(preempt_count() <= 1);
+	int lock = oops_in_progress || (
+		!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
+		(preempt_count() <= 1));
 #else
 	int lock = 1;
 #endif
Index: b/kernel/rcutree.c
===================================================================
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -758,6 +758,11 @@ static void print_other_cpu_stall(struct
 	raw_spin_unlock_irqrestore(&rnp->lock, flags);
 
 	/*
+	 * Allow printk() to flush to device
+	 */
+	bust_spinlocks(1);
+
+	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
@@ -799,6 +804,8 @@ static void print_other_cpu_stall(struct
 
 	rcu_print_detail_task_stall(rsp);
 
+	bust_spinlocks(0);
+
 	force_quiescent_state(rsp, 0);  /* Kick them all. */
 }
 
@@ -808,6 +815,11 @@ static void print_cpu_stall(struct rcu_s
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
 	/*
+	 * Allow printk() to flush to device
+	 */
+	bust_spinlocks(1);
+
+	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
@@ -820,6 +832,8 @@ static void print_cpu_stall(struct rcu_s
 	if (!trigger_all_cpu_backtrace())
 		dump_stack();
 
+	bust_spinlocks(0);
+
 	raw_spin_lock_irqsave(&rnp->lock, flags);
 	if (ULONG_CMP_GE(jiffies, rsp->jiffies_stall))
 		rsp->jiffies_stall = jiffies +

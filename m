From: "Tim Sander" <tim.sander@hbm.com>
Subject: [patch] Re: RCU?: Scheduling while atomic with 3.4.23-rt33
Date: Mon, 18 Feb 2013 13:40:15 +0100
Message-ID: <1531475.RE4mPsegvf@dabox>
References: <4738617.pBMCEJ5E3K@dabox> <alpine.LFD.2.02.1302181214250.22263@ionos>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="nextPart3458342.eXhJ7SgOxQ"
Content-Transfer-Encoding: 7Bit
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	"Steven Rostedt" <rostedt@goodmis.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.LFD.2.02.1302181214250.22263@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3458342.eXhJ7SgOxQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="us-ascii"

Am Montag, 18. Februar 2013, 12:16:41 schrieb Thomas Gleixner:
> On Mon, 18 Feb 2013, Tim Sander wrote:
> > Here is a transtribed backtrace for easier reading:
> > c0010fac t dump_backtrace
> > c022c188 T dump_stack
> > c022c71c t __schedule_bug
> > c022fb28 t __schedule
> > c0230644 t rt_spin_lock_slowlock
> > c0230ba8 T rt_spin_lock
> > c003a9b8 T __wake_up
> > c0052a44 t invoke_rcu_callbacks
> > c0053764 T rcu_check_callbacks
> > c0026060 T update_process_times
>=20
> That's due to CONFIG_TINY_PREEMPT_RCU=3Dy. That's a known issue, which
> has been fixed in 3.6-rt.
>=20
> Steven, could you backport that to 3.2/3.4 please ?
As far as i see its been the waitequeue stuff. The patch below is the =
patch=20
from 3.6. backported to 3.4.


Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the =
commercial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im =
Handelsregister des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas =
Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for =
the addressee. If you are not the intended recipient, please let me know =
and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und =
lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese =
E-Mail.

--nextPart3458342.eXhJ7SgOxQ
Content-Disposition: attachment;
	filename="0022-rcutiny-Use-simple-waitqueue.patch"
Content-Transfer-Encoding: 7bit
Content-Type: text/x-patch;
	charset="UTF-8";
	name="0022-rcutiny-Use-simple-waitqueue.patch"

>From 2f0eb85792045f06bc0db3fe1fff17c9298240d3 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 3 Dec 2012 16:25:21 +0100
Subject: [PATCH] rcutiny: Use simple waitqueue

Simple waitqueues can be handled from interrupt disabled contexts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcutiny_plugin.h |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcutiny_plugin.h b/kernel/rcutiny_plugin.h
index 97e359b..2824dbd 100644
--- a/kernel/rcutiny_plugin.h
+++ b/kernel/rcutiny_plugin.h
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/wait-simple.h>
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -261,7 +262,7 @@ static void show_tiny_preempt_stats(struct seq_file *m)
 
 /* Controls for rcu_kthread() kthread. */
 static struct task_struct *rcu_kthread_task;
-static DECLARE_WAIT_QUEUE_HEAD(rcu_kthread_wq);
+static DEFINE_SWAIT_HEAD(rcu_kthread_wq);
 static unsigned long have_rcu_kthread_work;
 
 /*
@@ -754,7 +755,7 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-static DECLARE_WAIT_QUEUE_HEAD(sync_rcu_preempt_exp_wq);
+static DEFINE_SWAIT_HEAD(sync_rcu_preempt_exp_wq);
 static unsigned long sync_rcu_preempt_exp_count;
 static DEFINE_MUTEX(sync_rcu_preempt_exp_mutex);
 
@@ -776,7 +777,7 @@ static int rcu_preempted_readers_exp(void)
  */
 static void rcu_report_exp_done(void)
 {
-	wake_up(&sync_rcu_preempt_exp_wq);
+	swait_wake(&sync_rcu_preempt_exp_wq);
 }
 
 /*
@@ -828,8 +829,8 @@ void synchronize_rcu_expedited(void)
 	else {
 		rcu_initiate_boost();
 		local_irq_restore(flags);
-		wait_event(sync_rcu_preempt_exp_wq,
-			   !rcu_preempted_readers_exp());
+		swait_event(sync_rcu_preempt_exp_wq,
+			    !rcu_preempted_readers_exp());
 	}
 
 	/* Clean up and exit. */
@@ -917,7 +918,7 @@ static void invoke_rcu_callbacks(void)
 {
 	have_rcu_kthread_work = 1;
 	if (rcu_kthread_task != NULL)
-		wake_up(&rcu_kthread_wq);
+		swait_wake(&rcu_kthread_wq);
 }
 
 #ifdef CONFIG_RCU_TRACE
@@ -947,8 +948,8 @@ static int rcu_kthread(void *arg)
 	unsigned long flags;
 
 	for (;;) {
-		wait_event_interruptible(rcu_kthread_wq,
-					 have_rcu_kthread_work != 0);
+		swait_event_interruptible(rcu_kthread_wq,
+					  have_rcu_kthread_work != 0);
 		morework = rcu_boost();
 		local_irq_save(flags);
 		work = have_rcu_kthread_work;
-- 
1.7.9.5


--nextPart3458342.eXhJ7SgOxQ--

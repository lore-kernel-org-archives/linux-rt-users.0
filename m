From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.6-rt17
Date: Mon, 12 Nov 2012 22:28:09 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1211122223300.10000@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.6-rt17 release. 3.6.6-rt16 is just a
not announced update release to 3.6.6.

Changes since 3.6.6-rt16:

   * Finally make the NOHZ softirq pending detection work with the new
     softirq scheme.

   * Remove the WARN_ON from __raise_softirq_irqoff(). I got the
     information I want for now.

The delta patch against 3.6.6-rt16 is appended below and can be found
here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.6-rt16-rt17.patch.xz

The RT patch against 3.6.6 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.6-rt17.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.6-rt17.tar.xz

Enjoy,

	tglx

------------->
Index: linux-stable/kernel/softirq.c
===================================================================
--- linux-stable.orig/kernel/softirq.c
+++ linux-stable/kernel/softirq.c
@@ -100,20 +100,15 @@ void softirq_check_pending_idle(void)
 {
 	static int rate_limit;
 	struct softirq_runner *sr = &__get_cpu_var(softirq_runners);
-	u32 warnpending, pending = local_softirq_pending();
+	u32 warnpending = local_softirq_pending();
+	int i;
 
 	if (rate_limit >= 10)
 		return;
 
-	warnpending = pending;
-
-	while (pending) {
-		struct task_struct *tsk;
-		int i = __ffs(pending);
-
-		pending &= ~(1 << i);
+	for (i = 0; i < NR_SOFTIRQS; i++) {
+		struct task_struct *tsk = sr->runner[i];
 
-		tsk = sr->runner[i];
 		/*
 		 * The wakeup code in rtmutex.c wakes up the task
 		 * _before_ it sets pi_blocked_on to NULL under
@@ -638,7 +633,7 @@ static void do_raise_softirq_irqoff(unsi
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	do_raise_softirq_irqoff(nr);
-	if (WARN_ON_ONCE(!in_irq() && !current->softirq_nestcnt))
+	if (!in_irq() && !current->softirq_nestcnt)
 		wakeup_softirqd();
 }
 
Index: linux-stable/localversion-rt
===================================================================
--- linux-stable.orig/localversion-rt
+++ linux-stable/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17

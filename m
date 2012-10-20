From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.2-rt4
Date: Sat, 20 Oct 2012 21:40:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210202133470.2719@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.2-rt4 release. rt4 is just an update
to 3.6.2. The not announced 3.6.1-rt3 is an intermediate release with
a single change.

Changes since 3.6.1-rt2:

	* Remove the softirq noise printk

The delta patch against 3.6.1-rt2 is appended below and can be found here

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.1-rt2-rt3.patch.xz

The RT patch against 3.6.2 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.2-rt4.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.2-rt4.tar.xz

Enjoy,

	tglx

---------->

Index: linux-stable/kernel/softirq.c
===================================================================
--- linux-stable.orig/kernel/softirq.c
+++ linux-stable/kernel/softirq.c
@@ -468,8 +468,6 @@ static void do_single_softirq(int which,
  */
 static void do_current_softirqs(int need_rcu_bh_qs)
 {
-	int retry = 0;
-
 	while (current->softirqs_raised) {
 		int i = __ffs(current->softirqs_raised);
 		unsigned int pending, mask = (1U << i);
@@ -496,10 +494,6 @@ static void do_current_softirqs(int need
 		}
 		unlock_softirq(i);
 		WARN_ON(current->softirq_nestcnt != 1);
-		if (++retry == 20) {
-			printk(KERN_ERR "Crap, %s looping forever in softirq\n",
-			       current->comm);
-		}
 	}
 }
 
Index: linux-stable/localversion-rt
===================================================================
--- linux-stable.orig/localversion-rt
+++ linux-stable/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3

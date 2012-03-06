From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.2.9-rt16
Date: Tue, 6 Mar 2012 11:20:57 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203061118050.2742@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57320 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448Ab2CFKU7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 05:20:59 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.2.9-rt16 release.

Changes vs. 3.2.9-rt15:

  * cpu hotplug lock init fix [ Steven ]

  * seqlock fix CONFIG typo

The incremental patch against 3.2.9-rt15 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.9-rt15-rt16.patch.xz

and is appended below.


The RT patch against 3.2.9 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.9-rt16.patch.xz


The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patches-3.2.9-rt16.tar.xz


Enjoy,

	tglx

Index: linux-3.2/include/linux/seqlock.h
===================================================================
--- linux-3.2.orig/include/linux/seqlock.h
+++ linux-3.2/include/linux/seqlock.h
@@ -177,7 +177,7 @@ typedef struct {
 /*
  * Read side functions for starting and finalizing a read side section.
  */
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT_FULL
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	return read_seqcount_begin(&sl->seqcount);
Index: linux-3.2/kernel/cpu.c
===================================================================
--- linux-3.2.orig/kernel/cpu.c
+++ linux-3.2/kernel/cpu.c
@@ -59,16 +59,20 @@ static struct {
 	int refcount;
 } cpu_hotplug = {
 	.active_writer = NULL,
+#ifdef CONFIG_PREEMPT_RT_FULL
+	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
+#else
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
+#endif
 	.refcount = 0,
 };
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-# define hotplug_lock() spin_lock(&cpu_hotplug.lock)
-# define hotplug_unlock() spin_unlock(&cpu_hotplug.lock)
+# define hotplug_lock() rt_spin_lock(&cpu_hotplug.lock)
+# define hotplug_unlock() rt_spin_unlock(&cpu_hotplug.lock)
 #else
 # define hotplug_lock() mutex_lock(&cpu_hotplug.lock)
-# define hotplug_lock() mutex_unlock(&cpu_hotplug.lock)
+# define hotplug_unlock() mutex_unlock(&cpu_hotplug.lock)
 #endif
 
 struct hotplug_pcp {
Index: linux-3.2/localversion-rt
===================================================================
--- linux-3.2.orig/localversion-rt
+++ linux-3.2/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
Index: linux-3.2/include/net/neighbour.h
===================================================================
--- linux-3.2.orig/include/net/neighbour.h
+++ linux-3.2/include/net/neighbour.h
@@ -385,7 +385,7 @@ struct neighbour_cb {
 
 #define NEIGH_CB(skb)	((struct neighbour_cb *)(skb)->cb)
 
-static inline void neigh_ha_snapshot(char *dst, const struct neighbour *n,
+static inline void neigh_ha_snapshot(char *dst, struct neighbour *n,
 				     const struct net_device *dev)
 {
 	unsigned int seq;

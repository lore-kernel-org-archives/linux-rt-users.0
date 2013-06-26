From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 3/6] idr: Use migrate_disable() to stay on the current CPU
Date: Wed, 26 Jun 2013 15:28:09 -0400
Message-ID: <20130626193050.056722116@goodmis.org>
References: <20130626192806.107564905@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=idr-migrate-disable.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

idr_preload() and idr_preload_end() use preempt_disable() to keep the process
from migrating. For mainline that's fine, but for -rt, that has issues as
the spin_locks in between are changed to mutexes.

Use migrated_disable/enable() instead.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/include/linux/idr.h
===================================================================
--- linux-rt.git.orig/include/linux/idr.h
+++ linux-rt.git/include/linux/idr.h
@@ -94,7 +94,7 @@ void idr_init(struct idr *idp);
  */
 static inline void idr_preload_end(void)
 {
-	preempt_enable();
+	migrate_enable();
 }
 
 /**
Index: linux-rt.git/lib/idr.c
===================================================================
--- linux-rt.git.orig/lib/idr.c
+++ linux-rt.git/lib/idr.c
@@ -423,7 +423,7 @@ void idr_preload(gfp_t gfp_mask)
 	WARN_ON_ONCE(in_interrupt());
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 
-	preempt_disable();
+	migrate_disable();
 
 	/*
 	 * idr_alloc() is likely to succeed w/o full idr_layer buffer and
@@ -435,9 +435,9 @@ void idr_preload(gfp_t gfp_mask)
 	while (__this_cpu_read(idr_preload_cnt) < MAX_IDR_FREE) {
 		struct idr_layer *new;
 
-		preempt_enable();
+		migrate_enable();
 		new = kmem_cache_zalloc(idr_layer_cache, gfp_mask);
-		preempt_disable();
+		migrate_disable();
 		if (!new)
 			break;
 

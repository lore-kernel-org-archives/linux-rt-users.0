From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.3-rt7
Date: Fri, 26 Oct 2012 20:52:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210262036270.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.3-rt7 release.

Changes since 3.6.3-rt6:

   * Enable SLUB for RT

     Last time I looked at SLUB for RT (some years ago) it was just
     way more painful than dealing with SLAB, but Christoph Lameter
     has done major surgery on the SLUB code since then and it turns
     out that making SLUB usable for RT has become very simple. Thanks
     Christoph!

      slab.c: 172 insertions(+), 58 deletions(-)
      slub.c:  17 insertions(+), 13 deletions(-)

     I did some quick comparisons and even a simple hackbench run
     shows a significant speedup with SLUB vs. SLAB on RT. I'm not too
     surprised as SLUBs fastpath does not have the RT induced
     contention problems which we can observe with SLAB.

     As usual, give it a good testing and report whatever explodes :)

The delta patch against 3.6.3-rt6 is appended below and can be found
here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.3-rt6-rt7.patch.xz

The RT patch against 3.6.3 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.3-rt7.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.3-rt7.tar.xz

Enjoy,

	tglx

---------->
Index: linux-stable/init/Kconfig
===================================================================
--- linux-stable.orig/init/Kconfig
+++ linux-stable/init/Kconfig
@@ -1442,7 +1442,6 @@ config SLAB
 
 config SLUB
 	bool "SLUB (Unqueued Allocator)"
-	depends on !PREEMPT_RT_FULL
 	help
 	   SLUB is a slab allocator that minimizes cache line usage
 	   instead of managing queues of cached objects (SLAB approach).
Index: linux-stable/localversion-rt
===================================================================
--- linux-stable.orig/localversion-rt
+++ linux-stable/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
Index: linux-stable/mm/slub.c
===================================================================
--- linux-stable.orig/mm/slub.c
+++ linux-stable/mm/slub.c
@@ -31,6 +31,7 @@
 #include <linux/fault-inject.h>
 #include <linux/stacktrace.h>
 #include <linux/prefetch.h>
+#include <linux/locallock.h>
 
 #include <trace/events/kmem.h>
 
@@ -225,6 +226,8 @@ static inline void stat(const struct kme
 #endif
 }
 
+static DEFINE_LOCAL_IRQ_LOCK(slub_lock);
+
 /********************************************************************
  * 			Core slab cache functions
  *******************************************************************/
@@ -1278,7 +1281,7 @@ static struct page *allocate_slab(struct
 	flags &= gfp_allowed_mask;
 
 	if (flags & __GFP_WAIT)
-		local_irq_enable();
+		local_unlock_irq(slub_lock);
 
 	flags |= s->allocflags;
 
@@ -1318,7 +1321,7 @@ static struct page *allocate_slab(struct
 	}
 
 	if (flags & __GFP_WAIT)
-		local_irq_disable();
+		local_lock_irq(slub_lock);
 	if (!page)
 		return NULL;
 
@@ -1959,9 +1962,9 @@ int put_cpu_partial(struct kmem_cache *s
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				local_irq_save(flags);
+				local_lock_irqsave(slub_lock, flags);
 				unfreeze_partials(s);
-				local_irq_restore(flags);
+				local_unlock_irqrestore(slub_lock, flags);
 				pobjects = 0;
 				pages = 0;
 				stat(s, CPU_PARTIAL_DRAIN);
@@ -2201,7 +2204,7 @@ static void *__slab_alloc(struct kmem_ca
 	struct page *page;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(slub_lock, flags);
 #ifdef CONFIG_PREEMPT
 	/*
 	 * We may have been preempted and rescheduled on a different
@@ -2262,7 +2265,7 @@ load_freelist:
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(slub_lock, flags);
 	return freelist;
 
 new_slab:
@@ -2281,7 +2284,7 @@ new_slab:
 		if (!(gfpflags & __GFP_NOWARN) && printk_ratelimit())
 			slab_out_of_memory(s, gfpflags, node);
 
-		local_irq_restore(flags);
+		local_unlock_irqrestore(slub_lock, flags);
 		return NULL;
 	}
 
@@ -2296,7 +2299,7 @@ new_slab:
 	deactivate_slab(s, page, get_freepointer(s, freelist));
 	c->page = NULL;
 	c->freelist = NULL;
-	local_irq_restore(flags);
+	local_unlock_irqrestore(slub_lock, flags);
 	return freelist;
 }
 
@@ -2488,7 +2491,8 @@ static void __slab_free(struct kmem_cach
 				 * Otherwise the list_lock will synchronize with
 				 * other processors updating the list of slabs.
 				 */
-				spin_lock_irqsave(&n->list_lock, flags);
+				local_spin_lock_irqsave(slub_lock,
+							&n->list_lock, flags);
 
 			}
 		}
@@ -2538,7 +2542,7 @@ static void __slab_free(struct kmem_cach
 			stat(s, FREE_ADD_PARTIAL);
 		}
 	}
-	spin_unlock_irqrestore(&n->list_lock, flags);
+	local_spin_unlock_irqrestore(slub_lock, &n->list_lock, flags);
 	return;
 
 slab_empty:
@@ -2552,7 +2556,7 @@ slab_empty:
 		/* Slab must be on the full list */
 		remove_full(s, page);
 
-	spin_unlock_irqrestore(&n->list_lock, flags);
+	local_spin_unlock_irqrestore(slub_lock, &n->list_lock, flags);
 	stat(s, FREE_SLAB);
 	discard_slab(s, page);
 }
@@ -4002,9 +4006,9 @@ static int __cpuinit slab_cpuup_callback
 	case CPU_DEAD_FROZEN:
 		mutex_lock(&slab_mutex);
 		list_for_each_entry(s, &slab_caches, list) {
-			local_irq_save(flags);
+			local_lock_irqsave(slub_lock, flags);
 			__flush_cpu_slab(s, cpu);
-			local_irq_restore(flags);
+			local_unlock_irqrestore(slub_lock, flags);
 		}
 		mutex_unlock(&slab_mutex);
 		break;

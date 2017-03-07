From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 2/9] radix-tree: use local locks
Date: Tue, 7 Mar 2017 16:32:52 -0600
Message-ID: <ef70db8b8f9923f739a8e0b7b30220f8b3e2a7a1.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        <stable-rt@vger.kernel.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The preload functionality uses per-CPU variables and preempt-disable to
ensure that it does not switch CPUs during its usage. This patch adds
local_locks() instead preempt_disable() for the same purpose and to
remain preemptible on -RT.

Cc: stable-rt@vger.kernel.org
Reported-and-debugged-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 682d58995008862febd37bbab89e33e38da84cc4)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/radix-tree.h | 12 ++----------
 lib/radix-tree.c           | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 9a80663a1574..e46b414e9e39 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -277,13 +277,10 @@ radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 unsigned int radix_tree_gang_lookup_slot(struct radix_tree_root *root,
 			void ***results, unsigned long *indices,
 			unsigned long first_index, unsigned int max_items);
-#ifndef CONFIG_PREEMPT_RT_FULL
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
-#else
-static inline int radix_tree_preload(gfp_t gm) { return 0; }
-static inline int radix_tree_maybe_preload(gfp_t gfp_mask) { return 0; }
-#endif
+void radix_tree_preload_end(void);
+
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag);
@@ -306,11 +303,6 @@ unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
 int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
 unsigned long radix_tree_locate_item(struct radix_tree_root *root, void *item);
 
-static inline void radix_tree_preload_end(void)
-{
-	preempt_enable_nort();
-}
-
 /**
  * struct radix_tree_iter - radix tree iterator state
  *
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 19713243e698..e91567dc635f 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
 #include <linux/preempt_mask.h>		/* in_interrupt() */
+#include <linux/locallock.h>
 
 
 /*
@@ -68,6 +69,7 @@ struct radix_tree_preload {
 	struct radix_tree_node *nodes[RADIX_TREE_PRELOAD_SIZE];
 };
 static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+static DEFINE_LOCAL_IRQ_LOCK(radix_tree_preloads_lock);
 
 static inline void *ptr_to_indirect(void *ptr)
 {
@@ -195,13 +197,13 @@ radix_tree_node_alloc(struct radix_tree_root *root)
 		 * succeed in getting a node here (and never reach
 		 * kmem_cache_alloc)
 		 */
-		rtp = &get_cpu_var(radix_tree_preloads);
+		rtp = &get_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
 		if (rtp->nr) {
 			ret = rtp->nodes[rtp->nr - 1];
 			rtp->nodes[rtp->nr - 1] = NULL;
 			rtp->nr--;
 		}
-		put_cpu_var(radix_tree_preloads);
+		put_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
 		/*
 		 * Update the allocation stack trace as this is more useful
 		 * for debugging.
@@ -241,7 +243,6 @@ radix_tree_node_free(struct radix_tree_node *node)
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Load up this CPU's radix_tree_node buffer with sufficient objects to
  * ensure that the addition of a single element in the tree cannot fail.  On
@@ -257,14 +258,14 @@ static int __radix_tree_preload(gfp_t gfp_mask)
 	struct radix_tree_node *node;
 	int ret = -ENOMEM;
 
-	preempt_disable();
+	local_lock(radix_tree_preloads_lock);
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
-		preempt_enable();
+		local_unlock(radix_tree_preloads_lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		preempt_disable();
+		local_lock(radix_tree_preloads_lock);
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < ARRAY_SIZE(rtp->nodes))
 			rtp->nodes[rtp->nr++] = node;
@@ -303,11 +304,16 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 	if (gfp_mask & __GFP_WAIT)
 		return __radix_tree_preload(gfp_mask);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	preempt_disable();
+	local_lock(radix_tree_preloads_lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
-#endif
+
+void radix_tree_preload_end(void)
+{
+	local_unlock(radix_tree_preloads_lock);
+}
+EXPORT_SYMBOL(radix_tree_preload_end);
 
 /*
  *	Return the maximum key which can be store into a
-- 
2.11.1

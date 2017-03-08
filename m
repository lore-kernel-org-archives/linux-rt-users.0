From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/7] radix-tree: use local locks
Date: Wed, 08 Mar 2017 15:30:08 -0500
Message-ID: <20170308203021.991649921@goodmis.org>
References: <20170308203007.731237400@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-radix-tree-use-local-locks.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.105-rt120-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The preload functionality uses per-CPU variables and preempt-disable to
ensure that it does not switch CPUs during its usage. This patch adds
local_locks() instead preempt_disable() for the same purpose and to
remain preemptible on -RT.

Cc: stable-rt@vger.kernel.org
Reported-and-debugged-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/radix-tree.h | 10 +---------
 lib/radix-tree.c           | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 70d26e461feb..f815eeeff7ac 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -231,11 +231,8 @@ unsigned long radix_tree_next_hole(struct radix_tree_root *root,
 unsigned long radix_tree_prev_hole(struct radix_tree_root *root,
 				unsigned long index, unsigned long max_scan);
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 int radix_tree_preload(gfp_t gfp_mask);
-#else
-static inline int radix_tree_preload(gfp_t gm) { return 0; }
-#endif
+void radix_tree_preload_end(void);
 
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
@@ -259,11 +256,6 @@ unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
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
index 3ed7e8ad92be..ed36bf860975 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -32,7 +32,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
-
+#include <linux/locallock.h>
 
 #ifdef __KERNEL__
 #define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
@@ -93,6 +93,7 @@ struct radix_tree_preload {
 	struct radix_tree_node *nodes[RADIX_TREE_PRELOAD_SIZE];
 };
 static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+static DEFINE_LOCAL_IRQ_LOCK(radix_tree_preloads_lock);
 
 static inline void *ptr_to_indirect(void *ptr)
 {
@@ -215,13 +216,13 @@ radix_tree_node_alloc(struct radix_tree_root *root)
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
 	}
 	if (ret == NULL)
 		ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
@@ -256,7 +257,6 @@ radix_tree_node_free(struct radix_tree_node *node)
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Load up this CPU's radix_tree_node buffer with sufficient objects to
  * ensure that the addition of a single element in the tree cannot fail.  On
@@ -272,14 +272,14 @@ int radix_tree_preload(gfp_t gfp_mask)
 	struct radix_tree_node *node;
 	int ret = -ENOMEM;
 
-	preempt_disable();
+	local_lock(radix_tree_preloads_lock);
 	rtp = &__get_cpu_var(radix_tree_preloads);
 	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
-		preempt_enable();
+		local_unlock(radix_tree_preloads_lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		preempt_disable();
+		local_lock(radix_tree_preloads_lock);
 		rtp = &__get_cpu_var(radix_tree_preloads);
 		if (rtp->nr < ARRAY_SIZE(rtp->nodes))
 			rtp->nodes[rtp->nr++] = node;
@@ -291,7 +291,12 @@ out:
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_preload);
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
2.10.2

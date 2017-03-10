From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.105-rt120
Date: Fri, 10 Mar 2017 10:26:08 -0500
Message-ID: <20170310102608.23c73535@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933427AbdCJP0U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 10:26:20 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.10.105-rt120 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: 6e9f736c520a43451cddc0eaa4876c476f9bbd68


Or to build 3.10.105-rt120 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.105.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.105-rt120.patch.xz



You can also build from 3.10.105-rt119 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.105-rt119-rt120.patch.xz



Enjoy,

-- Steve


Changes from v3.10.105-rt119:

---

Dan Murphy (1):
      lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP

John Ogness (1):
      x86/mm/cpa: avoid wbinvd() for PREEMPT

Sebastian Andrzej Siewior (3):
      radix-tree: use local locks
      rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from export symbol
      rt: Drop the removal of _GPL from rt_mutex_destroy()'s EXPORT_SYMBOL

Steven Rostedt (VMware) (1):
      Linux 3.10.105-rt120

Thomas Gleixner (1):
      lockdep: Handle statically initialized PER_CPU locks proper

----
 arch/x86/mm/pageattr.c     |  8 ++++++++
 include/linux/module.h     |  6 ++++++
 include/linux/mutex_rt.h   |  5 +++++
 include/linux/percpu.h     |  1 +
 include/linux/radix-tree.h | 10 +---------
 kernel/lockdep.c           | 32 +++++++++++++++++++++++---------
 kernel/module.c            | 36 ++++++++++++++++++++++++------------
 lib/radix-tree.c           | 21 +++++++++++++--------
 localversion-rt            |  2 +-
 mm/percpu.c                | 37 +++++++++++++++++++++++--------------
 10 files changed, 105 insertions(+), 53 deletions(-)
---------------------------
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index aabdf762f592..ca212268cedd 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -210,7 +210,15 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Avoid wbinvd() because it causes latencies on all CPUs,
+	 * regardless of any CPU isolation that may be in effect.
+	 */
+	unsigned long do_wbinvd = 0;
+#else
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
+#endif
 
 	BUG_ON(irqs_disabled());
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 761dc2848ffa..54090c4931bc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -394,6 +394,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
@@ -539,6 +540,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+static inline bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 static inline bool is_module_text_address(unsigned long addr)
 {
 	return false;
diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index c38a44b14da5..e0284edec655 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
+
+#ifdef CONFIG_DEBUG_MUTEXES
 #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
+#else
+static inline void mutex_destroy(struct mutex *lock) {}
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 12b394f75d8e..aa2799e07b88 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -176,6 +176,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 #endif
 
 extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
 #if !defined(CONFIG_SMP) || !defined(CONFIG_HAVE_SETUP_PER_CPU_AREA)
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
diff --git a/kernel/lockdep.c b/kernel/lockdep.c
index 6cbe12c0fc34..092fe64a49f6 100644
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -650,6 +650,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -677,10 +678,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
 	/*
 	 * Static locks do not have their class-keys yet - for them the key
-	 * is the lock object itself:
+	 * is the lock object itself. If the lock is in the per cpu area,
+	 * the canonical address of the lock (per cpu offset removed) is
+	 * used.
 	 */
-	if (unlikely(!lock->key))
-		lock->key = (void *)lock;
+	if (unlikely(!lock->key)) {
+		unsigned long can_addr, addr = (unsigned long)lock;
+
+		if (__is_kernel_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (__is_module_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (static_obj(lock))
+			lock->key = (void *)lock;
+		else
+			return ERR_PTR(-EINVAL);
+		is_static = true;
+	}
 
 	/*
 	 * NOTE: the class-key must be unique. For dynamic locks, a static
@@ -710,7 +724,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -727,13 +741,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	unsigned long flags;
 
 	class = look_up_lock_class(lock, subclass);
-	if (likely(class))
+	if (likely(!IS_ERR_OR_NULL(class)))
 		goto out_set_class_cache;
 
 	/*
 	 * Debug-check: all keys must be persistent!
- 	 */
-	if (!static_obj(lock->key)) {
+	 */
+	if (IS_ERR(class)) {
 		debug_locks_off();
 		printk("INFO: trying to register non-static key.\n");
 		printk("the code is fine but needs lockdep annotation.\n");
@@ -3275,7 +3289,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -3937,7 +3951,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 2c87e521032b..8f762a1bb944 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -524,16 +524,7 @@ static void percpu_modcopy(struct module *mod,
 		memcpy(per_cpu_ptr(mod->percpu, cpu), from, size);
 }
 
-/**
- * is_module_percpu_address - test whether address is from module static percpu
- * @addr: address to test
- *
- * Test whether @addr belongs to module static percpu area.
- *
- * RETURNS:
- * %true if @addr is from module static percpu area
- */
-bool is_module_percpu_address(unsigned long addr)
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 	struct module *mod;
 	unsigned int cpu;
@@ -547,9 +538,11 @@ bool is_module_percpu_address(unsigned long addr)
 			continue;
 		for_each_possible_cpu(cpu) {
 			void *start = per_cpu_ptr(mod->percpu, cpu);
+			void *va = (void *)addr;
 
-			if ((void *)addr >= start &&
-			    (void *)addr < start + mod->percpu_size) {
+			if (va >= start && va < start + mod->percpu_size) {
+				if (can_addr)
+					*can_addr = (unsigned long) (va - start);
 				preempt_enable();
 				return true;
 			}
@@ -560,6 +553,20 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+/**
+ * is_module_percpu_address - test whether address is from module static percpu
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to module static percpu area.
+ *
+ * RETURNS:
+ * %true if @addr is from module static percpu area
+ */
+bool is_module_percpu_address(unsigned long addr)
+{
+	return __is_module_percpu_address(addr, NULL);
+}
+
 #else /* ... !CONFIG_SMP */
 
 static inline void __percpu *mod_percpu(struct module *mod)
@@ -589,6 +596,11 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #define MODINFO_ATTR(field)	\
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
diff --git a/localversion-rt b/localversion-rt
index ba6e8821d159..fff72aad59ab 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt119
+-rt120
diff --git a/mm/percpu.c b/mm/percpu.c
index 25e2ea52db82..b96d41d20b1e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -946,18 +946,7 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
-/**
- * is_kernel_percpu_address - test whether address is from static percpu area
- * @addr: address to test
- *
- * Test whether @addr belongs to in-kernel static percpu area.  Module
- * static percpu areas are not considered.  For those, use
- * is_module_percpu_address().
- *
- * RETURNS:
- * %true if @addr is from in-kernel static percpu area, %false otherwise.
- */
-bool is_kernel_percpu_address(unsigned long addr)
+bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 #ifdef CONFIG_SMP
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
@@ -966,16 +955,36 @@ bool is_kernel_percpu_address(unsigned long addr)
 
 	for_each_possible_cpu(cpu) {
 		void *start = per_cpu_ptr(base, cpu);
+		void *va = (void *)addr;
 
-		if ((void *)addr >= start && (void *)addr < start + static_size)
+		if (va >= start && va < start + static_size) {
+			if (can_addr)
+				*can_addr = (unsigned long) (va - start);
 			return true;
-        }
+		}
+	}
 #endif
 	/* on UP, can't distinguish from other static vars, always false */
 	return false;
 }
 
 /**
+ * is_kernel_percpu_address - test whether address is from static percpu area
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to in-kernel static percpu area.  Module
+ * static percpu areas are not considered.  For those, use
+ * is_module_percpu_address().
+ *
+ * RETURNS:
+ * %true if @addr is from in-kernel static percpu area, %false otherwise.
+ */
+bool is_kernel_percpu_address(unsigned long addr)
+{
+	return __is_kernel_percpu_address(addr, NULL);
+}
+
+/**
  * per_cpu_ptr_to_phys - convert translated percpu address to physical address
  * @addr: the address to be converted to physical address
  *
